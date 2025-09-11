BPF_CLANG ?= clang
ARCH := $(shell uname -m)
ifeq ($(ARCH),x86_64)
  TARGET_ARCH := x86
else ifeq ($(ARCH),aarch64)
  TARGET_ARCH := arm64
else
  TARGET_ARCH := x86
endif

BPF_CFLAGS := -O2 -g -target bpf -D__TARGET_ARCH_$(TARGET_ARCH) \
  -Wall -Wno-unused-value -Wno-pointer-sign -I./bpf

all: bpf/hello.bpf.o

bpf/hello.bpf.o: bpf/hello.bpf.c bpf/vmlinux.h
	$(BPF_CLANG) $(BPF_CFLAGS) -c $< -o $@

clean:
	rm -f bpf/*.o
