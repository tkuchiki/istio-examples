FROM golang:1.24-alpine as builder

RUN go install github.com/fullstorydev/grpcurl/cmd/grpcurl@latest

FROM alpine:3 as alpine

COPY --from=builder /go/bin/grpcurl /usr/bin/grpcurl

