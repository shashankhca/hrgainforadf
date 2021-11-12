CREATE TABLE [dbo].[ADLS_Hierarchy] (
    [ID]                  INT           IDENTITY (1, 1) NOT NULL,
    [SourceSystem]        VARCHAR (30)  NULL,
    [Table_Name]          VARCHAR (250) NULL,
    [Layer]               VARCHAR (20)  NULL,
    [ContainerName]       VARCHAR (100) NULL,
    [Source_Folder_path]  VARCHAR (150) NULL,
    [Archive_Folder_Path] VARCHAR (100) NULL,
    [Failure_Folder_Path] VARCHAR (100) NULL
);

