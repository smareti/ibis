-- Creates required tables for ibis workflow generation and ingestion

-- ibis database/schema
create database if not exists ibis;

-- checks_balances
CREATE EXTERNAL TABLE if not exists ibis.checks_balances (   directory STRING,    pull_time INT,    avro_size BIGINT,    ingest_timestamp STRING,    parquet_time INT,    parquet_size BIGINT,    rows BIGINT,    lifespan STRING,    ack INT,    cleaned INT,    current_repull INT,    esp_appl_id STRING ) PARTITIONED BY (   domain STRING,    table STRING ) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS TEXTFILE LOCATION 'hdfs://nameservice1/user/dev/data/checks_balances';

-- checks_balances_audit
CREATE TABLE if not exists ibis.checks_balances_audit (   directory STRING,    pull_time INT,    avro_size BIGINT,    ingest_timestamp STRING,    parquet_time INT,    parquet_size BIGINT,    rows STRING,    lifespan STRING,    ack INT,    cleaned INT,    domain STRING,    table STRING ) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS TEXTFILE LOCATION 'hdfs://nameservice1/user/dev/data/checks_balances_audit';

-- esp_ids
CREATE TABLE IF NOT EXISTS ibis.esp_ids ( appl_id STRING, job_name STRING, time STRING,    string_date STRING, ksh_name STRING, esp_domain STRING ) PARTITIONED BY (domain STRING, db STRING,  frequency STRING, esp_group STRING, environment STRING) STORED AS PARQUET LOCATION 'hdfs://nameservice1/user/dev/data/espids';


-- it_table
CREATE TABLE IF NOT EXISTS ibis.it_table (full_table_name STRING,    domain STRING,    target_dir STRING,    split_by STRING,    mappers INT,    jdbcurl STRING,    connection_factories STRING,    db_username STRING,    password_file STRING,    load STRING,    fetch_size INT,    hold INT,    esp_appl_id STRING,    views STRING,    esp_group STRING,    check_column STRING, source_schema_name STRING, sql_query STRING, actions STRING) PARTITIONED BY (   source_database_name STRING,    source_table_name STRING,    db_env STRING ) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' STORED AS TEXTFILE LOCATION 'hdfs://nameservice1/user/dev/data/ibis/it_table';

-- dev it table
CREATE TABLE IF NOT EXISTS ibis.dev_it_table (full_table_name STRING,    domain STRING,    target_dir STRING,    split_by STRING,    mappers INT,    jdbcurl STRING,    connection_factories STRING,    db_username STRING,    password_file STRING,    load STRING,    fetch_size INT,    hold INT,    esp_appl_id STRING,    views STRING,    esp_group STRING, check_column STRING, source_schema_name STRING, sql_query STRING, actions STRING) PARTITIONED BY (   source_database_name STRING,    source_table_name STRING,    db_env STRING ) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' STORED AS TEXTFILE LOCATION 'hdfs://nameservice1/user/dev/data/ibis/dev_it_table';

 -- int it table
 CREATE TABLE IF NOT EXISTS ibis.int_it_table (full_table_name STRING,    domain STRING,    target_dir STRING,    split_by STRING,    mappers INT,    jdbcurl STRING,    connection_factories STRING,    db_username STRING,    password_file STRING,    load STRING,    fetch_size INT,    hold INT,    esp_appl_id STRING,    views STRING,    esp_group STRING,    check_column STRING, source_schema_name STRING, sql_query STRING, actions STRING) PARTITIONED BY (   source_database_name STRING,    source_table_name STRING,    db_env STRING ) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' STORED AS TEXTFILE LOCATION 'hdfs://nameservice1/user/dev/data/ibis/int_it_table';

-- prod it table
 CREATE TABLE IF NOT EXISTS ibis.prod_it_table (full_table_name STRING,    domain STRING,    target_dir STRING,    split_by STRING,    mappers INT,    jdbcurl STRING,    connection_factories STRING,    db_username STRING,    password_file STRING,    load STRING,    fetch_size INT,    hold INT,    esp_appl_id STRING,    views STRING,    esp_group STRING,    check_column STRING, source_schema_name STRING, sql_query STRING, actions STRING) PARTITIONED BY (   source_database_name STRING,    source_table_name STRING,   db_env STRING ) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' STORED AS TEXTFILE LOCATION 'hdfs://nameservice1/user/dev/data/ibis/prod_it_table';

