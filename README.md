# Service Helm Chart

A generic Helm chart for deploying microservices to Kubernetes.

## Usage

This chart is designed to be used as a dependency or referenced directly by ArgoCD Applications.

### As a dependency

```yaml
# Chart.yaml
dependencies:
  - name: service
    version: "1.0.0"
    repository: "oci://europe-west4-docker.pkg.dev/sandbox-9456/helm"
```

### With ArgoCD

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: my-service
spec:
  source:
    repoURL: oci://europe-west4-docker.pkg.dev/sandbox-9456/helm
    chart: service
    targetRevision: 1.0.0
    helm:
      valueFiles:
        - values.yaml
```

## Configuration

| Parameter                | Description                | Default        |
| ------------------------ | -------------------------- | -------------- |
| `replicaCount`           | Number of replicas         | `1`            |
| `image.repository`       | Container image repository | `""`           |
| `image.tag`              | Container image tag        | `""`           |
| `image.pullPolicy`       | Image pull policy          | `IfNotPresent` |
| `service.type`           | Service type               | `ClusterIP`    |
| `service.port`           | Service port               | `8080`         |
| `ingress.enabled`        | Enable ingress             | `false`        |
| `resources`              | Resource requests/limits   | `{}`           |
| `env`                    | Environment variables      | `[]`           |
| `autoscaling.enabled`    | Enable HPA                 | `false`        |
| `livenessProbe.enabled`  | Enable liveness probe      | `true`         |
| `readinessProbe.enabled` | Enable readiness probe     | `true`         |

See `values.yaml` for full configuration options.

## Publishing

```bash
helm package .
helm push service-1.0.0.tgz oci://europe-west4-docker.pkg.dev/sandbox-9456/helm
```
