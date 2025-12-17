# Service Helm Chart

A generic Helm chart for deploying microservices with GCP infrastructure support.

## Documentation

For detailed configuration options and parameters, see the [Chart README](chart/README.md).

## Structure

```
service-helm-chart/
├── chart/                    # Helm chart
│   ├── Chart.yaml
│   ├── values.yaml
│   ├── README.md             # Auto-generated parameters docs
│   ├── values.schema.json    # Auto-generated schema
│   └── templates/
│       ├── _helpers.tpl
│       ├── app/              # Application resources
│       │   ├── deployment.yaml
│       │   ├── service.yaml
│       │   ├── serviceaccount.yaml
│       │   ├── ingress.yaml
│       │   ├── hpa.yaml
│       │   ├── config-env.yaml
│       │   └── secret-env.yaml
│       └── infra/            # GCP Config Connector resources
│           ├── wif/
│           ├── database/
│           └── storage/
├── docs/
│   └── .readme-generator.json
├── Makefile
└── .github/workflows/ci.yml
```

## Development

```bash
# Generate docs and schema
make generate

# Lint the chart
make lint

# Template the chart
make template

# Package the chart
make build

# Push to registry
make push
```

## Usage

Add as a dependency in your Chart.yaml:

```yaml
dependencies:
  - name: service-chart
    version: "1.0.0"
    repository: oci://europe-west4-docker.pkg.dev/sandbox-9456/helm
```
