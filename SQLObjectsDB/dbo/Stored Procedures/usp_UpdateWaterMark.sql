/***************************************************************************************************  
Procedure:          [dbo].[usp_UpdateWaterMark]  
Create Date:        2021-09-28  
Author:             Viraj S. Dhokare  
Description:        Procedure to update the Timestamp in the WaterMark table.  
****************************************************************************************************  
SUMMARY OF CHANGES  
  
Date(yyyy-mm-dd)    Author              Comments  
------------------- ------------------- ------------------------------------------------------------  
2021-09-28          Viraj S. Dhokare    Initial Creation.  
2021-11-08			Shashank Jain		Added Try Catch Block
*******************************************************************************************************/  
  
CREATE PROCEDURE [dbo].[usp_UpdateWaterMark]  
@tableName				VARCHAR(100),  
@createTimestamp		DATETIME,  
@updateTimestamp        DATETIME  
AS  
 BEGIN  
 BEGIN TRY
	 UPDATE [dbo].[Watermark_Tbllist]  
	 SET [CreateTimestamp_LastFetched_Date] = @createTimestamp,  
		 [UpdateTimestamp_LastFetched_Date] = @updateTimestamp  
	 WHERE [Table_Name] = @tableName 
 END TRY
 BEGIN CATCH  
    -- Execute error retrieval routine.  
    EXECUTE dbo.usp_GetErrorInfo;  
END CATCH;  
 END