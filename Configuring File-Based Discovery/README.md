Lab 13.2 - Configuring File-Based Discovery

To make Prometheus read targets from a file named targets.yml, add the following scrape
configuration to the scrape_configs stanza of your prometheus.yml file:

- job_name: 'file-sd-demo'
file_sd_configs:
- files:
- 'targets.yml'

In the same directory as your prometheus.yml, create a targets.yml file with the following
contents:

- targets:
- 'localhost:10000'
- 'localhost:10001'
labels:
env: production
- targets:
- 'localhost:10002'
labels:
env: staging

This "discovers" your existing three demo services under a second scrape job named file-sd-demo
and labels the first two instances with the env="production" label and the third one with
env="staging".
Reload the Prometheus configuration by sending a HUP signal to the Prometheus process:

killall -HUP prometheus

You can now try changing the contents of targets.yml (such as changing the env label for one of
the target groups) without reloading the Prometheus configuration. Prometheus will watch the file and
should pick up any changes automatically.

Note: When updating a file_sd targets file of a production Prometheus server, ensure that you
make any file changes atomically to avoid Prometheus seeing partially updated contents. The best
way to ensure this is to create the updated file in a separate location and then rename it to the
destination file name (using the mv shell command or the rename() system call).

You now have a generic mechanism that lets you dynamically change the targets that Prometheus
monitors without having to restart or explicitly reload the Prometheus server. Instead of making manual
changes to the targets.yml file, you would now build an integration that reads target information
from your infrastructure and updates the targets.yml file accordingly.