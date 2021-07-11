FROM golang:1.15 as builder

RUN mkdir /go/src/app

WORKDIR /go/src/app

COPY go.mod go.mod
ADD main.go /go/src/app/

RUN go mod download

RUN CGO_ENABLED=0 GOOS=linux GO111MODULE=on go build -a -o devops-go-sample /go/src/app/main.go


FROM alpine:3.9
WORKDIR /go/src/app

COPY --from=builder /go/src/app/devops-go-sample .

ENTRYPOINT ["./devops-go-sample"]
