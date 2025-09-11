Pre requisite: 

1. Ensure BTF exist :

```bash
ls /sys/kernel/btf/vmlinux   # should exist
```

2. Install toolchain :

- Ubuntu 22.04+

```bash
sudo apt update
sudo apt install -y clang llvm make gcc pkg-config libelf-dev zlib1g-dev bpftool git golang
``` 

- Mount debugfs (for bpf_printk output)

```bash
sudo mount -t debugfs debugfs /sys/kernel/debug || true
``` 

2. Generate vmlinux.h (CO-RE type info)

```bash
bpftool btf dump file /sys/kernel/btf/vmlinux format c > bpf/vmlinux.h
```
