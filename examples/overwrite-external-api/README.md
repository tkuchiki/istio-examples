# External API Override

This example demonstrates how to use Istio to override responses from external APIs. This is useful for testing failure scenarios, mocking external dependencies, or providing fallback responses when external services are unavailable.

## Overview

The configuration shows how to:
- Register external services with ServiceEntry
- Configure TLS origination to convert HTTP to HTTPS
- Override specific API endpoints with custom responses using VirtualService

## Setup and Testing

1. Apply the external API override configuration:

```console
kubectl apply -f examples/overwrite-external-api/overwrite-external-api.yaml
```

2. Test the overridden endpoint - you should receive a custom error response instead of the normal UUID:

```console
bin/curl.sh -s http://httpbin.org/uuid
```

**Expected Result:** The request returns HTTP 503 status with the message "Upstream temporary outage" instead of the normal JSON UUID response from httpbin.org.

## Configuration Details

The `overwrite-external-api.yaml` file includes:
- **ServiceEntry**: Registers httpbin.org as an external service accessible from the mesh
- **DestinationRule**: Configures TLS origination to enable HTTP-to-HTTPS conversion
- **VirtualService**: Overrides the `/uuid` endpoint to return a custom 503 error response

:warning: **Important**: Even though the client uses HTTP endpoints, the configuration handles HTTPS communication with the external service through TLS origination.

This pattern is valuable for chaos engineering, testing error handling, and providing fallback responses during external service outages.
