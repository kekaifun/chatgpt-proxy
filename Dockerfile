FROM golang:1.20 as builder

WORKDIR /ChatGPT-Proxy

COPY go.mod go.sum ./

RUN go mod download

COPY . .
RUN ls && \
    make build



FROM alpine:3.14
WORKDIR /ChatGPT-Proxy
COPY --from=builder /ChatGPT-Proxy/bin/proxy ./bin/proxy
RUN chmod +x ./bin/proxy
EXPOSE 11031
ENTRYPOINT ["./bin/proxy"]