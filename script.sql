USE [master]
GO
/****** Object:  Database [THI_TN]    Script Date: 31/05/2022 8:31:51 AM ******/
CREATE DATABASE [THI_TN]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'THI_TN', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\THI_TN.mdf' , SIZE = 28672KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'THI_TN_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\THI_TN_log.ldf' , SIZE = 20096KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [THI_TN] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [THI_TN].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [THI_TN] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [THI_TN] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [THI_TN] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [THI_TN] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [THI_TN] SET ARITHABORT OFF 
GO
ALTER DATABASE [THI_TN] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [THI_TN] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [THI_TN] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [THI_TN] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [THI_TN] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [THI_TN] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [THI_TN] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [THI_TN] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [THI_TN] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [THI_TN] SET  DISABLE_BROKER 
GO
ALTER DATABASE [THI_TN] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [THI_TN] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [THI_TN] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [THI_TN] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [THI_TN] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [THI_TN] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [THI_TN] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [THI_TN] SET RECOVERY FULL 
GO
ALTER DATABASE [THI_TN] SET  MULTI_USER 
GO
ALTER DATABASE [THI_TN] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [THI_TN] SET DB_CHAINING OFF 
GO
ALTER DATABASE [THI_TN] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [THI_TN] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [THI_TN] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'THI_TN', N'ON'
GO
USE [THI_TN]
GO
/****** Object:  User [HTKN]    Script Date: 31/05/2022 8:31:51 AM ******/
CREATE USER [HTKN] FOR LOGIN [HTKN] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  DatabaseRole [MSmerge_PAL_role]    Script Date: 31/05/2022 8:31:51 AM ******/
CREATE ROLE [MSmerge_PAL_role]
GO
/****** Object:  DatabaseRole [MSmerge_E095246DE4E348E8823D48534B516527]    Script Date: 31/05/2022 8:31:51 AM ******/
CREATE ROLE [MSmerge_E095246DE4E348E8823D48534B516527]
GO
/****** Object:  DatabaseRole [MSmerge_975039493A4948AA88A1988549D3773C]    Script Date: 31/05/2022 8:31:51 AM ******/
CREATE ROLE [MSmerge_975039493A4948AA88A1988549D3773C]
GO
/****** Object:  DatabaseRole [MSmerge_46C10247474F4354BD7434589D1F3150]    Script Date: 31/05/2022 8:31:51 AM ******/
CREATE ROLE [MSmerge_46C10247474F4354BD7434589D1F3150]
GO
ALTER ROLE [db_owner] ADD MEMBER [HTKN]
GO
ALTER ROLE [MSmerge_PAL_role] ADD MEMBER [MSmerge_E095246DE4E348E8823D48534B516527]
GO
ALTER ROLE [MSmerge_PAL_role] ADD MEMBER [MSmerge_975039493A4948AA88A1988549D3773C]
GO
ALTER ROLE [MSmerge_PAL_role] ADD MEMBER [MSmerge_46C10247474F4354BD7434589D1F3150]
GO
/****** Object:  Schema [MSmerge_PAL_role]    Script Date: 31/05/2022 8:31:52 AM ******/
CREATE SCHEMA [MSmerge_PAL_role]
GO
/****** Object:  UserDefinedFunction [dbo].[checkedMH]    Script Date: 31/05/2022 8:31:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[checkedMH] 
(
	@maMH char(5), @ngayThi datetime
)

returns varchar(1) 
as
begin 
	declare @count int = 0, @checked varchar(1)
	select @count = count(*) from BANGDIEM where BANGDIEM.MAMH = @maMH  and BANGDIEM.DIEM is not null and BANGDIEM.NGAYTHI = @ngayThi
	if @count > 0
		set @checked = 'X'
	else 
		set @checked = ''
	return @checked
end;
GO
/****** Object:  UserDefinedFunction [dbo].[letterTolevel]    Script Date: 31/05/2022 8:31:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[letterTolevel] ( @trinhDo nchar(1))
returns nvarchar(400) as
begin 
	declare @return nvarchar(400)
	if @trinhDo = 'A'
		set @return = N'Đại học, chuyên ngành'
	else if @trinhDo = 'B'
		set @return = N'Đại học, không chuyên ngành'
	else 
		set @return = N'Cao đẳng'
	return @return
end;
GO
/****** Object:  UserDefinedFunction [dbo].[numTotext]    Script Date: 31/05/2022 8:31:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[numTotext] (@num float)
returns nvarchar(4000) as
BEGIN
	DECLARE @sNumber nvarchar(4000)
	DECLARE @Return	nvarchar(4000)
	DECLARE @mLen int
	DECLARE @i int

	DECLARE @mDigit char(1)
	DECLARE @mTemp nvarchar(4000)
	DECLARE @mNumText nvarchar(4000)

	SELECT @sNumber=LTRIM(cast(@num as nvarchar))
	SELECT @mLen = Len(@sNumber)

	if @mLen =2
		BEGIN
			SELECT @Return = N'Mười'
			RETURN @Return
		END
	SELECT @i=1
	SELECT @mTemp=''

	WHILE @i <= @mLen
		BEGIN

		SELECT @mDigit=SUBSTRING(@sNumber, @i, 1)

		IF @mDigit='0' SELECT @mNumText=N'không'
		ELSE
			BEGIN
			IF @mDigit='1' SELECT @mNumText=N'một'
			ELSE
			IF @mDigit='2' SELECT @mNumText=N'hai'
			ELSE
			IF @mDigit='3' SELECT @mNumText=N'ba'
			ELSE
			IF @mDigit='4' SELECT @mNumText=N'bốn'
			ELSE
			IF @mDigit='5' SELECT @mNumText=N'năm'
			ELSE
			IF @mDigit='6' SELECT @mNumText=N'sáu'
			ELSE
			IF @mDigit='7' SELECT @mNumText=N'bảy'
			ELSE
			IF @mDigit='8' SELECT @mNumText=N'tám'
			ELSE
			IF @mDigit='9' SELECT @mNumText=N'chín'
			ELSE 
			IF @mDigit='.' SELECT @mNumText=N'phẩy'
			END

		SELECT @mTemp = @mTemp + ' ' + @mNumText

		IF (@mLen = @i) BREAK
		
		IF @i =3
			SELECT @mTemp = @mTemp + N' mươi'
		SELECT @i=@i+1
		END


	SELECT @mTemp = Replace(@mTemp, N'không mươi ', N'không ')

	SELECT @mTemp = Replace(@mTemp, N'một mươi', N'mười')

	SELECT @mTemp = Replace(@mTemp, N'mươi năm', N'mươi lăm')

	--'Fix trường hợp x1, x>=2

	SELECT @mTemp = Replace(@mTemp, N'mươi một', N'mươi mốt')

	--'Bỏ ký tự space

	SELECT @mTemp = LTrim(@mTemp)

	--'Ucase ký tự đầu tiên

	SELECT @Return=UPPER(Left(@mTemp, 1)) + SUBSTRING(@mTemp,2, 4000)

	RETURN @Return
END

GO
/****** Object:  Table [dbo].[BAITHI]    Script Date: 31/05/2022 8:31:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BAITHI](
	[CAUHOI] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[CAUSO] [char](5) NOT NULL,
	[NOIDUNG] [ntext] NULL,
	[A] [ntext] NULL,
	[B] [ntext] NULL,
	[C] [ntext] NULL,
	[D] [ntext] NULL,
	[DAP_AN] [char](1) NULL,
	[DACHON] [nchar](1) NULL,
	[MABD] [nchar](20) NOT NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [MSmerge_df_rowguid_674CDA16773D4A91B75910843CDD2531]  DEFAULT (newsequentialid())
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BANGDIEM]    Script Date: 31/05/2022 8:31:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BANGDIEM](
	[MASV] [char](8) NOT NULL,
	[MAMH] [char](5) NOT NULL,
	[LAN] [smallint] NOT NULL,
	[NGAYTHI] [datetime] NULL,
	[DIEM] [float] NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [MSmerge_df_rowguid_FD684F6B3B384EB997F42D8A4F9CCD04]  DEFAULT (newsequentialid()),
 CONSTRAINT [PK_BANGDIEM] PRIMARY KEY CLUSTERED 
(
	[MASV] ASC,
	[MAMH] ASC,
	[LAN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BODE]    Script Date: 31/05/2022 8:31:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BODE](
	[CAUHOI] [int] NOT NULL,
	[MAMH] [char](5) NULL,
	[TRINHDO] [char](1) NULL,
	[NOIDUNG] [ntext] NULL,
	[A] [ntext] NULL,
	[B] [ntext] NULL,
	[C] [ntext] NULL,
	[D] [ntext] NULL,
	[DAP_AN] [char](1) NULL,
	[MAGV] [char](8) NOT NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [MSmerge_df_rowguid_6282160E1905435B94366ED8615E0AF0]  DEFAULT (newsequentialid()),
 CONSTRAINT [PK_BODE] PRIMARY KEY CLUSTERED 
(
	[CAUHOI] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[COSO]    Script Date: 31/05/2022 8:31:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[COSO](
	[MACS] [nchar](3) NOT NULL,
	[TENCS] [nvarchar](50) NOT NULL,
	[DIACHI] [nvarchar](100) NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [MSmerge_df_rowguid_04D52147B3F64A9E82503BC068FB2C02]  DEFAULT (newsequentialid()),
 CONSTRAINT [PK_COSO] PRIMARY KEY CLUSTERED 
(
	[MACS] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[GIAOVIEN]    Script Date: 31/05/2022 8:31:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GIAOVIEN](
	[MAGV] [char](8) NOT NULL,
	[HO] [nvarchar](50) NULL,
	[TEN] [nvarchar](10) NULL,
	[DIACHI] [nvarchar](50) NULL,
	[MAKH] [nchar](8) NOT NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [MSmerge_df_rowguid_DE5363A80E734EAC92ECE27D4B6B7625]  DEFAULT (newsequentialid()),
 CONSTRAINT [PK_GIAOVIEN] PRIMARY KEY CLUSTERED 
(
	[MAGV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GIAOVIEN_DANGKY]    Script Date: 31/05/2022 8:31:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GIAOVIEN_DANGKY](
	[MAGV] [char](8) NULL,
	[MAMH] [char](5) NOT NULL,
	[MALOP] [nchar](15) NOT NULL,
	[TRINHDO] [char](1) NULL,
	[NGAYTHI] [datetime] NULL,
	[LAN] [smallint] NOT NULL,
	[SOCAUTHI] [smallint] NULL,
	[THOIGIAN] [smallint] NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [MSmerge_df_rowguid_B954BA670B494DA48F48C96690AC7861]  DEFAULT (newsequentialid()),
 CONSTRAINT [PK_GIAOVIEN_DANGKY] PRIMARY KEY CLUSTERED 
(
	[MAMH] ASC,
	[MALOP] ASC,
	[LAN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[KHOA]    Script Date: 31/05/2022 8:31:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KHOA](
	[MAKH] [nchar](8) NOT NULL,
	[TENKH] [nvarchar](50) NOT NULL,
	[MACS] [nchar](3) NOT NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [MSmerge_df_rowguid_9B1929C283B348BBA302EDC9EECF2946]  DEFAULT (newsequentialid()),
 CONSTRAINT [PK_KHOA] PRIMARY KEY CLUSTERED 
(
	[MAKH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[LOP]    Script Date: 31/05/2022 8:31:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LOP](
	[MALOP] [nchar](15) NOT NULL,
	[TENLOP] [nvarchar](50) NOT NULL,
	[MAKH] [nchar](8) NOT NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [MSmerge_df_rowguid_C80A11EB5F51407995A1F0C84BC5722B]  DEFAULT (newsequentialid()),
 CONSTRAINT [PK_LOP] PRIMARY KEY CLUSTERED 
(
	[MALOP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MONHOC]    Script Date: 31/05/2022 8:31:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MONHOC](
	[MAMH] [char](5) NOT NULL,
	[TENMH] [nvarchar](50) NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [MSmerge_df_rowguid_A1CC7A6487F3445989DAC71F76889BD8]  DEFAULT (newsequentialid()),
 CONSTRAINT [PK_TENMH] PRIMARY KEY CLUSTERED 
(
	[MAMH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SINHVIEN]    Script Date: 31/05/2022 8:31:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SINHVIEN](
	[MASV] [char](8) NOT NULL,
	[HO] [nvarchar](50) NULL,
	[TEN] [nvarchar](10) NULL,
	[NGAYSINH] [date] NULL,
	[DIACHI] [nvarchar](100) NULL,
	[MALOP] [nchar](15) NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [MSmerge_df_rowguid_58D6FD625F4E4EA3A718BCF4122ED930]  DEFAULT (newsequentialid()),
	[MATKHAU] [nvarchar](50) NULL,
 CONSTRAINT [PK_SINHVIEN] PRIMARY KEY CLUSTERED 
(
	[MASV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  View [dbo].[Get_Subscribes]    Script Date: 31/05/2022 8:31:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[Get_Subscribes]
as 
SELECT PUBS.description AS TENCS, SUBS.subscriber_server AS TENSERVER
FROM     dbo.sysmergepublications AS PUBS INNER JOIN
                  dbo.sysmergesubscriptions AS SUBS ON PUBS.pubid = SUBS.pubid AND PUBS.publisher <> SUBS.subscriber_server AND PUBS.publication_type <> 0
GO
SET IDENTITY_INSERT [dbo].[BAITHI] ON 

INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2412, N'22   ', N'For business relations to continue between our two firms, satisfactory agreement must be ...... reached and signer', N'yet', N'both', N'either ', N'as well as', N'C', N'C', N'001AVCB1            ', N'ed29923f-ccdc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2413, N'55   ', N'MS. Galera gave a long...... in honor of the retiring vice-president', N'speak', N'speaker', N'speaking', N'speech', N'D', N'D', N'001AVCB1            ', N'ee29923f-ccdc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2414, N'51   ', N'A free watch will be provided with every purchase of $20.00 or more a ........ period of time', N'limit', N'limits', N'limited', N'limiting', N'C', N'C', N'001AVCB1            ', N'ef29923f-ccdc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2416, N'50   ', N'Aswering telephone calls is the..... of an operator', N'responsible', N'responsibly', N'responsive', N'responsibility', N'D', N'D', N'001AVCB1            ', N'f129923f-ccdc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2425, N'53   ', N'Because we value your business, we have .......for card members like you to receive one thousand  dollars of complimentary life insurance', N'arrange', N'arranged', N'arranges', N'arranging', N'B', N' ', N'001AVCB1            ', N'fa29923f-ccdc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2426, N'29   ', N'Conservatives predict that government finaces will remain...... during the period of the investigation', N'authoritative', N'summarized', N'examined', N'stable', N'D', N' ', N'001AVCB1            ', N'fb29923f-ccdc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2427, N'58   ', N'The customers were told that no ........could be made on weekend nights because the restaurant was too busy', N'delays', N'cuisines', N'reservation', N'violations', N'C', N' ', N'001AVCB1            ', N'fc29923f-ccdc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2428, N'26   ', N'The present government has an excellent ......to increase exports', N'popularity', N'regularity', N'celebrity', N'opportunity', N'D', N' ', N'001AVCB1            ', N'fd29923f-ccdc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2429, N'23   ', N'The corporation, which underwent a major restructing seven years ago, has been growing steadily ......five years', N'for', N'on', N'from', N'since', N'A', N' ', N'001AVCB1            ', N'fe29923f-ccdc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2430, N'21   ', N'Board members ..... carefully define their goals and objectives for the agency before the monthly meeting next week.', N'had', N'should', N'used ', N'have', N'B', N' ', N'001AVCB1            ', N'ff29923f-ccdc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2431, N'25   ', N'Two assistants will be required to ...... reporter''s names when they arrive at the press conference', N'remark', N'check', N'notify', N'ensure', N'B', N' ', N'001AVCB1            ', N'002a923f-ccdc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2433, N'126  ', N'Tốc độ của đường truyền T1 là:', N'2048 Mbps', N'1544 Mbps', N'155 Mbps', N'56 Kbps', N'B', N' ', N'001MMTCB2           ', N'847a2418-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2437, N'13   ', N'Chức năng của cấp vật lý(physical)', N'Qui định truyền 1 hay 2 chiều', N'Quản lý lỗi sai', N'Xác định thời gian truyền 1 bit dữ liệu', N'Quản lý địa chỉ vật lý', N'C', N' ', N'001MMTCB2           ', N'887a2418-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2450, N'109  ', N'Khoảng cách đường truyền tối đa mạng FDDI có thể đạt', N'1Km', N'10Km', N'100Km', N'1000Km', N'C', N' ', N'001MMTCB2           ', N'957a2418-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2451, N'104  ', N'Loại mạng nào dùng 2 loại frame khác nhau trên đường truyền', N'Token-ring', N'Token-bus', N'Ethernet', N'Tất cả đều sai', N'A', N' ', N'001MMTCB2           ', N'967a2418-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2452, N'83   ', N'Mạng máy tính thường sử dụng loại chuyển mach', N'Gói (packet switch)', N'Kênh (Circuit switch)', N'Thông báo(message switch)', N'Tất cả đều đúng', N'A', N' ', N'001MMTCB2           ', N'977a2418-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2453, N'139  ', N'Khi 1 cầu nối ( bridge) nhận được 1 framechưa biết thông tin về địa chỉ máy nhận, nó sẽ', N'Xóa bỏ frame này', N'Gửi trả lại máy gốc', N'Gửi đến mọi ngõ ra còn lại', N'Giảm thời gian sống của frame đi 1 đơn vị và gửi đến mọi ngõ ra còn lại', N'C', N' ', N'001MMTCB2           ', N'987a2418-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2454, N'7    ', N'mạng man không kết nối theo sơ đồ:', N'bus', N'ring', N'star', N'tree', N'D', N' ', N'001MMTCB2           ', N'997a2418-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2455, N'88   ', N'Nguyên nhân gây sai sót khi gửi/nhận dữ liệu trên mạng', N'Mất đồng bộ trong khi truyền', N'Nhiễu từ môi trường', N'Lỗi phần cứng hoặc phần mềm', N'Tất cả đều đúng ', N'D', N' ', N'001MMTCB2           ', N'9a7a2418-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2456, N'115  ', N'Cấp appliation trong mô hình TCP/IP tương đương với cấp nào trong mô hình OSI', N'Session', N'Application', N'Presentation', N'Tất cả đều đúng', N'D', N' ', N'001MMTCB2           ', N'9b7a2418-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2457, N'98   ', N'Chuẩn mạng nào có khả năng pkhát hiện xung đột (collision) trong khi truyền', N'1-persistent CSMA', N'p-persistent CSMA', N'Non-persistent CSMA', N'CSMA/CD', N'D', N' ', N'001MMTCB2           ', N'9c7a2418-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2458, N'5    ', N'mạng man được sử dụng trong phạm vi:', N'quốc gia', N'lục địa', N'khu phố', N'thành phố', N'D', N' ', N'001MMTCB2           ', N'9d7a2418-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2459, N'112  ', N'Kiểu datagram trong cấp network', N'Chỉ tìm đường 1 lần khi tạo kết nối', N'Phải tìm đường riêng cho từng packet', N'THông tin có sẵn trong packet, không cần tìm đường', N'Thông tin có sẵn trong router , không cần tìm đường', N'B', N' ', N'001MMTCB2           ', N'9e7a2418-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2460, N'3    ', N'để một máy tính truyền dữ liệu cho một số máy khác trong mạng, ta dùng loại địa chỉ', N'Broadcast', N'Broadband', N'multicast', N'multiple access', N'C', N' ', N'001MMTCB2           ', N'9f7a2418-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2461, N'103  ', N'Loại mạng nào không có độ ưu tiên', N'Ethernet', N'Token-ring', N'Token-bus', N'Tất cả đều sai', N'D', N' ', N'001MMTCB2           ', N'a07a2418-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2462, N'19   ', N'chọn câu sai trong các nguyên lý phân cấp của mô hình osi', N'mỗi cấp thực hiện 1 chức năng rõ ràng', N'mỗi cấp được chọn sao cho thông tin trao đổi giữa các cấp tối thiểu', N'mỗi cấp được tạo ra ứng với 1 mức trừu tượng hóa', N'mỗi cấp phải cung cấp cùng một kiểu địa chỉ và dịch vụ', N'D', N' ', N'001MMTCB2           ', N'a17a2418-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2463, N'14   ', N'Chức năng câp liên kết dữ liệu (data link)', N'Quản lý lỗi sai', N'Mã hóa dữ liệu', N'Tìm đường đi cho dữ liệu', N'Chọn kênh truyền', N'A', N' ', N'001MMTCB2           ', N'a27a2418-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2464, N'128  ', N'Loại frame nào được sử dụng trong mạng Token-ring', N'Monitor', N'Token', N'Data', N'Token và Data', N'D', N' ', N'001MMTCB2           ', N'a37a2418-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2472, N'82   ', N'Đường truyền E1 gồm 32 kênh, trong đó sử dụng cho dữ liệu là:', N'32 kênh', N'31 kênh', N'30 kênh', N'24 kênh', N'C', N'B', N'001MMTCB1           ', N'cffde37e-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2474, N'111  ', N'Kiểu mạch ảo(virtual circuit) được dùng trong loại dịch vụ mạng', N'Có kết nối', N'Không kết nối', N'Truyền 1 chiều', N'Truyền 2 chiều', N'A', N' ', N'001MMTCB1           ', N'd1fde37e-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2479, N'132  ', N'Thứ tự các cấp trong mô hình OSI', N'Application,Session,Transport,Physical', N'Application, Transport, Network, Physical', N'Application, Presentation,Session,Network,Transport,Data link,Physical', N'Application,Presentation,Session,Transport,Network,Data link,Physical', N'D', N' ', N'001MMTCB1           ', N'd6fde37e-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2480, N'114  ', N'Nguyên nhân dẫn đến tắt nghẻn (congestion) trên mạng', N'Tốc độ xử lý của router chậm', N'Buffers trong router nhỏ', N'Router có nhiều đường vào nhưng ít đường ra', N'Tất cả đều đúng', N'D', N' ', N'001MMTCB1           ', N'd7fde37e-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2483, N'89   ', N'Để tránh sai sót khi truyền dữ liệu trong cấp data link', N'Đánh số thứ tự frame', N'Quản lý dữ liệu theo frame', N'Dùng vùng checksum', N'Tất cả đều đúng', N'D', N' ', N'001MMTCB1           ', N'dafde37e-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2485, N'103  ', N'Loại mạng nào không có độ ưu tiên', N'Ethernet', N'Token-ring', N'Token-bus', N'Tất cả đều sai', N'D', N' ', N'001MMTCB1           ', N'dcfde37e-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2486, N'129  ', N'Thuật ngữ OSI là viết tắt bởi', N'Organization for Standard Institude', N'Organization for Standard Internet', N'Open Standard Institude', N'Open System Interconnection', N'D', N' ', N'001MMTCB1           ', N'ddfde37e-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2492, N'109  ', N'Khoảng cách đường truyền tối đa mạng FDDI có thể đạt', N'1Km', N'10Km', N'100Km', N'1000Km', N'C', N' ', N'001MMTCB1           ', N'e3fde37e-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2493, N'91   ', N'Hoạt động của protocol Stop and Wait', N'Chờ một khoảng thời gian time-out rồi gửi tiếp frame kế', N'Chờ 1 khoảng thời gian time-out rồi gửi lại frame trước', N'Chờ nhận được ACK của frame trước mới gửi tiếp frame kế', N'Không chờ mà gửi liên tiếp các frame kế nhau', N'C', N' ', N'001MMTCB1           ', N'e4fde37e-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2494, N'119  ', N'Dịch vụ truyền Email sử dụng protocol nào?', N'HTTP', N'NNTP', N'SMTP', N'FTP', N'C', N' ', N'001MMTCB1           ', N'e5fde37e-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2527, N'8    ', N'kiến trúc mạng (network architechture) là:', N'tập các chức năng trong mạng', N'tập các cấp và các protocol trong mỗi cấp', N'tập các dịch vụ trong mạng', N'tập các protocol trong mạng', N'B', N' ', N'004MMTCB1           ', N'51ad7291-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2415, N'57   ', N'Mr.Gonzales was very concerned.........the upcoming board of directors meeting', N'to', N'about', N'at ', N'upon', N'B', N'B', N'001AVCB1            ', N'f029923f-ccdc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2417, N'24   ', N'Making advance arrangements for audiovisual equipment is....... recommended for all seminars.', N'sternly', N'strikingly', N'stringently', N'strongly', N'A', N' ', N'001AVCB1            ', N'f229923f-ccdc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2418, N'56   ', N'Any person who is........ in volunteering his or her time for the campaign should send this office a letter of intent', N'interest', N'interested', N'interesting', N'interestingly', N'B', N' ', N'001AVCB1            ', N'f329923f-ccdc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2419, N'54   ', N'Employees are........that due to the new government regulations. there is to be no smoking in the factory', N'reminded', N'respected', N'remembered', N'reacted', N'A', N' ', N'001AVCB1            ', N'f429923f-ccdc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2420, N'27   ', N'While you are in the building, please wear your identification badge at all times so that you are ....... as a company employee.', N'recognize', N'recognizing', N'recognizable', N'recognizably', N'C', N' ', N'001AVCB1            ', N'f529923f-ccdc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2421, N'59   ', N'The sales representive''s presentation was difficult to understand ........ he spoke very quickly', N'because', N'althought', N'so that', N'than', N'A', N' ', N'001AVCB1            ', N'f629923f-ccdc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2422, N'20   ', N'The publishers suggested that the envelopes be sent to ...... by courier so that the film can be developed as soon as possible', N'they', N'their', N'theirs', N'them', N'A', N' ', N'001AVCB1            ', N'f729923f-ccdc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2423, N'28   ', N'Our studies show that increases in worker productivity have not been adequately .......rewarded by significant increases in ......', N'compensation', N'commodity', N'compilation', N'complacency', N'B', N' ', N'001AVCB1            ', N'f829923f-ccdc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2424, N'52   ', N'The president of the corporation has .......arrived in Copenhagen and will meet with the Minister of Trade on Monday morning', N'still', N'yet', N'already', N'soon', N'C', N' ', N'001AVCB1            ', N'f929923f-ccdc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2432, N'129  ', N'Thuật ngữ OSI là viết tắt bởi', N'Organization for Standard Institude', N'Organization for Standard Internet', N'Open Standard Institude', N'Open System Interconnection', N'D', N'A', N'001MMTCB2           ', N'837a2418-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2434, N'132  ', N'Thứ tự các cấp trong mô hình OSI', N'Application,Session,Transport,Physical', N'Application, Transport, Network, Physical', N'Application, Presentation,Session,Network,Transport,Data link,Physical', N'Application,Presentation,Session,Transport,Network,Data link,Physical', N'D', N' ', N'001MMTCB2           ', N'857a2418-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2435, N'130  ', N'Trong mạng Token-ting, khi 1 máy nhận được Token', N'Nó phải truyền cho máy kế trong vòng', N'Nó được quyền truyền dữ liệu', N'Nó được quyền giữ lại Token', N'Tất cả đều sai', N'B', N' ', N'001MMTCB2           ', N'867a2418-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2436, N'114  ', N'Nguyên nhân dẫn đến tắt nghẻn (congestion) trên mạng', N'Tốc độ xử lý của router chậm', N'Buffers trong router nhỏ', N'Router có nhiều đường vào nhưng ít đường ra', N'Tất cả đều đúng', N'D', N' ', N'001MMTCB2           ', N'877a2418-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2438, N'95   ', N'Khả năng nhận biết tình trạng đường truyền ( carrier sence) là', N'Xác định đường truyền tốt hay xấu', N'Có kết nối được hay không', N'Nhận biết có xung đột hay không', N'Đường truyền đang rảnh hay bận', N'C', N' ', N'001MMTCB2           ', N'897a2418-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2439, N'97   ', N'Mạng nào có khả năng nhận biết xung đột (collision)', N'ALOHA', N'CSMA', N'CSMA/CD', N'Tất cả đều đúng', N'D', N' ', N'001MMTCB2           ', N'8a7a2418-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2440, N'80   ', N'Termiator là linh kiện dùng trong loại cáp mạng', N'Cáp quang', N'UTP và STP ', N'Xoắn đôi', N'Đồng trục', N'D', N' ', N'001MMTCB2           ', N'8b7a2418-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2441, N'87   ', N'Dịch vụ nào không sử dụng trong cấp data link', N'Xác nhận, có kết nối', N'Xác nhận, không kết nôi', N'Không xác nhận, có kết nối', N'Không xác nhận, không kết nối', N'C', N' ', N'001MMTCB2           ', N'8c7a2418-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2442, N'105  ', N'Vùng dữ liệu trong mạng Ethernet chứa tối đa', N'185 bytes', N'1500 bytes', N'8182 bytes', N'Không giới hạn', N'B', N' ', N'001MMTCB2           ', N'8d7a2418-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2443, N'136  ', N'Chức năng cấp mạng (network) là', N'Mã hóa và định dạng dữ liệu', N'Tìm đường và kiểm soát tắc nghẽn', N'Truy cập môi trường mạng', N'Kiểm soát lỗi và kiểm soát lưu lượng', N'B', N' ', N'001MMTCB2           ', N'8e7a2418-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2444, N'94   ', N'Kiểm soát lưu lượng (flow control) có nghĩa là', N'Thay đổi thứ tự truyền frame', N'Điều tiết tốc độ truyền frame', N'Thay đổi thời gian chờ time-out', N'Điều chỉnh kích thước frame', N'B', N' ', N'001MMTCB2           ', N'8f7a2418-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2445, N'15   ', N'Chức năng cấp mạng (network)', N'Quản lý lưu lượng đường truyền', N'Điều khiển hoạt động subnet', N'Nén dữ liệu', N'Chọn điện áp trên kênh truyền', N'B', N' ', N'001MMTCB2           ', N'907a2418-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2446, N'89   ', N'Để tránh sai sót khi truyền dữ liệu trong cấp data link', N'Đánh số thứ tự frame', N'Quản lý dữ liệu theo frame', N'Dùng vùng checksum', N'Tất cả đều đúng', N'D', N' ', N'001MMTCB2           ', N'917a2418-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2447, N'93   ', N'Phương pháp nào được dủng trong việc phát hiện lỗi', N'Timer', N'Ack', N'Checksum', N'Tất cả đều đúng', N'C', N' ', N'001MMTCB2           ', N'927a2418-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2448, N'117  ', N'Chất lượng dịch vụ mạng không được đánh giá trên chỉ tiêu nào?', N'Thời gian thiết lập kết nối ngắn', N'Tỉ lệ sai sót rất nhỏ', N'Tốc độ đường truyền cao', N'Khả năng phục hồi khi có sự cố', N'A', N' ', N'001MMTCB2           ', N'937a2418-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2449, N'9    ', N'thuật ngữ nào không cùng nhóm:', N'simplex', N'multiplex', N'half duplex', N'full duplex', N'B', N' ', N'001MMTCB2           ', N'947a2418-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2465, N'92   ', N'Protocol nào tạo frame bằng phương pháp chèn kí tự', N'ADCCP', N'HDLC', N'SDLC', N'PPP', N'D', N' ', N'001MMTCB2           ', N'a47a2418-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2466, N'138  ', N'Tiền thân của mạng Internet là', N'Intranet', N'Ethernet', N'Arpanet', N'Token-bus', N'C', N' ', N'001MMTCB2           ', N'a57a2418-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2467, N'85   ', N'Thiết bị nào làm việc trong cấp vật lý (physical) ', N'Terminator', N'Hub', N'Repeater', N'Tất cả đều đúng', N'D', N' ', N'001MMTCB2           ', N'a67a2418-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2468, N'18   ', N'T-connector dùng trong loại cáp', N'10Base-2', N'10Base-5', N'10Base-T', N'10Base-F', N'A', N' ', N'001MMTCB2           ', N'a77a2418-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2469, N'10   ', N'loại dịch vụ nào có thể nhận dữ liệu không đúng thứ tự khi truyền', N'point to point', N'có kết nối', N'không kết nối', N'broadcast', N'C', N' ', N'001MMTCB2           ', N'a87a2418-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2470, N'119  ', N'Dịch vụ truyền Email sử dụng protocol nào?', N'HTTP', N'NNTP', N'SMTP', N'FTP', N'C', N' ', N'001MMTCB2           ', N'a97a2418-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2471, N'99   ', N'Loại mạng cục bộ nào dùng chuẩn CSMA/CD', N'Token-ring', N'Token-bus', N'Ethernet', N'ArcNet', N'C', N' ', N'001MMTCB2           ', N'aa7a2418-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2473, N'127  ', N'Khi một dịch vụ trả lời ACK cho biết dữ liệu đã nhận được, đó là', N'Dịch vụ có xác nhận', N'Dịch vụ không xác nhận', N'Dịch vụ có kết nối', N'Dịch vụ không kết nối', N'A', N' ', N'001MMTCB1           ', N'd0fde37e-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2475, N'137  ', N'Mạng CSMA/CD làm gì', N'Truyền Token trên mạng hình sao', N'Truyền Token trên mạng dạng Bus', N'Chia packet ra thành từng frame nhỏ và truỵền đi trên mạng', N'Truy cập đường truyền và truyền lại dữ liệu nếu xảy ra đụng độ', N'D', N' ', N'001MMTCB1           ', N'd2fde37e-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2476, N'19   ', N'chọn câu sai trong các nguyên lý phân cấp của mô hình osi', N'mỗi cấp thực hiện 1 chức năng rõ ràng', N'mỗi cấp được chọn sao cho thông tin trao đổi giữa các cấp tối thiểu', N'mỗi cấp được tạo ra ứng với 1 mức trừu tượng hóa', N'mỗi cấp phải cung cấp cùng một kiểu địa chỉ và dịch vụ', N'D', N' ', N'001MMTCB1           ', N'd3fde37e-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2477, N'133  ', N'Cấp vật lý (physical) không quản lý', N'Mức điện áp', N'Địa chỉ vật lý', N'Mạch giao tiếp vật lý', N'Truyền các bit dữ liêu', N'B', N' ', N'001MMTCB1           ', N'd4fde37e-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2478, N'97   ', N'Mạng nào có khả năng nhận biết xung đột (collision)', N'ALOHA', N'CSMA', N'CSMA/CD', N'Tất cả đều đúng', N'D', N' ', N'001MMTCB1           ', N'd5fde37e-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2481, N'118  ', N'Kỹ thuật Multiplexing được dùng khi', N'Có nhiều kênh truyền hơn đường truyền', N'Có nhiều đường truyền hơn kênh truyền', N'Truyền dữ liệu số trên mạng điện thoại', N'Truyền dữ liệu tương tự trên mạng điện thọai', N'A', N' ', N'001MMTCB1           ', N'd8fde37e-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2482, N'5    ', N'mạng man được sử dụng trong phạm vi:', N'quốc gia', N'lục địa', N'khu phố', N'thành phố', N'D', N' ', N'001MMTCB1           ', N'd9fde37e-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2501, N'10   ', N'loại dịch vụ nào có thể nhận dữ liệu không đúng thứ tự khi truyền', N'point to point', N'có kết nối', N'không kết nối', N'broadcast', N'C', N'C', N'001MMTCB1           ', N'ecfde37e-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2484, N'116  ', N'Cấp nào trong mô hình mạng OSI tương đương với cấp Internet trong mô hình TCP/IP ', N'Network', N'Transport', N'Physical', N'Data link', N'A', N' ', N'001MMTCB1           ', N'dbfde37e-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2487, N'107  ', N'Mạng nào có tốc độ truyền lớn hơn 100Mbps', N'Fast Ethernet', N'Gigabit Ethernet', N'Ethernet', N'Tất cả đều đúng', N'B', N' ', N'001MMTCB1           ', N'defde37e-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2488, N'120  ', N'Địa chỉ IP lớp B nằm trong phạm vi nào', N'192.0.0.0 - 223.0.0.0', N'127.0.0.0 - 191.0.0.0', N'128.0.0.0 - 191.0.0.0 ', N'1.0.0.0 - 126.0.0.0', N'C', N' ', N'001MMTCB1           ', N'dffde37e-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2489, N'110  ', N'Cấp network truyền nhận theo kiểu end-to-end vì nó quản lý dữ liệu', N'Giữa 2 đầu subnet', N'Giữa 2 máy tính trong mạng', N'Giữa 2 thiết bị trên đường truyền', N'Giữa 2 đầu đường truyền', N'A', N' ', N'001MMTCB1           ', N'e0fde37e-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2490, N'102  ', N'Loại mạng nào dùng 1 máy tính làm Monitor để bảo trì mạng', N'Ethernet', N'Token-ring', N'Token-bus', N'Tất cả đều sai', N'B', N' ', N'001MMTCB1           ', N'e1fde37e-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2491, N'90   ', N'Quản lý lưu lượng đường truyền là chức năng của cấp', N'Presentation', N'Network', N'Data link', N'Physical', N'C', N' ', N'001MMTCB1           ', N'e2fde37e-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2495, N'14   ', N'Chức năng câp liên kết dữ liệu (data link)', N'Quản lý lỗi sai', N'Mã hóa dữ liệu', N'Tìm đường đi cho dữ liệu', N'Chọn kênh truyền', N'A', N' ', N'001MMTCB1           ', N'e6fde37e-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2496, N'16   ', N'Chức năng cấp vận tải (transport) ', N'Quản lý địa chỉ mạng', N'Chuyển đổi các dạng frame khác nhau', N'Thiết lập và hủy bỏ dữ liệu', N'Mã hóa và giải mã dữ liệu', N'C', N' ', N'001MMTCB1           ', N'e7fde37e-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2497, N'105  ', N'Vùng dữ liệu trong mạng Ethernet chứa tối đa', N'185 bytes', N'1500 bytes', N'8182 bytes', N'Không giới hạn', N'B', N' ', N'001MMTCB1           ', N'e8fde37e-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2498, N'100  ', N'Mạng Ethernet được IEEE đưa vào chuẩn', N'IEEE 802.2', N'IEEE 802.3', N'IEEE 802.4', N'IEEE 802.5', N'B', N' ', N'001MMTCB1           ', N'e9fde37e-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2499, N'130  ', N'Trong mạng Token-ting, khi 1 máy nhận được Token', N'Nó phải truyền cho máy kế trong vòng', N'Nó được quyền truyền dữ liệu', N'Nó được quyền giữ lại Token', N'Tất cả đều sai', N'B', N' ', N'001MMTCB1           ', N'eafde37e-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2500, N'18   ', N'T-connector dùng trong loại cáp', N'10Base-2', N'10Base-5', N'10Base-T', N'10Base-F', N'A', N' ', N'001MMTCB1           ', N'ebfde37e-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2502, N'117  ', N'Chất lượng dịch vụ mạng không được đánh giá trên chỉ tiêu nào?', N'Thời gian thiết lập kết nối ngắn', N'Tỉ lệ sai sót rất nhỏ', N'Tốc độ đường truyền cao', N'Khả năng phục hồi khi có sự cố', N'A', N' ', N'004MMTCB1           ', N'38ad7291-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2503, N'136  ', N'Chức năng cấp mạng (network) là', N'Mã hóa và định dạng dữ liệu', N'Tìm đường và kiểm soát tắc nghẽn', N'Truy cập môi trường mạng', N'Kiểm soát lỗi và kiểm soát lưu lượng', N'B', N' ', N'004MMTCB1           ', N'39ad7291-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2504, N'92   ', N'Protocol nào tạo frame bằng phương pháp chèn kí tự', N'ADCCP', N'HDLC', N'SDLC', N'PPP', N'D', N' ', N'004MMTCB1           ', N'3aad7291-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2505, N'111  ', N'Kiểu mạch ảo(virtual circuit) được dùng trong loại dịch vụ mạng', N'Có kết nối', N'Không kết nối', N'Truyền 1 chiều', N'Truyền 2 chiều', N'A', N' ', N'004MMTCB1           ', N'3bad7291-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2506, N'9    ', N'thuật ngữ nào không cùng nhóm:', N'simplex', N'multiplex', N'half duplex', N'full duplex', N'B', N' ', N'004MMTCB1           ', N'3cad7291-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2507, N'109  ', N'Khoảng cách đường truyền tối đa mạng FDDI có thể đạt', N'1Km', N'10Km', N'100Km', N'1000Km', N'C', N' ', N'004MMTCB1           ', N'3dad7291-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2508, N'87   ', N'Dịch vụ nào không sử dụng trong cấp data link', N'Xác nhận, có kết nối', N'Xác nhận, không kết nôi', N'Không xác nhận, có kết nối', N'Không xác nhận, không kết nối', N'C', N' ', N'004MMTCB1           ', N'3ead7291-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2509, N'126  ', N'Tốc độ của đường truyền T1 là:', N'2048 Mbps', N'1544 Mbps', N'155 Mbps', N'56 Kbps', N'B', N' ', N'004MMTCB1           ', N'3fad7291-d7dc-ec11-ab4c-9a75b5a0942f')
GO
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2510, N'81   ', N'Mạng không dây dùng loại sóng nào không bị ảnh hưởng bởi khoảng cách địa lý', N'Sóng radio', N'Sống hồng ngoại', N'Sóng viba', N'Song cực ngắn', N'A', N' ', N'004MMTCB1           ', N'40ad7291-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2511, N'125  ', N'Cầu nối trong suốt hoạt động trong cấp nào', N'Data link', N'Physical', N'Network', N'Transport', N'A', N' ', N'004MMTCB1           ', N'41ad7291-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2512, N'134  ', N'TCP sử dụng loại dịch vụ', N'Có kết nối, độ tin cậy cao', N'Có kết nối, độ tin cậy thấp', N'Không kết nối, độ tin cậy cao', N'Không kết nối, độ tin cậy thấp', N'A', N' ', N'004MMTCB1           ', N'42ad7291-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2513, N'110  ', N'Cấp network truyền nhận theo kiểu end-to-end vì nó quản lý dữ liệu', N'Giữa 2 đầu subnet', N'Giữa 2 máy tính trong mạng', N'Giữa 2 thiết bị trên đường truyền', N'Giữa 2 đầu đường truyền', N'A', N' ', N'004MMTCB1           ', N'43ad7291-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2514, N'96   ', N'Mạng nào không có khả năng nhận biết tình trạng đường truyền (carrier sence)', N'ALOHA', N'CSMA', N'CSMA/CD', N'Tất cả đều đúng ', N'A', N' ', N'004MMTCB1           ', N'44ad7291-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2515, N'129  ', N'Thuật ngữ OSI là viết tắt bởi', N'Organization for Standard Institude', N'Organization for Standard Internet', N'Open Standard Institude', N'Open System Interconnection', N'D', N' ', N'004MMTCB1           ', N'45ad7291-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2516, N'113  ', N'Kiểm soát tắc nghẽn (congestion) là nhiệm vụ của cấp', N'Physical', N'Transport', N'Data link', N'Network', N'D', N' ', N'004MMTCB1           ', N'46ad7291-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2517, N'97   ', N'Mạng nào có khả năng nhận biết xung đột (collision)', N'ALOHA', N'CSMA', N'CSMA/CD', N'Tất cả đều đúng', N'D', N' ', N'004MMTCB1           ', N'47ad7291-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2518, N'127  ', N'Khi một dịch vụ trả lời ACK cho biết dữ liệu đã nhận được, đó là', N'Dịch vụ có xác nhận', N'Dịch vụ không xác nhận', N'Dịch vụ có kết nối', N'Dịch vụ không kết nối', N'A', N' ', N'004MMTCB1           ', N'48ad7291-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2519, N'95   ', N'Khả năng nhận biết tình trạng đường truyền ( carrier sence) là', N'Xác định đường truyền tốt hay xấu', N'Có kết nối được hay không', N'Nhận biết có xung đột hay không', N'Đường truyền đang rảnh hay bận', N'C', N' ', N'004MMTCB1           ', N'49ad7291-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2520, N'14   ', N'Chức năng câp liên kết dữ liệu (data link)', N'Quản lý lỗi sai', N'Mã hóa dữ liệu', N'Tìm đường đi cho dữ liệu', N'Chọn kênh truyền', N'A', N' ', N'004MMTCB1           ', N'4aad7291-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2521, N'107  ', N'Mạng nào có tốc độ truyền lớn hơn 100Mbps', N'Fast Ethernet', N'Gigabit Ethernet', N'Ethernet', N'Tất cả đều đúng', N'B', N' ', N'004MMTCB1           ', N'4bad7291-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2522, N'137  ', N'Mạng CSMA/CD làm gì', N'Truyền Token trên mạng hình sao', N'Truyền Token trên mạng dạng Bus', N'Chia packet ra thành từng frame nhỏ và truỵền đi trên mạng', N'Truy cập đường truyền và truyền lại dữ liệu nếu xảy ra đụng độ', N'D', N' ', N'004MMTCB1           ', N'4cad7291-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2523, N'16   ', N'Chức năng cấp vận tải (transport) ', N'Quản lý địa chỉ mạng', N'Chuyển đổi các dạng frame khác nhau', N'Thiết lập và hủy bỏ dữ liệu', N'Mã hóa và giải mã dữ liệu', N'C', N' ', N'004MMTCB1           ', N'4dad7291-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2524, N'139  ', N'Khi 1 cầu nối ( bridge) nhận được 1 framechưa biết thông tin về địa chỉ máy nhận, nó sẽ', N'Xóa bỏ frame này', N'Gửi trả lại máy gốc', N'Gửi đến mọi ngõ ra còn lại', N'Giảm thời gian sống của frame đi 1 đơn vị và gửi đến mọi ngõ ra còn lại', N'C', N' ', N'004MMTCB1           ', N'4ead7291-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2525, N'104  ', N'Loại mạng nào dùng 2 loại frame khác nhau trên đường truyền', N'Token-ring', N'Token-bus', N'Ethernet', N'Tất cả đều sai', N'A', N' ', N'004MMTCB1           ', N'4fad7291-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2526, N'138  ', N'Tiền thân của mạng Internet là', N'Intranet', N'Ethernet', N'Arpanet', N'Token-bus', N'C', N' ', N'004MMTCB1           ', N'50ad7291-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2528, N'101  ', N'Chuẩn nào không dùng trong mạng cục bộ (LAN )', N'IEEE 802.3', N'IEEE 802.4', N'IEEE 802.5', N'IEEE 802.6', N'D', N' ', N'004MMTCB1           ', N'52ad7291-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2529, N'131  ', N'Trong mạng cục bộ, để xác định 1 máy trong mạng ta dùng địa chỉ', N'MAC', N'Socket', N'Domain', N'Port', N'A', N' ', N'004MMTCB1           ', N'53ad7291-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2530, N'90   ', N'Quản lý lưu lượng đường truyền là chức năng của cấp', N'Presentation', N'Network', N'Data link', N'Physical', N'C', N' ', N'004MMTCB1           ', N'54ad7291-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BAITHI] ([CAUHOI], [CAUSO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [DACHON], [MABD], [rowguid]) VALUES (2531, N'18   ', N'T-connector dùng trong loại cáp', N'10Base-2', N'10Base-5', N'10Base-T', N'10Base-F', N'A', N'C', N'004MMTCB1           ', N'55ad7291-d7dc-ec11-ab4c-9a75b5a0942f')
SET IDENTITY_INSERT [dbo].[BAITHI] OFF
INSERT [dbo].[BANGDIEM] ([MASV], [MAMH], [LAN], [NGAYTHI], [DIEM], [rowguid]) VALUES (N'001     ', N'AVCB ', 1, CAST(N'2022-05-26 00:00:00.000' AS DateTime), 2.5, N'012a923f-ccdc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BANGDIEM] ([MASV], [MAMH], [LAN], [NGAYTHI], [DIEM], [rowguid]) VALUES (N'001     ', N'MMTCB', 1, CAST(N'2022-05-26 00:00:00.000' AS DateTime), 0.33, N'edfde37e-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BANGDIEM] ([MASV], [MAMH], [LAN], [NGAYTHI], [DIEM], [rowguid]) VALUES (N'001     ', N'MMTCB', 2, CAST(N'2022-05-26 00:00:00.000' AS DateTime), 0, N'ab7a2418-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BANGDIEM] ([MASV], [MAMH], [LAN], [NGAYTHI], [DIEM], [rowguid]) VALUES (N'004     ', N'MMTCB', 1, CAST(N'2022-05-26 00:00:00.000' AS DateTime), 0, N'56ad7291-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (1, N'MMTCB', N'A', N'mạng máy tính(compute netword) so với hệ thống tập trung multi-user', N'dễ phát triển hệ thống', N'tăng độ tin cậy', N'tiết kiệm chi phí', N'tất cả đều đúng', N'D', N'TH110   ', N'f04d76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (3, N'MMTCB', N'A', N'để một máy tính truyền dữ liệu cho một số máy khác trong mạng, ta dùng loại địa chỉ', N'Broadcast', N'Broadband', N'multicast', N'multiple access', N'C', N'TH123   ', N'f14d76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (4, N'MMTCB', N'A', N'thứ tự phân loại mạng theo chiều dài đường truyền', N'internet, lan, man, wan', N'internet, wan, man, lan', N'lan, wan, man, internet', N'man, lan, wan, internet', N'B', N'TH123   ', N'f24d76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (5, N'MMTCB', N'A', N'mạng man được sử dụng trong phạm vi:', N'quốc gia', N'lục địa', N'khu phố', N'thành phố', N'D', N'TH123   ', N'f34d76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (6, N'MMTCB', N'A', N'thuật ngữ man được viết tắt bởi:', N'middle area network', N'metropolitan area network', N'medium area network', N'multiple access network', N'D', N'TH123   ', N'f44d76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (7, N'MMTCB', N'A', N'mạng man không kết nối theo sơ đồ:', N'bus', N'ring', N'star', N'tree', N'D', N'TH123   ', N'f54d76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (8, N'MMTCB', N'A', N'kiến trúc mạng (network architechture) là:', N'tập các chức năng trong mạng', N'tập các cấp và các protocol trong mỗi cấp', N'tập các dịch vụ trong mạng', N'tập các protocol trong mạng', N'B', N'TH123   ', N'f64d76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (9, N'MMTCB', N'A', N'thuật ngữ nào không cùng nhóm:', N'simplex', N'multiplex', N'half duplex', N'full duplex', N'B', N'TH123   ', N'f74d76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (10, N'MMTCB', N'A', N'loại dịch vụ nào có thể nhận dữ liệu không đúng thứ tự khi truyền', N'point to point', N'có kết nối', N'không kết nối', N'broadcast', N'C', N'TH123   ', N'f84d76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (11, N'MMTCB', N'A', N'dịch vụ không xác nhận (unconfirmed) chỉ sử dụng 2 phép toán cơ bản:', N'response and confirm', N'confirm and request', N'request and indication', N'indication and response', N'C', N'TH123   ', N'f94d76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (12, N'MMTCB', N'A', N'Chọn câu sai trong các nguyên lý phân cấp của mô hình OSI', N'Mỗi cấp thực hiện 1 chức năng rõ ràng', N'Mỗi cấp được chọn sao cho thông tin trao đổi giữa các cấp tối thiểu', N'Mỗi cấp được tạo ra ứng với 1 mức trừu tượng hóa', N'Mỗi cấp phải cung cấp cùng 1 kiểu địa chỉ và dịch vụ', N'D', N'TH123   ', N'fa4d76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (13, N'MMTCB', N'A', N'Chức năng của cấp vật lý(physical)', N'Qui định truyền 1 hay 2 chiều', N'Quản lý lỗi sai', N'Xác định thời gian truyền 1 bit dữ liệu', N'Quản lý địa chỉ vật lý', N'C', N'TH123   ', N'fb4d76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (14, N'MMTCB', N'A', N'Chức năng câp liên kết dữ liệu (data link)', N'Quản lý lỗi sai', N'Mã hóa dữ liệu', N'Tìm đường đi cho dữ liệu', N'Chọn kênh truyền', N'A', N'TH123   ', N'fc4d76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (15, N'MMTCB', N'A', N'Chức năng cấp mạng (network)', N'Quản lý lưu lượng đường truyền', N'Điều khiển hoạt động subnet', N'Nén dữ liệu', N'Chọn điện áp trên kênh truyền', N'B', N'TH123   ', N'fd4d76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (16, N'MMTCB', N'A', N'Chức năng cấp vận tải (transport) ', N'Quản lý địa chỉ mạng', N'Chuyển đổi các dạng frame khác nhau', N'Thiết lập và hủy bỏ dữ liệu', N'Mã hóa và giải mã dữ liệu', N'C', N'TH123   ', N'fe4d76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (17, N'MMTCB', N'A', N'Cáp xoắn đôi trong mạng LAN dùng đầu nối', N'AUI', N'BNC', N'RJ11', N'RJ45', N'D', N'TH123   ', N'ff4d76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (18, N'MMTCB', N'A', N'T-connector dùng trong loại cáp', N'10Base-2', N'10Base-5', N'10Base-T', N'10Base-F', N'A', N'TH123   ', N'004e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (19, N'MMTCB', N'A', N'chọn câu sai trong các nguyên lý phân cấp của mô hình osi', N'mỗi cấp thực hiện 1 chức năng rõ ràng', N'mỗi cấp được chọn sao cho thông tin trao đổi giữa các cấp tối thiểu', N'mỗi cấp được tạo ra ứng với 1 mức trừu tượng hóa', N'mỗi cấp phải cung cấp cùng một kiểu địa chỉ và dịch vụ', N'D', N'TH123   ', N'014e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (20, N'AVCB ', N'A', N'The publishers suggested that the envelopes be sent to ...... by courier so that the film can be developed as soon as possible', N'they', N'their', N'theirs', N'them', N'A', N'TH234   ', N'024e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (21, N'AVCB ', N'A', N'Board members ..... carefully define their goals and objectives for the agency before the monthly meeting next week.', N'had', N'should', N'used ', N'have', N'B', N'TH234   ', N'034e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (22, N'AVCB ', N'A', N'For business relations to continue between our two firms, satisfactory agreement must be ...... reached and signer', N'yet', N'both', N'either ', N'as well as', N'C', N'TH234   ', N'044e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (23, N'AVCB ', N'A', N'The corporation, which underwent a major restructing seven years ago, has been growing steadily ......five years', N'for', N'on', N'from', N'since', N'A', N'TH234   ', N'054e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (24, N'AVCB ', N'A', N'Making advance arrangements for audiovisual equipment is....... recommended for all seminars.', N'sternly', N'strikingly', N'stringently', N'strongly', N'A', N'TH234   ', N'064e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (25, N'AVCB ', N'A', N'Two assistants will be required to ...... reporter''s names when they arrive at the press conference', N'remark', N'check', N'notify', N'ensure', N'B', N'TH234   ', N'074e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (26, N'AVCB ', N'A', N'The present government has an excellent ......to increase exports', N'popularity', N'regularity', N'celebrity', N'opportunity', N'D', N'TH234   ', N'084e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (27, N'AVCB ', N'A', N'While you are in the building, please wear your identification badge at all times so that you are ....... as a company employee.', N'recognize', N'recognizing', N'recognizable', N'recognizably', N'C', N'TH234   ', N'094e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (28, N'AVCB ', N'A', N'Our studies show that increases in worker productivity have not been adequately .......rewarded by significant increases in ......', N'compensation', N'commodity', N'compilation', N'complacency', N'B', N'TH234   ', N'0a4e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (29, N'AVCB ', N'A', N'Conservatives predict that government finaces will remain...... during the period of the investigation', N'authoritative', N'summarized', N'examined', N'stable', N'D', N'TH234   ', N'0b4e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (30, N'AVCB ', N'B', N'Battery-operated reading lamps......very well right now', N'sale', N'sold', N'are selling', N'were sold', N'C', N'TH234   ', N'0c4e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (31, N'AVCB ', N'B', N'In order to place a call outside the office, you have to .......nine first. ', N'tip', N'make', N'dial', N'number', N'D', N'TH234   ', N'0d4e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (32, N'AVCB ', N'B', N'We are pleased to inform...... that the missing order has been found.', N'you', N'your', N'yours', N'yourseld', N'A', N'TH234   ', N'0e4e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (33, N'AVCB ', N'B', N'Unfortunately, neither Mr.Sachs....... Ms Flynn will be able to attend the awards banquet this evening', N'but', N'and', N' nor', N'either', N'C', N'TH234   ', N'0f4e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (34, N'AVCB ', N'B', N'According to the manufacturer, the new generatir is capable of....... the amount of power consumed by our facility by nearly ten percent.', N'reduced', N'reducing', N'reduce', N'reduces', N'B', N'TH234   ', N'104e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (35, N'AVCB ', N'B', N'After the main course, choose from our wide....... of homemade deserts', N'varied', N'various', N'vary', N'variety', N'D', N'TH234   ', N'114e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (36, N'AVCB ', N'B', N'One of the most frequent complaints among airline passengers is that there is not ...... legroom', N'enough', N'many', N'very', N'plenty', N'A', N'TH234   ', N'124e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (37, N'AVCB ', N'B', N'Faculty members are planning to..... a party in honor of Dr.Walker, who will retire at the end of the semester', N'carry', N'do', N'hold', N'take', N'D', N'TH234   ', N'134e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (38, N'AVCB ', N'B', N'Many employees seem more ....... now about how to use the new telephone system than they did before they attended the workshop', N'confusion', N'confuse', N'confused', N'confusing', N'C', N'TH234   ', N'144e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (39, N'AVCB ', N'B', N'.........our production figures improve in the near future, we foresee having to hire more people between now and July', N'During', N'Only', N'Unless', N'Because', N'D', N'TH234   ', N'154e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (40, N'AVCB ', N'C', N'Though their performance was relatively unpolished, the actors held the audience''s ........for the duration of the play.', N'attentive', N'attentively', N'attention', N'attentiveness', N'C', N'TH234   ', N'164e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (41, N'AVCB ', N'C', N'Dr. Abernathy''s donation to Owstion College broke the record for the largest private gift...... give to the campus', N'always', N'rarely', N'once', N'ever', N'C', N'TH234   ', N'174e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (42, N'AVCB ', N'C', N'Savat Nation Park is ....... by train,bus, charter plane, and rental car.', N'accessible', N'accessing', N'accessibility', N'accesses', N'A', N'TH234   ', N'184e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (43, N'AVCB ', N'C', N'In Piazzo''s lastest architectural project, he hopes to......his flare for blending contemporary and traditional ideals.', N'demonstrate', N'appear', N'valve', N'position', N'A', N'TH234   ', N'194e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (44, N'AVCB ', N'C', N'Replacing the offic equipment that the company purchased only three years ago seems quite.....', N'waste', N'wasteful', N'wasting', N'wasted', N'C', N'TH234   ', N'1a4e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (45, N'AVCB ', N'C', N'On........, employees reach their peak performance level when they have been on the job for at least two years.', N'common', N'standard', N'average', N'general', N'D', N'TH234   ', N'1b4e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (46, N'AVCB ', N'C', N'We were........unaware of the problems with the air-conidtioning units in the hotel rooms until this week.', N'complete ', N'completely', N'completed', N'completing', N'D', N'TH234   ', N'1c4e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (47, N'AVCB ', N'C', N'If you send in an order ....... mail, we recommend that you phone our sales division directly to confirm the order.', N'near', N'by', N'for', N'on', N'A', N'TH234   ', N'1d4e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (48, N'AVCB ', N'C', N'A recent global survey suggests.......... demand for aluminum and tin will remain at its current level for the next five to ten years.', N'which', N'it ', N'that', N'both', N'C', N'TH234   ', N'1e4e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (49, N'AVCB ', N'C', N'Rates for the use of recreational facilities do not include ta and are subject to change without.........', N'signal', N'cash', N'report', N'notice', N'A', N'TH234   ', N'1f4e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (50, N'AVCB ', N'A', N'Aswering telephone calls is the..... of an operator', N'responsible', N'responsibly', N'responsive', N'responsibility', N'D', N'TH234   ', N'204e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (51, N'AVCB ', N'A', N'A free watch will be provided with every purchase of $20.00 or more a ........ period of time', N'limit', N'limits', N'limited', N'limiting', N'C', N'TH234   ', N'214e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (52, N'AVCB ', N'A', N'The president of the corporation has .......arrived in Copenhagen and will meet with the Minister of Trade on Monday morning', N'still', N'yet', N'already', N'soon', N'C', N'TH234   ', N'224e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (53, N'AVCB ', N'A', N'Because we value your business, we have .......for card members like you to receive one thousand  dollars of complimentary life insurance', N'arrange', N'arranged', N'arranges', N'arranging', N'B', N'TH234   ', N'234e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (54, N'AVCB ', N'A', N'Employees are........that due to the new government regulations. there is to be no smoking in the factory', N'reminded', N'respected', N'remembered', N'reacted', N'A', N'TH234   ', N'244e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (55, N'AVCB ', N'A', N'MS. Galera gave a long...... in honor of the retiring vice-president', N'speak', N'speaker', N'speaking', N'speech', N'D', N'TH234   ', N'254e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (56, N'AVCB ', N'A', N'Any person who is........ in volunteering his or her time for the campaign should send this office a letter of intent', N'interest', N'interested', N'interesting', N'interestingly', N'B', N'TH234   ', N'264e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (57, N'AVCB ', N'A', N'Mr.Gonzales was very concerned.........the upcoming board of directors meeting', N'to', N'about', N'at ', N'upon', N'B', N'TH234   ', N'274e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (58, N'AVCB ', N'A', N'The customers were told that no ........could be made on weekend nights because the restaurant was too busy', N'delays', N'cuisines', N'reservation', N'violations', N'C', N'TH234   ', N'284e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (59, N'AVCB ', N'A', N'The sales representive''s presentation was difficult to understand ........ he spoke very quickly', N'because', N'althought', N'so that', N'than', N'A', N'TH234   ', N'294e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (60, N'AVCB ', N'B', N'It has been predicted that an.......weak dollar will stimulate tourism in the United States', N'increased', N'increasingly', N'increases', N'increase', N'B', N'TH234   ', N'2a4e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (61, N'AVCB ', N'B', N'The firm is not liable for damage resulting from circumstances.........its control.', N'beyond', N'above', N'inside', N'around', N'A', N'TH234   ', N'2b4e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (62, N'AVCB ', N'B', N'Because of.......weather conditions, California has an advantage in the production of fruits and vegetables', N'favorite', N'favor', N'favorable', N'favorably', N'C', N'TH234   ', N'2c4e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (63, N'AVCB ', N'B', N'On international shipments, all duties and taxes are paid by the..........', N'recipient', N'receiving', N'receipt', N'receptive', N'A', N'TH234   ', N'2d4e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (64, N'AVCB ', N'B', N'Although the textbook gives a definitive answer,wise managers will look for........ own creative solutions', N'them', N'their', N'theirs', N'they', N'B', N'TH234   ', N'2e4e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (65, N'AVCB ', N'B', N'Initial ....... regarding the merger of the companies took place yesterday at the Plaza Conference Center.', N'negotiations', N'dedications', N'propositions', N'announcements', N'A', N'TH234   ', N'2f4e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (66, N'AVCB ', N'B', N'Please......... photocopies of all relevant docunments to this office ten days prior to your performance review date', N'emerge', N'substantiate', N'adapt', N'submit', N'D', N'TH234   ', N'304e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (67, N'AVCB ', N'B', N'The auditor''s results for the five year period under study were .........the accountant''s', N'same', N'same as', N'the same', N'the same as', N'D', N'TH234   ', N'314e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (68, N'AVCB ', N'B', N'.........has the marketing environment been more complex and subject to change', N'Totally', N'Negatively', N'Decidedly', N'Rarely', N'D', N'TH234   ', N'324e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (69, N'AVCB ', N'B', N'All full-time staff are eligible to participate in the revised health plan, which becomes effective the first ......... the month.', N'of', N'to', N'from', N'for', N'A', N'TH234   ', N'334e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (70, N'AVCB ', N'C', N'Contracts must be read........ before they are signed.', N'thoroughness', N'more thorough', N'thorough', N'thoroughly', N'D', N'TH234   ', N'344e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (71, N'AVCB ', N'C', N'Passengers should allow for...... travel time to the airport in rush hour traffic', N'addition', N'additive', N'additionally', N'additional', N'D', N'TH234   ', N'354e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (72, N'AVCB ', N'C', N'This fiscal year, the engineering team has worked well together on all phases ofproject.........', N'development', N'developed', N'develops', N'developer', N'A', N'TH234   ', N'364e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (73, N'AVCB ', N'C', N'Mr.Dupont had no ....... how long it would take to drive downtown', N'knowledge', N'thought', N'idea', N'willingness', N'C', N'TH234   ', N'374e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (74, N'AVCB ', N'C', N'Small company stocks usually benefit..........the so called January effect that cause the price of these stocks to rise between November and January', N'unless', N'from', N'to ', N'since', N'B', N'TH234   ', N'384e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (75, N'AVCB ', N'C', N'It has been suggested that employees ........to work in their current positions until the quarterly review is finished.', N'continuity', N'continue', N'continuing', N'continuous', N'B', N'TH234   ', N'394e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (76, N'AVCB ', N'C', N'It is admirable that Ms.Jin wishes to handle all transactions by........, but it might be better if several people shared the responsibility', N'she', N'herself', N'her', N'hers', N'B', N'TH234   ', N'3a4e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (77, N'AVCB ', N'C', N'This new highway construction project will help the company.........', N'diversity', N'clarify', N'intensify', N'modify', N'A', N'TH234   ', N'3b4e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (78, N'AVCB ', N'C', N'Ms.Patel has handed in an ........business plan to the director', N'anxious', N'evident', N'eager', N'outstanding', N'D', N'TH234   ', N'3c4e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (79, N'AVCB ', N'C', N'Recent changes in heating oil costs have affected..........production of turniture', N'local', N'locality', N'locally', N'location', N'A', N'TH234   ', N'3d4e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (80, N'MMTCB', N'A', N'Termiator là linh kiện dùng trong loại cáp mạng', N'Cáp quang', N'UTP và STP ', N'Xoắn đôi', N'Đồng trục', N'D', N'TH123   ', N'3e4e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (81, N'MMTCB', N'A', N'Mạng không dây dùng loại sóng nào không bị ảnh hưởng bởi khoảng cách địa lý', N'Sóng radio', N'Sống hồng ngoại', N'Sóng viba', N'Song cực ngắn', N'A', N'TH123   ', N'3f4e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (82, N'MMTCB', N'A', N'Đường truyền E1 gồm 32 kênh, trong đó sử dụng cho dữ liệu là:', N'32 kênh', N'31 kênh', N'30 kênh', N'24 kênh', N'C', N'TH123   ', N'404e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (83, N'MMTCB', N'A', N'Mạng máy tính thường sử dụng loại chuyển mach', N'Gói (packet switch)', N'Kênh (Circuit switch)', N'Thông báo(message switch)', N'Tất cả đều đúng', N'A', N'TH123   ', N'414e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (84, N'MMTCB', N'A', N'Cáp UTP hỗ trợ tôc độ truyền 100MBps là loại', N'Cat 3', N'Cat 4', N'Cat 5', N'Cat 6', N'C', N'TH123   ', N'424e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (85, N'MMTCB', N'A', N'Thiết bị nào làm việc trong cấp vật lý (physical) ', N'Terminator', N'Hub', N'Repeater', N'Tất cả đều đúng', N'D', N'TH123   ', N'434e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (86, N'MMTCB', N'A', N'Phương pháp dồn kênh phân chia tần số gọi là', N'FDM', N'WDM', N'TDM', N'CSMA', N'A', N'TH123   ', N'444e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (87, N'MMTCB', N'A', N'Dịch vụ nào không sử dụng trong cấp data link', N'Xác nhận, có kết nối', N'Xác nhận, không kết nôi', N'Không xác nhận, có kết nối', N'Không xác nhận, không kết nối', N'C', N'TH123   ', N'454e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (88, N'MMTCB', N'A', N'Nguyên nhân gây sai sót khi gửi/nhận dữ liệu trên mạng', N'Mất đồng bộ trong khi truyền', N'Nhiễu từ môi trường', N'Lỗi phần cứng hoặc phần mềm', N'Tất cả đều đúng ', N'D', N'TH123   ', N'464e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (89, N'MMTCB', N'A', N'Để tránh sai sót khi truyền dữ liệu trong cấp data link', N'Đánh số thứ tự frame', N'Quản lý dữ liệu theo frame', N'Dùng vùng checksum', N'Tất cả đều đúng', N'D', N'TH123   ', N'474e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (90, N'MMTCB', N'A', N'Quản lý lưu lượng đường truyền là chức năng của cấp', N'Presentation', N'Network', N'Data link', N'Physical', N'C', N'TH123   ', N'484e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (91, N'MMTCB', N'A', N'Hoạt động của protocol Stop and Wait', N'Chờ một khoảng thời gian time-out rồi gửi tiếp frame kế', N'Chờ 1 khoảng thời gian time-out rồi gửi lại frame trước', N'Chờ nhận được ACK của frame trước mới gửi tiếp frame kế', N'Không chờ mà gửi liên tiếp các frame kế nhau', N'C', N'TH123   ', N'494e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (92, N'MMTCB', N'A', N'Protocol nào tạo frame bằng phương pháp chèn kí tự', N'ADCCP', N'HDLC', N'SDLC', N'PPP', N'D', N'TH123   ', N'4a4e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (93, N'MMTCB', N'A', N'Phương pháp nào được dủng trong việc phát hiện lỗi', N'Timer', N'Ack', N'Checksum', N'Tất cả đều đúng', N'C', N'TH123   ', N'4b4e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (94, N'MMTCB', N'A', N'Kiểm soát lưu lượng (flow control) có nghĩa là', N'Thay đổi thứ tự truyền frame', N'Điều tiết tốc độ truyền frame', N'Thay đổi thời gian chờ time-out', N'Điều chỉnh kích thước frame', N'B', N'TH123   ', N'4c4e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (95, N'MMTCB', N'A', N'Khả năng nhận biết tình trạng đường truyền ( carrier sence) là', N'Xác định đường truyền tốt hay xấu', N'Có kết nối được hay không', N'Nhận biết có xung đột hay không', N'Đường truyền đang rảnh hay bận', N'C', N'TH123   ', N'4d4e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (96, N'MMTCB', N'A', N'Mạng nào không có khả năng nhận biết tình trạng đường truyền (carrier sence)', N'ALOHA', N'CSMA', N'CSMA/CD', N'Tất cả đều đúng ', N'A', N'TH123   ', N'4e4e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (97, N'MMTCB', N'A', N'Mạng nào có khả năng nhận biết xung đột (collision)', N'ALOHA', N'CSMA', N'CSMA/CD', N'Tất cả đều đúng', N'D', N'TH123   ', N'4f4e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (98, N'MMTCB', N'A', N'Chuẩn mạng nào có khả năng pkhát hiện xung đột (collision) trong khi truyền', N'1-persistent CSMA', N'p-persistent CSMA', N'Non-persistent CSMA', N'CSMA/CD', N'D', N'TH123   ', N'504e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (99, N'MMTCB', N'A', N'Loại mạng cục bộ nào dùng chuẩn CSMA/CD', N'Token-ring', N'Token-bus', N'Ethernet', N'ArcNet', N'C', N'TH123   ', N'514e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (100, N'MMTCB', N'A', N'Mạng Ethernet được IEEE đưa vào chuẩn', N'IEEE 802.2', N'IEEE 802.3', N'IEEE 802.4', N'IEEE 802.5', N'B', N'TH123   ', N'524e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (101, N'MMTCB', N'A', N'Chuẩn nào không dùng trong mạng cục bộ (LAN )', N'IEEE 802.3', N'IEEE 802.4', N'IEEE 802.5', N'IEEE 802.6', N'D', N'TH123   ', N'534e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
GO
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (102, N'MMTCB', N'A', N'Loại mạng nào dùng 1 máy tính làm Monitor để bảo trì mạng', N'Ethernet', N'Token-ring', N'Token-bus', N'Tất cả đều sai', N'B', N'TH123   ', N'544e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (103, N'MMTCB', N'A', N'Loại mạng nào không có độ ưu tiên', N'Ethernet', N'Token-ring', N'Token-bus', N'Tất cả đều sai', N'D', N'TH123   ', N'554e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (104, N'MMTCB', N'A', N'Loại mạng nào dùng 2 loại frame khác nhau trên đường truyền', N'Token-ring', N'Token-bus', N'Ethernet', N'Tất cả đều sai', N'A', N'TH123   ', N'564e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (105, N'MMTCB', N'A', N'Vùng dữ liệu trong mạng Ethernet chứa tối đa', N'185 bytes', N'1500 bytes', N'8182 bytes', N'Không giới hạn', N'B', N'TH123   ', N'574e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (106, N'MMTCB', N'A', N'Chọn câu sai:" Cầu nối (bridge) có thể kết nối các mạng có...."', N'Chiều dài frame khác nhau', N'Cấu trúc frame khác nhau', N'Tốc độ truyền khác nhau', N'Chuẩn khác nhau', N'A', N'TH123   ', N'584e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (107, N'MMTCB', N'A', N'Mạng nào có tốc độ truyền lớn hơn 100Mbps', N'Fast Ethernet', N'Gigabit Ethernet', N'Ethernet', N'Tất cả đều đúng', N'B', N'TH123   ', N'594e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (108, N'MMTCB', N'A', N'Mạng Ethernet sử dụng được loại cáp', N'Cáp quang', N'Xoắn đôi', N'Đồng trục', N'Tất cả đều đúgn', N'D', N'TH123   ', N'5a4e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (109, N'MMTCB', N'A', N'Khoảng cách đường truyền tối đa mạng FDDI có thể đạt', N'1Km', N'10Km', N'100Km', N'1000Km', N'C', N'TH123   ', N'5b4e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (110, N'MMTCB', N'A', N'Cấp network truyền nhận theo kiểu end-to-end vì nó quản lý dữ liệu', N'Giữa 2 đầu subnet', N'Giữa 2 máy tính trong mạng', N'Giữa 2 thiết bị trên đường truyền', N'Giữa 2 đầu đường truyền', N'A', N'TH123   ', N'5c4e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (111, N'MMTCB', N'A', N'Kiểu mạch ảo(virtual circuit) được dùng trong loại dịch vụ mạng', N'Có kết nối', N'Không kết nối', N'Truyền 1 chiều', N'Truyền 2 chiều', N'A', N'TH123   ', N'5d4e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (112, N'MMTCB', N'A', N'Kiểu datagram trong cấp network', N'Chỉ tìm đường 1 lần khi tạo kết nối', N'Phải tìm đường riêng cho từng packet', N'THông tin có sẵn trong packet, không cần tìm đường', N'Thông tin có sẵn trong router , không cần tìm đường', N'B', N'TH123   ', N'5e4e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (113, N'MMTCB', N'A', N'Kiểm soát tắc nghẽn (congestion) là nhiệm vụ của cấp', N'Physical', N'Transport', N'Data link', N'Network', N'D', N'TH123   ', N'5f4e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (114, N'MMTCB', N'A', N'Nguyên nhân dẫn đến tắt nghẻn (congestion) trên mạng', N'Tốc độ xử lý của router chậm', N'Buffers trong router nhỏ', N'Router có nhiều đường vào nhưng ít đường ra', N'Tất cả đều đúng', N'D', N'TH123   ', N'604e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (115, N'MMTCB', N'A', N'Cấp appliation trong mô hình TCP/IP tương đương với cấp nào trong mô hình OSI', N'Session', N'Application', N'Presentation', N'Tất cả đều đúng', N'D', N'TH123   ', N'614e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (116, N'MMTCB', N'A', N'Cấp nào trong mô hình mạng OSI tương đương với cấp Internet trong mô hình TCP/IP ', N'Network', N'Transport', N'Physical', N'Data link', N'A', N'TH123   ', N'624e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (117, N'MMTCB', N'A', N'Chất lượng dịch vụ mạng không được đánh giá trên chỉ tiêu nào?', N'Thời gian thiết lập kết nối ngắn', N'Tỉ lệ sai sót rất nhỏ', N'Tốc độ đường truyền cao', N'Khả năng phục hồi khi có sự cố', N'A', N'TH123   ', N'634e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (118, N'MMTCB', N'A', N'Kỹ thuật Multiplexing được dùng khi', N'Có nhiều kênh truyền hơn đường truyền', N'Có nhiều đường truyền hơn kênh truyền', N'Truyền dữ liệu số trên mạng điện thoại', N'Truyền dữ liệu tương tự trên mạng điện thọai', N'A', N'TH123   ', N'644e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (119, N'MMTCB', N'A', N'Dịch vụ truyền Email sử dụng protocol nào?', N'HTTP', N'NNTP', N'SMTP', N'FTP', N'C', N'TH123   ', N'654e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (120, N'MMTCB', N'A', N'Địa chỉ IP lớp B nằm trong phạm vi nào', N'192.0.0.0 - 223.0.0.0', N'127.0.0.0 - 191.0.0.0', N'128.0.0.0 - 191.0.0.0 ', N'1.0.0.0 - 126.0.0.0', N'C', N'TH123   ', N'664e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (121, N'MMTCB', N'A', N'Subnet Mask nào sau đây chỉ cho tối đa 2 địa chỉ host', N'255.255.255.252', N'255.255.255.254', N'255.255.255.248', N'255.255.255.240', N'A', N'TH123   ', N'674e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (122, N'MMTCB', N'A', N'Thành phần nào không thuộc socket', N'Port', N'Địa chỉ IP', N'Địa chỉ cấp MAC', N'Protocol cấp Transport', N'C', N'TH123   ', N'684e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (123, N'MMTCB', N'A', N'Mục đích của Subnet Mask trong địa chỉ IP là', N'Xác định host của địa chỉ IP', N'Xác định vùng network của địa chỉ IP', N'Lấy các bit trong vùng subnet làm địa chỉ host', N'Lấy các bit trong vùng địa chỉ host làm subnet', N'A', N'TH123   ', N'694e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (124, N'MMTCB', N'A', N'Bước đầu tiên cần thực hiện để truyền dữ liệu theo ALOHA là', N'Chờ 1 thời gian ngẫu nhiên', N'Gửi tín hiệu tạo kết nối', N'Kiểm tra tình trạng đường truyền', N'Lập tức truyền dữ liệu', N'D', N'TH123   ', N'6a4e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (125, N'MMTCB', N'A', N'Cầu nối trong suốt hoạt động trong cấp nào', N'Data link', N'Physical', N'Network', N'Transport', N'A', N'TH123   ', N'6b4e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (126, N'MMTCB', N'A', N'Tốc độ của đường truyền T1 là:', N'2048 Mbps', N'1544 Mbps', N'155 Mbps', N'56 Kbps', N'B', N'TH123   ', N'6c4e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (127, N'MMTCB', N'A', N'Khi một dịch vụ trả lời ACK cho biết dữ liệu đã nhận được, đó là', N'Dịch vụ có xác nhận', N'Dịch vụ không xác nhận', N'Dịch vụ có kết nối', N'Dịch vụ không kết nối', N'A', N'TH123   ', N'6d4e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (128, N'MMTCB', N'A', N'Loại frame nào được sử dụng trong mạng Token-ring', N'Monitor', N'Token', N'Data', N'Token và Data', N'D', N'TH123   ', N'6e4e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (129, N'MMTCB', N'A', N'Thuật ngữ OSI là viết tắt bởi', N'Organization for Standard Institude', N'Organization for Standard Internet', N'Open Standard Institude', N'Open System Interconnection', N'D', N'TH123   ', N'6f4e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (130, N'MMTCB', N'A', N'Trong mạng Token-ting, khi 1 máy nhận được Token', N'Nó phải truyền cho máy kế trong vòng', N'Nó được quyền truyền dữ liệu', N'Nó được quyền giữ lại Token', N'Tất cả đều sai', N'B', N'TH123   ', N'704e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (131, N'MMTCB', N'A', N'Trong mạng cục bộ, để xác định 1 máy trong mạng ta dùng địa chỉ', N'MAC', N'Socket', N'Domain', N'Port', N'A', N'TH123   ', N'714e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (132, N'MMTCB', N'A', N'Thứ tự các cấp trong mô hình OSI', N'Application,Session,Transport,Physical', N'Application, Transport, Network, Physical', N'Application, Presentation,Session,Network,Transport,Data link,Physical', N'Application,Presentation,Session,Transport,Network,Data link,Physical', N'D', N'TH123   ', N'724e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (133, N'MMTCB', N'A', N'Cấp vật lý (physical) không quản lý', N'Mức điện áp', N'Địa chỉ vật lý', N'Mạch giao tiếp vật lý', N'Truyền các bit dữ liêu', N'B', N'TH123   ', N'734e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (134, N'MMTCB', N'A', N'TCP sử dụng loại dịch vụ', N'Có kết nối, độ tin cậy cao', N'Có kết nối, độ tin cậy thấp', N'Không kết nối, độ tin cậy cao', N'Không kết nối, độ tin cậy thấp', N'A', N'TH123   ', N'744e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (135, N'MMTCB', N'A', N'Địa chỉ IP bao gồm', N'Địa chỉ Network và địa chỉ host', N'Địa chỉ physical và địa chỉ logical', N'Địa chỉ cấp MAC và và địa chỉ LLC', N'Địa chỉ hardware và địa chỉ software', N'A', N'TH123   ', N'754e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (136, N'MMTCB', N'A', N'Chức năng cấp mạng (network) là', N'Mã hóa và định dạng dữ liệu', N'Tìm đường và kiểm soát tắc nghẽn', N'Truy cập môi trường mạng', N'Kiểm soát lỗi và kiểm soát lưu lượng', N'B', N'TH123   ', N'764e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (137, N'MMTCB', N'A', N'Mạng CSMA/CD làm gì', N'Truyền Token trên mạng hình sao', N'Truyền Token trên mạng dạng Bus', N'Chia packet ra thành từng frame nhỏ và truỵền đi trên mạng', N'Truy cập đường truyền và truyền lại dữ liệu nếu xảy ra đụng độ', N'D', N'TH123   ', N'774e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (138, N'MMTCB', N'A', N'Tiền thân của mạng Internet là', N'Intranet', N'Ethernet', N'Arpanet', N'Token-bus', N'C', N'TH123   ', N'784e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (139, N'MMTCB', N'A', N'Khi 1 cầu nối ( bridge) nhận được 1 framechưa biết thông tin về địa chỉ máy nhận, nó sẽ', N'Xóa bỏ frame này', N'Gửi trả lại máy gốc', N'Gửi đến mọi ngõ ra còn lại', N'Giảm thời gian sống của frame đi 1 đơn vị và gửi đến mọi ngõ ra còn lại', N'C', N'TH123   ', N'794e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (140, N'MMTCB', N'A', N'Chức năng của cấp Network là', N'Tìm đường', N'Mã hóa dữ liệu', N'Tạo địa chỉ vật lý', N'Kiểm soát lưu lượng', N'A', N'TH123   ', N'7a4e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (141, N'MMTCB', N'B', N'Sự khác nhau giữa địa chỉ cấp Data link và Network là', N'Địa chỉ cấp Data link có kích thước nhỏ hơn địa chỉ cấp Network', N'Địa chỉ cấp Data link là đia chỉ Physic, địa chỉ cấp Network là địa chỉ Logic', N'Địa chỉ cấp Data Link là địa chỉ Logic, địa chỉ câp Network là địa chỉ Physic', N'Địa chỉ Data link cấu hình theo mạng, địa chỉ cấp Network xác định theo IEEE', N'B', N'TH123   ', N'7b4e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (142, N'MMTCB', N'B', N'Kỹ thuật nào không sử dụng được trong việc kiểm soát lưu lượng(flow control)', N'Ack', N'Buffer', N'Windowing', N'Multiplexing', N'D', N'TH123   ', N'7c4e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (143, N'MMTCB', N'B', N'Cấp cao nhất trong mô hình mạng OSI là', N'Transport', N'Physical', N'Network', N'Application', N'D', N'TH123   ', N'7d4e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (144, N'MMTCB', N'B', N'Tại sao mạng máy tình dùng mô hình phân cấp', N'Để mọi người sử dụng cùng 1 ứng dụng mạng', N'Để phân biệt giữa chuẩn mạng và ứng dụng mạng', N'Giảm độ phức tạp trong việc thiết kế và cài đặt', N'Các cấp khác không cần sửa đổi khi thay đổi 1 cấp mạng', N'D', N'TH123   ', N'7e4e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (145, N'MMTCB', N'B', N'Router làm gì để giảm tăc nghẽn (congestion)', N'Nén dữ liệu', N'Lọc bớt dữ liệu theo địa chỉ vật lý', N'Lọc bớt dữ liệu theo địa chỉ logic', N'Cấm truyền dữ liệu broadcasr', N'D', N'TH123   ', N'7f4e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (146, N'MMTCB', N'B', N'Byte đầu của 1 IP có giá trị 222, địa chỉ này thuộc lớp địa chỉ nào', N'Lớp A', N'Lớp B', N'Lớp C', N'Lớp D', N'C', N'TH123   ', N'804e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (147, N'MMTCB', N'B', N'Chọn câu đúng đối với switch của mạng LAN', N'Là 1 cầu nối tốc độ cao', N'Nhận data từ 1 cổng và xuất ra mọi cổng còn lại', N'Nhận data từ 1 cổng và xuất ra  cổng đích tùy theo địa chỉ cấp IP', N'Nhận data từ 1 cổng và xuất ra 1 cổng đích tùy theo địa chỉ cấp MAC', N'D', N'TH123   ', N'814e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (148, N'MMTCB', N'B', N'Thuật ngữ nào cho biết loại mạng chỉ truyền được  chiều tại 1 thời điểm', N'Half duplex', N'Full duplex', N'Simplex', N'Monoplex', N'A', N'TH123   ', N'824e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (149, N'MMTCB', N'B', N'Protocol nghĩa là', N'Tập các chuẩn truyền dữ liệu', N'Tập các cấp mạng trong mô hình OSI', N'Tập các chức năng của từng cấp trong mạng', N'Tập các qui tắc và cấu trúc dữ liệu để truyền thông giữa các cấp mạng', N'D', N'TH123   ', N'834e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (150, N'MMTCB', N'B', N'Truyền dữ liệu theo kiểu có kết nối không cần thực hiện việc', N'Hủy kết nối', N'Tạo kết nối', N'Truyền dữ liệu', N'Tìm đường cho từng gói tin', N'D', N'TH123   ', N'844e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (151, N'MMTCB', N'B', N'Byte đầu của địa chỉ IP lớp E nằm trong phạm vi', N'128 - 191', N'192 - 232 ', N'224 - 239 ', N'240 - 247', N'D', N'TH123   ', N'854e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (152, N'MMTCB', N'B', N'Khi truyền đi chuỗi "VIET NAM" nhưng nhận được chuỗi"MAN TEIV ". Cần phải hiệu chỉnh các protocol trong cấp nào để truyền chính xác', N'Session', N'Transport', N'Application', N'Presentation', N'B', N'TH123   ', N'864e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (153, N'MMTCB', N'B', N'Tên cáp UTP dùng torng mạng Fast Ethernet là', N'100BaseF', N'100Base2', N'100BaseT', N'100Base5', N'C', N'TH123   ', N'874e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (154, N'MMTCB', N'B', N'Tốc độ truyền của mạng Ethernet là', N'1 Mbps', N'10 Mbps', N'100 Mbps', N'1000 Mbps', N'B', N'TH123   ', N'884e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (155, N'MMTCB', N'B', N'Dịch vụ mạng thường được phân chia thành', N'Dịch vụ không kết nối và có kết nối', N'Dich vụ có xác nhận và không xác nhận', N'Dịch vụ có độ tin cậy cao và có độ tin cậy thấp', N'Tất cả đều đúng', N'D', N'TH123   ', N'894e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (156, N'MMTCB', N'B', N'Đơn vị truyền dữ liệu trong cấp Network gọi là', N'Bit', N'Frame', N'Packet', N'Segment', N'C', N'TH123   ', N'8a4e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (157, N'MMTCB', N'B', N'Protocol nào trong mạng TCP/IP chuyển đổi địa chỉ vật lý thành địa chỉ IP', N'IP', N'ARP', N'ICMP', N'RARP', N'D', N'TH123   ', N'8b4e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (158, N'MMTCB', N'B', N'Đầu nới AUI dùng cho loại cáp nào?', N'Đồng trục', N'Xoắn đôi', N'Cáp quang', N'Tất cả đều đúng', N'A', N'TH123   ', N'8c4e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (159, N'MMTCB', N'B', N'Subnet mask chuẩn của địa chỉ IP lớp B là', N'255.0.0.0', N'255.255.0.0', N'255.255.255.0', N'255.255.255.255', N'B', N'TH123   ', N'8d4e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (160, N'MMTCB', N'B', N'Lý do nào khiến người ta chọn protocol TCP hơn là UDP', N'Không ACK', N'Dễ sử dụng', N'Độ tin cậy', N'Không kết nối', N'C', N'TH123   ', N'8e4e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (161, N'MMTCB', N'B', N'Nhược điểm của dịch vụ có kết nối so với không kết nối', N'Độ tin cậy', N'Thứ tự nhận dữ liệu không đúng', N'Đường truyền không thay đổi', N'Đường truyền thay đổi liên tục', N'C', N'TH123   ', N'8f4e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (162, N'MMTCB', N'B', N'Cấp Data link không thực hiện chức năng nào?', N'Kiểm soát lỗi', N'Địa chỉ vật lý', N'Kiểm soát lưu lượng', N'Thiết lập kết nối', N'D', N'TH123   ', N'904e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (163, N'MMTCB', N'B', N'Cầu nối (bridge)dựa vào thông tin nào để truyền tiếp hoặc hủy bỏ 1 frame', N'Điạ chỉ nguồn', N'Địa chỉ đích', N'Địa chỉ mạng', N'Tất cả đều đúng', N'C', N'TH123   ', N'914e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (164, N'MMTCB', N'B', N'Chuẩn nào sử dụng trong cấp presentation?', N'UTP và STP', N'SMTP và HTTP', N'ASCII và EBCDIC', N'TCP và UDP', N'C', N'TH123   ', N'924e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (165, N'MMTCB', N'B', N'Đơn vị truyền dữ liệu giữa các cấp trong mạng theo thứ tự', N'bit,frame,packet,data', N'bit,packet,frame,data', N'data,frame,packet,bit', N'data,bit,packet,frame', N'A', N'TH123   ', N'934e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (166, N'MMTCB', N'B', N'Mạng Ethernet do cơ quan nào phát minh', N'ANSI', N'ISO', N'IEEE', N'XEROX', N'D', N'TH123   ', N'944e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (167, N'MMTCB', N'B', N'Chiều dài loại cáp nào tối đa 100 m? ', N'10Base2', N'10Base5', N'10BaseT', N'10BaseF', N'C', N'TH123   ', N'954e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (168, N'MMTCB', N'B', N'Địa chỉ IP 100.150.200.250 có nghĩa là', N'Địa chỉ network 100, địa chỉ host 150.200.250', N'Địa chỉ network 100.150, địa chỉ host 200.250', N'Địa chỉ network 100.150.200, địa chỉ host 250', N'Tất cả đều sai', N'D', N'TH123   ', N'964e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (169, N'MMTCB', N'B', N'Switching hun khác hub thông thường ở chỗ nó làm', N'Giảm collision trên mạng', N'Tăng collision trên mạng', N'Giảm congestion trên mạng', N'Tăng congestion trên mạng', N'A', N'TH123   ', N'974e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (170, N'MMTCB', N'B', N'Loại cáp nào chỉ truyền dữ liệu 1 chiều', N'Cáp quang', N'Xoắn đôi', N'Đồng trục', N'Tất cả đều đúng', N'A', N'TH123   ', N'984e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (171, N'MMTCB', N'B', N'Thiết bị Modem dùng để', N'Tách và ghép tín hiệu', N'Nén và gải nén tín hiệu', N'Mã hóa và giải mã tín hiệu', N'Điều chế và giải điều chế tín hiệu', N'D', N'TH123   ', N'994e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (172, N'MMTCB', N'B', N'Việc cấp phát kênh truyền áp dụng cho loại mạng', N'Peer to peer', N'Point to point', N'Broadcast', N'Multiple Access', N'C', N'TH123   ', N'9a4e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (173, N'MMTCB', N'B', N'Mạng nào dùng phương pháp mã hóa Manchester Encoding', N'Ethernet', N'Token-ring', N'Token-bus', N'Tất cả đều đúng ', N'D', N'TH123   ', N'9b4e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (174, N'MMTCB', N'B', N'Phương pháp tìm đường có tính đến thời gian trễ', N'Tìm đường theo chiều sâu', N'Tìm đường theo chiều rộng', N'Tìm đường theo vector khoảng cách', N'Tìm đường theo trạng thái đường truyền', N'D', N'TH123   ', N'9c4e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (175, N'MMTCB', N'B', N'Chuẩn mạng nào khi có dữ liệu không truyền ngay mà chờ 1 thời gian ngẫu nhiên?', N'1-presistent CSMA', N'p-presistent CSMA', N'Non-presistent CSMA', N'CSMA/CD', N'C', N'TH123   ', N'9d4e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (176, N'MMTCB', N'B', N'Phương pháp chèn bit (bit stuffing) được dùng để', N'Phân biệt đầu và cuối frame', N'Bổ sung cho đủ kích thước frame tối thiểu', N'Phân cách nhiều bit 0 bằng bit 1', N'Biến đổi dạng dữ liệu 8 bit ra 16 bit', N'A', N'TH123   ', N'9e4e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (177, N'MMTCB', N'B', N'Để chống nhiễu trên đường truyền tốt nhất, nên dùng loại cáp:', N'Xoắn đôi', N'Đồng trục', N'Cáp quang', N'Mạng không dây', N'C', N'TH123   ', N'9f4e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (178, N'MMTCB', N'B', N'Phần mềm gửi/nhận thư điện tử thuộc cấp nào trong mô hình OSI', N'Data link', N'Network', N'Application', N'Presentation', N'C', N'TH123   ', N'a04e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (179, N'MMTCB', N'B', N'Chức năng của thiết bị Hub trong mạng LAN', N'Mã hóa tín hiệu', N'Triệt tiêu tín hiệu', N'Phân chia tín hiệu', N'Điều chế tín hiếu', N'C', N'TH123   ', N'a14e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (180, N'MMTCB', N'B', N'Switch là thiết bị mạng làm việc tương tự như', N'Hub', N'Repeater', N'Router', N'Bridge', N'D', N'TH123   ', N'a24e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (181, N'MMTCB', N'C', N'Thiết bị nào làm việc trong cấp Network', N'Bridge', N'Repeater', N'Router', N'Gateway', N'C', N'TH123   ', N'a34e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (182, N'MMTCB', N'C', N'Thiết bị nào cần có bộ nhớ làm buffer', N'Hub', N'Switch', N'Repeater', N'Router', N'D', N'TH123   ', N'a44e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (183, N'MMTCB', N'C', N'Luật 5-4-3 cho phép tối đa', N'5 segment trong 1 mạng', N'5 repeater trong 1 mạng', N'5 máy tính trong 1 mạng', N'5 máy tính trong 1 segment', N'A', N'TH123   ', N'a54e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (184, N'MMTCB', N'C', N'Thiết bị nào có thể thêm vào mạng LAN mà không sợ vi phạm luật 5-4-3', N'Router', N'Repeater', N'Máy tính', N'Tất cả đều đúng', N'A', N'TH123   ', N'a64e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (185, N'MMTCB', N'C', N'Thêm thiết bị nào vào mạng có thể qui phạm luật 5-4-3', N'Router', N'Repeater', N'Bridge', N'Tất cả đều đúng', N'B', N'TH123   ', N'a74e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (186, N'MMTCB', N'C', N'Mạng nào cóxảy ra xung đột (collision) trên đường truyền', N'Ethernet', N'Token-ring', N'Token-bus', N'Tất cả đều sai', N'A', N'TH123   ', N'a84e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (187, N'MMTCB', N'C', N'Từ "Broad" trong tên cáp 10Broad36 viết tắt bởi', N'Broadcast', N'Broadbase', N'Broadband', N'Broadway', N'C', N'TH123   ', N'a94e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (188, N'MMTCB', N'C', N'Protocol nào sử dụng trong cấp Network', N'IP', N'TCP', N'UDP', N'FTP', N'A', N'TH123   ', N'aa4e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (189, N'MMTCB', N'C', N'Protocol nào torng cấp Transport cung cấp dịch vụ không kết nối', N'IP', N'TCP', N'UDP', N'FTP', N'C', N'TH123   ', N'ab4e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (190, N'MMTCB', N'C', N'Protocol nào trong cấp Transport dùng kiểu dịch vụ có kết nối?', N'IP', N'TCP', N'UDP', N'FTP', N'B', N'TH123   ', N'ac4e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (191, N'MMTCB', N'C', N'Địa chỉ IP được chia làm mấy lớp', N'2', N'3', N'4', N'5', N'D', N'TH123   ', N'ad4e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (192, N'MMTCB', N'C', N'Chức năng nào không phải của cấp Network', N'Tìm đường', N'Địa chỉ logic', N'Kiểm soát tắc nghẽn', N'Chất lượng dịch vụ', N'B', N'TH123   ', N'ae4e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (193, N'MMTCB', N'C', N'Phương pháp chèn kí tự dùng để', N'Phân cách các frame', N'Phân biệt dữ liệu và ký tự điều khiển', N'Nhận diện đầu cuối frame', N'Bổ sung cho đủ kich thước frame tối thiểu', N'B', N'TH123   ', N'af4e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (194, N'MMTCB', N'C', N'Kỹ thuật truyền nào mã hóa trực tiếp dữ liệu ra đường truyền không cần sóng mang', N'Broadcast', N'Digital', N'Baseband', N'Broadband', N'C', N'TH123   ', N'b04e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (195, N'MMTCB', N'C', N'Sóng viba sử dụng băng tần', N'SHF', N'LF và MF', N'UHF và VHF', N'Tất cả đều đúng', N'D', N'TH123   ', N'b14e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (196, N'MMTCB', N'C', N'Sóng viba bị ảnh hưởng bời', N'Trời mưa', N'Sấm chớp', N'Giông bão', N'Ánh sáng mặt trời', N'A', N'TH123   ', N'b24e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (197, N'MMTCB', N'C', N'Đường dây trung kế trong mạng điện thoại sử dụng', N'Tín hiệu số', N'Kỹ thuật dồn kênh', N'Cáp quang, cáp đồng và viba', N'Tất cả đêu đúng', N'D', N'TH123   ', N'b34e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (198, N'MMTCB', N'C', N'Cáp quang dùng công nghệ dồn kênh nào', N'TDM', N'FDM', N'WDM', N'CDMA', N'C', N'TH123   ', N'b44e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (199, N'MMTCB', N'C', N'Nhược điểm của phương pháp chèn ký tự', N'Giảm tốc độ đường truyền', N'Tăng phí tổn đường truyền', N'Mất đồng bộ frame', N'Không nhận diện được frame', N'B', N'TH123   ', N'b54e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (201, N'MMTCB', N'C', N'Mạng nào dùng công nghệ Token-bus', N'FDDI', N'CDDI', N'Fast Ethernet', N'100VG-AnyLAN', N'D', N'TH123   ', N'b74e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (202, N'MMTCB', N'C', N'Thiết bị nào tự trao đổi thông tin lẫn nhau để quản lý mạng', N'Hub', N'Bridge', N'Router', N'Repeater', N'C', N'TH123   ', N'b84e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
GO
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (203, N'MMTCB', N'C', N'Tần số sóng điện từ dùng trong mạng vô tuyến sắp theo thứ tự tăng dần', N'Radio,viba,hồng ngoại', N'Radio,hồng ngoại,viba', N'Hồng ngoại,viba,radio', N'Viba,radio,hồng ngoại', N'A', N'TH123   ', N'b94e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (204, N'MMTCB', N'C', N'Đường dây hạ kế (local loop) trong mạch điện thoại dùng tín hiệu', N'Digital', N'Analog', N'Manchester', N'T1 hoặc E1', N'B', N'TH123   ', N'ba4e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (205, N'MMTCB', N'C', N'Để tránh nhận trùng dữ liệu người ta dùng phương pháp', N'Đánh số thứ tự các frame', N'Quy định kích thước frame cố định', N'Chờ nhận ACK mới gửi frame kế tiếp', N'So sánh và loại bỏ các frame giống nhau', N'A', N'TH123   ', N'bb4e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (206, N'MMTCB', N'C', N'Cơ chế Timer dùng để', N'Đo thời gian chơ frame', N'Tránh tình trạng mất frame', N'Chọn thời điểm truyền frame', N'Kiểm soát thòi gian truyền frame', N'A', N'TH123   ', N'bc4e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (207, N'MMTCB', N'C', N'Cấp nào trong mô hình OSI quan tâm tới topology mạng', N'Transport', N'Network', N'Data link', N'Physical', N'B', N'TH123   ', N'bd4e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (208, N'MMTCB', N'C', N'Loại mạng nào sử dụng trên WAN', N'Ethernet và Token-bus', N'ISDN và Frame relay', N'Token-ring và FDDI', N'SDLC và HDLC', N'A', N'TH123   ', N'be4e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (209, N'MMTCB', N'C', N'Repeater nhiều port là tên gọi của', N'Hub', N'Host', N'Bridge', N'Router', N'A', N'TH123   ', N'bf4e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (210, N'MMTCB', N'C', N'Đơn vị đo tốc độ đường truyền', N'bps(bit per second)', N'Bps(Byte per second)', N'mps(meter per second)', N'hertz (ccle per second)', N'A', N'TH123   ', N'c04e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (211, N'MMTCB', N'C', N'Repeater dùng để', N'Lọc bớt dữ liệu trên mạng', N'Tăng tốc độ lưu thông trên mạng', N'Tăng thời gian trễ trên mạng', N'Mở rộng chiều dài đường truyền', N'D', N'TH123   ', N'c14e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (212, N'MMTCB', N'C', N'Cáp đồng trục (coaxial)', N'Có 4 đôi dây', N'Không cần repeater', N'Truyền tín hiệu ánh sáng', N'Chống nhiễu tốt hơn UTP', N'D', N'TH123   ', N'c24e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (213, N'MMTCB', N'C', N'Câp Data link ', N'Truyền dữ liệu cho các cấp khác trong mạng', N'Cung cấp dịch vụ cho chương trình ứng dụng', N'Nhận tín hiệu yếu,lọc,khuếch đại và phát lại trên mạng', N'Bảo đảm đường truyền dữ liệu tin cậy giữa 2 đầu đường truyền', N'D', N'TH123   ', N'c34e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (214, N'MMTCB', N'C', N'Địa chỉ IP còn gọi là', N'Địa chĩ vật lý', N'Địa chỉ luận lý', N'Địa chỉ thập phân', N'Địa chỉ thập lục phân', N'B', N'TH123   ', N'c44e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (215, N'MMTCB', N'C', N'Cấp Presentation', N'Thiết lập, quản lý và kết thúc các ứng dụng', N'Hướng dẫn cách mô tả hình ảnh, âm thanh, tiếng nói', N'Cung cấp dịch vụ truyền dữ liệu từ nguồn đến đích', N'Hỗ trợ việc truyền thông trong các ứng dụng như web, mail...', N'C', N'TH123   ', N'c54e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (216, N'MMTCB', N'C', N'Tập các luật để định dạng và truyền dữ liệu gọi là', N'Qui luật (rule)', N'Nghi thức (protocol)', N'Tiêu chuẩn (standard)', N'Mô hình (model)', N'B', N'TH123   ', N'c64e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (217, N'MMTCB', N'C', N'Tại sao cần có tiêu chuẩn về mang', N'Định hướng phát triển phần cứng và phần mềm mới', N'LAN,MAN và WAN sử dụng các thiết bị khác nhau', N'Kết nối mạng giữa các quôc gia khác nhau', N'Tương thích về công nghệ để truyền thông được lẫn nhau', N'D', N'TH123   ', N'c74e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (218, N'MMTCB', N'C', N'Dữ liệu truyền trên mạng bằng', N'Mã ASCII', N'Số nhị phân', N'Không và một', N'Xung điện áp', N'D', N'TH123   ', N'c84e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (219, N'MMTCB', N'C', N'Mạng CSMA/CD', N'Kiểm tra để bảo đảm dữ liệu truyền đến đích', N'Kiểm tra đường truyền nếu rảnh mới truyền dữ liệu', N'Chờ 1 thời gian ngẫu nhiên rồi truyền  dữ liệu kế tiếp', N'Tất cả đều đúng', N'B', N'TH123   ', N'c94e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (220, N'MMTCB', N'C', N'Địa chỉ MAC ', N'Gồm có 32 bit', N'Còn gọi là địa chỉ logic', N'Nằm trong cấp Network', N'Dùng để phân biệt các máy trong mạng', N'D', N'TH123   ', N'ca4e76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (234, N'CTDL ', N'A', N'hbybyb', N'ádg', N'ádg', N'ádg', N'ádg', N'B', N'TH110   ', N'6085b0c9-06d2-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (235, N'CTDL ', N'A', N'asdgasdg', N'asdg', N'asdg', N'adsg', N'adsg', N'B', N'TH110   ', N'950229dd-c4dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (236, N'CTDL ', N'A', N'ggu', N'ftyu', N'try', N'rty', N'yu', N'B', N'TH110   ', N'634fc5f1-c4dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (237, N'CTDL ', N'A', N'ryti', N'y', N'ertu', N'ertu', N'erterty', N'A', N'TH110   ', N'c5d878f9-c4dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (238, N'CTDL ', N'A', N'45', N'shtt', N'dfdf', N'dfg', N'dfg', N'B', N'TH110   ', N'4853d109-c5dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (239, N'CTDL ', N'A', N'ábd', N'gggh', N'gbnm', N'qưer', N'aaabh', N'B', N'TH110   ', N'c6a3d6ff-10dd-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (240, N'CTDL ', N'A', N'a', N'b', N'c', N'd', N'e', N'B', N'TH110   ', N'10b17a08-11dd-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (241, N'CTDL ', N'A', N'a', N'a', N'a', N'a', N'a', N'B', N'TH101   ', N'6b2cf742-11dd-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (242, N'CTDL ', N'A', N'ba', N'ab', N'ab', N'áb', N'áb', N'A', N'TH101   ', N'ccdfb94c-11dd-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (243, N'CTDL ', N'A', N'tttt', N't', N'hh', N'h', N'f', N'D', N'TH101   ', N'aae66754-11dd-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[COSO] ([MACS], [TENCS], [DIACHI], [rowguid]) VALUES (N'CS1', N'Cơ sở 1 ', N'11 Nguyễn Đình Chiểu, Phường Đakao, Quận 1, TP. HCM', N'd24d76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[COSO] ([MACS], [TENCS], [DIACHI], [rowguid]) VALUES (N'CS2', N'Cơ sở 2', N'Số 9 Man Thiện , quận 9, TP. HCM', N'd34d76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[GIAOVIEN] ([MAGV], [HO], [TEN], [DIACHI], [MAKH], [rowguid]) VALUES (N'TH101   ', N'KIEU DAC', N'THIEN', N'9,3A, Q.BINH TAN', N'CNTT    ', N'db4d76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[GIAOVIEN] ([MAGV], [HO], [TEN], [DIACHI], [MAKH], [rowguid]) VALUES (N'TH110   ', N'LE VAN', N'SON', N'Q.9', N'DT      ', N'1c5c8c8a-f8cf-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[GIAOVIEN] ([MAGV], [HO], [TEN], [DIACHI], [MAKH], [rowguid]) VALUES (N'TH123   ', N'PHAN VAN ', N'HAI', N'15/72 LE VAN THO F8 GO VAP', N'CNTT    ', N'dc4d76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[GIAOVIEN] ([MAGV], [HO], [TEN], [DIACHI], [MAKH], [rowguid]) VALUES (N'TH234   ', N'DAO VAN ', N'TUYET', N'14/7 BUI DINH TUY TAN BINH', N'CNTT    ', N'dd4d76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[GIAOVIEN] ([MAGV], [HO], [TEN], [DIACHI], [MAKH], [rowguid]) VALUES (N'TH358   ', N'NGUYEN TRI', N'CUONG', N'Q.9', N'VT      ', N'f271b105-d8ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[GIAOVIEN] ([MAGV], [HO], [TEN], [DIACHI], [MAKH], [rowguid]) VALUES (N'TH456   ', N'NGUYEN VAN', N'THANH', N'Q.9', N'DT      ', N'ed114cb1-68ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[GIAOVIEN_DANGKY] ([MAGV], [MAMH], [MALOP], [TRINHDO], [NGAYTHI], [LAN], [SOCAUTHI], [THOIGIAN], [rowguid]) VALUES (N'TH101   ', N'asd  ', N'TH05           ', N'A', CAST(N'2022-05-26 00:00:00.000' AS DateTime), 2, 13, 20, N'c332bc17-c1dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[GIAOVIEN_DANGKY] ([MAGV], [MAMH], [MALOP], [TRINHDO], [NGAYTHI], [LAN], [SOCAUTHI], [THOIGIAN], [rowguid]) VALUES (N'TH123   ', N'AVCB ', N'TH04           ', N'A', CAST(N'2022-05-19 00:00:00.000' AS DateTime), 2, 20, 20, N'8e3151e8-8cd7-ec11-ab4a-8d988a78990c')
INSERT [dbo].[GIAOVIEN_DANGKY] ([MAGV], [MAMH], [MALOP], [TRINHDO], [NGAYTHI], [LAN], [SOCAUTHI], [THOIGIAN], [rowguid]) VALUES (N'TH123   ', N'AVCB ', N'TH05           ', N'B', CAST(N'2022-05-13 00:00:00.000' AS DateTime), 1, 60, 30, N'79aa9776-6ad4-ec11-ab49-f83f8a785c71')
INSERT [dbo].[GIAOVIEN_DANGKY] ([MAGV], [MAMH], [MALOP], [TRINHDO], [NGAYTHI], [LAN], [SOCAUTHI], [THOIGIAN], [rowguid]) VALUES (N'TH123   ', N'AVCB ', N'TH06           ', N'A', CAST(N'2022-05-26 00:00:00.000' AS DateTime), 1, 20, 20, N'aa343335-ccdc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[GIAOVIEN_DANGKY] ([MAGV], [MAMH], [MALOP], [TRINHDO], [NGAYTHI], [LAN], [SOCAUTHI], [THOIGIAN], [rowguid]) VALUES (N'TH123   ', N'AVCB ', N'TH07           ', N'A', CAST(N'2022-05-26 00:00:00.000' AS DateTime), 2, 20, 15, N'efb25607-87d7-ec11-ab4a-8d988a78990c')
INSERT [dbo].[GIAOVIEN_DANGKY] ([MAGV], [MAMH], [MALOP], [TRINHDO], [NGAYTHI], [LAN], [SOCAUTHI], [THOIGIAN], [rowguid]) VALUES (N'TH101   ', N'CSDL ', N'TH04           ', N'A', CAST(N'2022-05-27 00:00:00.000' AS DateTime), 1, 10, 15, N'ba2ef461-f8cf-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[GIAOVIEN_DANGKY] ([MAGV], [MAMH], [MALOP], [TRINHDO], [NGAYTHI], [LAN], [SOCAUTHI], [THOIGIAN], [rowguid]) VALUES (N'TH234   ', N'CTDL ', N'TH05           ', N'A', CAST(N'2022-05-18 00:00:00.000' AS DateTime), 1, 10, 15, N'bccc9f95-c7d6-ec11-ab49-f83f8a785c71')
INSERT [dbo].[GIAOVIEN_DANGKY] ([MAGV], [MAMH], [MALOP], [TRINHDO], [NGAYTHI], [LAN], [SOCAUTHI], [THOIGIAN], [rowguid]) VALUES (N'TH110   ', N'CTDL ', N'VT04           ', N'A', CAST(N'2022-05-26 00:00:00.000' AS DateTime), 1, 10, 20, N'f41f2128-d3d0-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[GIAOVIEN_DANGKY] ([MAGV], [MAMH], [MALOP], [TRINHDO], [NGAYTHI], [LAN], [SOCAUTHI], [THOIGIAN], [rowguid]) VALUES (N'TH358   ', N'CTDL ', N'VT04           ', N'A', CAST(N'2022-05-26 00:00:00.000' AS DateTime), 2, 20, 20, N'dac5633e-d3d0-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[GIAOVIEN_DANGKY] ([MAGV], [MAMH], [MALOP], [TRINHDO], [NGAYTHI], [LAN], [SOCAUTHI], [THOIGIAN], [rowguid]) VALUES (N'TH234   ', N'MMTCB', N'TH06           ', N'A', CAST(N'2022-05-26 00:00:00.000' AS DateTime), 1, 30, 15, N'aa0cd4fc-d6dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[GIAOVIEN_DANGKY] ([MAGV], [MAMH], [MALOP], [TRINHDO], [NGAYTHI], [LAN], [SOCAUTHI], [THOIGIAN], [rowguid]) VALUES (N'TH234   ', N'MMTCB', N'TH06           ', N'A', CAST(N'2022-05-26 00:00:00.000' AS DateTime), 2, 40, 15, N'1ccaa90a-d7dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[GIAOVIEN_DANGKY] ([MAGV], [MAMH], [MALOP], [TRINHDO], [NGAYTHI], [LAN], [SOCAUTHI], [THOIGIAN], [rowguid]) VALUES (N'TH358   ', N'MMTCB', N'VT04           ', N'B', CAST(N'2022-05-26 00:00:00.000' AS DateTime), 2, 10, 15, N'2a0106ed-a2dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[KHOA] ([MAKH], [TENKH], [MACS], [rowguid]) VALUES (N'CNTT    ', N'Công nghệ thông tin', N'CS1', N'd84d76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[KHOA] ([MAKH], [TENKH], [MACS], [rowguid]) VALUES (N'DT      ', N'Điện tử', N'CS2', N'd94d76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[KHOA] ([MAKH], [TENKH], [MACS], [rowguid]) VALUES (N'QTKD    ', N'Quản trị kinh doanh', N'CS1', N'18096242-1dce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[KHOA] ([MAKH], [TENKH], [MACS], [rowguid]) VALUES (N'VT      ', N'Viễn thông', N'CS2', N'da4d76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[LOP] ([MALOP], [TENLOP], [MAKH], [rowguid]) VALUES (N'D18CQCN01      ', N'Ngành CNTT Khóa 2018 -1', N'CNTT    ', N'df4d76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[LOP] ([MALOP], [TENLOP], [MAKH], [rowguid]) VALUES (N'DT05           ', N'test', N'DT      ', N'8c8673df-9fdc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[LOP] ([MALOP], [TENLOP], [MAKH], [rowguid]) VALUES (N'TH04           ', N'TIN HOC 2004', N'CNTT    ', N'e04d76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[LOP] ([MALOP], [TENLOP], [MAKH], [rowguid]) VALUES (N'TH05           ', N'TIN HOC 2005', N'CNTT    ', N'e14d76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[LOP] ([MALOP], [TENLOP], [MAKH], [rowguid]) VALUES (N'TH06           ', N'TIN HOC 2006', N'CNTT    ', N'e24d76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[LOP] ([MALOP], [TENLOP], [MAKH], [rowguid]) VALUES (N'TH07           ', N'TIN HOC 2007', N'CNTT    ', N'e34d76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[LOP] ([MALOP], [TENLOP], [MAKH], [rowguid]) VALUES (N'TH08           ', N'TIN HOC 2008', N'CNTT    ', N'e44d76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[LOP] ([MALOP], [TENLOP], [MAKH], [rowguid]) VALUES (N'VT04           ', N'VIỄN THÔNG 2004', N'VT      ', N'e54d76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[MONHOC] ([MAMH], [TENMH], [rowguid]) VALUES (N'asd  ', N'asddss', N'67b5ee49-c0dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[MONHOC] ([MAMH], [TENMH], [rowguid]) VALUES (N'ASDS ', N'DASDA', N'788bcc43-c0dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[MONHOC] ([MAMH], [TENMH], [rowguid]) VALUES (N'AVCB ', N'ANH VAN CAN BAN', N'd44d76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[MONHOC] ([MAMH], [TENMH], [rowguid]) VALUES (N'CSDL ', N'CƠ SỞ DỮ LIỆU', N'd54d76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[MONHOC] ([MAMH], [TENMH], [rowguid]) VALUES (N'CTDL ', N'CẤU TRÚC DỮ LIỆU', N'd64d76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[MONHOC] ([MAMH], [TENMH], [rowguid]) VALUES (N'DSDAS', N'CÁU RUCASD', N'd383ab74-c0dc-ec11-ab4c-9a75b5a0942f')
INSERT [dbo].[MONHOC] ([MAMH], [TENMH], [rowguid]) VALUES (N'MMTCB', N'MẠNG MÁY TÍNH CĂN BẢN', N'd74d76a8-18ce-ec11-ab47-9d8aa5c31a2d')
INSERT [dbo].[SINHVIEN] ([MASV], [HO], [TEN], [NGAYSINH], [DIACHI], [MALOP], [rowguid], [MATKHAU]) VALUES (N'001     ', N'LÊ VĂN ', N'THÀNH', CAST(N'1985-03-06' AS Date), N'23/5 PHUNG KHAC KHOAN F3 Q3', N'TH06           ', N'e64d76a8-18ce-ec11-ab47-9d8aa5c31a2d', N'1234')
INSERT [dbo].[SINHVIEN] ([MASV], [HO], [TEN], [NGAYSINH], [DIACHI], [MALOP], [rowguid], [MATKHAU]) VALUES (N'002     ', N'DAO TRONG', N'KHAI', CAST(N'1979-08-19' AS Date), N'15/72 LE VAN THO F8 GOVAP', N'TH04           ', N'e74d76a8-18ce-ec11-ab47-9d8aa5c31a2d', N'1234')
INSERT [dbo].[SINHVIEN] ([MASV], [HO], [TEN], [NGAYSINH], [DIACHI], [MALOP], [rowguid], [MATKHAU]) VALUES (N'003     ', N'CAO TUAN', N'KHA', CAST(N'1985-12-06' AS Date), N'12/5 LE QUANG DINH F5 GO VAP', N'TH04           ', N'e84d76a8-18ce-ec11-ab47-9d8aa5c31a2d', N'1234')
INSERT [dbo].[SINHVIEN] ([MASV], [HO], [TEN], [NGAYSINH], [DIACHI], [MALOP], [rowguid], [MATKHAU]) VALUES (N'004     ', N'HA THANH ', N'BINH', CAST(N'1984-03-24' AS Date), N'23/4 HOANG HOA THAM', N'TH06           ', N'e94d76a8-18ce-ec11-ab47-9d8aa5c31a2d', N'1234')
INSERT [dbo].[SINHVIEN] ([MASV], [HO], [TEN], [NGAYSINH], [DIACHI], [MALOP], [rowguid], [MATKHAU]) VALUES (N'005     ', N'NGUYEN THÚY ', N'VÂN', CAST(N'1987-11-06' AS Date), N'7 HUYNH THUC KHANG', N'VT04           ', N'ea4d76a8-18ce-ec11-ab47-9d8aa5c31a2d', N'1234')
INSERT [dbo].[SINHVIEN] ([MASV], [HO], [TEN], [NGAYSINH], [DIACHI], [MALOP], [rowguid], [MATKHAU]) VALUES (N'006     ', N'NGUYEN NGOC ', N'YEN', CAST(N'1980-11-23' AS Date), N'3/5 AN DUONG VUONG', N'TH05           ', N'eb4d76a8-18ce-ec11-ab47-9d8aa5c31a2d', N'1234')
INSERT [dbo].[SINHVIEN] ([MASV], [HO], [TEN], [NGAYSINH], [DIACHI], [MALOP], [rowguid], [MATKHAU]) VALUES (N'007     ', N'NGUYEN THUY ', N'DUNG', CAST(N'1988-05-23' AS Date), N'8 HUYNH VAN BANH f1 q binh thanh', N'TH05           ', N'ec4d76a8-18ce-ec11-ab47-9d8aa5c31a2d', N'1234')
INSERT [dbo].[SINHVIEN] ([MASV], [HO], [TEN], [NGAYSINH], [DIACHI], [MALOP], [rowguid], [MATKHAU]) VALUES (N'008     ', N'TRINH', N'PHONG', CAST(N'1985-12-10' AS Date), N'', N'TH06           ', N'ed4d76a8-18ce-ec11-ab47-9d8aa5c31a2d', N'1234')
INSERT [dbo].[SINHVIEN] ([MASV], [HO], [TEN], [NGAYSINH], [DIACHI], [MALOP], [rowguid], [MATKHAU]) VALUES (N'009     ', N'TRAN THANH', N'HUNG', CAST(N'1985-03-28' AS Date), N'', N'TH05           ', N'ee4d76a8-18ce-ec11-ab47-9d8aa5c31a2d', N'1234')
INSERT [dbo].[SINHVIEN] ([MASV], [HO], [TEN], [NGAYSINH], [DIACHI], [MALOP], [rowguid], [MATKHAU]) VALUES (N'011     ', N'PHAN HONG', N'NGOC', CAST(N'1986-01-17' AS Date), N'PHAN VAN HAN BINH THANH', N'TH05           ', N'ef4d76a8-18ce-ec11-ab47-9d8aa5c31a2d', N'1234')
INSERT [dbo].[SINHVIEN] ([MASV], [HO], [TEN], [NGAYSINH], [DIACHI], [MALOP], [rowguid], [MATKHAU]) VALUES (N'101     ', N'TRAN VAN', N'QUYET', CAST(N'1999-09-12' AS Date), N'Q.9', N'VT04           ', N'05ffb35d-d3d0-ec11-ab47-9d8aa5c31a2d', N'1234')
INSERT [dbo].[SINHVIEN] ([MASV], [HO], [TEN], [NGAYSINH], [DIACHI], [MALOP], [rowguid], [MATKHAU]) VALUES (N'102     ', N'PHAM TUAN', N'MANH', CAST(N'2000-12-12' AS Date), N'Q.9', N'VT04           ', N'4581916b-d3d0-ec11-ab47-9d8aa5c31a2d', N'1234')
INSERT [dbo].[SINHVIEN] ([MASV], [HO], [TEN], [NGAYSINH], [DIACHI], [MALOP], [rowguid], [MATKHAU]) VALUES (N'ádsd    ', N'ádasd', N'sdasd', CAST(N'2001-08-17' AS Date), N'sdasd', N'ádasđ          ', N'0523e772-bfdc-ec11-ab4c-9a75b5a0942f', N'12315')
INSERT [dbo].[SINHVIEN] ([MASV], [HO], [TEN], [NGAYSINH], [DIACHI], [MALOP], [rowguid], [MATKHAU]) VALUES (N'sads    ', N'a', N'hoang tét', CAST(N'2001-04-29' AS Date), N'dak lak', N'D18CQCN0       ', N'cd32535a-a1dc-ec11-ab4c-9a75b5a0942f', N'1234')
INSERT [dbo].[SINHVIEN] ([MASV], [HO], [TEN], [NGAYSINH], [DIACHI], [MALOP], [rowguid], [MATKHAU]) VALUES (N'te      ', N'tét', N'set', NULL, N'sét', N'DT05           ', N'e90c4365-a2dc-ec11-ab4c-9a75b5a0942f', N'123')
/****** Object:  Index [MSmerge_index_869578136]    Script Date: 31/05/2022 8:31:52 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [MSmerge_index_869578136] ON [dbo].[BAITHI]
(
	[rowguid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [MSmerge_index_245575913]    Script Date: 31/05/2022 8:31:52 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [MSmerge_index_245575913] ON [dbo].[BANGDIEM]
(
	[rowguid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [MSmerge_index_1077578877]    Script Date: 31/05/2022 8:31:52 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [MSmerge_index_1077578877] ON [dbo].[BODE]
(
	[rowguid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [MSmerge_index_309576141]    Script Date: 31/05/2022 8:31:52 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [MSmerge_index_309576141] ON [dbo].[COSO]
(
	[rowguid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [MSmerge_index_1173579219]    Script Date: 31/05/2022 8:31:52 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [MSmerge_index_1173579219] ON [dbo].[GIAOVIEN]
(
	[rowguid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [MSmerge_index_373576369]    Script Date: 31/05/2022 8:31:52 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [MSmerge_index_373576369] ON [dbo].[GIAOVIEN_DANGKY]
(
	[rowguid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [MSmerge_index_405576483]    Script Date: 31/05/2022 8:31:52 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [MSmerge_index_405576483] ON [dbo].[KHOA]
(
	[rowguid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UN_TENLOP]    Script Date: 31/05/2022 8:31:52 AM ******/
