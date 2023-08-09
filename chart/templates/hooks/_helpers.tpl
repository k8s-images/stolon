{{/*
Create stolonctl image name.
*/}}
{{- define "stolon.stolonctl.image" -}}
{{-   $repository := .Values.stolonctl.image.repository -}}
{{-   $tag := .Values.stolonctl.image.tag -}}
{{-   printf "%s:%s" $repository $tag -}}
{{- end -}}

{{/*
Create postgres utils image name.
*/}}
{{- define "stolon.postgresUtils.image" -}}
{{-   $repository := .Values.postgresUtils.image.repository -}}
{{-   $tag := .Values.postgresUtils.image.tag -}}
{{-   printf "%s:%s" $repository $tag -}}
{{- end -}}

{{/*
Set PGHOST and PGPORT for postgres utils
*/}}
{{- define "stolon.postgresUtils.envVars" -}}
- name: PGHOST
  valueFrom:
    secretKeyRef:
      name: {{ include "stolon.fullname" . }}
      key: pg-host
- name: PGPORT
  valueFrom:
    secretKeyRef:
      name: {{ include "stolon.fullname" . }}
      key: pg-port
- name: PGDATABASE
  value: postgres
- name: PGUSER
  valueFrom:
    secretKeyRef:
      name: {{ include "stolon.fullname" . }}
      key: pg-su-username
- name: PGPASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ include "stolon.fullname" . }}
      key: pg-su-password
{{- end -}}
