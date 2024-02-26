Lab 14.2 - Probing Example Services

In this example, you will configure Prometheus to probe some websites using HTTP(S) through the
Blackbox Exporter. This is where you will apply the aforementioned relabeling rules to always scrape
the Blackbox Exporter, but pass the service targets to probe to it via a target query parameter.

Add the following to the scrape_configs section in your prometheus.yml:

- job_name: 'blackbox'
metrics_path: /probe
params:
module:
- http_2xx # Look for an HTTP 200 response.
static_configs:
- targets: # Targets to probe through the Blackbox Exporter.
- 'http://prometheus.io'
- 'https://prometheus.io'
- 'http://example.com:8080'
relabel_configs:
- source_labels: [__address__]
target_label: __param_target
- source_labels: [__param_target]
target_label: instance
- target_label: __address__
replacement: 127.0.0.1:9115 # Blackbox Exporter address.

Reload the Prometheus configuration by sending a HUP signal to the Prometheus process:

killall -HUP prometheus

The Prometheus server should now automatically start scraping the Blackbox Exporter. Head to your
Prometheus server's targets page at http://<machine-ip>:9090/targets and verify that the
discovered service probe targets are visible there.

Note: You should see all three Blackbox Exporter probe targets in the UP state, but that does not
mean that the target probes succeeded. It only means that the scrape of the Blackbox Exporter itself
worked, as the exporter can even return useful metrics about the service probe if the probe failed. The
exact metrics returned about the backend probe depend on the Blackbox Exporter module in either
case.

In the case of the http prober module, several metrics related to the probe are returned, for example:

probe_duration_seconds: How many seconds the backend probe took
probe_success: Whether the probe was overall successful (0 or 1)
probe_http_status_code: The backend’s HTTP status code
probe_http_content_length: The length in bytes of the backend HTTP response content
probe_http_redirects: How many redirects were followed
probe_http_ssl: Whether the probe used SSL in the final redirect (0 or 1)
probe_ssl_earliest_cert_expiry: In the case of an SSL request, the Unix timestamp of
the certificate expiry
probe_ip_protocol: The IP protocol version used for the backend probe (4 or 6)

Head to http://<machine-ip>:9090/graph and evaluate the following expression:

probe_success{job="blackbox"}

You should see a value of 0 (unsuccessful probe) for the http://example.com:8080 target and a
1 for the other targets. Note that http://prometheus.io redirects permanently to
https://prometheus.io. The Blackbox exporter follows redirects, and thus even the
http://prometheus.io target probe will include SSL/TLS-related metrics like certificate expiry.
You can find out in how many days the SSL certificate for prometheus.io will expire by querying for:

(
probe_ssl_earliest_cert_expiry{instance="https://prometheus.io"}
-
time()
) / 86400

This kind of expression is useful for alerting on soon-to-expire certificates.