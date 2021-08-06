FROM golang:alpine as build-env

ENV GO111MODULE=on

RUN apk update && apk add bash ca-certificates git gcc g++ libc-dev

RUN mkdir /chat-app
RUN mkdir -p /chat-app/proto

WORKDIR /chat-app

COPY ./proto/service.pb.go ./proto
COPY ./main.go .

COPY go.mod .
COPY go.sum .

RUN go mod download

RUN go build -o chat-app .

CMD ./chat-app