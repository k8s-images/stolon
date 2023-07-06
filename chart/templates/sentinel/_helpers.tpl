{{/*
Create the name for sentinel
*/}}
{{- define "stolon.sentinel.name" -}}
{{-   $name := include "stolon.fullname" . -}}
{{-   printf "%s-sentinel" $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Sentinel selector labels
*/}}
{{- define "stolon.sentinel.selectorLabels" -}}
{{ include "stolon.selectorLabels" . }}
component: stolon-sentinel
{{- end -}}
