PROJECT = jobman

BIN = ./bin
HOOKS = ./hooks
DOCS = ./docs
MANPAGE = $(DOCS)/manpage
COMPLETIONS = $(DOCS)/completions
COVREPORT = coverage.txt

GO = go
LINTER = golangci-lint
DOCKER = docker


.PHONY: all
all: format update-all test build-all install

###
### Testing
###
.PHONY: unittest
unittest:
	$(GO) test -v -race -cover -coverprofile=$(COVREPORT) -covermode=atomic ./...

.PHONY: e2etest
e2etest:
	true  # TODO

.PHONY: perftest
perftest:
	true  # TODO

$(BIN)/$(LINTER):
	wget -O- -nv https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s v1.49.0
	$(BIN)/$(LINTER) --version

.PHONY: lint
lint: $(BIN)/$(LINTER)
	$(LINTER) run

.PHONY: test
test: unittest e2etest perftest lint

###
### Building
###
.PHONY: build
build:
	mkdir -p $(BIN) \
	&& $(GO) build -o $(BIN)/ .
.PHONY: build

.PHONY: docker-image
docker-image:
	$(DOCKER) build -t $(PROJECT) .

.PHONY: build-all
build-all: build docker-image

.PHONY: install
install:
	$(GO) install

###
### Autoformatting and updating
###
.PHONY: format
format:
	$(GO) fmt

.PHONY: update-all
update-all:
	run-parts $(HOOKS)

###
### Autogeneration
###
$(MANPAGE):
	mkdir -p $@

.PHONY: gen-manpage
gen-manpage: $(MANPAGE)
	$(GO) run devel/manpages/manpages.go

.PHONY: gen-completions
gen-completions:
	for CMPSHELL in bash zsh powershell; do \
		mkdir -p $(COMPLETIONS)/$$CMPSHELL \
		&& $(GO) run devel/autocomplete/autocomplete.go; \
	done

.PHONY: gen-all
gen-all: gen-manpage gen-completions

###
### Cleanup
###
.PHONY: clean
clean:
	rm -rf $(COVREPORT) $(BIN)
	rm $(MANPAGE)/$(PROJECT).*
	rm $(COMPLETIONS)/**/*jobman