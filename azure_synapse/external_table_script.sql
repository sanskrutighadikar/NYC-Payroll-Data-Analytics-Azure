IF NOT EXISTS (SELECT * FROM sys.external_file_formats WHERE name = 'SynapseDelimitedTextFormat') 
CREATE EXTERNAL FILE FORMAT [SynapseDelimitedTextFormat] 
WITH ( FORMAT_TYPE = DELIMITEDTEXT ,
FORMAT_OPTIONS (
FIELD_TERMINATOR = ',',
FIRST_ROW = 2,
USE_TYPE_DEFAULT = FALSE
))
GO

IF NOT EXISTS (SELECT * FROM sys.external_data_sources WHERE name = 'sanycpayrollcontainer_sanycpayroll_dfs_core_windows_net') 
	CREATE EXTERNAL DATA SOURCE [sanycpayrollcontainer_sanycpayroll_dfs_core_windows_net] 
	WITH (
		LOCATION = 'abfss://sanycpayrollcontainer@sanycpayroll.dfs.core.windows.net' 
	)
GO

CREATE EXTERNAL TABLE [dbo].[NYC_Payroll_Summary](
[FiscalYear] [int] NULL,
[AgencyName] [varchar](50) NULL,
[TotalPaid] [float] NULL
)
WITH (
LOCATION = 'dirstaging/',
DATA_SOURCE = [sanycpayrollcontainer_sanycpayroll_dfs_core_windows_net],
FILE_FORMAT = [SynapseDelimitedTextFormat]
)
GO


SELECT TOP 100 * FROM [dbo].[NYC_Payroll_Summary]
GO