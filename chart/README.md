# stolon

![Version: 0.2.1](https://img.shields.io/badge/Version-0.2.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.17.0](https://img.shields.io/badge/AppVersion-0.17.0-informational?style=flat-square)

Stolon is a cloud native PostgreSQL manager for PostgreSQL high availability

**Homepage:** <https://github.com/k8s-images/stolon>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| Anton Kulikov |  | <https://github.com/4ops> |

## Source Code

* <https://github.com/sorintlab/stolon>
* <https://github.com/wal-g/wal-g>
* <https://git.postgresql.org/gitweb/?p=postgresql.git>

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| clusterName | string | `"k8s-ha"` |  |
| clusterSpec | object | `{"initMode":"new"}` | See: https://github.com/sorintlab/stolon/blob/master/doc/cluster_spec.md |
| clusterSuffix | string | `"cluster.local"` |  |
| fullnameOverride | string | `""` |  |
| imagePullSecrets | list | `[]` |  |
| initCluster | bool | `true` |  |
| keeper.affinity | object | `{}` |  |
| keeper.containerPort | int | `6432` |  |
| keeper.extraEnvVars | list | `[]` |  |
| keeper.extraPorts | list | `[]` |  |
| keeper.extraVolumeMounts | list | `[]` |  |
| keeper.extraVolumes | list | `[]` |  |
| keeper.image.pullPolicy | string | `"IfNotPresent"` |  |
| keeper.image.repository | string | `"ghcr.io/k8s-images/stolon/keeper"` |  |
| keeper.image.tag | string | `"0.17.0-13.11-r2"` |  |
| keeper.metrics.enabled | bool | `true` |  |
| keeper.metrics.port | int | `9003` |  |
| keeper.nodeSelector | object | `{}` |  |
| keeper.persistence.enabled | bool | `false` |  |
| keeper.persistence.size | string | `"8Gi"` |  |
| keeper.persistence.storageClass | string | `""` |  |
| keeper.podAnnotations."kubectl.kubernetes.io/default-container" | string | `"keeper"` |  |
| keeper.podSecurityContext.fsGroup | int | `1042` |  |
| keeper.preStopHook.enabled | bool | `true` |  |
| keeper.preStopHook.exec | object | `{}` |  |
| keeper.preStopHook.httpGet | object | `{}` |  |
| keeper.preStopHook.tcpSocket | object | `{}` |  |
| keeper.replicaCount | int | `1` |  |
| keeper.resources | object | `{}` |  |
| keeper.securityContext.allowPrivilegeEscalation | bool | `false` |  |
| keeper.securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| keeper.securityContext.readOnlyRootFilesystem | bool | `true` |  |
| keeper.securityContext.runAsGroup | int | `1042` |  |
| keeper.securityContext.runAsUser | int | `1042` |  |
| keeper.tolerations | list | `[]` |  |
| nameOverride | string | `""` |  |
| postInstallQuieries | list | `[]` |  |
| postgresUtils.extraEnvVars | list | `[]` |  |
| postgresUtils.extraVolumeMounts | list | `[]` |  |
| postgresUtils.extraVolumes | list | `[]` |  |
| postgresUtils.image.pullPolicy | string | `"IfNotPresent"` |  |
| postgresUtils.image.repository | string | `"ghcr.io/k8s-images/stolon/postgres-utils"` |  |
| postgresUtils.image.tag | string | `"13.11-r2"` |  |
| postgresUtils.podSecurityContext.fsGroup | int | `1042` |  |
| postgresUtils.securityContext.allowPrivilegeEscalation | bool | `false` |  |
| postgresUtils.securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| postgresUtils.securityContext.readOnlyRootFilesystem | bool | `true` |  |
| postgresUtils.securityContext.runAsGroup | int | `1042` |  |
| postgresUtils.securityContext.runAsUser | int | `1042` |  |
| proxy.affinity | object | `{}` |  |
| proxy.autoscaling.enabled | bool | `false` |  |
| proxy.autoscaling.maxReplicas | int | `100` |  |
| proxy.autoscaling.minReplicas | int | `1` |  |
| proxy.autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| proxy.autoscaling.targetMemoryUtilizationPercentage | int | `0` |  |
| proxy.containerPort | int | `5432` |  |
| proxy.extraEnvVars | list | `[]` |  |
| proxy.extraPorts | list | `[]` |  |
| proxy.extraVolumeMounts | list | `[]` |  |
| proxy.extraVolumes | list | `[]` |  |
| proxy.image.pullPolicy | string | `"IfNotPresent"` |  |
| proxy.image.repository | string | `"ghcr.io/k8s-images/stolon/proxy"` |  |
| proxy.image.tag | string | `"0.17.0-r2"` |  |
| proxy.metrics.enabled | bool | `true` |  |
| proxy.metrics.port | int | `9002` |  |
| proxy.nodeSelector | object | `{}` |  |
| proxy.podAnnotations | object | `{}` |  |
| proxy.podSecurityContext | object | `{}` |  |
| proxy.replicaCount | int | `1` |  |
| proxy.resources | object | `{}` |  |
| proxy.securityContext.allowPrivilegeEscalation | bool | `false` |  |
| proxy.securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| proxy.securityContext.readOnlyRootFilesystem | bool | `true` |  |
| proxy.securityContext.runAsGroup | int | `1042` |  |
| proxy.securityContext.runAsUser | int | `1042` |  |
| proxy.service.name | string | `""` |  |
| proxy.service.port | int | `5432` |  |
| proxy.tolerations | list | `[]` |  |
| rbac.create | bool | `true` |  |
| rbac.name | string | `""` |  |
| rbac.rules[0].apiGroups[0] | string | `""` |  |
| rbac.rules[0].resources[0] | string | `"pods"` |  |
| rbac.rules[0].resources[1] | string | `"configmaps"` |  |
| rbac.rules[0].resources[2] | string | `"events"` |  |
| rbac.rules[0].verbs[0] | string | `"*"` |  |
| replPassword | string | `""` |  |
| replUsername | string | `"stolon_repl"` |  |
| sentinel.affinity | object | `{}` |  |
| sentinel.autoscaling.enabled | bool | `false` |  |
| sentinel.autoscaling.maxReplicas | int | `100` |  |
| sentinel.autoscaling.minReplicas | int | `1` |  |
| sentinel.autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| sentinel.autoscaling.targetMemoryUtilizationPercentage | int | `0` |  |
| sentinel.extraEnvVars | list | `[]` |  |
| sentinel.extraPorts | list | `[]` |  |
| sentinel.extraVolumeMounts | list | `[]` |  |
| sentinel.extraVolumes | list | `[]` |  |
| sentinel.image.pullPolicy | string | `"IfNotPresent"` |  |
| sentinel.image.repository | string | `"ghcr.io/k8s-images/stolon/sentinel"` |  |
| sentinel.image.tag | string | `"0.17.0-r2"` |  |
| sentinel.metrics.enabled | bool | `true` |  |
| sentinel.metrics.port | int | `9001` |  |
| sentinel.nodeSelector | object | `{}` |  |
| sentinel.podAnnotations | object | `{}` |  |
| sentinel.podSecurityContext | object | `{}` |  |
| sentinel.replicaCount | int | `1` |  |
| sentinel.resources | object | `{}` |  |
| sentinel.securityContext.allowPrivilegeEscalation | bool | `false` |  |
| sentinel.securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| sentinel.securityContext.readOnlyRootFilesystem | bool | `true` |  |
| sentinel.securityContext.runAsGroup | int | `1042` |  |
| sentinel.securityContext.runAsUser | int | `1042` |  |
| sentinel.tolerations | list | `[]` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.name | string | `""` |  |
| serviceMonitor.create | bool | `false` |  |
| serviceMonitor.honorLabels | bool | `false` |  |
| serviceMonitor.interval | string | `"30s"` |  |
| serviceMonitor.jobLabel | string | `"stolon-cluster"` |  |
| serviceMonitor.metricRelabelings | list | `[]` |  |
| serviceMonitor.name | string | `""` |  |
| serviceMonitor.namespace | string | `""` |  |
| serviceMonitor.relabelings | list | `[]` |  |
| serviceMonitor.scrapeTimeout | string | `"10s"` |  |
| stolonctl.extraEnvVars | list | `[]` |  |
| stolonctl.extraVolumeMounts | list | `[]` |  |
| stolonctl.extraVolumes | list | `[]` |  |
| stolonctl.image.pullPolicy | string | `"IfNotPresent"` |  |
| stolonctl.image.repository | string | `"ghcr.io/k8s-images/stolon/stolonctl"` |  |
| stolonctl.image.tag | string | `"0.17.0-r2"` |  |
| stolonctl.podSecurityContext | object | `{}` |  |
| stolonctl.securityContext.allowPrivilegeEscalation | bool | `false` |  |
| stolonctl.securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| stolonctl.securityContext.readOnlyRootFilesystem | bool | `true` |  |
| stolonctl.securityContext.runAsGroup | int | `1042` |  |
| stolonctl.securityContext.runAsUser | int | `1042` |  |
| suPassword | string | `""` |  |
| suUsername | string | `"stolon_su"` |  |
| updateClusterSpec | bool | `false` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.0](https://github.com/norwoodj/helm-docs/releases/v1.11.0)
