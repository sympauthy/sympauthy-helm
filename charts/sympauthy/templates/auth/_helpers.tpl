{{/*
Name of the auth component.
*/}}
{{- define "sympauthy.names.auth" -}}
{{- $componentName := default "auth" .Values.nameOverrides.auth }}
{{- printf "%s-%s" $.Chart.Name $componentName | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Fullname of resources deployed for the auth component.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "sympauthy.fullnames.auth" -}}
{{- if .Values.fullnameOverrides.auth }}
{{- .Values.fullnameOverrides.auth | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default "auth" .Values.nameOverrides.auth }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Common labels for resources of the auth component.
*/}}
{{- define "sympauthy.labels.auth" -}}
{{ include "sympauthy.labels.common" . }}
{{ include "sympauthy.selectorLabels.auth" . }}
{{- end }}

{{/*
Selector labels for 
*/}}
{{- define "sympauthy.selectorLabels.auth" -}}
app.kubernetes.io/name: {{ include "sympauthy.names.auth" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Name of the configmap containing the configuration the auth component including the application.yml
*/}}
{{- define "sympauthy.configmaps.auth" -}}
{{- $fullname := include "sympauthy.fullnames.auth" . }}
{{- printf "%s-%s" $fullname "configmap" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Name of the secrets containing the configuration the auth component including the application.yml
*/}}
{{- define "sympauthy.secrets.auth" -}}
{{- $fullname := include "sympauthy.fullnames.auth" . }}
{{- printf "%s-%s" $fullname "secret" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Inject MICRONAUT_CONFIG_FILES as an environment variable configured with the configmap and/or secret
depending on what is being used by the user.
*/}}
{{- define "sympauthy.envs.auth" -}}
{{- $appymlPaths := list -}}
{{- if .Values.configs.auth -}}
{{- $appymlPaths = append $appymlPaths "/etc/configmap/application.yml" -}}
{{- end -}}
{{- if .Values.secrets.auth -}}
{{- $appymlPaths = append $appymlPaths "/etc/secret/application.yml" -}}
{{- end -}}
{{- if $appymlPaths -}}
- name: MICRONAUT_CONFIG_FILES
  value: {{ join "," $appymlPaths }}
{{- end -}}
{{- end }}