ALTER TABLE [dbo].[LOP] ADD  CONSTRAINT [UN_TENLOP] UNIQUE NONCLUSTERED 
(
	[TENLOP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [MSmerge_index_1253579504]    Script Date: 31/05/2022 8:31:52 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [MSmerge_index_1253579504] ON [dbo].[LOP]
(
	[rowguid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UN_TENMH]    Script Date: 31/05/2022 8:31:52 AM ******/
ALTER TABLE [dbo].[MONHOC] ADD  CONSTRAINT [UN_TENMH] UNIQUE NONCLUSTERED 
(
	[TENMH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_MONHOC]    Script Date: 31/05/2022 8:31:52 AM ******/
CREATE NONCLUSTERED INDEX [IX_MONHOC] ON [dbo].[MONHOC]
(
	[MAMH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [MSmerge_index_469576711]    Script Date: 31/05/2022 8:31:52 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [MSmerge_index_469576711] ON [dbo].[MONHOC]
(
	[rowguid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [MSmerge_index_501576825]    Script Date: 31/05/2022 8:31:52 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [MSmerge_index_501576825] ON [dbo].[SINHVIEN]
(
	[rowguid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BANGDIEM]  WITH NOCHECK ADD  CONSTRAINT [FK_BANGDIEM_MONHOC] FOREIGN KEY([MAMH])
REFERENCES [dbo].[MONHOC] ([MAMH])
GO
ALTER TABLE [dbo].[BANGDIEM] CHECK CONSTRAINT [FK_BANGDIEM_MONHOC]
GO
ALTER TABLE [dbo].[BANGDIEM]  WITH NOCHECK ADD  CONSTRAINT [FK_BANGDIEM_SINHVIEN1] FOREIGN KEY([MASV])
REFERENCES [dbo].[SINHVIEN] ([MASV])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[BANGDIEM] CHECK CONSTRAINT [FK_BANGDIEM_SINHVIEN1]
GO
ALTER TABLE [dbo].[BODE]  WITH NOCHECK ADD  CONSTRAINT [FK_BODE_GIAOVIEN] FOREIGN KEY([MAGV])
REFERENCES [dbo].[GIAOVIEN] ([MAGV])
GO
ALTER TABLE [dbo].[BODE] CHECK CONSTRAINT [FK_BODE_GIAOVIEN]
GO
ALTER TABLE [dbo].[BODE]  WITH NOCHECK ADD  CONSTRAINT [FK_BODE_MONHOC] FOREIGN KEY([MAMH])
REFERENCES [dbo].[MONHOC] ([MAMH])
GO
ALTER TABLE [dbo].[BODE] CHECK CONSTRAINT [FK_BODE_MONHOC]
GO
ALTER TABLE [dbo].[GIAOVIEN]  WITH CHECK ADD  CONSTRAINT [FK_GIAOVIEN_KHOA] FOREIGN KEY([MAKH])
REFERENCES [dbo].[KHOA] ([MAKH])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[GIAOVIEN] CHECK CONSTRAINT [FK_GIAOVIEN_KHOA]
GO
ALTER TABLE [dbo].[GIAOVIEN_DANGKY]  WITH CHECK ADD  CONSTRAINT [FK_GIAOVIEN_DANGKY_GIAOVIEN1] FOREIGN KEY([MAGV])
REFERENCES [dbo].[GIAOVIEN] ([MAGV])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[GIAOVIEN_DANGKY] CHECK CONSTRAINT [FK_GIAOVIEN_DANGKY_GIAOVIEN1]
GO
ALTER TABLE [dbo].[GIAOVIEN_DANGKY]  WITH CHECK ADD  CONSTRAINT [FK_GIAOVIEN_DANGKY_LOP] FOREIGN KEY([MALOP])
REFERENCES [dbo].[LOP] ([MALOP])
GO
ALTER TABLE [dbo].[GIAOVIEN_DANGKY] CHECK CONSTRAINT [FK_GIAOVIEN_DANGKY_LOP]
GO
ALTER TABLE [dbo].[GIAOVIEN_DANGKY]  WITH CHECK ADD  CONSTRAINT [FK_GIAOVIEN_DANGKY_MONHOC1] FOREIGN KEY([MAMH])
REFERENCES [dbo].[MONHOC] ([MAMH])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[GIAOVIEN_DANGKY] CHECK CONSTRAINT [FK_GIAOVIEN_DANGKY_MONHOC1]
GO
ALTER TABLE [dbo].[KHOA]  WITH CHECK ADD  CONSTRAINT [FK_KHOA_COSO] FOREIGN KEY([MACS])
REFERENCES [dbo].[COSO] ([MACS])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[KHOA] CHECK CONSTRAINT [FK_KHOA_COSO]
GO
ALTER TABLE [dbo].[LOP]  WITH CHECK ADD  CONSTRAINT [FK_LOP_KHOA] FOREIGN KEY([MAKH])
REFERENCES [dbo].[KHOA] ([MAKH])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[LOP] CHECK CONSTRAINT [FK_LOP_KHOA]
GO
ALTER TABLE [dbo].[BAITHI]  WITH NOCHECK ADD  CONSTRAINT [repl_identity_range_DFE2A3D3_AE71_4726_A147_D6757269A68F] CHECK NOT FOR REPLICATION (([CAUHOI]>=(1) AND [CAUHOI]<=(1001) OR [CAUHOI]>(1001) AND [CAUHOI]<=(2001)))
GO
ALTER TABLE [dbo].[BAITHI] CHECK CONSTRAINT [repl_identity_range_DFE2A3D3_AE71_4726_A147_D6757269A68F]
GO
ALTER TABLE [dbo].[BANGDIEM]  WITH NOCHECK ADD  CONSTRAINT [CK_DIEM] CHECK  (([DIEM]>=(0) AND [DIEM]<=(10)))
GO
ALTER TABLE [dbo].[BANGDIEM] CHECK CONSTRAINT [CK_DIEM]
GO
ALTER TABLE [dbo].[BANGDIEM]  WITH NOCHECK ADD  CONSTRAINT [CK_LANTHI] CHECK  (([LAN]>=(1) AND [LAN]<=(2)))
GO
ALTER TABLE [dbo].[BANGDIEM] CHECK CONSTRAINT [CK_LANTHI]
GO
ALTER TABLE [dbo].[BODE]  WITH NOCHECK ADD  CONSTRAINT [CK_BODE] CHECK  (([TRINHDO]='A' OR [TRINHDO]='B' OR [TRINHDO]='C'))
GO
ALTER TABLE [dbo].[BODE] CHECK CONSTRAINT [CK_BODE]
GO
ALTER TABLE [dbo].[BODE]  WITH NOCHECK ADD  CONSTRAINT [CK_DAPAN] CHECK  (([DAP_AN]='D' OR ([DAP_AN]='C' OR ([DAP_AN]='B' OR [DAP_AN]='A'))))
GO
ALTER TABLE [dbo].[BODE] CHECK CONSTRAINT [CK_DAPAN]
GO
ALTER TABLE [dbo].[GIAOVIEN_DANGKY]  WITH CHECK ADD  CONSTRAINT [CK_LAN] CHECK  (([LAN]>=(1) AND [LAN]<=(2)))
GO
ALTER TABLE [dbo].[GIAOVIEN_DANGKY] CHECK CONSTRAINT [CK_LAN]
GO
ALTER TABLE [dbo].[GIAOVIEN_DANGKY]  WITH CHECK ADD  CONSTRAINT [CK_SOCAUTHI] CHECK  (([SOCAUTHI]>=(10) AND [SOCAUTHI]<=(100)))
GO
ALTER TABLE [dbo].[GIAOVIEN_DANGKY] CHECK CONSTRAINT [CK_SOCAUTHI]
GO
ALTER TABLE [dbo].[GIAOVIEN_DANGKY]  WITH CHECK ADD  CONSTRAINT [CK_THOIGIAN] CHECK  (([THOIGIAN]>=(15) AND [THOIGIAN]<=(60)))
GO
ALTER TABLE [dbo].[GIAOVIEN_DANGKY] CHECK CONSTRAINT [CK_THOIGIAN]
GO
ALTER TABLE [dbo].[GIAOVIEN_DANGKY]  WITH CHECK ADD  CONSTRAINT [CK_TRINHDO] CHECK  (([TRINHDO]='C' OR ([TRINHDO]='B' OR [TRINHDO]='A')))
GO
ALTER TABLE [dbo].[GIAOVIEN_DANGKY] CHECK CONSTRAINT [CK_TRINHDO]
GO
/****** Object:  StoredProcedure [dbo].[SP_BAITHI]    Script Date: 31/05/2022 8:31:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_BAITHI] @maLop nchar(15) , @maSV nchar(8), @maMH nchar(5), @lan smallint
AS
DECLARE @ngayThi datetime, @soCauThi int, @trinhDo char(1), @maBD nchar(20), @dem int, @demduoi INT, @TrinhDoDuoi nchar(1),@CauDuoi INT,@CauCUng INT
set @maBD=RTRIM(@maSV)+RTRIM(@maMH)+CAST(@lan AS NCHAR(10))
SELECT @ngayThi = NGAYTHI, @soCauThi = SOCAUTHI, @trinhDo = TRINHDO  FROM GIAOVIEN_DANGKY WHERE MAMH = @maMH AND MALOP = @malop AND LAN = @lan
PRINT @SOCAUTHI
PRINT @trinhDo
BEGIN TRY
	IF(@trinhDo = 'A')
			BEGIN 
				SET @TrinhDoDuoi = 'B'
			END
			--Trình độ B
			ELSE IF(@trinhDo = 'B')
			BEGIN 
				SET @TrinhDoDuoi = 'C'
			END
	IF(@trinhDo='C')
	BEGIN
	SELECT @dem = COUNT(CAUHOI) FROM BODE WHERE MAMH = @maMH AND TRINHDO = @trinhdo AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA)) 
	PRINT @dem 
		IF(@dem>=@socauthi)
		begin	INSERT INTO BAITHI (CAUSO,NoiDung, A, B, C, D,DAP_AN, MaBD)
				SELECT TOP (@soCauThi) CAUHOI, NOIDUNG, A,B,C,D,DAP_AN, @maBD FROM BODE 
				WHERE MAMH = @maMH AND TRINHDO = @trinhDo AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))  
				ORDER BY  NEWID()
				SELECT CAUHOI,CAUSO,NoiDung, A,B,C,D, DAP_AN, MaBD FROM BAITHI WHERE MaBD = @maBD
		END
		else if(@dem < @soCauThi)
		BEGIN
			SELECT @demduoi = COUNT(CAUHOI) FROM BODE 
			WHERE MAMH = @maMH AND TRINHDO = @trinhDo AND MAGV NOT IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))  
				
			if(@demduoi < @soCauThi - @dem)
					BEGIN
					RAISERROR('Không đủ số câu để tạo đề!', 16, 1)
					END
			else if(@demduoi >= @soCauThi - @dem)
					BEGIN 
						INSERT INTO BAITHI (CauSo, NoiDung, A, B, C, D,DAP_AN, MaBD)
						SELECT TOP (@dem) CAUHOI, NOIDUNG, A,B,C,D,DAP_AN,@maBD FROM BODE 
						WHERE MAMH = @maMH AND TRINHDO = @trinhDo AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))  
						ORDER BY  NEWID()
		
						INSERT INTO BAITHI (CauSo, NoiDung, A, B, C, D,DAP_AN, MaBD)
						SELECT TOP (@soCauThi - @dem) CAUHOI, NOIDUNG, A,B,C,D,DAP_AN,@maBD FROM BODE 
						WHERE MAMH = @maMH AND TRINHDO = @trinhDo AND MAGV NOT IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))  
						ORDER BY  NEWID()
					
						-- trả về kết quả
						SELECT CauHoi,CauSo,NoiDung, A,B,C,D, DAP_AN, MaBD FROM BAITHI WHERE MaBD = @maBD
					END
		END
	END
	--trinh do khac C
	else 
	begin 
	-- đổ câu hỏi vào bảng tạm,lấy toàn bộ trình độ A
			SELECT  CAUHOI AS CAUHOI, NOIDUNG  AS NOIDUNG, A AS A,B AS B,C  AS  C,D  AS  D,DAP_AN AS DAP_AN, @maBD AS maBD INTO #DETHI FROM BODE 
			WHERE MAMH = @maMH AND TRINHDO = @trinhDo AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))  

			SELECT @dem = COUNT(CAUHOI) FROM BODE --lưu Số lượng trình độ A
			WHERE MAMH = @maMH AND TRINHDO = @trinhDo AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))  
			Print @dem
			IF(@dem >= @soCauThi)--A>=100%
				BEGIN
					INSERT INTO BAITHI (CauSo, NoiDung, A, B, C, D,DAP_AN, MaBD)
					SELECT TOP (@soCauThi) CAUHOI, NOIDUNG, A,B,C,D,DAP_AN, @maBD FROM #DETHI -- lấy dữ liệu random từ bảng tạm #dethi
					ORDER BY  NEWID()

					-- Trả về kết quả để in câu hỏi thi ra màn hình
					SELECT CauHoi,CauSo,NoiDung, A,B,C,D, DAP_AN, MaBD FROM BAITHI WHERE MaBD = @maBD
				END
			else if(@dem>=@soCauThi*0.7)
			--do cau hoi tu trinh do duoi
				BEGIN
					insert into #DETHI (cauhoi, noidung, a , b , c , d , dap_an , maBD )-- Lưu B
					SELECT  TOP (@soCauThi - @dem) CAUHOI, NOIDUNG, A,B,C,D,DAP_AN, @maBD FROM BODE 
					WHERE MAMH = @maMH AND TRINHDO = @TrinhDoDuoi AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))  
					ORDER BY  NEWID()

					SELECT @demduoi = COUNT(CAUHOI) FROM BODE -- Lấy số lượng trinhdo duoi
					WHERE MAMH = @maMH AND TRINHDO = @TrinhDoDuoi AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))  
					if(@demduoi>=@soCauThi-@dem)
						begin 
							INSERT INTO BAITHI (CauSo, NoiDung, A, B, C, D,DAP_AN, MaBD)
							SELECT TOP (@soCauThi) CAUHOI, NOIDUNG, A,B,C,D,DAP_AN,@maBD FROM #DETHI 
							ORDER BY  NEWID()
							SELECT CauHoi,CauSo,NoiDung, A,B,C,D, DAP_AN, MaBD FROM BAITHI WHERE MaBD = @maBD
						end
					else --trinhdoduoi k du lay trinhdotren o co so khac bu vao
						begin 
							insert into #DETHI (cauhoi, noidung, a , b , c , d , dap_an , maBD ) -- Lấy A2
							SELECT TOP (@soCauThi - @dem - @demduoi) CAUHOI, NOIDUNG, A,B,C,D,DAP_AN,@maBD FROM BODE 
							WHERE MAMH = @maMH AND TRINHDO = @trinhDo AND MAGV NOT IN  (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))  
							ORDER BY  NEWID() 
							SELECT @CauCUng = COUNT(CAUHOI) FROM BODE -- lưu số lượng câu A2
							WHERE MAMH = @maMH AND TRINHDO = @trinhDo AND MAGV NOT IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA)) 
							SELECT @CauDuoi = COUNT(CAUHOI) FROM BODE --Lưu số Lượng B2
							WHERE MAMH = @maMH AND TRINHDO = @TrinhDoDuoi AND MAGV NOT IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))  
							if(@CauCUng>=@soCauThi-@dem-@demduoi)--A2 đủ
								BEGIN
									INSERT INTO BAITHI (CauSo, NoiDung, A, B, C, D,DAP_AN, MaBD)
									SELECT TOP (@soCauThi) CAUHOI, NOIDUNG, A,B,C,D,DAP_AN,@maBD FROM #DETHI 
									ORDER BY  NEWID()--random

									SELECT CauHoi,CauSo,NoiDung, A,B,C,D, DAP_AN, MaBD FROM BAITHI WHERE MaBD = @maBD
								END
							ELSE IF(@CauDuoi>@soCauThi-@dem-@demduoi-@CauCUng) --b2 ĐỦ
								BEGIN
									insert into #DETHI (cauhoi, noidung, a , b , c , d , dap_an , maBD )-- lấy B2
									SELECT TOP (@soCauThi - @dem - @CauCUng - @demduoi) CAUHOI, NOIDUNG, A,B,C,D,DAP_AN,@maBD FROM BODE 
									WHERE MAMH = @maMH AND TRINHDO = @TrinhDoDuoi AND MAGV NOT IN  (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))  
									ORDER BY  NEWID()

									INSERT INTO BAITHI (CauSo, NoiDung, A, B, C, D,DAP_AN, MaBD) -- đổ dữ  liệu vào bài thi
									SELECT TOP (@soCauThi) CAUHOI, NOIDUNG, A,B,C,D,DAP_AN,@maBD FROM #DETHI 
									ORDER BY  NEWID()

									SELECT CauHoi,CauSo,NoiDung, A,B,C,D, DAP_AN, MaBD FROM BAITHI WHERE MaBD = @maBD
								END
							ELSE 
								BEGIN
						
									RAISERROR('Không đủ số câu để tạo đề!', 16, 1)
								END
						END
				
				END

---------------------
			ELSE --de cung trinhdo k du 70%
				BEGIN
					
					Print '70' 
					Print @dem
					insert into #DETHI (cauhoi, noidung, a , b , c , d , dap_an , maBD ) -- Lấy A2
					SELECT  TOP (@soCauThi - @dem) CAUHOI, NOIDUNG, A,B,C,D,DAP_AN, @maBD  FROM BODE 
					WHERE MAMH = @maMH AND TRINHDO = @trinhDo AND MAGV NOT IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))  
					ORDER BY  NEWID()
					SELECT @CauCUng = COUNT(CAUHOI) FROM BODE -- lưu số lượng câu A2
					WHERE MAMH = @maMH AND TRINHDO = @trinhDo AND MAGV NOT IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA)) 
					IF(@CauCUng >= @soCauThi-@dem)--If(A2 +A> 100%)
						BEGIN
							INSERT INTO BAITHI (CauSo, NoiDung, A, B, C, D,DAP_AN, MaBD)
							SELECT TOP (@soCauThi) CAUHOI, NOIDUNG, A,B,C,D,DAP_AN,@maBD FROM #DETHI 
							ORDER BY  NEWID()--random

							SELECT CauHoi,CauSo,NoiDung, A,B,C,D, DAP_AN, MaBD FROM BAITHI WHERE MaBD = @maBD
						END
					ELSE IF(@CauCUng >= @soCauThi*0.7 - @dem) -- If(A2 +A>= 70%)
						BEGIN
							insert into #DETHI (cauhoi, noidung, a , b , c , d , dap_an , maBD )-- lấy B cùng cs
							SELECT TOP (@soCauThi - @dem - @CauCUng) CAUHOI, NOIDUNG, A,B,C,D,DAP_AN,@maBD FROM BODE 
							WHERE MAMH = @maMH AND TRINHDO = @TrinhDoDuoi AND MAGV  IN  (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))  
							ORDER BY  NEWID() 

							SELECT @demduoi = COUNT(CAUHOI) FROM BODE -- Lưu số lượng B
							WHERE MAMH = @maMH AND TRINHDO = @TrinhDoDuoi AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))  
						
							SELECT @CauDuoi = COUNT(CAUHOI) FROM BODE --Lưu số lượng B2
							WHERE MAMH = @maMH AND TRINHDO = @TrinhDoDuoi AND MAGV NOT IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))  
						
							IF(@demduoi >= @soCauThi - @dem - @CauCUng ) --if(B >= 100-A-A2)
								BEGIN
									INSERT INTO BAITHI (CauSo, NoiDung, A, B, C, D,DAP_AN, MaBD)
									SELECT TOP (@soCauThi) CAUHOI, NOIDUNG, A,B,C,D,DAP_AN,@maBD FROM #DETHI 
									ORDER BY  NEWID()--random

									SELECT CauHoi,CauSo,NoiDung, A,B,C,D, DAP_AN, MaBD FROM BAITHI WHERE MaBD = @maBD -- In kết quả để thi
								END
							ELSE IF(@CauDuoi >= @soCauThi - @dem - @CauCUng - @demduoi)-- If( B2 >= 100 -A - A2 - B)
								BEGIN
									insert into #DETHI (cauhoi, noidung, a , b , c , d , dap_an , maBD )-- lấy B2
									SELECT TOP (@soCauThi - @dem - @CauCUng - @demduoi) CAUHOI, NOIDUNG, A,B,C,D,DAP_AN,@maBD FROM BODE 
									WHERE MAMH = @maMH AND TRINHDO = @TrinhDoDuoi AND MAGV NOT IN  (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))  
									ORDER BY  NEWID() --random

									INSERT INTO BAITHI (CauSo, NoiDung, A, B, C, D,DAP_AN, MaBD) -- đổ dữ  liệu vào bài thi
									SELECT TOP (@soCauThi) CAUHOI, NOIDUNG, A,B,C,D,DAP_AN,@maBD FROM #DETHI 
									ORDER BY  NEWID()--random

									SELECT CauHoi,CauSo,NoiDung, A,B,C,D, DAP_AN, MaBD FROM BAITHI WHERE MaBD = @maBD -- In kết quả để thi
								END 
							
							ELSE 
								BEGIN
									RAISERROR('Không đủ số câu để tạo đề!', 16, 1)
								END
						END
					ELSE 
						BEGIN
							RAISERROR('Không đủ số câu để tạo đề!', 16, 1)
						END
				END
	END
END try
	BEGIN CATCH

	   DECLARE @ErrorMessage VARCHAR(2000)
	   SELECT @ErrorMessage = 'Lỗi: ' + ERROR_MESSAGE()
	  
	END CATCH
GO
/****** Object:  StoredProcedure [dbo].[SP_check_TonTai_Diem]    Script Date: 31/05/2022 8:31:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[SP_check_TonTai_Diem] @mamh char(5),@malop char (8),@solan smallint
as
    if exists (select MASV from BANGDIEM WHERE  MAMH = @mamh and LAN = @solan AND MASV IN (select MASV from  SINHVIEN  WHERE SINHVIEN.MALOP = @malop)
)
        raiserror('Sinh viên đã thi môn này bạn không thể xoá hoặc sửa!',16,1)
GO
/****** Object:  StoredProcedure [dbo].[SP_Chon_Mon_Thi]    Script Date: 31/05/2022 8:31:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[SP_Chon_Mon_Thi]  @maSV nchar(8),@maLop nchar(15)
AS
DECLARE @ngaythi date
select @ngaythi = GETDATE()
SELECT MONHOC.MAMH, MONHOC.TENMH ,GVDK.NGAYTHI,GVDK.LAN, GVDK.SOCAUTHI, GVDK.THOIGIAN,GVDK.TRINHDO FROM GIAOVIEN_DANGKY GVDK INNER JOIN MONHOC ON  (GVDK.MALOP=@maLop AND GVDK.MAMH=MONHOC.MAMH AND GVDK.NGAYTHI=@ngaythi)
where LAN not in (select LAN from BANGDIEM where MASV=@maSV and MAMH=MONHOC.MAMH)
GO
/****** Object:  StoredProcedure [dbo].[SP_Chon_Mon_Thi_GV]    Script Date: 31/05/2022 8:31:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[SP_Chon_Mon_Thi_GV] @maLop nchar(15)
AS

SELECT MONHOC.MAMH, MONHOC.TENMH ,GVDK.NGAYTHI,GVDK.LAN, GVDK.SOCAUTHI, GVDK.THOIGIAN,GVDK.TRINHDO FROM GIAOVIEN_DANGKY GVDK INNER JOIN MONHOC ON  (GVDK.MALOP=@maLop AND GVDK.MAMH=MONHOC.MAMH)
GO
/****** Object:  StoredProcedure [dbo].[SP_Chuyen_Khoa_GV]    Script Date: 31/05/2022 8:31:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SP_Chuyen_Khoa_GV]
	@maGv nchar(8), @maKhoa nchar(8)
as
begin 
	update GIAOVIEN
	set MAKH = @maKhoa
	where MAGV = @maGv
	if not exists (select * from GIAOVIEN where MAGV = @maGv and MAKH = @maKhoa)
	raiserror ('Chuyển khoa thất bại, vui lòng thử lại!', 16, 1)
end;
GO
/****** Object:  StoredProcedure [dbo].[SP_Chuyen_Lop_SV]    Script Date: 31/05/2022 8:31:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[SP_Chuyen_Lop_SV]
    @maSV nchar(8), @maLop nchar(8) 
as
begin 
    update SINHVIEN
    set MALOP = @maLop
    where MASV = @maSV 
    if not exists (select * from SINHVIEN where MASV = @maSV and MALOP = @maLop)
    raiserror ('Chuyển lớp thất bại', 16, 1)
end;
GO
/****** Object:  StoredProcedure [dbo].[SP_Ds_Lan_Thi]    Script Date: 31/05/2022 8:31:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[SP_Ds_Lan_Thi] @maLop nchar(15), @maMH char(5)
as
begin
	select GIAOVIEN_DANGKY.LAN from GIAOVIEN_DANGKY where GIAOVIEN_DANGKY.MALOP = @maLop and GIAOVIEN_DANGKY.MAMH = @maMH
end
GO
/****** Object:  StoredProcedure [dbo].[SP_Ds_Mon_Hoc_DK_Thi]    Script Date: 31/05/2022 8:31:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[SP_Ds_Mon_Hoc_DK_Thi] @maLop nchar(15)
as
begin
	select distinct MONHOC.MAMH, MONHOC.TENMH from GIAOVIEN_DANGKY inner join MONHOC on GIAOVIEN_DANGKY.MAMH = MONHOC.MAMH and GIAOVIEN_DANGKY.MALOP = @maLop
end
GO
/****** Object:  StoredProcedure [dbo].[SP_In_Bang_Diem]    Script Date: 31/05/2022 8:31:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[SP_In_Bang_Diem]

@MaLop nchar(8),
@MaMH nchar(5),
@LanThi int

AS
	SELECT SV.MASV, SV.HO, SV.TEN, BD.DIEM, dbo.numToText(BD.DIEM) AS DIEMCHU FROM GIAOVIEN_DANGKY GVDK 
	JOIN BANGDIEM BD ON ( GVDK.MALOP=@MaLop AND GVDK.MAMH=@MaMH AND GVDK.LAN=@LanThi AND BD.MAMH = GVDK.MAMH AND BD.LAN = GVDK.LAN)
	JOIN SINHVIEN SV ON(SV.MASV = BD.MASV)
GO
/****** Object:  StoredProcedure [dbo].[SP_In_DSDK_Thi]    Script Date: 31/05/2022 8:31:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[SP_In_DSDK_Thi] @fromDate datetime, @endDate datetime
as
begin
	select LOP.TENLOP, MONHOC.TENMH, GIAOVIEN.HO + ' ' +GIAOVIEN.TEN as 'Họ tên', GIAOVIEN_DANGKY.SOCAUTHI, CONVERT(DATE, GIAOVIEN_DANGKY.NGAYTHI), [dbo].[checkedMH](GIAOVIEN_DANGKY.MAMH, GIAOVIEN_DANGKY.NGAYTHI) dathi from GIAOVIEN_DANGKY
		inner join GIAOVIEN on (GIAOVIEN_DANGKY.MAGV = GIAOVIEN.MAGV)
		inner join LOP on (GIAOVIEN_DANGKY.MALOP = LOP.MALOP)
		inner join MONHOC on (GIAOVIEN_DANGKY.MAMH = MONHOC.MAMH)
	where GIAOVIEN_DANGKY.NGAYTHI between @fromDate and @endDate
	order by GIAOVIEN_DANGKY.NGAYTHI
end;
GO
/****** Object:  StoredProcedure [dbo].[SP_Kt_Dang_Nhap_SV]    Script Date: 31/05/2022 8:31:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[SP_Kt_Dang_Nhap_SV] @maSv nvarchar(8), @maKhau nvarchar(50)
as
if not exists (select MASV from SINHVIEN where MASV = @maSv)	
	raiserror ('Không tìm thấy mã sinh viên, vui lòng nhập lại!', 16, 1)
else if not exists (select MATKHAU from SINHVIEN where MATKHAU = @maKhau)
	raiserror ('Sai mật khẩu, vui lòng nhập lại!', 16, 1)
GO
/****** Object:  StoredProcedure [dbo].[SP_Kt_De_Ton_Tai]    Script Date: 31/05/2022 8:31:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[SP_Kt_De_Ton_Tai] @cauHoi int
as
begin
	if exists (select CAUHOI from BODE where CAUHOI = @cauHoi)
		raiserror ('Câu hỏi đã tồn tại, vui lòng chọn lại!', 16,1)
end
GO
/****** Object:  StoredProcedure [dbo].[SP_Kt_GV_Ton_Tai]    Script Date: 31/05/2022 8:31:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[SP_Kt_GV_Ton_Tai]
@maGv nchar(8)
as
begin
	if exists (select MAGV from GIAOVIEN where MAGV = @maGv)
	raiserror ('Mã giáo viên đã tồn tại, vui lòng chọn mã khác!', 16,1)
end;
GO
/****** Object:  StoredProcedure [dbo].[SP_Kt_KH_Ton_Tai]    Script Date: 31/05/2022 8:31:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SP_Kt_KH_Ton_Tai]
@maKh nchar(8), @tenKh nvarchar(50)
as
begin
	if exists (select MAKH from KHOA where MAKH = @maKh)
		raiserror ('Mã khoa đã tồn tại, vui lòng chọn mã khác!', 16,1)
	else if exists (select TENKH from KHOA where TENKH like @tenKh)
		raiserror ('Tên khoa đã tồn tại, vui lòng chọn tên khác!', 16, 1)
end;
GO
/****** Object:  StoredProcedure [dbo].[SP_Kt_Loginname]    Script Date: 31/05/2022 8:31:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SP_Kt_Loginname] @lName nchar(30)
as
if @lName in (select * from [dbo].[Get_Loginnames]) 
	raiserror ('Tên đăng nhập đã tồn tại, vui lòng chọn tên khác!', 16, 1)

GO
/****** Object:  StoredProcedure [dbo].[SP_Kt_Username]    Script Date: 31/05/2022 8:31:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[SP_Kt_Username] @uName nchar(20)
as
if @uName in (select * from [dbo].[Get_Usernames]) 
	raiserror ('User đã tồn tại, vui lòng chọn user khác!', 16, 1)

GO
/****** Object:  StoredProcedure [dbo].[SP_Lay_Thong_Tin_GV_Tu_Login]    Script Date: 31/05/2022 8:31:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_Lay_Thong_Tin_GV_Tu_Login]
@TENLOGIN NVARCHAR (50)
AS
DECLARE @TENUSER NVARCHAR(50)
SELECT @TENUSER=NAME FROM sys.sysusers WHERE sid = SUSER_SID(@TENLOGIN)
 
 SELECT USERNAME = @TENUSER, 
  HOTEN = (SELECT HO+ ' '+ TEN FROM GIAOVIEN  WHERE MAGV = @TENUSER ),
   TENNHOM= NAME
   FROM sys.sysusers 
   WHERE UID = (SELECT GROUPUID 
                 FROM SYS.SYSMEMBERS 
                   WHERE MEMBERUID= (SELECT UID FROM sys.sysusers 
                                      WHERE NAME=@TENUSER))
GO
/****** Object:  StoredProcedure [dbo].[SP_Lay_Thong_Tin_SV_Tu_Login]    Script Date: 31/05/2022 8:31:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_Lay_Thong_Tin_SV_Tu_Login]
@TENLOGIN NVARCHAR (50)
AS
DECLARE @TENUSER NVARCHAR(50)
 
 SELECT USERNAME = (SELECT MASV FROM SINHVIEN  WHERE MASV = @TENLOGIN ), 
  HOTEN = (SELECT HO+ ' '+ TEN FROM SINHVIEN  WHERE MASV = @TENLOGIN ),
  TENNHOM = 'SINHVIEN'

GO
/****** Object:  StoredProcedure [dbo].[SP_Ma_Lop]    Script Date: 31/05/2022 8:31:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create PROC [dbo].[SP_Ma_Lop]  @maSv nchar(8)
as
select MALOP from SINHVIEN where MASV=@maSv
GO
/****** Object:  StoredProcedure [dbo].[SP_Tao_Tai_Khoan]    Script Date: 31/05/2022 8:31:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SP_Tao_Tai_Khoan]
@lgName nvarchar(30), @userName nvarchar(20), @pass nvarchar(30), @role nvarchar(30)
as
	exec sp_addlogin @lgName, @pass, 'THI_TN'
	exec sp_grantdbaccess @lgName , @userName
	exec sp_addrolemember @role, @userName
	if @role = 'TRUONG' or @role = 'COSO'
	begin 
		exec sp_addsrvrolemember @lgName, 'SecurityAdmin'
	end;
GO
/****** Object:  StoredProcedure [dbo].[SP_Thi_Thu]    Script Date: 31/05/2022 8:31:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_Thi_Thu] @maLop nchar(15) , @maMH nchar(5), @lan smallint
AS
DECLARE @ngayThi datetime, @soCauThi int, @trinhDo nchar(1), @dem int, @demduoi INT, @TrinhDoDuoi nchar(1),@CauDuoi INT,@CauCUng INT
create table #temp 
(CAUSO int, NOIDUNG ntext, A ntext,  B ntext, C ntext,D ntext, DAP_AN char(1))
SELECT @ngayThi = NGAYTHI, @soCauThi = SOCAUTHI, @trinhDo = TRINHDO  FROM GIAOVIEN_DANGKY WHERE MAMH = @maMH AND MALOP = @malop AND LAN = @lan
BEGIN TRY
	IF(@trinhDo = 'A')
			BEGIN 
				SET @TrinhDoDuoi = 'B'
			END
			--Trình độ B
			ELSE IF(@trinhDo = 'B')
			BEGIN 
				SET @TrinhDoDuoi = 'C'
			END
	IF(@trinhDo='C')
	BEGIN
		SELECT @dem = COUNT(CAUHOI) FROM BODE WHERE MAMH = @maMH AND TRINHDO = @trinhdo AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA)) 
	
		IF(@dem>=@socauthi)
		begin	INSERT INTO #temp (CAUSO,NoiDung, A, B, C, D,DAP_AN)
				SELECT TOP (@soCauThi) CAUHOI, NOIDUNG, A,B,C,D,DAP_AN FROM BODE 
				WHERE MAMH = @maMH AND TRINHDO = @trinhDo AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))  
				ORDER BY  NEWID()
				SELECT * FROM #temp
		END
		else if(@dem < @soCauThi)
		BEGIN
			SELECT @demduoi = COUNT(CAUHOI) FROM BODE 
			WHERE MAMH = @maMH AND TRINHDO = @trinhDo AND MAGV NOT IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))  
				
			if(@demduoi < @soCauThi - @dem)
					BEGIN
					RAISERROR('Không đủ số câu để tạo đề!', 16, 1)
					END
			else if(@demduoi >= @soCauThi - @dem)
					BEGIN 
						INSERT INTO #temp (CauSo, NoiDung, A, B, C, D,DAP_AN)
						SELECT TOP (@dem) CAUHOI, NOIDUNG, A,B,C,D,DAP_AN FROM BODE 
						WHERE MAMH = @maMH AND TRINHDO = @trinhDo AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))  
						ORDER BY  NEWID()
		
						INSERT INTO #temp (CauSo, NoiDung, A, B, C, D,DAP_AN )
						SELECT TOP (@soCauThi - @dem) CAUHOI, NOIDUNG, A,B,C,D,DAP_AN FROM BODE 
						WHERE MAMH = @maMH AND TRINHDO = @trinhDo AND MAGV NOT IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))  
						ORDER BY  NEWID()
					
						-- trả về kết quả
						SELECT * FROM #temp
					END
		END
	END
	--trinh do khac C
	else 
	begin 
	-- đổ câu hỏi vào bảng tạm,lấy toàn bộ trình độ A
			SELECT  CAUHOI AS CAUHOI, NOIDUNG  AS NOIDUNG, A AS A,B AS B,C  AS  C,D  AS  D,DAP_AN AS DAP_AN INTO #DETHI FROM BODE 
			WHERE MAMH = @maMH AND TRINHDO = @trinhDo AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))  

			SELECT @dem = COUNT(CAUHOI) FROM BODE --lưu Số lượng trình độ A
			WHERE MAMH = @maMH AND TRINHDO = @trinhDo AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))  
			
			IF(@dem >= @soCauThi)--A>=100%
				BEGIN
					INSERT INTO #temp (CauSo, NoiDung, A, B, C, D,DAP_AN)
					SELECT TOP (@soCauThi) CAUHOI, NOIDUNG, A,B,C,D,DAP_AN FROM #DETHI -- lấy dữ liệu random từ bảng tạm #dethi
					ORDER BY  NEWID()

					-- Trả về kết quả để in câu hỏi thi ra màn hình
					SELECT * FROM #temp
				END
			else if(@dem>=@soCauThi*0.7)
			--do cau hoi tu trinh do duoi
				BEGIN
					insert into #DETHI (cauhoi, noidung, a , b , c , d , dap_an )-- Lưu B
					SELECT  TOP (@soCauThi - @dem) CAUHOI, NOIDUNG, A,B,C,D,DAP_AN FROM BODE 
					WHERE MAMH = @maMH AND TRINHDO = @TrinhDoDuoi AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))  
					ORDER BY  NEWID()

					SELECT @demduoi = COUNT(CAUHOI) FROM BODE -- Lấy số lượng trinhdo duoi
					WHERE MAMH = @maMH AND TRINHDO = @TrinhDoDuoi AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))  
					if(@demduoi>=@soCauThi-@dem)
						begin 
							INSERT INTO #temp(CauSo, NoiDung, A, B, C, D,DAP_AN)
							SELECT TOP (@soCauThi) CAUHOI, NOIDUNG, A,B,C,D,DAP_AN FROM #DETHI 
							ORDER BY  NEWID()
							SELECT * FROM #temp
						end
					else --trinhdoduoi k du lay trinhdotren o co so khac bu vao
						begin 
							insert into #DETHI (cauhoi, noidung, a , b , c , d , dap_an  ) -- Lấy A2
							SELECT TOP (@soCauThi - @dem - @demduoi) CAUHOI, NOIDUNG, A,B,C,D,DAP_AN FROM BODE 
							WHERE MAMH = @maMH AND TRINHDO = @trinhDo AND MAGV NOT IN  (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))  
							ORDER BY  NEWID() 
							SELECT @CauCUng = COUNT(CAUHOI) FROM BODE -- lưu số lượng câu A2
							WHERE MAMH = @maMH AND TRINHDO = @trinhDo AND MAGV NOT IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA)) 
							SELECT @CauDuoi = COUNT(CAUHOI) FROM BODE --Lưu số Lượng B2
							WHERE MAMH = @maMH AND TRINHDO = @TrinhDoDuoi AND MAGV NOT IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))  
							if(@CauCUng>=@soCauThi-@dem-@demduoi)--A2 đủ
								BEGIN
									INSERT INTO #temp (CauSo, NoiDung, A, B, C, D,DAP_AN)
									SELECT TOP (@soCauThi) CAUHOI, NOIDUNG, A,B,C,D,DAP_AN FROM #DETHI 
									ORDER BY  NEWID()--random

									SELECT * FROM #temp
								END
							ELSE IF(@CauDuoi>@soCauThi-@dem-@demduoi-@CauCUng) --b2 ĐỦ
								BEGIN
									insert into #DETHI (cauhoi, noidung, a , b , c , d , dap_an  )-- lấy B2
									SELECT TOP (@soCauThi - @dem - @CauCUng - @demduoi) CAUHOI, NOIDUNG, A,B,C,D,DAP_AN FROM BODE 
									WHERE MAMH = @maMH AND TRINHDO = @TrinhDoDuoi AND MAGV NOT IN  (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))  
									ORDER BY  NEWID()

									INSERT INTO #temp (CauSo, NoiDung, A, B, C, D,DAP_AN) -- đổ dữ  liệu vào bài thi
									SELECT TOP (@soCauThi) CAUHOI, NOIDUNG, A,B,C,D,DAP_AN FROM #DETHI 
									ORDER BY  NEWID()

									SELECT * FROM #temp
								END
							ELSE 
								BEGIN
						
									RAISERROR('Không đủ số câu để tạo đề!', 16, 1)
								END
						END
				
				END

---------------------
			ELSE --de cung trinhdo k du 70%
				BEGIN
					
					
					insert into #DETHI (cauhoi, noidung, a , b , c , d , dap_an  ) -- Lấy A2

					SELECT  TOP (@soCauThi - @dem) CAUHOI, NOIDUNG, A,B,C,D,DAP_AN  FROM BODE 
					WHERE MAMH = @maMH AND TRINHDO = @trinhDo AND MAGV NOT IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))  
					ORDER BY  NEWID()
					SELECT @CauCUng = COUNT(CAUHOI) FROM BODE -- lưu số lượng câu A2
					WHERE MAMH = @maMH AND TRINHDO = @trinhDo AND MAGV NOT IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA)) 
					IF(@CauCUng >= @soCauThi-@dem)--If(A2 +A> 100%)
						BEGIN
							INSERT INTO #temp (CauSo, NoiDung, A, B, C, D,DAP_AN)
							SELECT TOP (@soCauThi) CAUHOI, NOIDUNG, A,B,C,D,DAP_AN FROM #DETHI 
							ORDER BY  NEWID()--random

							SELECT * FROM #temp
						END
							
					ELSE IF(@CauCUng >= @soCauThi*0.7 - @dem) -- If(A2 +A>= 70%)
						BEGIN
							insert into #DETHI (cauhoi, noidung, a , b , c , d , dap_an  )-- lấy B cùng cs
							SELECT TOP (@soCauThi - @dem - @CauCUng) CAUHOI, NOIDUNG, A,B,C,D,DAP_AN FROM BODE 
							WHERE MAMH = @maMH AND TRINHDO = @TrinhDoDuoi AND MAGV  IN  (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))  
							ORDER BY  NEWID() 

							SELECT @demduoi = COUNT(CAUHOI) FROM BODE -- Lưu số lượng B
							WHERE MAMH = @maMH AND TRINHDO = @TrinhDoDuoi AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))  
						
							SELECT @CauDuoi = COUNT(CAUHOI) FROM BODE --Lưu số lượng B2
							WHERE MAMH = @maMH AND TRINHDO = @TrinhDoDuoi AND MAGV NOT IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))  
							IF(@demduoi >= @soCauThi - @dem - @CauCUng ) --if(B >= 100-A-A2)
								BEGIN
									INSERT INTO #temp (CauSo, NoiDung, A, B, C, D,DAP_AN)
									SELECT TOP (@soCauThi) CAUHOI, NOIDUNG, A,B,C,D,DAP_AN FROM #DETHI 
									ORDER BY  NEWID()--random

									SELECT * FROM #temp-- In kết quả để thi
								END
							ELSE IF(@CauDuoi >= @soCauThi - @dem - @CauCUng - @demduoi)-- If( B2 >= 100 -A - A2 - B)
								BEGIN
									insert into #DETHI (cauhoi, noidung, a , b , c , d , dap_an  )-- lấy B2
									SELECT TOP (@soCauThi - @dem - @CauCUng - @demduoi) CAUHOI, NOIDUNG, A,B,C,D,DAP_AN FROM BODE 
									WHERE MAMH = @maMH AND TRINHDO = @TrinhDoDuoi AND MAGV NOT IN  (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))  
									ORDER BY  NEWID() --random

									INSERT INTO #temp (CauSo, NoiDung, A, B, C, D,DAP_AN) -- đổ dữ  liệu vào bài thi
									SELECT TOP (@soCauThi) CAUHOI, NOIDUNG, A,B,C,D,DAP_AN FROM #DETHI 
									ORDER BY  NEWID()--random

									SELECT * FROM #temp -- In kết quả để thi
								END 
							
							ELSE 
								BEGIN
									RAISERROR('Không đủ số câu để tạo đề!', 16, 1)
								END
						END
					ELSE 
						BEGIN
							RAISERROR('Không đủ số câu để tạo đề!', 16, 1)
						END
				END
	END
END try
	BEGIN CATCH
		DECLARE @ErrorMessage VARCHAR(2000)
		SELECT @ErrorMessage = 'Lỗi: ' + ERROR_MESSAGE()
	END CATCH
GO
/****** Object:  StoredProcedure [dbo].[sp_Tim_GVDK]    Script Date: 31/05/2022 8:31:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Tim_GVDK] @X CHAR (10), @Y CHAR (10) , @Z SMALLINT
AS
        IF  exists(select MALOP from  GIAOVIEN_DANGKY  where MALOP =@X and MAMH = @Y and LAN = @Z)
            raiserror('Mã lớp, Mã môn và Lần thi đăng ký  không được trùng!',16,1)
GO
/****** Object:  StoredProcedure [dbo].[sp_TimLop]    Script Date: 31/05/2022 8:31:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_TimLop] @X NCHAR (10), @Y NCHAR (10)
AS
        IF  exists(select MALOP from  LINK2.THI_TN.dbo.LOP  where MALOP =@X)
            raiserror('Mã lớp không được trùng!',16,1)
        else if exists(select TENLOP from LINK2.THI_TN.DBO.LOP WHERE TENLOP = @Y) 
            raiserror ('Tên lớp không được trùng!',16,1)
GO
/****** Object:  StoredProcedure [dbo].[sp_TimMonHoc]    Script Date: 31/05/2022 8:31:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_TimMonHoc]
  @X char(5)
AS
 DECLARE @MACS VARCHAR(10), @HO nvarchar(50), @TEN nvarchar(10)
        IF  exists(select MAMH from  MONHOC  where MAMH =@X)
            raiserror('Mã môn học này đã tồn tại!',16,1)
GO
/****** Object:  StoredProcedure [dbo].[sp_TimSinhVien]    Script Date: 31/05/2022 8:31:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_TimSinhVien] @X char(8)
AS
 DECLARE @MACS VARCHAR(10), @HO nvarchar(50), @TEN nvarchar(10)
        IF  exists(select MASV from  LINK2.THI_TN.dbo.SINHVIEN  where MASV =@X)
            raiserror('Mã sinh viên đã tồn tại!',16,1)
GO
/****** Object:  StoredProcedure [dbo].[SP_Xem_Ket_Qua]    Script Date: 31/05/2022 8:31:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[SP_Xem_Ket_Qua] @MaSV char(8),@MaMH char(5), @Lan smallint
AS
SELECT ROW_NUMBER()OVER(ORDER BY CAUHOI) STT,CAUSO,NOIDUNG,A,B,C,D,DAP_AN,DACHON FROM BAITHI WHERE MABD=RTRIM(@MaSV)+RTRIM(@MaMH)+CAST(@Lan AS CHAR(1))
GO
/****** Object:  StoredProcedure [dbo].[Xoa_Login]    Script Date: 31/05/2022 8:31:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[Xoa_Login]
  @USRNAME VARCHAR(50)
  
AS
	declare @LGNAME  VARCHAR(50)
	begin try
	select  @LGNAME = sp.name
					FROM sys.server_principals AS sp INNER JOIN
						 sys.database_principals AS dp ON sp.sid = dp.sid		
						 where dp.name = @USRNAME 
	 EXEC SP_DROPUSER @USRNAME
	 EXEC SP_DROPLOGIN @LGNAME
	end try
	begin catch	
	print ERROR_MESSAGE()
	end catch	
GO
USE [master]
GO
ALTER DATABASE [THI_TN] SET  READ_WRITE 
GO
