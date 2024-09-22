#
# Build
#
FROM golang:1.22 AS builder

ENV CGO_ENABLED=0
ENV GOOS=linux
WORKDIR /build

COPY ./prom-col .

RUN go build -o prom-col ./...

#
# Deploy
#
FROM gcr.io/distroless/static-debian12:latest

WORKDIR /

COPY --from=builder /build/prom-col /prom-col

USER nonroot

CMD [ "/prom-col" ]
