<p align="center">
  <img src="../docs/logos/helm.png" alt="Helm Logo" width="150">
</p>

# service-chart

A generic Helm chart for deploying microservices.

<p align="left">
  <img src="../docs/logos/primetoday.png" alt="PrimeToday" width="150">
</p>

## Parameters

### Global Configuration

| Name               | Description                      | Value |
| ------------------ | -------------------------------- | ----- |
| `nameOverride`     | Name override for the chart      | `""`  |
| `fullnameOverride` | Full name override for the chart | `""`  |

### Application Configuration

| Name                                                | Description                          | Value     |
| --------------------------------------------------- | ------------------------------------ | --------- |
| `app.replicaCount`                                  | Number of replicas                   | `1`       |
| `app.annotations`                                   | Pod annotations                      | `{}`      |
| `app.labels`                                        | Pod labels                           | `{}`      |
| `app.resources`                                     | Resource requests and limits         | `{}`      |
| `app.resources`                                     | Example:                             |           |
| `app.resources`                                     | ```yaml                              |           |
| `app.resources`                                     | requests:                            |           |
| `app.resources`                                     | cpu: 100m                            |           |
| `app.resources`                                     | memory: 128Mi                        |           |
| `app.resources`                                     | limits:                              |           |
| `app.resources`                                     | cpu: 500m                            |           |
| `app.resources`                                     | memory: 256Mi                        |           |
| `app.resources`                                     | ```                                  |           |
| `app.nodeSelector`                                  | Node selector                        | `{}`      |
| `app.tolerations`                                   | Tolerations                          | `[]`      |
| `app.affinity`                                      | Affinity rules                       | `{}`      |
| `app.podSecurityContext`                            | Pod security context                 | `{}`      |
| `app.securityContext`                               | Container security context           | `{}`      |
| `app.volumes`                                       | Additional volumes                   | `[]`      |
| `app.volumeMounts`                                  | Additional volume mounts             | `[]`      |
| `app.autoscaling.enabled`                           | Enable Horizontal Pod Autoscaler     | `true`    |
| `app.autoscaling.minReplicas`                       | Minimum number of replicas           | `1`       |
| `app.autoscaling.maxReplicas`                       | Maximum number of replicas           | `10`      |
| `app.autoscaling.targetCPUUtilizationPercentage`    | Target CPU utilization percentage    | `80`      |
| `app.autoscaling.targetMemoryUtilizationPercentage` | Target memory utilization percentage | `""`      |
| `app.livenessProbe.enabled`                         | Enable liveness probe                | `true`    |
| `app.livenessProbe.path`                            | Liveness probe path                  | `/health` |
| `app.livenessProbe.initialDelaySeconds`             | Initial delay seconds                | `5`       |
| `app.livenessProbe.periodSeconds`                   | Period seconds                       | `10`      |
| `app.livenessProbe.timeoutSeconds`                  | Timeout seconds                      | `5`       |
| `app.livenessProbe.failureThreshold`                | Failure threshold                    | `3`       |
| `app.readinessProbe.enabled`                        | Enable readiness probe               | `true`    |
| `app.readinessProbe.path`                           | Readiness probe path                 | `/health` |
| `app.readinessProbe.initialDelaySeconds`            | Initial delay seconds                | `5`       |
| `app.readinessProbe.periodSeconds`                  | Period seconds                       | `10`      |
| `app.readinessProbe.timeoutSeconds`                 | Timeout seconds                      | `5`       |
| `app.readinessProbe.failureThreshold`               | Failure threshold                    | `3`       |
| `app.startupProbe.enabled`                          | Enable startup probe                 | `false`   |
| `app.startupProbe.path`                             | Startup probe path                   | `/health` |
| `app.startupProbe.initialDelaySeconds`              | Initial delay seconds                | `10`      |
| `app.startupProbe.periodSeconds`                    | Period seconds                       | `10`      |
| `app.startupProbe.timeoutSeconds`                   | Timeout seconds                      | `5`       |
| `app.startupProbe.failureThreshold`                 | Failure threshold                    | `30`      |

