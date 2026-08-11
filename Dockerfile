FROM golang:1.22-alpine AS builder

WORKDIR /app
COPY . .

RUN go mod download
RUN CGO_ENABLED=0 go build -v -o x-ui main.go

FROM alpine:latest

RUN apk add --no-cache ca-certificates tzdata curl bash
WORKDIR /usr/local/x-ui

COPY --from=builder /app/x-ui .

EXPOSE 2053

CMD ["./x-ui"]
