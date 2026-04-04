# nfs-utils

Installs the NFS mount helpers on the Kairos host and loads the NFS kernel module, enabling NFS shares to be mounted.

> **Note:** The mount helpers are statically compiled, so this bundle works on all Kairos flavors regardless of the underlying libc. It requires the kernel to be compiled with NFS module support.

## Configuration

```yaml
#cloud-config

bundles:
  - targets:
      - run://quay.io/kairos/community-bundles:nfs-utils_latest
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

| File                    | Description                                |
|-------------------------|--------------------------------------------|
| `/usr/bin/mount.nfs`    | NFS mount helper (used by `mount -t nfs`)  |
| `/usr/bin/mount.nfs4`   | NFSv4 mount helper                         |
| `/usr/bin/umount.nfs`   | NFS umount helper                          |
| `/usr/bin/umount.nfs4`  | NFSv4 umount helper                        |
