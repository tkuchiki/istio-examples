# Delay Fault Injection

This example demonstrates how to inject network delays into your service mesh using Istio VirtualService. This is valuable for testing how your applications handle latency and timeouts in distributed systems.

## Prerequisites

Before running the delay examples, deploy the required services:

```console
# Deploy httpbin service (test target)
bin/deploy-httpbin.sh

# Deploy curl client (test tool) 
bin/deploy-curl.sh
```

Both scripts support setting the `ISTIO_VERSION` environment variable if needed.

## Example 1: 100% Delay Injection

This configuration adds a 2-second delay to **all** requests to the httpbin service.

1. Apply the delay configuration for all requests:

```console
kubectl apply -f examples/delay/delay-all.yaml
```

2. Test the delay - you should notice a 2-second delay in response time:

```console
bin/curl.sh -s httpbin.default.svc.cluster.local:8000/uuid
```

**Expected Result:** Every request will have an additional 2-second delay before receiving the response.

## Example 2: 50% Delay Injection

This configuration adds a 2-second delay to **50%** of requests, allowing you to test partial network degradation scenarios.

1. Apply the partial delay configuration:

```console
kubectl apply -f examples/delay/delay-50.yaml
```

2. Test with multiple requests to see the mixed behavior:

```console
for i in {1..6}; do bin/curl.sh -s httpbin.default.svc.cluster.local:8000/uuid; done
```

**Expected Result:** Approximately half of the requests will have a 2-second delay, while the other half will respond normally. This helps test how your application handles inconsistent response times.

## Configuration Details

- **delay-all.yaml**: Injects 2-second delay into 100% of requests
- **delay-50.yaml**: Injects 2-second delay into 50% of requests

These delay injection techniques are essential for chaos engineering and testing application resilience under various network conditions.
