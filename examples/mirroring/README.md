# Traffic Mirroring

This example demonstrates Istio's traffic mirroring feature, which allows you to duplicate live traffic to a secondary service for testing, debugging, or monitoring purposes. This is also known as "shadowing" traffic.

## Overview

Traffic mirroring enables you to:
- Test new service versions with real production traffic without affecting users
- Debug issues by capturing live traffic patterns
- Perform load testing with realistic traffic
- Validate changes in a production-like environment

## Setup and Testing

1. Deploy the second version of the httpbin service:

```console
kubectl apply -f examples/mirroring/httpbin-v2.yaml
```

2. Apply the traffic mirroring configuration:

```console
kubectl apply -f examples/mirroring/mirroring.yaml
```

3. Send a test request to the httpbin service:

```console
bash bin/curl.sh -sI httpbin.default.svc.cluster.local:8000/status/200
```

4. Check the logs of the primary service (v1) - this should show the request:

```console
kubectl logs deploy/httpbin -c httpbin
```

5. Check the logs of the mirrored service (v2) - this should also show the same request:

```console
kubectl logs deploy/httpbin-v2 -c httpbin-v2
```

## Expected Results

After sending requests:
- The client receives responses only from the primary service (v1)
- Both v1 and v2 services receive and process the requests (visible in logs)
- The mirrored traffic (v2) responses are discarded and don't affect the client

## Configuration Details

The `mirroring.yaml` file configures:
- **Primary Route**: 100% of traffic goes to httpbin v1 (subset)
- **Mirror Route**: All traffic is also copied to httpbin v2 (subset)  
- **Mirror Percentage**: 100% of requests are mirrored
- **DestinationRule**: Defines service subsets based on version labels

This pattern is ideal for safely testing new deployments, performance analysis, and debugging with real production traffic patterns.
