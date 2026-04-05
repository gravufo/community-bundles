# renovate: datasource=docker depName=alpine versioning=docker
ARG ALPINE_VERSION=3.21
FROM alpine:${ALPINE_VERSION} AS build

RUN apk add --no-cache tzdata tar && \
    mkdir -p /pkg/usr/share/zoneinfo && \
    tar --hard-dereference -C /usr/share/zoneinfo -cf - . | tar -C /pkg/usr/share/zoneinfo -xf -

FROM scratch
COPY --from=build /pkg/usr /usr