-- integration tests - it table
CREATE TABLE IF NOT EXISTS ibis.int_tests_it_table (full_table_name STRING,    domain STRING,    target_dir STRING,    split_by STRING,    mappers INT,    jdbcurl STRING,    connection_factories STRING,    db_username STRING,    password_file STRING,    load STRING,    fetch_size INT,    hold INT,    esp_appl_id STRING,    views STRING,    esp_group STRING,    check_column STRING, source_schema_name STRING, sql_query STRING, actions STRING) PARTITIONED BY (   source_database_name STRING,    source_table_name STRING,   db_env STRING ) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' STORED AS TEXTFILE LOCATION 'hdfs://nameservice1/user/dev/data/ibis/int_tests_it_table';

-- integration tests - it table export
CREATE TABLE IF NOT EXISTS ibis.int_tests_it_table_export ( full_table_name STRING,source_dir STRING, mappers INT, jdbcurl STRING, connection_factories STRING, db_username STRING, password_file STRING,  frequency STRING,  fetch_size INT, target_schema STRING,  target_table STRING, staging_database STRING  )   PARTITIONED BY (  source_database_name STRING, source_table_name STRING,    db_env STRING) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' STORED AS TEXTFILE LOCATION 'hdfs://nameservice1/user/dev/data/ibis/int_tests_it_table_export'

--pha_table
CREATE TABLE IF NOT EXISTS imdw_dev.it_table (   full_table_name STRING,    domain STRING,    target_dir STRING,    split_by STRING,    mappers INT,    jdbcurl STRING,    connection_factories STRING,    db_username STRING,    password_file STRING,    load STRING,    fetch_size INT,    hold INT,    esp_appl_id STRING,    views STRING,    esp_group STRING,    check_column STRING, source_schema_name STRING, sql_query STRING, actions STRING) PARTITIONED BY (source_database_name string,    source_table_name string, db_env STRING)  ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' STORED AS TEXTFILE LOCATION 'hdfs://nameservice1/user/dev/data/ibis/imdw_dev.it_table';

-- table for logging qa action results
CREATE TABLE IF NOT EXISTS ibis.qa_resultsv2 (log_time TIMESTAMP, table_name STRING, log STRING, status STRING) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' WITH SERDEPROPERTIES ('serialization.format'='|', 'field.delim'='|') STORED AS TEXTFILE LOCATION 'hdfs://nameservice1/user/hive/warehouse/ibis.db/qa_resultsv2';

-- staging_it_table
-- this table is a sort of staging table to it_table
CREATE TABLE IF NOT EXISTS ibis.staging_it_table (requestor STRING, request_time timestamp, desc STRING, resolved BOOLEAN, dirty_column STRING, esp_group STRING, full_table_name STRING,    domain STRING,    target_dir STRING,    split_by STRING,    mappers INT,    jdbcurl STRING,    connection_factories STRING,    db_username STRING,    password_file STRING,    load STRING,    fetch_size INT,    hold INT, esp_appl_id STRING, views STRING, source_database_name STRING,    source_table_name STRING,    check_column STRING,    source_schema_name STRING,  sql_query STRING,   actions STRING) PARTITIONED BY (resolve_id STRING) STORED AS PARQUET LOCATION 'hdfs://nameservice1/user/dev/data/ibis/staging_it_table';

-- staging_it_table - integration tests
CREATE TABLE IF NOT EXISTS ibis.staging_it_table (requestor STRING, request_time timestamp, desc STRING, resolved BOOLEAN, dirty_column STRING, esp_group STRING, full_table_name STRING,    domain STRING,    target_dir STRING,    split_by STRING,    mappers INT,    jdbcurl STRING,    connection_factories STRING,    db_username STRING,    password_file STRING,    load STRING,    fetch_size INT,    hold INT, esp_appl_id STRING, views STRING, source_database_name STRING,    source_table_name STRING,    check_column STRING,    source_schema_name STRING,  sql_query STRING,   actions STRING) PARTITIONED BY (resolve_id STRING) STORED AS PARQUET LOCATION 'hdfs://nameservice1/user/dev/data/ibis/staging_it_table';

