{{/*
Name and version of the chart
*/}}
{{- define "sympauthy.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

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
Common labels
*/}}
{{- define "sympauthy.labels.common" -}}
helm.sh/chart: {{ include "sympauthy.chart" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
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
