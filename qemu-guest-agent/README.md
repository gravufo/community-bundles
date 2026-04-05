# qemu-guest-agent

Installs and enables the QEMU Guest Agent (`qemu-ga`) on the Kairos host, allowing the hypervisor to communicate with the guest VM (e.g. for graceful shutdown, file system freeze, guest info queries).

> **Note:** The agent binary is statically compiled, so this bundle works on all Kairos flavors regardless of the underlying libc. It requires a virtio-serial port named `org.qemu.guest_agent.0` to be configured in the VM.

## Configuration

```yaml
#cloud-config

bundles:
  - targets:
      - run://quay.io/kairos/community-bundles:qemu-guest-agent_latest
```

## Usage

Once installed, the agent runs as a systemd service and starts automatically on boot:

```bash
systemctl status qemu-guest-agent
```

On the QEMU/libvirt host side, ensure the VM is configured with a virtio-serial channel:

```xml
<channel type="unix">
  <target type="virtio" name="org.qemu.guest_agent.0"/>
</channel>
```

## Installed files

| File                                             | Description                        |
|--------------------------------------------------|------------------------------------|
| `/usr/local/bin/qemu-ga`                         | QEMU Guest Agent binary            |
| `/etc/systemd/system/qemu-guest-agent.service`   | systemd service unit               |
