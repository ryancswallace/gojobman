FROM golang:1.15-alpine as build

WORKDIR /go/src/github.com/ryancswallace/jobman
COPY . /go/src/github.com/ryancswallace/jobman

RUN apk update && apk add build-base

RUN make install

ENTRYPOINT ["/bin/sh"]


FROM alpine:3.12

COPY --from=build /go/bin/jobman /usr/bin/jobman

RUN apk update

ENTRYPOINT ["/bin/sh"]