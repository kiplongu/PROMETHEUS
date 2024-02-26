Lab 16.1 - Downloading and Configuring Alertmanager

In a new terminal, change to your home directory and download Alertmanager 0.21.0 for Linux:

wget https://github.com/prometheus/alertmanager/releases/download/v0.21.0/alertmanage
r-0.21.0.linux-amd64.tar.gz

Extract the tarball:

tar xvfz alertmanager-0.21.0.linux-amd64.tar.gz

Change into the extracted directory:

cd alertmanager-0.21.0.linux-amd64

Before starting the Alertmanager, create a simple configuration file for it. Save the following in a file
named alertmanager.yml (replace the existing default file contents):

route:
group_by: ['alertname', 'job']
group_wait: 30s
group_interval: 5m
repeat_interval: 3h
receiver: test-receiver



This configuration groups all incoming alerts by their alertname and job labels and waits 30
seconds (group_wait) before sending a notification for a grouping to see if other alerts for the same
group will still arrive. It then sends a notification containing all alerts in that group. In case new alerts
for the same group arrive after that, it will send another notification after five more minutes (group_interval).
Finally, if any alerts in the group are still firing three hours later
(repeat_interval), it will resend the notification another time.

In this simple demo configuration, there is only one top-level route that routes all alerts to a single
receiver called test-receiver. You are going to configure this receiver in the following sections.

Alternative A: Sending Notifications to Slack

If you have a Slack account (or would like to create a Slack workspace for this course), you can send
alert notifications to a channel on Slack. Otherwise, follow the Alternative B section below to send
notifications to a generic webhook receiver, which does not require any external accounts.
Create a Slack channel with an incoming webhook integration:

Create a Slack channel called #alertmanager in your Slack workspace.
Head to Slack's "Incoming WebHooks" app page.
Click the "Add Configuration" button.
Choose the #alertmanager channel in the "Post to Channel" dropdown list.
Click "Add Incoming WebHooks Integration".
Slack should now give you a webhook URL of the form:
https://hooks.slack.com/services/T00000000/B00000000/XXXXXXXXXXXXXXXXX
XXXXXXX


IMPORTANT: Replace the <slack webhook URL> placeholder with the webhook URL you just
received from Slack.

This receiver configuration sends all notifications to the #alertmanager Slack channel as the user
"Demo Alertmanager". Besides sending messages when alerts are firing, it will also notify you when a
group of alerts have been marked as resolved.

This example alerting rule instructs Prometheus to send alerts for any instance and path label
combinations that have an error rate of more than 0.5% for more than 30 seconds. Note that this for
duration is quite short, in order to quickly produce visible results. In real alerting rules, a more common
value would be 5 minutes ("for: 5m"). This rule will also attach an extra severity="critical"
label to any generated alerts. This extra label could be used to route alerts to a pager or other critical
notification mechanism via the Alertmanager routing configuration. Finally, a human-readable
description annotation is sent along with each alert, which you could choose to include in
notification templates on the Alertmanager side.