{{/*
Auxiliary function to get the right value for existingSecret.

Usage:
{{ include "common.include.template" (dict "context" $ "template" "_pod.tpl" ) }}
Params:
  - template - string - Required. Nname of template in common
*/}}
{{- define "common.include.template" -}}
{{ fail ($.Files.Get (print "templates/" .template ) ) }}

{{ tpl ($.Files.Get (print "templates/" .template ) ) .context }}
{{- end }}

{{- define "common.include.pod" -}}
{{ range $path, $_ :=  $.Files.Glob  "**/*.yaml" }}
      {{ $path }}
{{ end }}
{{ include (print .Template.BasePath "/_pod.yaml") . | sha256sum }}
{{- end }}