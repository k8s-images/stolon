{{/*
Create the name for proxy
*/}}
{{- define "stolon.proxy.name" -}}
{{-   $name := include "stolon.fullname" . -}}
{{-   printf "%s-proxy" $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Proxy selector labels
*/}}
{{- define "stolon.proxy.selectorLabels" -}}
{{ include "stolon.selectorLabels" . }}
component: stolon-proxy
{{- end -}}

{{/*
Create the name of the proxy service to use
*/}}
{{- define "stolon.proxy.serviceName" -}}
{{-   $name := include "stolon.proxy.name" . -}}
{{-   default $name .Values.proxy.service.name -}}
{{- end -}}
