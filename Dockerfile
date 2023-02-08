FROM golang:1.13-alpine as builder

ENV GO111MODULE=on

RUN apk --no-cache add git libc-dev gcc
RUN go get github.com/mjibson/esc

COPY . /go/src/github.com/mailslurper/mailslurper
WORKDIR /go/src/github.com/mailslurper/mailslurper/cmd/mailslurper

RUN go get
RUN go generate
RUN go build

ADD assets/* ./

EXPOSE 8080 8085 2500

ENTRYPOINT ["./mailslurper"]
