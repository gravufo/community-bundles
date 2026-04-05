# renovate: datasource=docker depName=alpine versioning=docker
ARG ALPINE_VERSION=3.21
FROM alpine:${ALPINE_VERSION} AS build

RUN apk add --no-cache \
    bash \
    build-base \
    python3 \
    py3-setuptools \
    meson \
    ninja \
    git \
    linux-headers \
    glib-dev \
    glib-static \
    libcap-ng-dev \
    libcap-ng-static \
    util-linux-dev \
    util-linux-static \
    libffi-dev \
    pcre2-dev \
    zlib-dev \
    zlib-static

# renovate: datasource=github-tags depName=qemu/qemu versioning=semver
ARG QEMU_REF=v10.0.4

WORKDIR /src
RUN git clone --depth=1 --branch "${QEMU_REF}" https://github.com/qemu/qemu.git .

RUN ./configure \
      --prefix=/usr \
      --disable-werror \
      --enable-guest-agent \
      --disable-tools \
      --disable-system \
      --disable-user \
      --static

RUN make -j"$(nproc)" qemu-ga
RUN mkdir -p /pkg/usr/bin && \
    cp build/qga/qemu-ga /pkg/usr/bin/qemu-ga && \
    strip /pkg/usr/bin/qemu-ga

FROM scratch
COPY run.sh /run.sh
COPY --from=build /pkg/usr/bin/qemu-ga .
COPY ./assets /assets
ENTRYPOINT ["/run.sh"]
