PROJECT = jobman

# output paths
BIN = ./bin
DOCS = ./docs
MANPAGE = $(DOCS)/manpage
COMPLETIONS = $(DOCS)/completions
COVREPORT = coverage.txt

# source code paths
DEVEL = ./devel
GEN_UPDATES = $(DEVEL)/updates
GEN_MANPAGE = $(DEVEL)/manpages/manpages.go
GEN_COMPLETIONS = $(DEVEL)/autocomplete/autocomplete.go

# executables
GO = go
LINTER = golangci-lint
DOCKER = docker

# versions
GO_VERSION := $(shell cat go.version)


.PHONY: all
all: format update-all test build-all install

###
### Testing
### These targets execute tests and linters against the source code
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
### Autoformatting and updating
### These targets edit files tracked in the source code repository
###
.PHONY: format
format:
	$(GO) fmt

.PHONY: update
update:
	export GO_VERS=$(GO_VERSION) \
	&& run-parts $(GEN_UPDATES)

.PHONY: update-all
update-all: format update

###
### Autogeneration
### These targets generate files *not* tracked in the source code repository
###
$(MANPAGE):
	mkdir -p $@

.PHONY: gen-manpage
gen-manpage: $(MANPAGE)
	$(GO) run $(GEN_MANPAGE)

.PHONY: gen-completions
gen-completions:
	for CMPSHELL in bash zsh powershell; do \
		mkdir -p $(COMPLETIONS)/$$CMPSHELL \
		&& $(GO) run $(GEN_COMPLETIONS); \
	done

.PHONY: gen-all
gen-all: gen-manpage gen-completions

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
### Cleanup
###
.PHONY: clean
clean:
	rm -rf $(COVREPORT) $(BIN)
	rm $(MANPAGE)/$(PROJECT).*
	rm $(COMPLETIONS)/**/*jobman