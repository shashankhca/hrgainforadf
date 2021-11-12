/***************************************************************************************************  
Procedure:          [dbo].[usp_TableLog]  
Create Date:        2021-09-24  
Author:             Viraj S. Dhokare  
Description:        Procedure to log the table start/end execution results.  
****************************************************************************************************  
SUMMARY OF CHANGES  
  
Date(yyyy-mm-dd)    Author              Comments  
------------------- ------------------- ------------------------------------------------------------  
2021-09-24          Viraj S. Dhokare    Initial Creation.
2021-11-08			Shashank Jain		Added try and catch block

  
*******************************************************************************************************/ 
  
CREATE PROCEDURE [dbo].[usp_TableLog]  
@isStart				VARCHAR(1),  
@pipelineID				VARCHAR(200),  
@pipelineName			VARCHAR(100),  
@tableName				VARCHAR(100),  
@sourceCount			VARCHAR(20),  
@incrementCount			VARCHAR(20),  
@fileCount				VARCHAR(20),  
@targetCount			VARCHAR(20),  
@insertedCount			VARCHAR(20),  
@updatedCount			VARCHAR(20),  
@loadStartTime			DATETIME,  
@loadEndTime			DATETIME,  
@status					VARCHAR(8),  
@masterPipelineID       VARCHAR(200),  
@masterPipelineName     VARCHAR(100),
@sourceSystem			VARCHAR(30)
  
AS  
 BEGIN  
 BEGIN TRY
  IF(@isStart = 1)  
    BEGIN  
	   INSERT INTO TableLog ([SourceSystem],[MasterPipeline_ID],[MasterPipeline_Name],[Pipeline_ID],[Pipeline_Name],[Table_Name],[Load_Start_Time])  
	   VALUES (@sourceSystem,@masterPipelineID,@masterPipelineName,@pipelineID,@pipelineName,@tableName,@loadStartTime)  
	END  
  
   ELSE  
    BEGIN  
     UPDATE TableLog  
	 SET [Load_End_Time]	  = @loadEndTime,  
		 [SourceCount]		  = @sourceCount,  
		 [Records_fetched]    = @incrementCount,  
		 [Insert_count_file]  = @fileCount,  
		 [Insert_count_DB]    = @insertedCount,  
		 [Update_count_DB]    = @updatedCount,  
		 [TargetCount]        = @targetCount,  
		 [Status]             = @status  
	 WHERE [Pipeline_ID]  = @pipelineID  
     AND [Table_Name]     = @tableName  
  
      UPDATE TableLog  
	  SET [Elapsed_Time]  = CAST(([Load_End_Time]-[Load_Start_Time]) AS TIME(0))  
	  WHERE [Pipeline_ID] = @pipelineID  
	  AND [Table_Name]	  = @tableName  
  END  
  END TRY
  BEGIN CATCH  
    -- Execute error retrieval routine.  
    EXECUTE dbo.usp_GetErrorInfo;  
END CATCH;  
 END