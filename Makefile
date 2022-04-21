build:
	go build -o bin/jobman main.go

exec:
	./bin/jobman

run: build exec

install:
	go install

format:
	go fmt

test:
	go test

release:
	go get -u github.com/mitchellh/gox
	go get -u github.com/tcnksm/ghr
	go mod vendor
	$(GOPATH)/bin/gox -os="linux darwin windows" -arch="amd64" -output="./dist/jobman_{{.OS}}_{{.Arch}}"
	$(GOPATH)/bin/ghr