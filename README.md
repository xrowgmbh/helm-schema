# JSON schemas for Helm

## Develop

Execute:

```bash
sh build.sh
```

Now do a change in the code or the schema and run the following command for testing:

```
helm lint schema-test/
```

## Creating a JSON Schema for existing YAML values

We can infer a schema from existing YAML values and use it as a starting point when writing a new schema. The steps are:

* Convert your values YAML file to JSON SCHEMA on https://codebeautify.org/yaml-to-json-schema-generator
* Paste the schema into the values.schema.json file


## Pattern

### Metrics
```bash
metrics:
  # Enable or disable exporting metrics
  enabled: true
 
# Service that exposes metrics
# service:
  # Annotations for the metrics service (often used for Prometheus scraping)
  # annotations:
  #   prometheus.io/scrape: "true"
  #   prometheus.io/path: "/metrics"
  #   prometheus.io/port: "8080"
  # Type of the service (ClusterIP, NodePort, LoadBalancer)
  # type: ClusterIP
  # Service port configuration
  # ports:
  # - name: metrics
  #   port: 8080
  #   targetPort: 8080
  #   protocol: TCP

#  Service Monitor (when using Prometheus Operator)
#  serviceMonitor:
  #  Enable or disable service monitor creation
  #  enabled: false
    
  # Additional labels for the ServiceMonitor
  # labels: {}
    
  # Interval at which metrics should be scraped
  # interval: 30s
    
  # Scrape timeout
  # scrapeTimeout: 10s

  # Custom metrics endpoints for cases where auto-discovery is not sufficient
# endpoints: []
  # Example:
  # endpoints:
  #   - port: metrics
  #     path: /metrics
  #     scheme: http
  #     relabelings:
  #       - sourceLabels: [__meta_kubernetes_pod_name]
  #         action: replace
  #         targetLabel: kubernetes_pod_name
```

### Autoscaling

```bash
autoscaling:
  maxReplicas: 10
  metrics:
  - type: Resource
    resource:
      name: cpu
      target:
        type: Utilization
        averageUtilization: 80
```