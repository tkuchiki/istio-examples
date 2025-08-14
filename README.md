# Istio Examples

A comprehensive collection of practical Istio service mesh examples and traffic management patterns. This repository provides hands-on demonstrations of Istio's key features including fault injection, circuit breaking, traffic mirroring, retry policies, and more.

## 🚀 Quick Start

### Prerequisites

- Docker
- [kind (Kubernetes in Docker)](https://kind.sigs.k8s.io/docs/user/quick-start/)
- kubectl

### Setup

1. **Create a Kind cluster with Istio-ready configuration:**

```bash
bin/setup-kind-cluster.sh
```

2. **Install Istio with demo profile:**

```bash
# You can check the istio download script before running bin/install-istio.sh
# grep DOWNLOAD_SCRIPT bin/inc.sh
bin/download-script.sh

bin/install-istio.sh
```

3. **Install Istio monitoring addons (optional):**

```bash
bin/install-istio-addons.sh
```

4. **Deploy the httpbin:**

```bash
bin/deploy-httpbin.sh
```

## 📚 Examples

This repository contains practical examples demonstrating Istio's traffic management capabilities:

| Example | Description | Key Features |
|---------|-------------|--------------|
| **[Abort](examples/abort/)** | Fault injection with HTTP/gRPC error responses | Error handling, resilience testing |
| **[Circuit Breaking](examples/circuit-breaking/)** | Connection limits and outlier detection | Load protection, automatic recovery |
| **[Delay](examples/delay/)** | Network latency injection for testing | Timeout testing, latency simulation |
| **[Mirroring](examples/mirroring/)** | Traffic shadowing for safe testing | A/B testing, debugging, monitoring |
| **[Overwrite External API](examples/overwrite-external-api/)** | Override external API responses with custom responses | API mocking, service virtualization, TLS origination |
| **[Retry](examples/retry/)** | Automatic retry policies for failed requests | Reliability improvement, transient error handling |

Each example includes:
- Clear setup instructions
- Expected results and behavior
- Configuration explanations
- Use case descriptions

## 🛠️ Utility Scripts

The `bin/` directory contains helper scripts for common operations:

### Cluster Management
- `setup-kind-cluster.sh` - Create Kubernetes cluster with kind
- `install-istio.sh [version]` - Install Istio with demo profile
- `install-istio-addons.sh` - Install Grafana, Jaeger, Kiali, Prometheus
- `cleanup.sh` - Clean up resources

### Service Deployment
- `deploy-httpbin.sh` - Deploy httpbin test service
- `deploy-curl.sh` - Deploy curl client for testing
- `deploy-fortio.sh` - Deploy Fortio load testing tool
- `deploy-grpc-echo.sh` - Deploy gRPC echo service

### Testing Tools
- `curl.sh` - Execute curl commands from within the cluster
- `build-and-load-grpcurl.sh` - Build and load gRPC testing tools
- `build-and-load-delay-http-echo.sh` - Build custom HTTP echo service

## 🏗️ Project Structure

```
istio-examples/
├── bin/                        # Utility scripts for setup and testing
├── examples/                   # Traffic management examples
│   ├── abort/                  # Fault injection examples
│   ├── circuit-breaking/       # Circuit breaker patterns
│   ├── delay/                  # Latency injection
│   ├── mirroring/              # Traffic shadowing
│   ├── overwrite-external-api/ # External API response overriding
│   └── retry/                  # Retry policy examples
└── common/                     # Shared resources and custom services
    ├── go/                     # Go-based services (delay-http-echo)
    └── grpc/                   # gRPC services and tools
```

## 📖 Getting Started

1. **Follow the Quick Start** to set up your environment
2. **Choose an example** from the table above based on your learning goals
3. **Navigate to the example directory** and follow the README instructions
4. **Experiment** with different configurations and parameters
5. **Monitor** the behavior using Istio's observability tools (Kiali, Jaeger, Grafana)

## 🔧 Configuration

The project uses environment variables that can be customized:

- `CLUSTER_NAME` - Kind cluster name (default: `istio-example`)
- `ISTIO_VERSION` - Istio version to install (default: `1.27.0`)

These can be set before running scripts:

```bash 
ISTIO_VERSION=1.26.1 bin/install-istio.sh
```

## 🧹 Cleanup

To remove all resources and the kind cluster:

```bash
bin/cleanup.sh
```
