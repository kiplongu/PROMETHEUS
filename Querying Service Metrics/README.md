Lab 20.6 - Querying Service Metrics

You can query the metrics of the demo service instances that were discovered through the
kubernetes-service-endpoints scrape configuration in the same way that you queried them
earlier on in this course, when you were running the demo service outside of Kubernetes. The only
difference is that the target labels will be slightly different. As one example, the following query should
give you the total HTTP request rate:

sum by(job) (rate(demo_api_request_duration_seconds_count[1m]))

You can query the metrics of any other job whose service was annotated for scraping as well. Note
that this means you don't have to update your Prometheus configuration every time you want to
monitor another service's endpoints. Simply add the prometheus.io/scrape: "true" annotation
and the Prometheus server will discover the targets automatically.