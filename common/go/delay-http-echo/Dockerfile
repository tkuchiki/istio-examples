FROM golang:1.24-alpine as builder

RUN mkdir /go/src/delay-http-echo
COPY main.go /go/src/delay-http-echo

WORKDIR /go/src/delay-http-echo

RUN go mod init delay-http-echo && go build .

FROM scratch

COPY --from=builder /go/src/delay-http-echo/delay-http-echo /usr/bin/delay-http-echo

ENTRYPOINT ["/usr/bin/delay-http-echo"]
