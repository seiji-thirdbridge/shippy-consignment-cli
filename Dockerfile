# consignment-cli/Dockerfile
FROM golang:1.9.4 as builder

WORKDIR /go/src/github.com/seiji-thirdbridge/shippy-consignment-cli

COPY . .

RUN go get
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo .

FROM alpine:latest

RUN mkdir -p /app
WORKDIR /app

ADD consignment.json /app/consignment.json
COPY --from=builder /go/src/github.com/seiji-thirdbridge/shippy-consignment-cli .

CMD ["./shippy-consignment-cli"]
