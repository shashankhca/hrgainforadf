CREATE TABLE [dbo].[Table_List_bkp_20211025] (
    [Table_ID]                INT           IDENTITY (1, 1) NOT NULL,
    [Table_Name]              VARCHAR (50)  NULL,
    [Column_Name]             VARCHAR (MAX) NULL,
    [Transformed_Column_Name] VARCHAR (MAX) NULL,
    [Transformed_Flag]        INT           NULL,
    [Is_Active_Flag]          INT           NULL,
    [InsertionDate]           DATETIME      NULL,
    [Hash_Column]             VARCHAR (500) NULL,
    [is_Hash]                 VARCHAR (1)   NULL,
    [is_Key]                  VARCHAR (300) NULL
);

