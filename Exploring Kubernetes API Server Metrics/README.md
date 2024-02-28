Lab 20.5 - Exploring Kubernetes API Server Metrics

The Kubernetes API Server exposes metrics about the inner events and states of the API Server itself.

For example, this contains a metric apiserver_request_total that counts requests to the API
Server broken out for each verb (GET, LIST, etc.), API resource, resource group, and HTTP response
content type and code.

To show how many service-discovery-related requests (most of which will come from the Prometheus
server in our test cluster) the Kubernetes API Server is handling, query for:

rate(apiserver_request_total{group="discovery.k8s.io",
job="kubernetes-apiserver"}[5m])

This should not be a high number, but you could use a similar query to diagnose overload situations,
where a client is sending too many requests to the API Server.
You can list all time series that the API Server exposes by querying in the Console (not Graph!) view
for:

{job="kubernetes-apiserver"}