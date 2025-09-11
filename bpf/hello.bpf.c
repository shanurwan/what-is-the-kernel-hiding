// SPDX-License-Identifier: GPL-2.0
#include "vmlinux.h"  // generated via: bpftool btf dump file /sys/kernel/btf/vmlinux format c > bpf/vmlinux.h
#include <bpf/bpf_helpers.h>
#include <bpf/bpf_tracing.h>

char LICENSE[] SEC("license") = "GPL";

// Fires when any process calls execve()
SEC("tracepoint/syscalls/sys_enter_execve")
int tp_execve(struct trace_event_raw_sys_enter *ctx) {
    __u64 pid_tgid = bpf_get_current_pid_tgid();
    __u32 pid = pid_tgid >> 32;
    bpf_printk("hello-bpf: execve by pid=%d\n", pid);
    return 0;
}
