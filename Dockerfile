# TODO: add support for local builds in addition to GoReleaser "copies"
# TODO: include supporting files (e.g., config, man, completions

# ARG go_vers=1.16

# FROM golang:${go_vers}-alpine as build

# RUN apk update && apk add build-base

# WORKDIR /go/src/github.com/ryancswallace/jobman
# COPY . /go/src/github.com/ryancswallace/jobman

# RUN make install

# ENTRYPOINT ["/bin/sh"]


# FROM alpine:3.12

# RUN apk update

# COPY --from=build /go/bin/jobman /usr/bin/jobman

# ENTRYPOINT ["/bin/sh"]


FROM alpine:3.12

RUN apk update

ENTRYPOINT ["/bin/sh"]

COPY jobman /usr/bin/jobman