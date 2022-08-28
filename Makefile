NAME = jobman
GO = go
BIN = ./bin

.PHONY: all
all: format test build install

.PHONY: build
build:
	mkdir -p $(BIN) \
	&& $(GO) build -o $(BIN)/$(NAME) main.go
.PHONY: build

.PHONY: install
install:
	$(GO) install

.PHONY: format
format:
	$(GO) fmt

.PHONY: test
test:
	$(GO) test -v ./... -cover \
	&& $(GO) vet ./...

release: export TAG=$$(cat ./version)
release:
	go get -u github.com/mitchellh/gox
	go get -u github.com/tcnksm/ghr
	$(GOPATH)/bin/gox -os="linux darwin windows" -arch="amd64" -output="./dist/jobman_{{.OS}}_{{.Arch}}"
	git tag -a $(TAG) -m "release $(TAG)"
	git push --tags
	$(GOPATH)/bin/ghr -t $(GH_TOKEN_JOBMAN_RELEASE) $(TAG) dist/

