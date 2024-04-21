# Create a recording rule to track the rate at which a node is receiving traffic. Find below more details:



  (a) Create a file called node-rules.yaml under /etc/prometheus directory.


  (b) Update this file to:


        (i) Create a group called node, this group should have all the rules for node_exporters.


        (ii) Set the interval for the rules to run every 15s.


        (iii) Add a record called node_network_receive_bytes_rate.


        (iv) The expression should be rate(node_network_receive_bytes_total{job="nodes"}[2m])


  (c) Finally, update the prometheus.yml file to import rules from node-rules.yaml file and restart the prometheus service.
  # solution


Create a new file /etc/prometheus/node-rules.yaml:


vi /etc/prometheus/node-rules.yaml



Add below lines in it:


groups:
  - name: node
    interval: 15s
    rules:
      - record: node_network_receive_bytes_rate
        expr: rate(node_network_receive_bytes_total{job="nodes"}[2m])



Edit /etc/prometheus/prometheus.yml file:


vi /etc/prometheus/prometheus.yml



Add below line under rule_files: section:


  - "node-rules.yaml"



Restart the prometheus service:


systemctl restart prometheus


# Update the node group you created earlier to add another rule to get the average rate of received packets across all interfaces on a node, as each node has 2 interfaces. Please find below more details:



  (a) The record name should be node_network_receive_bytes_rate_avg.


  (b) The expression should be:


avg by(instance) (node_network_receive_bytes_rate)



  (c) Restart the prometheus service.

  # solution
  Edit /etc/prometheus/node-rules.yaml file:


vi /etc/prometheus/node-rules.yaml



Add the required rule so that the file looks like below:


groups:
  - name: node
    interval: 15s
    rules:
      - record: node_network_receive_bytes_rate
        expr: rate(node_network_receive_bytes_total{job="nodes"}[2m])
      - record: node_network_receive_bytes_rate_avg
        expr: avg by(instance) (node_network_receive_bytes_rate)



Restart the prometheus service:


systemctl restart prometheus