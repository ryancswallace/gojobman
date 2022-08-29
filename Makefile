NAME = jobman
GO = go
BIN = ./bin
COVREPORT = coverage.txt

.PHONY: all
all: format test build install

.PHONY: format
format:
	$(GO) fmt

.PHONY: unittest
unittest:
	$(GO) test -v -race -cover -coverprofile=$(COVREPORT) -covermode=atomic ./...

.PHONY: e2etest
e2etest:
	true  # TODO

.PHONY: perftest
perftest:
	true  # TODO

$(BIN)/golangci-lint:
	wget -O- -nv https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s v1.49.0
	$(BIN)/golangci-lint --version

.PHONY: lint
lint: $(BIN)/golangci-lint
	golangci-lint run

.PHONY: test
test: unittest e2etest perftest lint

.PHONY: build
build:
	mkdir -p $(BIN) \
	&& $(GO) build -o $(BIN)/ .
.PHONY: build

.PHONY: install
install:
	$(GO) install

.PHONY: clean
clean:
	rm -rf $(COVREPORT) $(BIN)

.PHONY: docker-image
docker-image:
	docker build -t $(NAME) .