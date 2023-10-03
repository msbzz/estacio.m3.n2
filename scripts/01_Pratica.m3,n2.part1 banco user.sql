---ATEN��O - NECESS�RIO ESTAR LOGADO COM 'sa' e o management ter sido inicializado
-- Cria��o do banco e usuario
USE master;
GO

-- Mata todas as conex�es para o banco de dados 'loja'
DECLARE @Kill VARCHAR(8000) = '';

SELECT @Kill = @Kill + 'KILL ' + CONVERT(VARCHAR(5), SPId) + ';'
FROM master..sysprocesses 
WHERE DBId = DB_ID('loja') AND SPId <> @@SPID;

EXEC (@Kill);

-- Agora, tente excluir o banco de dados
DROP DATABASE loja;
GO

CREATE DATABASE [loja]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'loja', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\loja.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'loja_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\loja_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [loja].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [loja] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [loja] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [loja] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [loja] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [loja] SET ARITHABORT OFF 
GO

ALTER DATABASE [loja] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [loja] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [loja] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [loja] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [loja] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [loja] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [loja] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [loja] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [loja] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [loja] SET  DISABLE_BROKER 
GO

ALTER DATABASE [loja] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [loja] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [loja] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [loja] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [loja] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [loja] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [loja] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [loja] SET RECOVERY FULL 
GO

ALTER DATABASE [loja] SET  MULTI_USER 
GO

ALTER DATABASE [loja] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [loja] SET DB_CHAINING OFF 
GO

ALTER DATABASE [loja] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO

ALTER DATABASE [loja] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO

ALTER DATABASE [loja] SET DELAYED_DURABILITY = DISABLED 
GO

ALTER DATABASE [loja] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO

ALTER DATABASE [loja] SET QUERY_STORE = ON
GO

ALTER DATABASE [loja] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO

ALTER DATABASE [loja] SET  READ_WRITE 
GO

-- cria��o do usuario loja

USE [master]

GO

IF EXISTS (SELECT 1 FROM sys.server_principals WHERE name = 'loja') 
BEGIN
    DROP LOGIN [loja] -- Substitua 'UserName' pelo nome do usu�rio
END
GO
CREATE LOGIN [loja] WITH PASSWORD=N'loja', DEFAULT_DATABASE=[loja], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF

-- Concede o papel de sistema sysadmin, que tem privil�gios de n�vel superior
-- verificar porque esta sendo necess�rio para conex�o com app
EXEC sp_addsrvrolemember 'loja', 'sysadmin';
GO

GO
USE [loja]
GO
CREATE USER [loja] FOR LOGIN [LOJA]
GO
USE [loja]
GO
ALTER ROLE [db_datareader] ADD MEMBER [LOJA]
GO
USE [loja]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [LOJA]
GO
USE [loja]
GO
ALTER ROLE [db_ddladmin] ADD MEMBER [LOJA]
GO
USE [loja]
GO
ALTER ROLE [db_owner] ADD MEMBER [LOJA]
GO

