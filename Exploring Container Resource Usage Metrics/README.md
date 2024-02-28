Lab 20.4 - Exploring Container Resource Usage Metrics

The container resource usage metrics that the Kubelet's built-in cAdvisor exposes are the same as the metrics from a stand-alone cAdvisor. The only difference is that Kubernetes attaches additional
Kubernetes-specific labels to the containers it starts.
For example, query for:

sum by(namespace) (rate(container_cpu_usage_seconds_total[1m]))

This shows the aggregate CPU usage for all containers, summed up by Kubernetes namespace.
You can also have a look at the memory usage of the three demo service containers:

container_memory_usage_bytes{pod=~"demo-service-.*",container="demo-service"}

This works analogously for the other resource usage metrics that the Kubelet exposes.