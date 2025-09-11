Pre requisite: 

1. Ensure BTF exist :

```bash
ls /sys/kernel/btf/vmlinux   # should exist
```

then copy it next to BPF code 

```bash
cd /mnt/c/Users/user/Documents/Shafiqah/Project/eBPF
cp /mnt/c/WINDOWS/system32/bpftool/src/vmlinux.h .
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

