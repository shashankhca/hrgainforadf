CREATE TABLE [dbo].[Error_logging] (
    [Pipeline_ID]       VARCHAR (MAX) NULL,
    [Pipleline_Name]    VARCHAR (50)  NULL,
    [Error_Description] VARCHAR (MAX) NULL,
    [Error_Datetime]    DATETIME      DEFAULT (getdate()) NULL
);

