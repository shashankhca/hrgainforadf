CREATE TABLE [dbo].[Email_Configuration] (
    [Email_Configuration_ID]       INT           IDENTITY (1, 1) NOT NULL,
    [Email_Subject]                VARCHAR (100) NULL,
    [Email_Receipient_List]        VARCHAR (MAX) NULL,
    [Email_Send_Status]            VARCHAR (10)  NULL,
    [Email_Notification_Send_Time] DATETIME      NULL
);

