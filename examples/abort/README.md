# Abort Testing

This example demonstrates how to use Istio VirtualService to inject faults by aborting requests with specific error codes. This is useful for testing how your applications handle server errors and improving resilience.

## HTTP Abort Example

The HTTP abort example injects HTTP 502 errors into 40% of requests to the httpbin service.

### Setup and Testing

1. Apply the HTTP abort configuration:

```console
kubectl apply -f examples/abort/abort-http.yaml
```

2. Test the abort behavior by sending multiple requests. You should see some requests return 502 errors:

```console
for i in {1..10}; do bash bin/curl.sh -s -o /dev/null -w '%{http_code}\n' httpbin.default.svc.cluster.local:8000/status/200; done
```

**Expected Result:** Approximately 40% of requests will return HTTP 502 status codes, while 60% will succeed with 200 status codes.

## gRPC Abort Example

The gRPC abort example injects `UNAVAILABLE` status into 50% of gRPC requests to the echo service.

### Setup and Testing

1. Create and configure the gRPC test namespace:

```console
kubectl create ns echo-grpc
kubectl label namespace echo-grpc istio-injection=enabled
```

2. Build and deploy the gRPC testing tools:

```console
bin/build-and-load-grpcurl.sh 
```

3. Apply the gRPC abort configuration:

```console
kubectl apply -f examples/abort/abort-grpc.yaml
```

4. Test the gRPC abort behavior:

```console
kubectl -n echo-grpc exec deploy/grpcurl -- grpcurl -plaintext echo.echo-grpc.svc.cluster.local:7070 proto.EchoTestService.Echo
```

**Expected Result:** Approximately 50% of gRPC calls will fail with `UNAVAILABLE` status, while 50% will succeed.

## Configuration Details

- **HTTP Abort** (`abort-http.yaml`): Configures 40% of HTTP requests to return HTTP 502 errors
- **gRPC Abort** (`abort-grpc.yaml`): Configures 50% of gRPC requests to return UNAVAILABLE status

These fault injection techniques help you test and improve your application's error handling capabilities.
