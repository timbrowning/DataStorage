USE Master
ALTER DATABASE AdventureWorksDWX SET SINGLE_USER WITH ROLLBACK IMMEDIATE

IF EXISTS (SELECT [name] FROM [master].[sys].[databases] WHERE [name] = N'AdventureWorksDWX ')
    DROP DATABASE AdventureWorksDWX;

CREATE DATABASE [AdventureWorksDWX];
	
