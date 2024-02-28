Lab 20.1 - Setting Up a Kubernetes Cluster

In this step, you will set up a single-node Kubernetes cluster on your machine. The following
instructions have been tested on Ubuntu 20.04, but should work similarly on other Ubuntu versions.
Installation steps on other Linux distributions will vary. See the Kubernetes installation instructions for
details if you are not using Ubuntu 20.04 or want to use a different way of installing Kubernetes.
First, install the Kubelet server, as well as the kubeadm and kubectl CLI tools.
As root, execute the following commands:

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF
apt-get update
apt-get install -y kubelet kubeadm kubectl


The Kubelet should now be restarting every few seconds, as it waits in a crashloop for kubeadm to tell it what to do.
As root, initialize a Kubernetes cluster using kubeadm:

kubeadm init

As root, copy over the administrator-level kubectl configuration to your normal user's home
directory (IMPORTANT: be sure to replace the <username> placeholder with your normal user's user
name!):

USERNAME=<username>
mkdir /home/$USERNAME/.kube
cp /etc/kubernetes/admin.conf /home/$USERNAME/.kube/config
chown $USERNAME:$USERNAME -R /home/$USERNAME/.kube

Note that this means that your user will have full administrator-level access to the Kubernetes cluster.
Switch back to your normal user.
Since this is a single-node cluster, you have to allow running user pods on the same node that the
Kubernetes master is running on:
kubectl taint nodes --all node-role.kubernetes.io/master-
Install a pod networking plugin on the cluster (Weave Net in this case) so that pods can talk to each
other:
kubectl apply -n kube-system -f
"https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr
-d '\n')"

List the nodes of the Kubernetes cluster:

kubectl get nodes
After a minute or two, you should see one node in the Ready state, meaning that your Kubernetes
cluster is ready to use.