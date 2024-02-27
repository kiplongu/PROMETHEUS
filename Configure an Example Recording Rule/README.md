Lab 18.1 - Configure an Example Recording Rule

In this lab exercise, you will configure an example recording rule. Let us pretend that you are
monitoring many demo service instances (not just three) and that it is expensive to calculate the total number of requests across all instances and other label sub-dimensions (path, method, etc.):

sum by(job) (rate(demo_api_request_duration_seconds_count[5m]))

You will create a recording rule to pre-record this expression into a new series with the name
job:demo_api_request_duration_seconds_count:rate5m. The recording rule will be
evaluated (and recorded) every 5 seconds, as per our initially configured global
evaluation_interval setting.

Create a new file in the same directory as your prometheus.yml called recording_rules.yml:

groups:
- name: demo-service
rules:
- record: job:demo_api_request_duration_seconds_count:rate5m
expr: |
sum by(job) (rate(demo_api_request_duration_seconds_count[5m]))

You then have to tell Prometheus to load this rule file by adding an entry to the rule_files list in the
prometheus.yml (which already references the alerting_rules.yml file). Update the
rule_files list to look like this:

rule_files:
- alerting_rules.yml
- recording_rules.yml

Reload the Prometheus configuration by sending a HUP signal to the Prometheus process:

killall -HUP prometheus

In the Prometheus server, run the following query:

job:demo_api_request_duration_seconds_count:rate5m

This should give you the same result as the original query, but only requires loading pre-computed
series. In a large setup, this could now be much faster than running the original query. You could now
also pull this aggregated metric into higher-level Prometheus servers using federation, without
burdening those servers with instance-level detail. You will learn how to do this in the next chapter.

Note: Recording rules only start writing out results starting from the time they were configured. They do not support back-filling of historical data with the results of an expression.