/***************************************************************************************************    
Procedure:          [dbo].[usp_PipelineLog]    
Create Date:        2021-09-23    
Author:             Viraj S. Dhokare    
Description:        Procedure to log the pipeline start/end execution results.    
****************************************************************************************************    
SUMMARY OF CHANGES    
    
Date(yyyy-mm-dd)    Author              Comments    
------------------- ------------------- ------------------------------------------------------------    
2021-09-23          Viraj S. Dhokare    Initial Creation.    
2021-10-05          Viraj S. Dhokare    Added parameters @pipelineType,@pipelineLoad.    
2021-10-14          Viraj S. Dhokare	Added parameter @sourceSystem.
2021-10-26          Abhilash.Gandi      Added parameter @triggerType.
2021-11-08			Shashank Jain		Added Try and Catch Block
*******************************************************************************************************/    
    
CREATE PROCEDURE [dbo].[usp_PipelineLog]    
 @isStart        VARCHAR(1),    
 @pipelineID     VARCHAR(250),    
 @pipelineName   VARCHAR(100),    
 @pipelineType   VARCHAR(15),    
 @pipelineLoad   VARCHAR(15),    
 @startDatetime  DATETIME,    
 @endDateTime    DATETIME,    
 @status         VARCHAR(8),    
 @runAuditID     BIGINT,    
 @triggerName    VARCHAR(20),
 @triggerType    VARCHAR(20),
 @sourceSystem	 VARCHAR(30)
  
AS    
 BEGIN    
 BEGIN TRY
 IF(@isStart) = 1    
     BEGIN    
	  INSERT INTO [ControlETLRun] ([SourceSystem],[Pipeline_ID],[Pipeline_Name],[Pipeline_Type],[Pipeline_Load],[StartDatetime],[Trigger_Name],[Trigger_Type])    
	  VALUES (@sourceSystem,@pipelineID,@pipelineName,@pipelineType,@pipelineLoad,@startDatetime,@triggerName,@triggerType)    
     END    
      
   ELSE    
    BEGIN    
		UPDATE ControlETLRun    
		SET [EndDatetime] = @endDateTime,    
			[Status]      = @status    
		WHERE [Pipeline_ID] = @pipelineID    
		AND [RunAuditID]    = @runAuditID
	
		UPDATE ControlETLRun    
		SET [Elapsed_Time]  = CAST(([EndDatetime]-[StartDatetime]) AS TIME(0))    
		WHERE [Pipeline_ID] = @pipelineID    
		AND [RunAuditID]    = @runAuditID    
    END    
	END TRY
	BEGIN CATCH  
    -- Execute error retrieval routine.  
    EXECUTE dbo.usp_GetErrorInfo;  
END CATCH;  
 END    
    
    