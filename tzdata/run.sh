#!/bin/bash

set -ex

ZONEINFO_DIR=/usr/local/share/zoneinfo

# Copy timezone data to /usr/local/share/zoneinfo (writable on immutable OSes)
mkdir -p "${ZONEINFO_DIR}"
cp -r usr/share/zoneinfo/. "${ZONEINFO_DIR}/"

# Set TZDIR so both glibc and musl libc find the timezone files
if ! grep -q '^TZDIR=' /etc/environment 2>/dev/null; then
    echo "TZDIR=${ZONEINFO_DIR}" >> /etc/environment
fi

# Set UTC as the default timezone if /etc/localtime is not already set
if [ ! -e /etc/localtime ]; then
    ln -sf "${ZONEINFO_DIR}/UTC" /etc/localtime
fi

echo "tzdata installed successfully"
