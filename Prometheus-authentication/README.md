# The Node exporter is already installed on both nodes, i.e., node01 and node02. Now, let's configure the node exporter on both nodes as below:


Create a directory called node_exporter under /etc.
Create a blank file called config.yml under this newly created directory.
Set appropriate permissions for node_exporter directory and config.yml file. The node exporter username on both nodes is nodeusr
Finally, edit the node exporter service, i.e., /etc/systemd/system/node_exporter.service to use config.yml config file.
Make sure to restart the node_exporter service once done.


Note: You should be able to SSH into node01 and node02 through user root (without any password) from prometheus-server. Once you SSH into any node (for example node01) and you are done with your changes, remember to exit from that node (i.e node01) before SSH into the another node (i.e node02).

# Solution

SSH to node01


ssh root@node01



Create the config:


mkdir /etc/node_exporter/
touch /etc/node_exporter/config.yml
chmod 700 /etc/node_exporter
chmod 600 /etc/node_exporter/config.yml
chown -R nodeusr:nodeusr /etc/node_exporter



Edit node_exporter service


vi /etc/systemd/system/node_exporter.service



Change below line:


ExecStart=/usr/local/bin/node_exporter


to

ExecStart=/usr/local/bin/node_exporter --web.config=/etc/node_exporter/config.yml



Reload the daemon and Restart node_exporter service


systemctl daemon-reload
systemctl restart node_exporter
exit