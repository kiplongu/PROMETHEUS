Lab 15.1 - Running the Pushgateway

Let's download and run the Pushgateway.

In a new terminal, change to your home directory and download Pushgateway version 1.4.0 for Linux:

wget https://github.com/prometheus/pushgateway/releases/download/v1.4.0/pushgateway-1
.4.0.linux-amd64.tar.gz

Extract the archive:

tar xvfz pushgateway-1.4.0.linux-amd64.tar.gz

Change into the extracted directory:

cd pushgateway-1.4.0.linux-amd64

The Pushgateway does not require further configuration. If you wanted to persist pushed metrics
across restarts in a file, you could provide a value to the --persistence.file command-line flag.
For now, you can omit this flag to only keep metrics in memory.

Run the Pushgateway:

./pushgateway

The Pushgateway listens on port 9091 by default. Head to http://<machine-ip>:9091/ to
inspect its web interface. There should not be any pushed metrics visible yet.