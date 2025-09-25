# Raux Custom Image

Custom Docker image for Raux with dynamic configuration generation based on environment variables.

## Quick Start

Build the custom Raux image:

```bash
cd src/raux/image
docker build -t raux .
docker tag raux localhost/raux
```
