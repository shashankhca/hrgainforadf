CREATE TABLE [dbo].[ControlETLRun] (
    [RunAuditID]    INT           IDENTITY (1, 1) NOT NULL,
    [SourceSystem]  VARCHAR (30)  NULL,
    [Pipeline_ID]   VARCHAR (250) NULL,
    [Pipeline_Name] VARCHAR (100) NULL,
    [Pipeline_Type] VARCHAR (15)  NULL,
    [Pipeline_Load] VARCHAR (15)  NULL,
    [StartDatetime] DATETIME      NOT NULL,
    [EndDatetime]   DATETIME      NULL,
    [Elapsed_Time]  TIME (7)      NULL,
    [Status]        VARCHAR (8)   NULL,
    [Trigger_Name]  VARCHAR (100) NULL,
    [Trigger_Type]  VARCHAR (20)  NULL
);

