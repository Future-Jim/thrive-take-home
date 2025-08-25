FROM golang:1.23 AS builder

WORKDIR /app
COPY . .
RUN go build -o app .

FROM gcr.io/distroless/base-debian12
WORKDIR /
COPY --from=builder /app/app .
EXPOSE 8080
CMD ["./app"]