-- prod_it_table_export : table for logging export table entry
CREATE TABLE ibis.prod_it_table_export ( full_table_name STRING,source_dir STRING, mappers INT, jdbcurl STRING, connection_factories STRING, db_username STRING, password_file STRING,  frequency STRING,  fetch_size INT, target_schema STRING,  target_table STRING, staging_database STRING  )   PARTITIONED BY (  source_database_name STRING, source_table_name STRING,    db_env STRING) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' STORED AS TEXTFILE LOCATION 'hdfs://nameservice1/user/dev/data/ibis/prod_it_table_export'

-- int_it_table_export : table for logging export table entry
CREATE TABLE ibis.int_it_table_export ( full_table_name STRING,source_dir STRING, mappers INT, jdbcurl STRING, connection_factories STRING, db_username STRING, password_file STRING,  frequency STRING,  fetch_size INT, target_schema STRING,  target_table STRING, staging_database STRING  )   PARTITIONED BY (  source_database_name STRING, source_table_name STRING,    db_env STRING) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' STORED AS TEXTFILE LOCATION 'hdfs://nameservice1/user/dev/data/ibis/int_it_table_export'

-- dev_it_table_export : table for logging export table entry
CREATE TABLE ibis.dev_it_table_export ( full_table_name STRING,source_dir STRING, mappers INT, jdbcurl STRING, connection_factories STRING, db_username STRING, password_file STRING,  frequency STRING,  fetch_size INT, target_schema STRING,  target_table STRING, staging_database STRING  )   PARTITIONED BY (  source_database_name STRING, source_table_name STRING, db_env    STRING) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' STORED AS TEXTFILE LOCATION 'hdfs://nameservice1/user/dev/data/ibis/dev_it_table_export'

-- export_checks_balances
CREATE TABLE ibis.checks_balances_export ( directory STRING, push_time INT, txt_size BIGINT, export_timestamp STRING, parquet_time INT, parquet_size BIGINT, row_count BIGINT, lifespan STRING, ack INT, cleaned INT, current_repull INT, esp_appl_id STRING   )   PARTITIONED BY ( domain STRING, table_name STRING  )   ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'   WITH SERDEPROPERTIES ('serialization.format'='\t', 'field.delim'='\t')  STORED AS TEXTFILE  LOCATION 'hdfs://nameservice1/user/dev/data/checks_balances_export'

-- table for logging qa action results for export
CREATE TABLE ibis.qa_export_results ( log_time TIMESTAMP,  table_name STRING, log STRING, status STRING  ) WITH SERDEPROPERTIES ('serialization.format'='1') STORED AS TEXTFILE  LOCATION 'hdfs://nameservice1/user/hive/warehouse/ibis.db/qa_export_results'

--table for freq_ingest
CREATE TABLE `ibis.freq_ingest`(   `frequency` string,   `activate` string) PARTITIONED BY (   `view_name` string,   `full_table_name` string)  WITH SERDEPROPERTIES ('serialization.format'='1') STORED AS TEXTFILE  LOCATION 'hdfs://nameservice1/user/dev/data/ibis/freq_ingest'

-- table for teradata split_by replace {0} with servername wdctd,wdctd2
CREATE TABLE ibis.teradata_split_{0} (   databasename STRING,   tablename STRING,   indexnumber SMALLINT,   indextype CHAR(1),   uniqueflag CHAR(1),   columnname STRING,   columnposition SMALLINT,   columntyped STRING,   nullable CHAR(1),   rank1 STRING ) WITH SERDEPROPERTIES ('serialization.format'='1') STORED AS TEXTFILE LOCATION 'hdfs://nameservice1/user/hive/warehouse/ibis.db/teradata_split_{0}' TBLPROPERTIES ('totalSize'='136662', 'numRows'='2191', 'rawDataSize'='134471', 'COLUMN_STATS_ACCURATE'='true', 'numFiles'='1')

