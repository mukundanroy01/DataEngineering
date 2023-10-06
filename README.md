# DataEngineering
This repo contains files of each Data Engineering Projects.

## Project1
### ETL-Batch Processing: AzureDatafactory->Databricks->AzureSQL->Power BI
This project performs Extraction of raw data from local sql server, curate and transform using Pyspark and warehouse them into Azure SQL. Power BI is used as reporting tool to visualize the analyses handle at warehouse data.

## Project2
### Transformation of Unstructured(JSON) to Structured(CSV):AzureDatafactory->Databricks->Events/StorageQueues->Snowflake
This project performs Extraction of raw json data from datalake, perform necessary transformations and save as delimitted files using Pyspark. Event grid is configured to record the creation of these blob files and send a message to storage queue. In Snowflake, snowpipes are integrated with these azure storage queues to read notification and auto ingest the blobs created into snowflake respective datawareshouse tables. 
