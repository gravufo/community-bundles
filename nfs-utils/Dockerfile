# renovate: datasource=docker depName=alpine versioning=docker
ARG ALPINE_VERSION=3.21
FROM alpine:${ALPINE_VERSION} AS build

# renovate: datasource=github-releases depName=linux-nfs/nfs-utils versioning=loose extractVersion=^nfs-utils-(?<version>.+)$
ARG NFS_UTILS_VERSION=2-6-4

RUN apk add --no-cache \
    build-base \
    pkgconf \
    rpcgen \
    wget \
    xz \
    libevent-dev \
    libevent-static \
    sqlite-dev \
    sqlite-static \
    lvm2-dev \
    libtirpc-dev \
    libtirpc-static \
    libtirpc-nokrb \
    util-linux-dev \
    util-linux-static \
    libcap-dev

RUN set -ex; \
    NFS_DOT_VER=$(echo "${NFS_UTILS_VERSION}" | tr '-' '.'); \
    wget -O /tmp/nfs-utils.tar.xz \
        "https://www.kernel.org/pub/linux/utils/nfs-utils/${NFS_DOT_VER}/nfs-utils-${NFS_DOT_VER}.tar.xz"; \
    tar -xf /tmp/nfs-utils.tar.xz -C /tmp; \
    mv "/tmp/nfs-utils-${NFS_DOT_VER}" /tmp/nfs-utils-src

WORKDIR /tmp/nfs-utils-src

RUN ./configure \
    --disable-gss \
    --without-krb5 \
    --without-tcp-wrappers \
    --disable-shared \
    CFLAGS="-Os"

# Create a gcc wrapper that injects -static -static-libgcc on link steps.
# Must pass CC=gcc-static-wrap to make — libtool takes CC from the Makefile
# variable (passed as an arg), not from the CC= inside the libtool script.
RUN printf '#!/bin/sh\nfor a in "$@"; do case "$a" in -c|-E|-S) exec gcc "$@";; esac; done\nexec gcc -static -static-libgcc "$@"\n' \
        > /usr/local/bin/gcc-static-wrap && \
    chmod +x /usr/local/bin/gcc-static-wrap

# Remove shared libs so the linker is forced to use the static .a versions.
# Use libtirpc-nokrb.a — the regular libtirpc.a has GSS symbols compiled in
# which have no static Kerberos equivalent.
RUN rm -f \
    /usr/lib/libtirpc.so* \
    /usr/lib/libmount.so* \
    /usr/lib/libblkid.so* \
    /usr/lib/libcap.so* && \
    ln -sf /usr/lib/libtirpc-nokrb.a /usr/lib/libtirpc.a

RUN sed -i '1s/^/#include <unistd.h>\n/' support/reexport/fsidd.c && \
    sed -i '1s/^/#include <unistd.h>\n/' support/reexport/reexport.c && \
    make -C support && \
    make -C utils/mount CC=gcc-static-wrap LDFLAGS="-Wl,--strip-all"

RUN set -ex; \
    mkdir -p /pkg/usr/bin; \
    find utils/mount -maxdepth 1 -type f -perm /111 -exec cp {} /pkg/usr/bin/ \;

FROM scratch
COPY run.sh /run.sh
COPY --from=build /pkg /
