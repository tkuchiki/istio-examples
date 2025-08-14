# Circuit Breaking

This example demonstrates Istio's circuit breaking capabilities using DestinationRule. Circuit breaking helps prevent cascading failures by temporarily stopping requests to unhealthy services and allows them time to recover.

## Overview

The circuit breaker configuration sets strict limits on connections and requests:
- **Max Connections**: 1 concurrent connection
- **Max Pending Requests**: 1 request waiting in queue
- **Max Requests Per Connection**: 1 request per connection
- **Outlier Detection**: Ejects pods after 1 consecutive 5xx error for 3 minutes

## Setup and Testing

1. Deploy the Fortio load testing tool:

```console
bin/deploy-fortio.sh
```

2. Apply the circuit breaking configuration:

```console
kubectl apply -f examples/circuit-breaking/circuit-breaking.yaml
```

3. Generate load to trigger the circuit breaker (2 concurrent connections, 20 total requests):

```console
kubectl exec deploy/fortio-deploy -c fortio -- /usr/bin/fortio load -c 2 -qps 0 -n 20 -loglevel Warning http://httpbin.default.svc.cluster.local:8000/get
```

## Expected Results

When the circuit breaker activates, you should observe:
- Some requests succeed (HTTP 200)
- Some requests are rejected by the circuit breaker (HTTP 503 with "upstream connect error or disconnect/reset before headers")
- The Fortio output will show the distribution of response codes

## Configuration Details

The `circuit-breaking.yaml` file configures:
- **Connection Pool Settings**: Limits concurrent connections and pending requests
- **Outlier Detection**: Automatically removes unhealthy service instances from the load balancing pool
- **Recovery**: Unhealthy instances are gradually returned to service after the ejection period

This pattern helps maintain service stability under high load or when downstream services become unresponsive.
