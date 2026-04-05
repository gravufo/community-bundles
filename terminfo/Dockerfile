# renovate: datasource=docker depName=alpine versioning=docker
ARG ALPINE_VERSION=3.21
FROM alpine:${ALPINE_VERSION} AS build

RUN apk add --no-cache ncurses-terminfo && \
    mkdir -p /pkg/usr/share/terminfo && \
    cp -r /usr/share/terminfo/. /pkg/usr/share/terminfo/

FROM scratch
COPY run.sh /run.sh
COPY --from=build /pkg /
