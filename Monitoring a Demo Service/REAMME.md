Lab 5.2 - Selecting Series
Before you can do anything more useful in PromQL, you have to learn how to select series data from
the TSDB. The simplest way to do so is to ask for all series that have a certain metric name. The query
for this is simply the metric name itself. For example:
demo_api_request_duration_seconds_count
Try executing this query (and subsequent ones) both in the Table view and the Graph view of the
expression browser. The Table view will show you the latest value for each series, while the Graph
view will show you their development over time. The Table view should look like this:


Note: Regular expressions in Prometheus are always fully anchored. That means that they always try
to match the entire string instead of just a substring. Thus you do not need to prefix the regular
expression with "^" to match the beginning of the path label value, or suffix it with "$" to match the
end. In cases where you want to allow matching substrings, you can prepend and append ".*" to the
regular expression as necessary.
In Prometheus, metric names are internally represented as just another label with the special label
name __name__. So the query:
demo_api_request_duration_seconds_count
...is equivalent to selecting the metric name by its internal __name__ label:
{__name__="demo_api_request_duration_seconds_count"}
This can sometimes be useful to select multiple metric names at once using regular expressions for
debugging purposes.
Note: So far you have selected metric names without regard for the scrape job they originated from. In
larger settings it is possible for multiple services (jobs) to expose the same metric name, but with
slightly different semantics. To be on the safe side and avoid naming collisions, always include a
selector for the job label in your series selectors. For example, instead of: