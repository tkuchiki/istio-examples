# Retry Policy

This example demonstrates Istio's automatic retry capabilities using VirtualService. Retry policies help improve service reliability by automatically retrying failed requests, which is especially useful for handling transient network issues or temporary service unavailability.

## Overview

The retry configuration includes:
- **Maximum Attempts**: 4 total attempts (1 initial + 3 retries)
- **Per-Try Timeout**: 1 second timeout for each individual attempt
- **Overall Timeout**: 10 seconds total timeout for the entire request
- **Retry Conditions**: Retries on 5xx errors, connection failures, refused streams, gateway errors, and connection resets

## Setup and Testing

1. Deploy the delay-http-echo service:

```console
bin/build-and-load-delay-http-echo.sh
bin/deploy-delay-http-echo.sh
```

2. Apply the retry policy configuration:

```console
kubectl apply -f examples/retry/retry.yaml
```

3. Test the retry behavior by making requests to the service:

```console
# Keep calling the API until you get a response where attempts is 2 or greater
bin/curl.sh -s delay-http-echo.default.svc.cluster.local:8088
```

## Expected Results

When the service experiences failures or delays:
- Istio will automatically retry failed requests up to 4 times
- Each retry attempt has a 1-second timeout
- The response may include headers showing the number of retry attempts
- Look for responses where the attempt count is 2 or higher, indicating retries occurred

## Configuration Details

The `retry.yaml` file configures:
- **Timeout**: 10-second overall timeout for requests
- **Retry Attempts**: Up to 4 total attempts per request
- **Per-Try Timeout**: 1-second timeout for each individual attempt  
- **Retry Conditions**: Automatically retries on various failure scenarios including server errors and network issues

This retry mechanism helps improve the overall reliability and user experience of your distributed applications by transparently handling transient failures.
