Lab 20.3 - Monitoring Kubernetes Components with
Prometheus

Now, let’s look at the metrics that Prometheus collects from the Kubernetes components. Head to the
Prometheus server’s targets page at http://<machine-ip>:30000/targets. Although the
Prometheus configuration didn’t contain any static target configurations, it should have discovered
targets for:

Job kubelet: This monitors the health of the Kubelets themselves (you only have one in your
test cluster).

Job kubelet-cadvisor: This monitors the built-in cAdvisor endpoint of the Kubelets, which
exposes per-container resource usage metrics for the containers running on each machine.
Job kubernetes-apiserver: This monitors the health of the Kubernetes API Server
instances (of which you also only have one).

Endpoints for services that have the Kubernetes annotation prometheus.io/scrape:
"true" set:

○ Job demo-service: This is the demo service.
○ Job kube-dns: Kubernetes's DNS server. Although you didn't set a scrape annotation
on this one yourself, it comes with the right annotation out of the box when setting up a
Kubernetes cluster.
○ Job prometheus: This is the Prometheus server monitoring itself.