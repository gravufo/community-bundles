# nfs-utils

Installs the NFS mount helpers on the Kairos host and loads the NFS kernel module, enabling NFS shares to be mounted.

> **Note:** The mount helpers are statically compiled, so this extension works on all Kairos flavors regardless of the underlying libc. It requires the kernel to be compiled with NFS module support.

## Installation

This bundle is distributed as a system extension (sysext). Install it with:

```bash
kairos-agent sysext install oci://quay.io/kairos/community-bundles:nfs-utils_latest
kairos-agent sysext enable --common --now nfs-utils
```

## Usage

After installation, NFS shares can be mounted using the standard `mount` command:

```bash
mount -t nfs server:/export /mnt/data
mount -t nfs4 server:/export /mnt/data
```

Or via `/etc/fstab`:

```fstab
server:/export  /mnt/data  nfs  defaults  0  0
```

## Installed files

| File                     | Description                                |
|--------------------------|--------------------------------------------|
| `/usr/sbin/mount.nfs`    | NFS mount helper (used by `mount -t nfs`)  |
| `/usr/sbin/mount.nfs4`   | NFSv4 mount helper                         |
| `/usr/sbin/umount.nfs`   | NFS umount helper                          |
| `/usr/sbin/umount.nfs4`  | NFSv4 umount helper                        |
