# FROM golang:1.15-alpine as build

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

COPY dist/jobman_linux_amd64_v1/jobman /usr/bin/jobman