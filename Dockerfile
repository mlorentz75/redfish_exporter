FROM golang:1.21-alpine AS builder

WORKDIR /src
COPY . .
RUN go mod download
RUN go build -o /build/redfish_exporter

FROM scratch

COPY --from=builder /build/redfish_exporter /redfish_exporter
COPY config.example.yml redfish_exporter.yml
CMD ["/redfish_exporter","--config.file","/redfish_exporter.yml"]
EXPOSE 9610