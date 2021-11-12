CREATE TABLE [dbo].[Watermark_Tbllist] (
    [Watermark_ID]                     INT          IDENTITY (1, 1) NOT NULL,
    [Table_Name]                       VARCHAR (50) NULL,
    [UpdateTimestamp_WaterMark]        VARCHAR (50) NULL,
    [UpdateTimestamp_LastFetched_Date] DATETIME     NULL,
    [CreateTimestamp_WaterMark]        VARCHAR (70) NULL,
    [CreateTimestamp_LastFetched_Date] DATETIME     NULL
);

