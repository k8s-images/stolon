{{/*
Expand the name of the chart.
*/}}
{{- define "stolon.name" -}}
{{-   default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "stolon.fullname" -}}
{{-   if .Values.fullnameOverride -}}
{{-     .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{-   else -}}
{{-     $name := default .Chart.Name .Values.nameOverride -}}
{{-     if contains $name .Release.Name -}}
{{-       .Release.Name | trunc 63 | trimSuffix "-" -}}
{{-     else -}}
{{-       printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{-     end -}}
{{-   end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "stolon.chart" -}}
{{-   printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "stolon.labels" -}}
helm.sh/chart: {{ include "stolon.chart" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{ include "stolon.selectorLabels" . }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "stolon.selectorLabels" -}}
app.kubernetes.io/name: {{ include "stolon.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
stolon-cluster: {{ .Values.clusterName }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "stolon.serviceAccountName" -}}
{{-   if .Values.serviceAccount.create -}}
{{-     default (include "stolon.fullname" .) .Values.serviceAccount.name -}}
{{-   else -}}
{{-     default "default" .Values.serviceAccount.name -}}
{{-   end -}}
{{- end -}}

{{/*
Create the name of the role to use
*/}}
{{- define "stolon.rbacName" -}}
{{-   default (include "stolon.fullname" .) .Values.rbac.name -}}
{{- end -}}

{{/*
Common components env
*/}}
{{- define "stolon.commonEnv" -}}
- name: POD_NAME
  valueFrom:
    fieldRef:
      apiVersion: v1
      fieldPath: metadata.name
- name: POD_IP
  valueFrom:
    fieldRef:
      apiVersion: v1
      fieldPath: status.podIP
{{- end -}}

{{/*
Create a service monitor name.
*/}}
{{- define "stolon.serviceMonitorName" -}}
{{-   $name := include "stolon.fullname" . -}}
{{-   default $name .Values.serviceMonitor.name -}}
{{- end -}}
