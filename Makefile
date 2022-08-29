NAME = jobman
GO = go
BIN = ./bin

.PHONY: all
all: format test build install

.PHONY: format
format:
	$(GO) fmt

.PHONY: unittest
unittest:
	$(GO) test -v -race -cover -coverprofile=coverage.txt -covermode=atomic ./...

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

release: export TAG=$$(cat ./version)
release:
	go get -u github.com/mitchellh/gox
	go get -u github.com/tcnksm/ghr
	$(GOPATH)/bin/gox -os="linux darwin windows" -arch="amd64" -output="./dist/jobman_{{.OS}}_{{.Arch}}"
	git tag -a $(TAG) -m "release $(TAG)"
	git push --tags
	$(GOPATH)/bin/ghr -t $(GH_TOKEN_JOBMAN_RELEASE) $(TAG) dist/

