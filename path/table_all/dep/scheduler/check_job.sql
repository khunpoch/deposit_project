SELECT job_name, state, last_start_date, next_run_date
FROM dba_scheduler_jobs
WHERE job_name = 'DAILY_JOB_ETL_DEP'
;

SELECT log_id, log_date, job_name, status, additional_info
FROM dba_scheduler_job_log
WHERE job_name = 'DAILY_JOB_ETL_DEP'
;