### Container Image Configuration

| Name               | Description                              | Value          |
| ------------------ | ---------------------------------------- | -------------- |
| `image.repository` | Container image repository               | `""`           |
| `image.pullPolicy` | Image pull policy                        | `IfNotPresent` |
| `image.tag`        | Image tag (defaults to chart appVersion) | `""`           |

### Service Account Configuration

| Name                         | Description                                 | Value  |
| ---------------------------- | ------------------------------------------- | ------ |
| `serviceAccount.create`      | Create a service account                    | `true` |
| `serviceAccount.annotations` | Annotations for the service account         | `{}`   |
| `serviceAccount.name`        | Service account name (generated if not set) | `""`   |

### Service Configuration

| Name                 | Description                            | Value       |
| -------------------- | -------------------------------------- | ----------- |
| `service.type`       | Service type                           | `ClusterIP` |
| `service.port`       | Service port                           | `8080`      |
| `service.targetPort` | Target port (defaults to service port) | `""`        |

### Ingress Configuration

| Name                  | Description                    | Value   |
| --------------------- | ------------------------------ | ------- |
| `ingress.enabled`     | Enable ingress                 | `true`  |
| `ingress.className`   | Ingress class name             | `nginx` |
| `ingress.annotations` | Ingress annotations            | `{}`    |
| `ingress.hostname`    | Ingress hostname               | `""`    |
| `ingress.hostname`    | Example: `"myapp.example.com"` |         |

### ConfigMap Environment Configuration

| Name              | Description                                        | Value |
| ----------------- | -------------------------------------------------- | ----- |
| `configEnv.pairs` | ConfigMap environment variables (key-value pairs)  | `{}`  |
| `configEnv.pairs` | Example: `{ VERSION: "1.0.0", LOG_LEVEL: "info" }` |       |

### External Secrets Configuration

| Name                      | Description                                                  | Value |
| ------------------------- | ------------------------------------------------------------ | ----- |
| `secretEnv.pairs`         | Secret key to GCP Secret Manager key mapping                 | `{}`  |
| `secretEnv.pairs`         | Example: `{ DB_PASSWORD: "my-project/db-password" }`         |       |
| `secretEnv.templatePairs` | Template pairs for secret transformation                     | `{}`  |
| `secretEnv.templatePairs` | Example: `{ DATABASE_URL: "{{ .DB_PASSWORD | toString }}" }` |       |

### Google Cloud Platform Configuration

| Name                         | Description                                       | Value          |
| ---------------------------- | ------------------------------------------------- | -------------- |
| `gcp.projectId`              | GCP project ID                                    | `""`           |
| `gcp.projectId`              | Example: `"my-gcp-project-123"`                   |                |
| `gcp.serviceAccount.enabled` | Enable GCP service account with Workload Identity | `false`        |
| `gcp.database.enabled`       | Enable Cloud SQL database resources               | `false`        |
| `gcp.database.instanceName`  | Cloud SQL instance name                           | `""`           |
| `gcp.database.instanceName`  | Example: `"my-project:europe-west4:my-instance"`  |                |
| `gcp.database.databaseName`  | Database name (defaults to release name)          | `""`           |
| `gcp.database.userName`      | Database user name (defaults to release name)     | `""`           |
| `gcp.storage.enabled`        | Enable GCS bucket resources                       | `false`        |
| `gcp.storage.location`       | GCS bucket location                               | `europe-west4` |
| `gcp.storage.storageClass`   | GCS storage class                                 | `STANDARD`     |
| `gcp.storage.objectAdmins`   | IAM members with objectAdmin role                 | `[]`           |
| `gcp.storage.objectAdmins`   | Example: `["group:developers@myorg.com"]`         |                |

<!-- This section will be auto-generated by readme-generator -->
