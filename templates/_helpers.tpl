{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "backendapp.name" -}}
{{- default "backendapp" .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- define "frontendapp.name" -}}
{{- default "frontendapp" .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "nifi.name" -}}
{{- default "nifi" .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "backendapp.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "backendapp.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "mongo.serviceName" -}}
{{- printf "%s-%s" .Values.database.mongo.serviceName .Release.Namespace| replace "+" "_" | trunc 80 | trimSuffix "-" -}}
{{- end -}}
{{/* Create mongodb database url for.*/}}
{{- define "mongo.dburl" -}}
{{/* sprig needs to conver .Values.database.mongo.replicas to int */}}
{{- $replicas := (atoi (printf "%d" (int64 .Values.database.mongo.replicas))) -}}
{{- $mongoSurfix := (printf "mongo.%s.svc.cluster.local" .Release.Namespace) -}}
{{- range $i, $e := until $replicas -}}
{{- printf "mongo-%d.%s" $i $mongoSurfix -}}
{{- if lt (add $i 1) $replicas -}}
,
{{- end -}}
{{- end -}}
{{- end -}}