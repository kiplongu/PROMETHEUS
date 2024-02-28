Lab 20.2 - Setting Up Prometheus on Kubernetes

Prometheus needs to be granted permissions to perform service discovery and to scrape Kubernetes's
own service endpoints. To keep things simple for this lab, create a very permissive authorization policy
for the Kubernetes cluster:

kubectl create clusterrolebinding permissive-binding \
--clusterrole=cluster-admin \
--user=admin \
--user=kubelet \
--group=system:serviceaccounts

On a real Kubernetes cluster, you will want to set more granular permissions. More on that later.
Since the required example Kubernetes resource files to configure and set up Prometheus are
relatively long, download a repository containing them to ease the process:
git clone https://github.com/juliusv/prometheus-k8s-files
Change into the repository:

cd prometheus-k8s-files

First, store the Prometheus server's configuration in a Kubernetes ConfigMap with the name
prometheus-config (in setups where the Prometheus configuration contains confidential
credentials, you may want to use a Kubernetes Secret instead of a ConfigMap):

kubectl apply -f prometheus-config.yml

Study the configuration file contents to understand how this configuration uses Kubernetes service
discovery and relabeling rules to automatically discover and scrape the Kubernetes API Server, the
Kubelets, and all endpoints of services on the cluster that have a prometheus.io/scrape:
"true" annotation. Note that this and similar annotation names do not have a hard-coded meaning in
Prometheus, and depending on your situation, you might want to choose a different way of structuring
your Prometheus-related Kubernetes annotations and how they are acted upon in relabeling rules.
Now, create a corresponding Prometheus deployment and service that uses the ConfigMap that you
created above:

kubectl apply -f prometheus-deployment.yml

The resulting Prometheus server should now be reachable at http://<machine-ip>:30000/.
To get some web service metrics, run three demo service instances on Kubernetes as well:

kubectl apply -f demo-service.yml

Verify that both the Prometheus server and three instances of your demo service have been started
successfully:

kubectl get pods

This should show all pods in the Running state, at least eventually.