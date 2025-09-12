# eBPF-Based Cloud & Network Observability Agent

A lightweight, Kubernetes-native observability agent powered by eBPF for deep, low-overhead visibility into network flows, TCP health, system calls, and resource usage with zero code changes for app teams.

Deployed as a DaemonSet and managed via Helm/Flux (GitOps), it exposes per-pod / per-namespace / per-node metrics for platform reliability, SLO/SLA monitoring, and security anomaly detection.

## Features
- Per-Pod Network Tracing : Inbound/outbound bytes & packets, connection counts, TCP retransmits, estimated latency percentiles (from kernel TCP info).


- System Call Monitoring (opt-in) : Log unusual execve, openat, chmod with pod/namespace labels for compliance & runtime forensics.


- Kubernetes-Aware Labels : Pod, namespace, node, container image out-of-the-box.


- Prometheus-Native: /metrics endpoint; Grafana dashboards included.


- Low Overhead : In-kernel data collection (CO-RE), ring-buffer export, rate-limited userspace.


- Security & SLO Alerts : Prometheus/Alertmanager rules for SLO breaches and suspicious activity.


## Architecture (High Level)

```

+------------------+
|   Kubernetes     |
|     Cluster      |
+--------+---------+
         |
     DaemonSet
         |
   +-----v-----+     kprobes/tracepoints/tc
   |  eBPF C   |  --(collect)-->
   +-----+-----+
         |
   +-----v-----+     ringbuf / maps
   | User-Space|  --(enrich+export)-->  /metrics
   |  Exporter |                         (Prometheus)
   +-----+-----+                                |
         |                                       v
     Prometheus ------------------------------> Grafana


``` 

## Why this help platform
- Reliability & SLOs (API gateway/auth/payments): Per-pod flow + TCP health lets you spot noisy backends, cross-AZ packet loss, or TLS handshake regressions without app code changes. That shortens incident triage and helps bring down p95/p99 on critical paths.


- Security & compliance posture: Runtime signals (suspicious execve, ptrace, unexpected egress) with pod/namespace identity feed your SIEM. That strengthens auditability for regulated environments and helps prove “effective monitoring” in reviews.


- Cost & simplicity: eBPF avoids sidecars and reduces duplicate agents. You can keep your APM/vendor where it’s strongest and use eBPF for low-overhead, high-cardinality network/syscall telemetry.


- Developer experience: One Helm/Flux-managed DaemonSet = zero-code telemetry for every team. Faster onboarding, fewer bespoke dashboards.
