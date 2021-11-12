/*
Author		Shashank Jain
Date		24/09/2021
Jira		HRGA-1272
Comments	Error logging stored proc for pipeline failure.
*/



CREATE PROCEDURE [dbo].[usp_pipelineErrorLog](
	@Pipeline_ID					VARCHAR(100),
	@Pipeline_Name                  VARCHAR(100) ,     
	@Error_Description              VARCHAR(MAX)
	)

AS
  BEGIN
BEGIN TRY   
   INSERT INTO [dbo].[Error_logging] (Pipeline_ID,[Pipleline_Name],[Error_Description])
   SELECT @Pipeline_ID,@Pipeline_Name,@Error_Description

END TRY

BEGIN CATCH  
    -- Execute error retrieval routine.  
    EXECUTE dbo.usp_GetErrorInfo;  
END CATCH;  
END