# renovate: datasource=docker depName=alpine versioning=docker
ARG ALPINE_VERSION=3.21
FROM alpine:${ALPINE_VERSION} AS build

RUN apk add --no-cache tzdata && \
    mkdir -p /pkg/usr/share/zoneinfo && \
    cp -r /usr/share/zoneinfo/. /pkg/usr/share/zoneinfo/

FROM scratch
COPY run.sh /run.sh
COPY --from=build /pkg /
