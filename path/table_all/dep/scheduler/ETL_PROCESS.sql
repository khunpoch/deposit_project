BEGIN
    DBMS_SCHEDULER.CREATE_JOB (
        job_name        => 'DAILY_JOB_ETL_DEP',
        job_type        => 'PLSQL_BLOCK',
        job_action      => 'BEGIN run_etl_dep ; END;',  --  call procedure ETL
        start_date      => SYSTIMESTAMP,
        repeat_interval => 'FREQ=DAILY; BYHOUR=0; BYMINUTE=0; BYSECOND=0', -- Runs every day at midnight
        enabled         => TRUE,
        comments        => 'Daily job to run ETL procedure to schema DEP '
    );
END;
/