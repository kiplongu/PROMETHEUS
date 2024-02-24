Instrumenting an Example Service
Let’s instrument an example service. You can either choose to instrument an example based on Go or
based on Python. Both implement a demo API on port 12345 which processes dummy API requests
at the HTTP paths /api/foo and /api/bar with different latencies. They also run a periodic batch
job in the background which can fail with a certain probability. Try adding metrics for the following:

The request latency distribution for each path of the API.
The number of total vs. failed batch job runs.
The timestamp of the last successful batch job run.
Other metrics that you can think of.

In a new terminal, clone the git repository containing both the Go and the Python example code:

git clone https://github.com/juliusv/instrumentation-exercise




