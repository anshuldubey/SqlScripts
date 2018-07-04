DECLARE @QRY VARCHAR(MAX) = ''
DECLARE @SCHEMANAME VARCHAR(50) = 'SCHEMA_NAME'
DECLARE @TABLENAME VARCHAR(50) = 'DB_TABLE_TO_GET_A_RECORD'
DECLARE @PKColumn VARCHAR(50)= 'PRIMARY_KEY_COLUMN_NAME_HERE'
DECLARE @PKID VARCHAR(50) = 'PRIMARY_KEY_VALUE_HERE'

select @QRY = @QRY + 'SELECT '''+ co.Name +''' + '' = '+ CASE WHEN co.system_type_id = 36 THEN 'new Guid(' ELSE '' END 
+'"'' + CAST('+ co.name +' AS VARCHAR(2048)) + ''"'+ CASE WHEN co.system_type_id = 36 THEN ')' ELSE '' END +','' FROM '+ sc.Name 
+'.'+ ta.name +' WHERE '+ @PKColumn +' = ''' + @PKID + ''' UNION '
from sys.columns co
	inner join sys.tables ta on co.object_id = ta.object_id
	inner join sys.schemas sc on ta.schema_id = sc.schema_id
	where ta.name = @TABLENAME and sc.Name = @SCHEMANAME
SELECT @QRY = SUBSTRING(@QRY, 1, LEN(@QRY) - 6)
EXECUTE(@QRY)
