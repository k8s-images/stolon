{{/*
Create the name for keeper
*/}}
{{- define "stolon.keeper.name" -}}
{{-   $name := include "stolon.fullname" . -}}
{{-   printf "%s-keeper" $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Keeper selector labels
*/}}
{{- define "stolon.keeper.selectorLabels" -}}
{{ include "stolon.selectorLabels" . }}
component: stolon-keeper
{{- end -}}

{{/*
Create the name of the keeper service to use
*/}}
{{- define "stolon.keeper.serviceName" -}}
{{-   $name := include "stolon.keeper.name" . -}}
{{-   printf "%s-pods" $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
