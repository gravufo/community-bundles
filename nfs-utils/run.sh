#!/bin/bash

set -ex

# Load NFS kernel modules (no-op if already compiled into the kernel)
modprobe nfs 2>/dev/null || true
modprobe nfsv4 2>/dev/null || true

# Copy NFS mount helpers to /usr/bin
mkdir -p /usr/local/bin
for f in usr/bin/*; do
    [ -f "$f" ] || continue
    cp -a "$f" "/usr/local/bin/$(basename "$f")"
    chmod +x "/usr/local/bin/$(basename "$f")"
done

echo "nfs-utils installed successfully"
