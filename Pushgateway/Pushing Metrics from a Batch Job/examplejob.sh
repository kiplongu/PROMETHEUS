cat <<EOF | curl --data-binary @- http://localhost:9091/metrics/job/demo_batch_job
# TYPE demo_batch_job_last_successful_run_timestamp_seconds gauge
# HELP demo_batch_job_last_successful_run_timestamp_seconds The Unix timestamp in seconds of the last successful batch job run.
demo_batch_job_last_successful_run_timestamp_seconds $(date +%s)
# TYPE demo_batch_job_last_run_timestamp_seconds gauge
# HELP demo_batch_job_last_run_timestamp_seconds The Unix timestamp in seconds of the last successful batch job run.
demo_batch_job_last_run_timestamp_seconds $(date +%s)
# TYPE demo_batch_job_users_deleted gauge
# HELP demo_batch_job_users_deleted How many users were deleted in the last batch job run.
demo_batch_job_users_deleted $RANDOM
EOF
