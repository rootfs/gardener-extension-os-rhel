############# builder
FROM golang:1.13.4 AS builder

WORKDIR /go/src/github.com/gardener/gardener-extension-os-rhel
COPY . .
RUN make install-requirements && make VERIFY=true all

############# gardener-extension-os-rhel
FROM alpine:3.11.3 AS gardener-extension-os-rhel

COPY --from=builder /go/bin/gardener-extension-os-rhel /gardener-extension-os-rhel
ENTRYPOINT ["/gardener-extension-os-rhel"]
