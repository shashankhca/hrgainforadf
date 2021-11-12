CREATE TABLE [dbo].[TableLog] (
    [Pipeline_TableLogID] INT           IDENTITY (1, 1) NOT NULL,
    [SourceSystem]        VARCHAR (30)  NULL,
    [MasterPipeline_ID]   VARCHAR (400) NULL,
    [MasterPipeline_Name] VARCHAR (100) NULL,
    [Pipeline_ID]         VARCHAR (400) NULL,
    [Pipeline_Name]       VARCHAR (100) NULL,
    [Table_Name]          VARCHAR (100) NULL,
    [Load_Start_Time]     DATETIME      NULL,
    [Load_End_Time]       DATETIME      NULL,
    [Elapsed_Time]        TIME (7)      NULL,
    [Records_fetched]     BIGINT        NULL,
    [Insert_count_file]   BIGINT        NULL,
    [Insert_count_DB]     BIGINT        NULL,
    [Update_count_DB]     BIGINT        NULL,
    [SourceCount]         BIGINT        NULL,
    [TargetCount]         BIGINT        NULL,
    [Status]              VARCHAR (8)   NULL
);

