/***************************************************************************************************      
Procedure:          [dbo].[usp_GenerateSQLString]      
Create Date:        2021-09-22      
Author:             Viraj S. Dhokare      
Description:        Procedure to generate a dynamic SQL query for full/incremental load.      
****************************************************************************************************      
SUMMARY OF CHANGES      
      
Date(yyyy-mm-dd)    Author              Comments      
------------------- ------------------- ------------------------------------------------------------      
2021-09-22          Viraj S. Dhokare    Initial Creation.      
2021-09-28          Viraj S. Dhokare    Added logic to dynamically create a SQLString with the       
										WaterMark column and value, fetch the watermark column name.     
2021-10-04          Viraj S. Dhokare    Added logic to fetch the SourceFolderPath, ArchiveFolderPath      
                                        and the FailureFolderPath. 
2021-11-08          Shashank Jain		Added Try and Catch Block
      
*******************************************************************************************************/      
  
CREATE PROCEDURE [dbo].[usp_GenerateSQLString]      
 @tableName VARCHAR(100),      
 @loadType VARCHAR(10)          
      
AS      
  BEGIN      
    DECLARE @SQLString			VARCHAR(MAX)      
    DECLARE @createwatermark	VARCHAR(100)      
    DECLARE @updatewatermark	VARCHAR(100)      
    DECLARE @keyColumns         VARCHAR(500)      
    DECLARE @hashColumns        VARCHAR(MAX)      
    DECLARE @containerName      VARCHAR(100)      
    DECLARE @srcFolderPath      VARCHAR(150)      
    DECLARE @archiveFolderPath  VARCHAR(150)      
    DECLARE @failureFolderPath  VARCHAR(150)      
 BEGIN TRY     
  IF(@loadType) = 'Full'      
   BEGIN    
    UPDATE Watermark_Tbllist
	SET [CreateTimestamp_LastFetched_Date] = NULL
	WHERE [Table_Name] = @tableName

    SELECT @SQLstring = 'SELECT ' + STRING_AGG(ISNULL(CASE WHEN [Transformed_Flag] = 1       
						 THEN [Transformed_Column_Name] ELSE '"' + [Column_Name] + '"' END,''),',') + ' FROM ' + [Table_Name]       
    FROM [dbo].[Table_List]      
    WHERE [Table_Name] = @tableName      
    AND [Is_Active_Flag] = 1      
    GROUP BY [Table_Name]      
   END      
      
 ELSE      
  BEGIN      
    SELECT @SQLstring = 'SELECT ' + STRING_AGG(ISNULL(CASE WHEN Src.[Transformed_Flag] = 1       
						 THEN Src.[Transformed_Column_Name] ELSE '"' + Src.[Column_Name] + '"' END,''),',') + ' FROM ' + Src.[Table_Name]       
      + ' WHERE [' + Dst.[CreateTimestamp_WaterMark] + '] > ''' +  ISNULL(CONVERT(VARCHAR(40),Dst.[CreateTimestamp_LastFetched_Date],121),'1900-01-01 00:00:00') + ''''    
    FROM [dbo].[Table_List] Src      
    INNER JOIN Watermark_Tbllist Dst      
    ON Src.[Table_Name] = Dst.[Table_Name]      
    WHERE Src.[Table_Name] = @tableName      
    AND [Is_Active_Flag] = 1      
    GROUP BY Src.[Table_Name],Dst.[CreateTimestamp_WaterMark],Dst.[CreateTimestamp_LastFetched_Date]
  END
      
    SELECT @createwatermark = [CreateTimestamp_WaterMark],      
           @updatewatermark = [UpdateTimestamp_WaterMark]      
    FROM [dbo].[Watermark_Tbllist]      
    WHERE [Table_Name] = @tableName      
      
    SELECT @keyColumns = STRING_AGG(ISNULL('"' + [Column_name] + '"',''),',') 
    FROM Table_List      
    WHERE [Table_Name] = @tableName      
    AND [Is_Key] = 1
    AND [Is_Active_Flag] = 1
     
/* Block if Mapping Data flow used 

    SELECT @hashColumns = STRING_AGG(ISNULL([Hash_Column],''),',')      
                          FROM [dbo].[Table_List]      
                          WHERE [Table_Name] = @tableName      
                          AND [is_Hash] = 1    
*/

/* Block if Azure SQL DB used */

    SELECT @hashColumns = STRING_AGG(ISNULL('"' + CAST([Hash_Column] AS VARCHAR(MAX)) + '"',''),',')      
    FROM [dbo].[Table_List]      
    WHERE [Table_Name] = @tableName      
    AND [is_Hash] = 1   
    AND [Is_Active_Flag] = 1                      
      
    SELECT @containerName       = [ContainerName],      
           @srcFolderPath       = [Source_Folder_path],      
           @archiveFolderPath   = [Archive_Folder_Path],      
           @failureFolderPath   = [Failure_Folder_Path]      
    FROM ADLS_Hierarchy      
    WHERE [Table_Name] = @tableName      
    AND [Layer] = 'RAW'      
              
    SELECT @SQLstring AS [SQLString], @createwatermark AS [CreateTimestamp_Column], @updatewatermark AS [UpdateTimestamp_Column], @keyColumns AS [KeyColumns],       
           @hashColumns AS [HashColumns], @containerName AS [ContainerName], @srcFolderPath AS [SourceFolderPath], @archiveFolderPath AS [ArchiveFolderPath], @failureFolderPath AS [FailureFolderPath]      
                 
  END TRY
  BEGIN CATCH  
    -- Execute error retrieval routine.  
    EXECUTE dbo.usp_GetErrorInfo;  
END CATCH;  
  END 