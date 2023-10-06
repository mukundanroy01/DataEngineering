CREATE OR REPLACE DATABASE SNOWPIPE_DB;

--Creating a connection with Azure
CREATE OR REPLACE STORAGE INTEGRATION azure_integration
TYPE = EXTERNAL_STAGE
STORAGE_PROVIDER = AZURE
ENABLED = TRUE
AZURE_TENANT_ID = '4b9bed05-6d21-4415-9bbb-c423356a6bdd'
STORAGE_ALLOWED_LOCATIONS = ('azure://azuredataengstorage.blob.core.windows.net/azuredataengcontainer/');

--Requesting access to Azure
--DESC INTEGRATION azure_integration

--Creating a File Format of Delimitted Text
CREATE OR REPLACE FILE FORMAT SNOWPIPE_DB.PUBLIC.fileformat_azure
TYPE = CSV
FIELD_DELIMITER = ','
SKIP_HEADER = 1;

--Stages (Source Files)
CREATE OR REPLACE STAGE SNOWPIPE_DB.PUBLIC.stage_azure_neoattributes
STORAGE_INTEGRATION = azure_integration
URL = 'azure://azuredataengstorage.blob.core.windows.net/azuredataengcontainer/Near_Earth_Objects/Developed/Neo_Attributes.csv'
FILE_FORMAT = fileformat_azure;

CREATE OR REPLACE STAGE SNOWPIPE_DB.PUBLIC.stage_azure_neoorbits
STORAGE_INTEGRATION = azure_integration
URL = 'azure://azuredataengstorage.blob.core.windows.net/azuredataengcontainer/Near_Earth_Objects/Developed/Neo_Orbits.csv'
FILE_FORMAT = fileformat_azure;

CREATE OR REPLACE STAGE SNOWPIPE_DB.PUBLIC.stage_azure_neodates
STORAGE_INTEGRATION = azure_integration
URL = 'azure://azuredataengstorage.blob.core.windows.net/azuredataengcontainer/Near_Earth_Objects/Developed/Neo_Dates.csv'
FILE_FORMAT = fileformat_azure;

CREATE OR REPLACE STAGE SNOWPIPE_DB.PUBLIC.stage_azure_neogrouped
STORAGE_INTEGRATION = azure_integration
URL = 'azure://azuredataengstorage.blob.core.windows.net/azuredataengcontainer/Near_Earth_Objects/Developed/Neo_Grouped.csv'
FILE_FORMAT = fileformat_azure;

--Interfacing with Azure Queue storage
CREATE OR REPLACE NOTIFICATION INTEGRATION azure_event_attributesfile
ENABLED = TRUE
TYPE = QUEUE
NOTIFICATION_PROVIDER = AZURE_STORAGE_QUEUE
AZURE_STORAGE_QUEUE_PRIMARY_URI = 'https://azuredataengstorage.queue.core.windows.net/attributesqueue'
AZURE_TENANT_ID = '4b9bed05-6d21-4415-9bbb-c423356a6bdd';

CREATE OR REPLACE NOTIFICATION INTEGRATION azure_event_orbitsfile
ENABLED = TRUE
TYPE = QUEUE
NOTIFICATION_PROVIDER = AZURE_STORAGE_QUEUE
AZURE_STORAGE_QUEUE_PRIMARY_URI = 'https://azuredataengstorage.queue.core.windows.net/orbitsqueue'
AZURE_TENANT_ID = '4b9bed05-6d21-4415-9bbb-c423356a6bdd';

CREATE OR REPLACE NOTIFICATION INTEGRATION azure_event_datesfile
ENABLED = TRUE
TYPE = QUEUE
NOTIFICATION_PROVIDER = AZURE_STORAGE_QUEUE
AZURE_STORAGE_QUEUE_PRIMARY_URI = 'https://azuredataengstorage.queue.core.windows.net/datesqueue'
AZURE_TENANT_ID = '4b9bed05-6d21-4415-9bbb-c423356a6bdd';

CREATE OR REPLACE NOTIFICATION INTEGRATION azure_event_groupedfile
ENABLED = TRUE
TYPE = QUEUE
NOTIFICATION_PROVIDER = AZURE_STORAGE_QUEUE
AZURE_STORAGE_QUEUE_PRIMARY_URI = 'https://azuredataengstorage.queue.core.windows.net/groupedqueue'
AZURE_TENANT_ID = '4b9bed05-6d21-4415-9bbb-c423356a6bdd';

--DESC NOTIFICATION INTEGRATION azure_event

--Pipes to Auto Ingest from Stages(Azure Data Lake) based on Event handled and Queue Notifications
CREATE PIPE azure_pipe1
AUTO_INGEST = TRUE
INTEGRATION = azure_event_attributesfile
AS
COPY INTO SNOWPIPE_DB.PUBLIC.NEO_ATTRIBUTES
FROM @SNOWPIPE_DB.PUBLIC.stage_azure_neoattributes;

CREATE PIPE azure_pipe2
AUTO_INGEST = TRUE
INTEGRATION = azure_event_orbitsfile
AS
COPY INTO SNOWPIPE_DB.PUBLIC.NEO_ORBITS
FROM @SNOWPIPE_DB.PUBLIC.stage_azure_neoorbits;

CREATE PIPE azure_pipe3
AUTO_INGEST = TRUE
INTEGRATION = azure_event_datesfile
AS
COPY INTO SNOWPIPE_DB.PUBLIC.NEO_DATES
FROM @SNOWPIPE_DB.PUBLIC.stage_azure_neodates;

CREATE PIPE azure_pipe4
AUTO_INGEST = TRUE
INTEGRATION = azure_event_groupedfile
AS
COPY INTO SNOWPIPE_DB.PUBLIC.NEO_GROUPED
FROM @SNOWPIPE_DB.PUBLIC.stage_azure_neogrouped;
