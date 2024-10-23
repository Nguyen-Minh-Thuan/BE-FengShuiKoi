USE [master]


/****** Object:  Database [SWP391FengShuiKoiSystem]    Script Date: 24/09/24 7:10PM  ******/
--DROP DATABASE [SWP391FengShuiKoiSystem]
GO
CREATE DATABASE [SWP391FengShuiKoiSystem]
GO

Use [SWP391FengShuiKoiSystem]
GO

/****** Object:  Table [dbo].[User]    Script Date: 24/09/24 7:10PM  ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](300) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[Bio] [nvarchar](500) NULL,
	[ImageUrl] [nvarchar](250) NULL,
	[IsActive] [bit] NULL,
	[RoleID] [int] NOT NULL,
	[CreatedDate] [datetime] NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 24/09/24 7:10PM  ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[RoleID] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar] (50) NOT NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Blog]    Script Date: 24/09/24 7:10PM  ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Blog](
	[BlogId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[Title] [nvarchar](50) NOT NULL,
	[Content] [nvarchar](3000) NULL,
	[StatusId] [int]  NOT NULL,
	[ElementID] [int] NOT NULL,
	[CreatedDate] [datetime] NULL,
	[ImageUrl] [nvarchar](250) NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_Blog] PRIMARY KEY CLUSTERED 
(
	[BlogId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Advertisement]    Script Date: 24/09/24 7:10PM  ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Advertisement](
	[AdsId] [int] IDENTITY(1,1) NOT NULL,
	[AdsTypeId] [int] NOT NULL,
	[UserId] [int] NOT NULL,
	[PackageID] [int] NULL,
	[Title] [nvarchar](50) NOT NULL,
	[Content] [nvarchar](3000) NULL,
	[StatusId] [int]  NOT NULL,
	[ElementID] [int] NOT NULL,
	[StartedDate] [datetime] NULL,
	[ExpiredDate] [datetime] NULL,
	[Duration] [int] NULL,
	[ImageUrl] [nvarchar](250) NULL,
	[Reason] [nvarchar](500) NULL,
	[PaymentStatus] [bit] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_Advertisement] PRIMARY KEY CLUSTERED 
(
	[AdsId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Status]    Script Date: 24/09/24 7:10PM  ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Status](
	[StatusId] [int] IDENTITY(1,1) NOT NULL,
	[Status] [nvarchar](50) NOT NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_Status] PRIMARY KEY CLUSTERED 
(
	[StatusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AdsTypes]    Script Date: 24/09/24 7:10PM  ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdsTypes](
	[AdsTypeId] [int] IDENTITY(1,1) NOT NULL,
	[TypeName] [nvarchar](100) NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_AdsTypes] PRIMARY KEY CLUSTERED 
(
	[AdsTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Package]    Script Date: 24/09/24 7:10PM  ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Package](
	[PackageID] [int] IDENTITY(1,1) NOT NULL,
	[PackageName] [nvarchar](50) NULL,
	[Duration] [int] NOT NULL,
	[Price] [decimal](18, 2) NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_PackageID] PRIMARY KEY CLUSTERED 
(
	[PackageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Transaction]    Script Date: 24/09/24 7:10PM  ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Transaction](
	[TransactionID] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[AdsId] [int] NOT NULL,
	[PackageID] [int] NOT NULL,
	[TransactionDetail] [nvarchar] (3000) NOT NULL,
	[Duration] [int] NOT NULL,
	[PaymentMethod] [nvarchar] (50) NOT NULL,
	[TransactionDate] [datetime] NOT NULL,
	[TotalPrice] [decimal](18, 2) NOT NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_Transaction] PRIMARY KEY CLUSTERED 
(
	[TransactionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Element]    Script Date:   ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Element](
	[ElementID] [int] IDENTITY(1,1) NOT NULL,
	[Element] [nvarchar] (25) NOT NULL,
	[Description] [nvarchar] (500)  NULL,
	[Status] [bit] NULL,
 CONSTRAINT [PK_Element] PRIMARY KEY CLUSTERED 
(
	[ElementID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[General]    Script Date:   ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[General](
	[GeneralID] [int] IDENTITY(1,1) NOT NULL,
	[ElementID] [int] NOT NULL,
	[KuaID] [int] NOT NULL,
	--[Status] [bit] NOT NULL,
 CONSTRAINT [PK_General] PRIMARY KEY CLUSTERED 
(
	[GeneralID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Kua]    Script Date:   ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Kua](
	[KuaID] [int] IDENTITY(1,1) NOT NULL,
	[KuaName] [nvarchar] (25) NOT NULL,
	[Description] [nvarchar] (500) NOT NULL,
	[IsActive] [bit] NULL,
	--[Status] [bit] NOT NULL,
 CONSTRAINT [PK_Kua] PRIMARY KEY CLUSTERED 
(
	[KuaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Auspicious]    Script Date:   ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Auspicious](
	[AuspiciousID] [int] IDENTITY(1,1) NOT NULL,
	[DirectionID] [int] NOT NULL,
	[KuaID] [int] NOT NULL,
	[Description] [nvarchar] (300) NOT NULL,
	[IsActive] [bit] NULL,
	--[Status] [bit] NOT NULL,
 CONSTRAINT [PK_Auspicious] PRIMARY KEY CLUSTERED 
(
	[AuspiciousID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Inauspicious]    Script Date:   ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inauspicious](
	[InauspiciousID] [int] IDENTITY(1,1) NOT NULL,
	[DirectionID] [int] NOT NULL,
	[KuaID] [int] NOT NULL,
	[Description] [nvarchar] (300) NOT NULL,
	[IsActive] [bit] NULL,
	--[Status] [bit] NOT NULL,
 CONSTRAINT [PK_Inauspicious] PRIMARY KEY CLUSTERED 
(
	[InauspiciousID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Direction]    Script Date:   ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Direction](
	[DirectionID] [int] IDENTITY(1,1) NOT NULL,
	[GroupID] [int] NOT NULL,
	[DirectionName] [nvarchar] (25) NOT NULL,
	[IsActive] [bit] NULL,
	--[Status] [bit] NOT NULL,
 CONSTRAINT [PK_Direction] PRIMARY KEY CLUSTERED 
(
	[DirectionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DirectionGroup]    Script Date:   ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DirectionGroup](
	[GroupID] [int] IDENTITY(1,1) NOT NULL,
	[GroupName] [nvarchar] (25) NOT NULL,
	[Description] [nvarchar] (300) NOT NULL,
	[IsActive] [bit] NULL,
	--[Status] [bit] NOT NULL,
 CONSTRAINT [PK_DirectionGroup] PRIMARY KEY CLUSTERED 
(
	[GroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pond]    Script Date:   ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pond](
	[PondID] [int] IDENTITY(1,1) NOT NULL,
	[ElementID] [int] NOT NULL,
	[ShapeID] [int] NOT NULL,
	[IsActive] [bit] NULL,
	--[Status] [bit] NOT NULL,
 CONSTRAINT [PK_Pond] PRIMARY KEY CLUSTERED 
(
	[PondID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Shape]    Script Date:   ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Shape](
	[ShapeID] [int] IDENTITY(1,1) NOT NULL,
	[Shape] [nvarchar] (25) NOT NULL,
	[IsActive] [bit] NULL,
	--[Status] [bit] NOT NULL,
 CONSTRAINT [PK_Shape] PRIMARY KEY CLUSTERED 
(
	[ShapeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ElementColor]    Script Date:   ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ElementColor](
	[ElementColorID] [int] IDENTITY(1,1) NOT NULL,
	[ElementID] [int] NOT NULL,
	[ColorID] [int] NOT NULL,
	[Values] [float] NOT NULL,
	[IsActive] [bit] NULL,
	--[Status] [bit] NOT NULL,
 CONSTRAINT [PK_ElementColor] PRIMARY KEY CLUSTERED 
(
	[ElementColorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Color]    Script Date:   ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Color](
	[ColorID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar] (25) NOT NULL,
	[IsActive] [bit] NULL,
	--[Status] [bit] NOT NULL,
 CONSTRAINT [PK_Color] PRIMARY KEY CLUSTERED 
(
	[ColorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PatternColor]    Script Date:   ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PatternColor](
	[PColorID] [int] IDENTITY(1,1) NOT NULL,
	[PatternID] [int] NOT NULL,
	[ColorID] [int] NOT NULL,
	[Values] [float] NOT NULL,
	[IsActive] [bit] NULL,
	--[Status] [bit] NOT NULL,
 CONSTRAINT [PK_PatternColor] PRIMARY KEY CLUSTERED 
(
	[PColorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pattern]    Script Date:   ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pattern](
	[PatternID] [int] IDENTITY(1,1) NOT NULL,
	[VarietyID] [int] NOT NULL,
	[PatternName] [nvarchar] (25) NOT NULL,
	[ImageURL] [nvarchar] (250) NULL,
	[IsActive] [bit] NULL,
	--[Status] [bit] NOT NULL,
 CONSTRAINT [PK_Pattern] PRIMARY KEY CLUSTERED 
(
	[PatternID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Variety]    Script Date:   ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Variety](
	[VarietyID] [int] IDENTITY(1,1) NOT NULL,
	[VarietyName] [nvarchar] (50) NOT NULL,
	[ImageURL] [nvarchar] (250) NULL,
	[Description] [nvarchar] (1500) NULL,
	[IsActive] [bit] NULL,
	--[Status] [bit] NOT NULL,
 CONSTRAINT [PK_Variety] PRIMARY KEY CLUSTERED 
(
	[VarietyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ElementQuantity]    Script Date:   ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ElementQuantity](
	[RecID] [int] IDENTITY(1,1) NOT NULL,
	[ElementID] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[IsActive] [bit] NULL,
	--[Status] [bit] NOT NULL,
 CONSTRAINT [PK_ElementQuantity] PRIMARY KEY CLUSTERED 
(
	[RecID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[QuantityBuff]    Script Date:   ******/
/*
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Drop TABLE [dbo].[QuantityBuff](
	[BuffID] [int] IDENTITY(1,1) NOT NULL,
	[Description] [nvarchar] (250) NULL,
 CONSTRAINT [PK_QuantityBuff] PRIMARY KEY CLUSTERED 
(
	[BuffID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
*/
/****** ========================================================================================================================================================================================================================================================================================================================================================================  ******/
/****** Insert  ******/
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([UserId],[UserName],[Password],[Email],[Bio],[ImageUrl],[IsActive],[RoleID]) VALUES (1, N'Admin', N'1', N'None', N'This is an Admin account', N'None', 1, 1)
INSERT [dbo].[User] ([UserId],[UserName],[Password],[Email],[Bio],[ImageUrl],[IsActive],[RoleID]) VALUES (2, N'Laazy', N'1', N'None', N'HungDepTrai', N'None', 1, 2)
INSERT [dbo].[User] ([UserId],[UserName],[Password],[Email],[Bio],[ImageUrl],[IsActive],[RoleID]) VALUES (3, N'User1', N'1', N'None', N'This is an User account', N'None', 1, 3)
INSERT [dbo].[User] ([UserId],[UserName],[Password],[Email],[Bio],[ImageUrl],[IsActive],[RoleID]) VALUES (4, N'User2', N'2', N'None', N'This is an User account', N'None', 1, 3)
INSERT [dbo].[User] ([UserId],[UserName],[Password],[Email],[Bio],[ImageUrl],[IsActive],[RoleID]) VALUES (5, N'User3', N'3', N'None', N'This is an User account', N'None', 1, 3)

SET IDENTITY_INSERT [dbo].[User] OFF
GO


SET IDENTITY_INSERT [dbo].[Role] ON;
INSERT INTO [dbo].[Role] ([RoleID], [RoleName]) VALUES (1, N'Admin');
INSERT INTO [dbo].[Role] ([RoleID], [RoleName]) VALUES (2, N'Staff');
INSERT INTO [dbo].[Role] ([RoleID], [RoleName]) VALUES (3, N'Member');
SET IDENTITY_INSERT [dbo].[Role] OFF;
GO 

INSERT INTO [dbo].[ElementQuantity] ([ElementID], [Quantity]) VALUES (1, 4);
INSERT INTO [dbo].[ElementQuantity] ([ElementID], [Quantity]) VALUES (1, 9);
INSERT INTO [dbo].[ElementQuantity] ([ElementID], [Quantity]) VALUES (2, 1);
INSERT INTO [dbo].[ElementQuantity] ([ElementID], [Quantity]) VALUES (2, 6);
INSERT INTO [dbo].[ElementQuantity] ([ElementID], [Quantity]) VALUES (3, 2);
INSERT INTO [dbo].[ElementQuantity] ([ElementID], [Quantity]) VALUES (3, 7);
INSERT INTO [dbo].[ElementQuantity] ([ElementID], [Quantity]) VALUES (4, 10);
INSERT INTO [dbo].[ElementQuantity] ([ElementID], [Quantity]) VALUES (4, 5);
INSERT INTO [dbo].[ElementQuantity] ([ElementID], [Quantity]) VALUES (5, 3);
INSERT INTO [dbo].[ElementQuantity] ([ElementID], [Quantity]) VALUES (5, 8);
/*
--Add đồ phong thủy
INSERT [dbo].[Advertisement] ([AdsTypeId],[UserId],[PackageID],[Title],[Content],[StatusId],[ElementID],[StartedDate],[ExpiredDate],[ImageUrl],[PaymentStatus]) VALUES (1,3,1,N'Tiêu đề Quảng cáo #1',N'Nội dung quảng cáo #1',4,1,CAST(N'2024-09-20T00:00:00.000' AS DateTime),CAST(N'2024-09-24T00:00:00.000' AS DateTime),N'None',0)
INSERT [dbo].[Advertisement] ([AdsTypeId],[UserId],[PackageID],[Title],[Content],[StatusId],[ElementID],[StartedDate],[ExpiredDate],[ImageUrl],[PaymentStatus]) VALUES (1,4,1,N'Tiêu đề Quảng cáo #2',N'Nội dung quảng cáo #2',5,2,CAST(N'2024-09-20T00:00:00.000' AS DateTime),CAST(N'2024-09-25T00:00:00.000' AS DateTime),N'None',1)
INSERT [dbo].[Advertisement] ([AdsTypeId],[UserId],[PackageID],[Title],[Content],[StatusId],[ElementID],[StartedDate],[ExpiredDate],[ImageUrl],[PaymentStatus]) VALUES (1,4,2,N'Tiêu đề Quảng cáo #3',N'Nội dung quảng cáo #3',2,3,CAST(N'2024-09-20T00:00:00.000' AS DateTime),CAST(N'2024-09-25T00:00:00.000' AS DateTime),N'None',1)
INSERT [dbo].[Advertisement] ([AdsTypeId],[UserId],[PackageID],[Title],[Content],[StatusId],[ElementID],[StartedDate],[ExpiredDate],[ImageUrl],[PaymentStatus]) VALUES (1,5,2,N'Tiêu đề Quảng cáo #4',N'Nội dung quảng cáo #4',6,4,CAST(N'2024-09-20T00:00:00.000' AS DateTime),CAST(N'2024-09-24T00:00:00.000' AS DateTime),N'None',1)

--Add Koi
SET IDENTITY_INSERT [dbo].[Advertisement] ON 

INSERT [dbo].[Advertisement] ([AdsId],[AdsTypeId],[UserId],[PackageID],[Title],[Content],[StatusId],[ElementID],[StartedDate],[ExpiredDate],[ImageUrl],[PaymentStatus]) VALUES (5,2,3,1,N'Tiêu đề Quảng cáo #5',N'Nội dung quảng cáo #1',4,1,CAST(N'2024-09-20T00:00:00.000' AS DateTime),CAST(N'2024-09-24T00:00:00.000' AS DateTime),N'None',0)
INSERT [dbo].[Advertisement] ([AdsId],[AdsTypeId],[UserId],[PackageID],[Title],[Content],[StatusId],[ElementID],[StartedDate],[ExpiredDate],[ImageUrl],[PaymentStatus]) VALUES (6,2,4,1,N'Tiêu đề Quảng cáo #6',N'Nội dung quảng cáo #2',5,2,CAST(N'2024-09-20T00:00:00.000' AS DateTime),CAST(N'2024-09-25T00:00:00.000' AS DateTime),N'None',1)
INSERT [dbo].[Advertisement] ([AdsId],[AdsTypeId],[UserId],[PackageID],[Title],[Content],[StatusId],[ElementID],[StartedDate],[ExpiredDate],[ImageUrl],[PaymentStatus]) VALUES (7,2,4,2,N'Tiêu đề Quảng cáo #7',N'Nội dung quảng cáo #3',1,3,CAST(N'2024-09-20T00:00:00.000' AS DateTime),CAST(N'2024-09-25T00:00:00.000' AS DateTime),N'None',1)
INSERT [dbo].[Advertisement] ([AdsId],[AdsTypeId],[UserId],[PackageID],[Title],[Content],[StatusId],[ElementID],[StartedDate],[ExpiredDate],[ImageUrl],[PaymentStatus]) VALUES (8,2,5,2,N'Tiêu đề Quảng cáo #8',N'Nội dung quảng cáo #4',6,4,CAST(N'2024-09-20T00:00:00.000' AS DateTime),CAST(N'2024-09-24T00:00:00.000' AS DateTime),N'None',1)

SET IDENTITY_INSERT [dbo].[Advertisement] OFF
GO
*/
SET IDENTITY_INSERT [dbo].[AdsTypes] ON;
INSERT INTO [dbo].[AdsTypes] ([AdsTypeId], [TypeName]) VALUES (1, N'Cá Koi');
INSERT INTO [dbo].[AdsTypes] ([AdsTypeId], [TypeName]) VALUES (2, N'Đồ Phong Thủy');
SET IDENTITY_INSERT [dbo].[AdsTypes] OFF;
GO

SET IDENTITY_INSERT [dbo].[Status] ON;
INSERT INTO [dbo].[Status] ([StatusId], [Status]) VALUES (1, N'Drafted');
INSERT INTO [dbo].[Status] ([StatusId], [Status]) VALUES (2, N'Pending');
INSERT INTO [dbo].[Status] ([StatusId], [Status]) VALUES (3, N'Cancelled');
INSERT INTO [dbo].[Status] ([StatusId], [Status]) VALUES (4, N'Approved');
INSERT INTO [dbo].[Status] ([StatusId], [Status]) VALUES (5, N'Deploying');
INSERT INTO [dbo].[Status] ([StatusId], [Status]) VALUES (6, N'Expired');
SET IDENTITY_INSERT [dbo].[Status] OFF;
GO

SET IDENTITY_INSERT [dbo].[Package] ON 

INSERT [dbo].[Package] ([PackageID],[PackageName],[Duration] ,[Price]) VALUES (1,N'Normal Package',3 ,30000)
INSERT [dbo].[Package] ([PackageID],[PackageName],[Duration] ,[Price]) VALUES (2,N'Exclusive Package',7 ,60000)

SET IDENTITY_INSERT [dbo].[Package] OFF
GO
/*
SET IDENTITY_INSERT [dbo].[Transaction] ON 

INSERT [dbo].[Transaction] ([TransactionID],[UserId],[AdsId],[PackageID],[PaymentMethod],[TransactionDate],[TotalPrice],[TransactionDetail],[Duration]) VALUES (1,3,1,1,N'QRCODE',CAST(N'2024-09-19T00:00:00.000' AS DateTime),250000,N'None',9)
INSERT [dbo].[Transaction] ([TransactionID],[UserId],[AdsId],[PackageID],[PaymentMethod],[TransactionDate],[TotalPrice],[TransactionDetail],[Duration]) VALUES (2,4,2,1,N'QRCODE',CAST(N'2024-09-19T00:00:00.000' AS DateTime),300000,N'None',9)
INSERT [dbo].[Transaction] ([TransactionID],[UserId],[AdsId],[PackageID],[PaymentMethod],[TransactionDate],[TotalPrice],[TransactionDetail],[Duration]) VALUES (3,4,3,2,N'QRCODE',CAST(N'2024-09-19T00:00:00.000' AS DateTime),600000,N'None',9)
INSERT [dbo].[Transaction] ([TransactionID],[UserId],[AdsId],[PackageID],[PaymentMethod],[TransactionDate],[TotalPrice],[TransactionDetail],[Duration]) VALUES (4,5,4,2,N'QRCODE',CAST(N'2024-09-19T00:00:00.000' AS DateTime),500000,N'None',9)

SET IDENTITY_INSERT [dbo].[Transaction] OFF
GO
*/

SET IDENTITY_INSERT [dbo].[Element] ON 

INSERT [dbo].[Element] ([ElementID], [Element], [Description], [Status]) VALUES (1, N'Kim', N'Hành Kim tượng trưng cho sức mạnh, tính cách kiên định và nghiêm túc.', 1)
INSERT [dbo].[Element] ([ElementID], [Element], [Description], [Status]) VALUES (2, N'Thủy', N'Hành Thủy tượng trưng cho nước, có tính tàng chứa.', 1)
INSERT [dbo].[Element] ([ElementID], [Element], [Description], [Status]) VALUES (3, N'Hỏa', N'Hành Hỏa tượng trưng cho sự may mắn, hạnh phúc, danh vọng và thành công.', 1)
INSERT [dbo].[Element] ([ElementID], [Element], [Description], [Status]) VALUES (4, N'Thổ', N'Hành Thổ tượng trưng cho sự nuôi dưỡng, màu mỡ và được coi là trung tâm của sự cân bằng, ổn định.', 1)
INSERT [dbo].[Element] ([ElementID], [Element], [Description], [Status]) VALUES (5, N'Mộc', N'Hành Mộc tượng trưng cho cây, có tính động, khởi đầu.', 1)

SET IDENTITY_INSERT [dbo].[Element] OFF
GO

SET IDENTITY_INSERT [dbo].[Kua] ON 

INSERT [dbo].[Kua] ([KuaID], [KuaName], [Description]) VALUES (1, N'Khảm', N'Cung khảm là cung đứng thứ nhất trong sơ đồ bát quái. Dựa vào cung này chúng ta có thể biết được vận mệnh, tính cách của một người thuộc cung này. Cung khảm thuộc hành Thủy và mang nhiều ý nghĩa, ví dụ như mưa, mặt trăng, tuyết rơi, sương mù, rượu. Cung khảm trong dịch lý có nghĩa hay lý sự, mưu gian và hoạn nạn.')
INSERT [dbo].[Kua] ([KuaID], [KuaName], [Description]) VALUES (2, N'Khôn', N'Cung Khôn là một trong 8 cung của sơ đồ bát quái, hay còn gọi là bát trạch. Cũng tương như nhiều cung mệnh khác, cung này sẽ đại diện  cho tính cách, vận mệnh, phong thuỷ của một nhóm người nào đó. Cung Khôn thuộc về hành Thổ và mang các ý nghĩa như: mây u ám, khí mù, nhà kho, chợ búa. Trong Dịch Lý: Khôn là Địa tức đất, nhún nhường khiêm tốn, cưu mang.')
INSERT [dbo].[Kua] ([KuaID], [KuaName], [Description]) VALUES (3, N'Chấn', N'Cung chấn là cung đứng vị trí thứ 3 trong sơ đồ Cung Mệnh. Cung chấn hay còn được gọi là Cung Phi Bát Trạch. Trong Dịch Lý, Chấn tức là Lôi, có nghĩa dũng mãnh, hiên ngang, khí phách, thành đạt. Cung này sẽ thuộc hành Mộc, có ý nghĩa tượng trưng cho cây cối, thảo mộc, sấm sét. ')
INSERT [dbo].[Kua] ([KuaID], [KuaName], [Description]) VALUES (4, N'Tốn', N'Cung Tốn là cung mang ý nghĩa gió, cái quạt, thuận chiều và tươi tốt. Còn trong Dịch lý là thì “Tốn” là Phong, có nghĩa là chịu phục tùng, tươi tốt. ')
INSERT [dbo].[Kua] ([KuaID], [KuaName], [Description]) VALUES (6, N'Càn', N'Cung Càn được xem là tượng trưng cho băng tuyết, nước đá và vàng. Theo Dịch lý, “càn” có nghĩa là “thiên” chỉ cốt cứng rắn, ý sáng suốt và tâm đức rạng ngời.')
INSERT [dbo].[Kua] ([KuaID], [KuaName], [Description]) VALUES (7, N'Đoài', N'Cung Đoài là một cung hoàng đạo thuộc hành Kim, mang đến nhiều ý nghĩa như ao dầm, mưa dầm, trăng non, nhạc khí, tinh tú hay giấy bút. Đây là cung mệnh thuộc hành Âm Kim, thể hiện sự vui mừng, sự dưỡng dục đối với các loài vật.')
INSERT [dbo].[Kua] ([KuaID], [KuaName], [Description]) VALUES (8, N'Cấn', N'Cung này mang ý nghĩa mây mù, khí bốc lên từ núi, đá. Theo như Dịch Lý thì “Cấn” tức là Sơn hay cũng chính là núi đá, trì trệ nhưng yên tĩnh và tâm đức.')
INSERT [dbo].[Kua] ([KuaID], [KuaName], [Description]) VALUES (9, N'Ly', N'Cung Ly mang ý nghĩa là mặt trời, lửa, tia chớp, cây khô, cái bóng và ấn tín. Còn theo như Dịch lý thì “Ly” tức là Hỏa, thể hiện sự trí tuệ, sáng suốt, văn minh và hào nhoáng.')


SET IDENTITY_INSERT [dbo].[Kua] OFF
GO


INSERT INTO [dbo].[Auspicious] ([DirectionID], [KuaID], [Description])
VALUES

-- Kua 1
(2, 1, N'Mang lại thịnh vượng,  phát triển công danh, mọi chuyện đều suôn sẻ trong cuộc sống'),
(1, 1, N'sức khoẻ dồi dào, không ốm đau, bệnh tật'),
(3, 1, N'liên quan mật thiết tới tình cảm và các mối quan hệ trong gia đình'),
(4, 1, N'mang lại bình yên và may mắn đến với mọi thành viên trong gia đình. Công việc, học hành dễ tiến bộ, thăng tiến'),

-- Kua 2, Kua 5 male
(8, 2, N'Mang lại thịnh vượng,  phát triển công danh, mọi chuyện đều suôn sẻ trong cuộc sống'),
(5, 2, N'sức khoẻ dồi dào, không ốm đau, bệnh tật'),
(7, 2, N'liên quan mật thiết tới tình cảm và các mối quan hệ trong gia đình'),
(6, 2, N'mang lại bình yên và may mắn đến với mọi thành viên trong gia đình. Công việc, học hành dễ tiến bộ, thăng tiến'),

-- Kua 3
(3, 3, N'Mang lại thịnh vượng,  phát triển công danh, mọi chuyện đều suôn sẻ trong cuộc sống'),
(4, 3, N'sức khoẻ dồi dào, không ốm đau, bệnh tật'),
(2, 3, N'liên quan mật thiết tới tình cảm và các mối quan hệ trong gia đình'),
(1, 3, N'mang lại bình yên và may mắn đến với mọi thành viên trong gia đình. Công việc, học hành dễ tiến bộ, thăng tiến'),

-- Kua 4
(4, 4, N'Mang lại thịnh vượng,  phát triển công danh, mọi chuyện đều suôn sẻ trong cuộc sống'),
(3, 4, N'sức khoẻ dồi dào, không ốm đau, bệnh tật'),
(1, 4, N'liên quan mật thiết tới tình cảm và các mối quan hệ trong gia đình'),
(2, 4, N'mang lại bình yên và may mắn đến với mọi thành viên trong gia đình. Công việc, học hành dễ tiến bộ, thăng tiến'),

-- Kua 6
(5, 6, N'Mang lại thịnh vượng,  phát triển công danh, mọi chuyện đều suôn sẻ trong cuộc sống'),
(8, 6, N'sức khoẻ dồi dào, không ốm đau, bệnh tật'),
(6, 6, N'liên quan mật thiết tới tình cảm và các mối quan hệ trong gia đình'),
(7, 6, N'mang lại bình yên và may mắn đến với mọi thành viên trong gia đình. Công việc, học hành dễ tiến bộ, thăng tiến'),

--Kua 7
(7, 7, N'Mang lại thịnh vượng,  phát triển công danh, mọi chuyện đều suôn sẻ trong cuộc sống'),
(6, 7, N'sức khoẻ dồi dào, không ốm đau, bệnh tật'),
(8, 7, N'liên quan mật thiết tới tình cảm và các mối quan hệ trong gia đình'),
(5, 7, N'mang lại bình yên và may mắn đến với mọi thành viên trong gia đình. Công việc, học hành dễ tiến bộ, thăng tiến'),

-- Kua 8, Kua 5 female
(6, 8, N'Mang lại thịnh vượng,  phát triển công danh, mọi chuyện đều suôn sẻ trong cuộc sống'),
(7, 8, N'sức khoẻ dồi dào, không ốm đau, bệnh tật'),
(5, 8, N'liên quan mật thiết tới tình cảm và các mối quan hệ trong gia đình'),
(8, 8, N'mang lại bình yên và may mắn đến với mọi thành viên trong gia đình. Công việc, học hành dễ tiến bộ, thăng tiến'),

-- Kua 9
(1, 9, N'Mang lại thịnh vượng,  phát triển công danh, mọi chuyện đều suôn sẻ trong cuộc sống'),
(2, 9, N'sức khoẻ dồi dào, không ốm đau, bệnh tật'),
(4, 9, N'liên quan mật thiết tới tình cảm và các mối quan hệ trong gia đình'),
(3, 9, N'mang lại bình yên và may mắn đến với mọi thành viên trong gia đình. Công việc, học hành dễ tiến bộ, thăng tiến')

INSERT INTO [dbo].[Inauspicious] ([DirectionID], [KuaID], [Description])
VALUES

-- Kua 1
(5, 1, N'Hại họa: quan phi, khẩu thiệt, bệnh tật, của cải suy sụp, thương nhơn khẩu'),
(8, 1, N'Ngũ quỷ: hỏa hoạn, bệnh tật, khẩu thiệt, hao mòn ruộng vườn, gia súc, thôi tài, tổn nhơn khẩu.'),
(7, 1, N'Lục sát: mất của, cãi vã, hao mòn gia súc vườn ruộng, thương tổn người nhà'),
(6, 1, N'Tuyệt mệnh: tuyệt tự, tổn hại con cái, không sống lâu, bệnh tật, thối tài, ruộng vườn súc vật bị hao mòn, bị người mưu hại'),

-- Kua 2, Kua 5 male
(1, 2, N'Hại họa: quan phi, khẩu thiệt, bệnh tật, của cải suy sụp, thương nhơn khẩu'),
(2, 2, N'Ngũ quỷ: hỏa hoạn, bệnh tật, khẩu thiệt, hao mòn ruộng vườn, gia súc, thôi tài, tổn nhơn khẩu.'),
(3, 2, N'Lục sát: mất của, cãi vã, hao mòn gia súc vườn ruộng, thương tổn người nhà'),
(4, 2, N'Tuyệt mệnh: tuyệt tự, tổn hại con cái, không sống lâu, bệnh tật, thối tài, ruộng vườn súc vật bị hao mòn, bị người mưu hại'),

-- Kua 3
(6, 3, N'Hại họa: quan phi, khẩu thiệt, bệnh tật, của cải suy sụp, thương nhơn khẩu'),
(7, 3, N'Ngũ quỷ: hỏa hoạn, bệnh tật, khẩu thiệt, hao mòn ruộng vườn, gia súc, thôi tài, tổn nhơn khẩu.'),
(8, 3, N'Lục sát: mất của, cãi vã, hao mòn gia súc vườn ruộng, thương tổn người nhà'),
(5, 3, N'Tuyệt mệnh: tuyệt tự, tổn hại con cái, không sống lâu, bệnh tật, thối tài, ruộng vườn súc vật bị hao mòn, bị người mưu hại'),

-- Kua 4
(7, 4, N'Hại họa: quan phi, khẩu thiệt, bệnh tật, của cải suy sụp, thương nhơn khẩu'),
(6, 4, N'Ngũ quỷ: hỏa hoạn, bệnh tật, khẩu thiệt, hao mòn ruộng vườn, gia súc, thôi tài, tổn nhơn khẩu.'),
(5, 4, N'Lục sát: mất của, cãi vã, hao mòn gia súc vườn ruộng, thương tổn người nhà'),
(8, 4, N'Tuyệt mệnh: tuyệt tự, tổn hại con cái, không sống lâu, bệnh tật, thối tài, ruộng vườn súc vật bị hao mòn, bị người mưu hại'),

-- Kua 6
(2, 6, N'Hại họa: quan phi, khẩu thiệt, bệnh tật, của cải suy sụp, thương nhơn khẩu'),
(1, 6, N'Ngũ quỷ: hỏa hoạn, bệnh tật, khẩu thiệt, hao mòn ruộng vườn, gia súc, thôi tài, tổn nhơn khẩu.'),
(4, 6, N'Lục sát: mất của, cãi vã, hao mòn gia súc vườn ruộng, thương tổn người nhà'),
(3, 6, N'Tuyệt mệnh: tuyệt tự, tổn hại con cái, không sống lâu, bệnh tật, thối tài, ruộng vườn súc vật bị hao mòn, bị người mưu hại'),

--Kua 7
(4, 7, N'Hại họa: quan phi, khẩu thiệt, bệnh tật, của cải suy sụp, thương nhơn khẩu'),
(3, 7, N'Ngũ quỷ: hỏa hoạn, bệnh tật, khẩu thiệt, hao mòn ruộng vườn, gia súc, thôi tài, tổn nhơn khẩu.'),
(2, 7, N'Lục sát: mất của, cãi vã, hao mòn gia súc vườn ruộng, thương tổn người nhà'),
(1, 7, N'Tuyệt mệnh: tuyệt tự, tổn hại con cái, không sống lâu, bệnh tật, thối tài, ruộng vườn súc vật bị hao mòn, bị người mưu hại'),

-- Kua 8, Kua 5 female
(3, 8, N'Hại họa: quan phi, khẩu thiệt, bệnh tật, của cải suy sụp, thương nhơn khẩu'),
(4, 8, N'Ngũ quỷ: hỏa hoạn, bệnh tật, khẩu thiệt, hao mòn ruộng vườn, gia súc, thôi tài, tổn nhơn khẩu.'),
(1, 8, N'Lục sát: mất của, cãi vã, hao mòn gia súc vườn ruộng, thương tổn người nhà'),
(2, 8, N'Tuyệt mệnh: tuyệt tự, tổn hại con cái, không sống lâu, bệnh tật, thối tài, ruộng vườn súc vật bị hao mòn, bị người mưu hại'),

-- Kua 9
(8, 9, N'Hại họa: quan phi, khẩu thiệt, bệnh tật, của cải suy sụp, thương nhơn khẩu'),
(5, 9, N'Ngũ quỷ: hỏa hoạn, bệnh tật, khẩu thiệt, hao mòn ruộng vườn, gia súc, thôi tài, tổn nhơn khẩu.'),
(6, 9, N'Lục sát: mất của, cãi vã, hao mòn gia súc vườn ruộng, thương tổn người nhà'),
(7, 9, N'Tuyệt mệnh: tuyệt tự, tổn hại con cái, không sống lâu, bệnh tật, thối tài, ruộng vườn súc vật bị hao mòn, bị người mưu hại')



/**
SET IDENTITY_INSERT [dbo].[Direction] ON 

INSERT [dbo].[Direction] ([DirectionID], [DirectionName]) VALUES (1, N'Đông')
INSERT [dbo].[Direction] ([DirectionID], [DirectionName]) VALUES (2, N'Tây')
INSERT [dbo].[Direction] ([DirectionID], [DirectionName]) VALUES (3, N'Nam')
INSERT [dbo].[Direction] ([DirectionID], [DirectionName]) VALUES (4, N'Bắc')
INSERT [dbo].[Direction] ([DirectionID], [DirectionName]) VALUES (5, N'Đông Bắc')
INSERT [dbo].[Direction] ([DirectionID], [DirectionName]) VALUES (6, N'Đông Nam')
INSERT [dbo].[Direction] ([DirectionID], [DirectionName]) VALUES (7, N'Tây Bắc')
INSERT [dbo].[Direction] ([DirectionID], [DirectionName]) VALUES (8, N'Tây Nam')

SET IDENTITY_INSERT [dbo].[Direction] OFF
GO



SET IDENTITY_INSERT [dbo].[DirectionGroup] ON 

INSERT [dbo].[DirectionGroup] ([GroupID], [GroupName], [Description]) VALUES (1, N'Đông Tứ Trạch', N'Đông Tứ Trạch bao gồm các cung: Tốn – Chấn – Khảm – Ly, tương ứng với các hướng Đông Nam – Đông – Bắc – Nam.')
INSERT [dbo].[DirectionGroup] ([GroupID], [GroupName], [Description]) VALUES (2, N'Tây Tứ Trạch', N'Tây Tứ Trạch bao gồm các cung: Khôn – Càn – Cấn – Đoài, tương ứng với các hướng Tây Nam – Tây Bắc – Đông Bắc – Tây.')

SET IDENTITY_INSERT [dbo].[DirectionGroup] OFF
GO
**/
SET IDENTITY_INSERT [dbo].[DirectionGroup] ON 

INSERT [dbo].[DirectionGroup] ([GroupID], [GroupName], [Description])
VALUES
(1, N'Đông Tứ Trạch', N'chỉ 4 hướng: Đông Nam, Đông, Bắc và Nam. Trong đó, hướng Đông được coi là hướng tốt nhất 
						vì mang lại may mắn và tài lộc cho những người thuộc Đông tứ mệnh.'),

(2, N'Tây Tứ Trạch', N'chỉ 4 hướng: Tây, Tây Bắc, Tây Nam và Đông Bắc. Trong đó, hướng Tây được coi là hướng tốt nhất 
						vì mang lại may mắn và tài lộc cho những người thuộc Tây tứ mệnh.')

SET IDENTITY_INSERT [dbo].[DirectionGroup] OFF
GO

SET IDENTITY_INSERT [dbo].[Direction] ON 

INSERT [dbo].[Direction] ([DirectionID], [GroupID], [DirectionName])
VALUES
-- các hướng của Đông Tứ mệnh
(1, 1, N'Đông'),
(2, 1, N'Đông Nam'),
(3, 1, N'Nam'),
(4, 1, N'Bắc'),

-- các hướng của Tây Tứ mệnh
(5, 2, N'Tây'),
(6, 2, N'Tây Nam'),
(7, 2, N'Tây Bắc'),
(8, 2, N'Đông Bắc')

SET IDENTITY_INSERT [dbo].[Direction] OFF
GO

SET IDENTITY_INSERT [dbo].[Pond] ON 

INSERT [dbo].[Pond] ([PondID], [ElementID], [ShapeID]) VALUES (1, 1, 1)
INSERT [dbo].[Pond] ([PondID], [ElementID], [ShapeID]) VALUES (2, 1, 2)
INSERT [dbo].[Pond] ([PondID], [ElementID], [ShapeID]) VALUES (3, 2, 2)
INSERT [dbo].[Pond] ([PondID], [ElementID], [ShapeID]) VALUES (4, 2, 1)
INSERT [dbo].[Pond] ([PondID], [ElementID], [ShapeID]) VALUES (5, 2, 5)
INSERT [dbo].[Pond] ([PondID], [ElementID], [ShapeID]) VALUES (6, 2, 6)
INSERT [dbo].[Pond] ([PondID], [ElementID], [ShapeID]) VALUES (7, 3, 5)
INSERT [dbo].[Pond] ([PondID], [ElementID], [ShapeID]) VALUES (8, 3, 7)
INSERT [dbo].[Pond] ([PondID], [ElementID], [ShapeID]) VALUES (9, 4, 2)
INSERT [dbo].[Pond] ([PondID], [ElementID], [ShapeID]) VALUES (10, 4, 5)
INSERT [dbo].[Pond] ([PondID], [ElementID], [ShapeID]) VALUES (11, 5, 3)
INSERT [dbo].[Pond] ([PondID], [ElementID], [ShapeID]) VALUES (12, 5, 4)
INSERT [dbo].[Pond] ([PondID], [ElementID], [ShapeID]) VALUES (13, 5, 5)
INSERT [dbo].[Pond] ([PondID], [ElementID], [ShapeID]) VALUES (14, 5, 6)

SET IDENTITY_INSERT [dbo].[Pond] OFF
GO

SET IDENTITY_INSERT [dbo].[Shape] ON 

INSERT [dbo].[Shape] ([ShapeID], [Shape]) VALUES (1, N'Hình lục giác')
INSERT [dbo].[Shape] ([ShapeID], [Shape]) VALUES (2, N'Hình tròn')
INSERT [dbo].[Shape] ([ShapeID], [Shape]) VALUES (3, N'Hình oval')
INSERT [dbo].[Shape] ([ShapeID], [Shape]) VALUES (4, N'Hình bán nguyệt')
INSERT [dbo].[Shape] ([ShapeID], [Shape]) VALUES (5, N'Hình vuông')
INSERT [dbo].[Shape] ([ShapeID], [Shape]) VALUES (6, N'Hình chữ nhật')
INSERT [dbo].[Shape] ([ShapeID], [Shape]) VALUES (7, N'Hình tam giác')

SET IDENTITY_INSERT [dbo].[Shape] OFF
GO

-- Mệnh Kim (ElementID = 1)
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (1, 6, 3);  -- Vàng nhạt
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (1, 7, 3);  -- Vàng đậm
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (1, 14, 3); -- Nâu nhạt
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (1, 15, 3); -- Nâu đậm

INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (1, 1, 2);  -- Trắng
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (1, 2, 2);  -- Xám
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (1, 3, 2);  -- Ghi
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (1, 4, 2);  -- Bạc
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (1, 5, 2);  -- Vàng ánh kim

INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (1, 12, -2); -- Đỏ
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (1, 11, -2); -- Hồng
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (1, 13, -2); -- Tím
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (1, 9, -2);  -- Cam

INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (1, 17, -3);  -- Xanh lá cây
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (1, 18, -3);  -- Xanh lục
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (1, 19, -3);  -- Xanh cỏ

-- Mệnh Mộc (ElementID = 5)
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (5, 29, 3); -- Đen
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (5, 20, 3); -- Xanh dương
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (5, 27, 3); -- Xanh biển
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (5, 28, 3); -- Xanh da trời

INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (5, 17, 2); -- Xanh lá cây
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (5, 18, 2); -- Xanh lục
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (5, 19, 2); -- Xanh cỏ

INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (5, 1, -2);  -- Trắng
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (5, 2, -2);  -- Xám
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (5, 3, -2);  -- Ghi
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (5, 4, -2);  -- Bạc
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (5, 5, -2);  -- Vàng ánh kim

INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (5, 7, -3); -- Vàng
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (5, 15, -3); -- Nâu Đậm
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (5, 16, -3); -- Nâu đất
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (5, 6, -3); -- Vàng nhạt

-- Mệnh Thủy (ElementID = 2)
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (2, 1, 3);  -- Trắng
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (2, 2, 3);  -- Xám
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (2, 3, 3);  -- Ghi
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (2, 4, 3);  -- Bạc
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (2, 5, 3);  -- Vàng ánh kim

INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (2, 29, 2); -- Đen
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (2, 20, 2); -- Xanh dương
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (2, 27, 2); -- Xanh biển
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (2, 28, 2); -- Xanh da trời

INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (2, 7, -2);  -- Vàng đậm
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (2, 14, -2);  -- Nâu nhạt
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (2, 15, -2);  -- Nâu đậm
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (2, 16, -2);  -- Nâu đất

INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (2, 12, -3); -- Đỏ
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (2, 11, -3); -- Hồng
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (2, 13, -3); -- Tím
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (2, 9, -3);  -- Cam

-- Mệnh Hỏa (ElementID = 3)
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (3, 17, 3); -- Xanh lá cây
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (3, 19, 3); -- Xanh cỏ
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (3, 18, 3); -- Xanh lục

INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (3, 12, 2); -- Đỏ
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (3, 11, 2); -- Hồng
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (3, 13, 2); -- Tím
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (3, 9, 2);  -- Cam

INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (3, 29, -2); -- Đen
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (3, 20, -2); -- Xanh dương
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (3, 27, -2); -- Xanh biển
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (3, 28, -2); -- Xanh da trời

INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (3, 1, -3); -- Trắng
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (3, 2, -3); -- Xám
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (3, 3, -3); -- Bạc
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (3, 4, -3); -- Bạc
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (3, 5, -3); -- Vàng ánh kim

-- Mệnh Thổ (ElementID = 4)
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (4, 12, 3); -- Đỏ
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (4, 11, 3); -- Hồng
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (4, 13, 3); -- Tím
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (4, 9, 3);  -- Cam

INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (4, 6, 2);  -- Vàng nhạt
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (4, 7, 2);  -- Vàng đậm
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (4, 14, 2); -- Nâu nhạt
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (4, 15, 2); -- Nâu đậm
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (4, 8, 2);  -- Vàng đất
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (4, 16, 2); -- Nâu đất

INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (4, 17, -2); -- Xanh lá cây
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (4, 18, -2); -- Xanh lục
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (4, 19, -2); -- Xanh lục

INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (4, 20, -3); -- Xanh dương
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (4, 27, -3); -- Xanh biển
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (4, 28, -3); -- Xanh da trời
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (4, 29, -3);  -- Đen


INSERT INTO [dbo].[Color] ([Name]) VALUES (N'Trắng');
INSERT INTO [dbo].[Color] ([Name]) VALUES (N'Xám');
INSERT INTO [dbo].[Color] ([Name]) VALUES (N'Ghi');
INSERT INTO [dbo].[Color] ([Name]) VALUES (N'Bạc');
INSERT INTO [dbo].[Color] ([Name]) VALUES (N'Vàng ánh kim');

INSERT INTO [dbo].[Color] ([Name]) VALUES (N'Vàng nhạt');
INSERT INTO [dbo].[Color] ([Name]) VALUES (N'Vàng đậm');
INSERT INTO [dbo].[Color] ([Name]) VALUES (N'Vàng đất');
INSERT INTO [dbo].[Color] ([Name]) VALUES (N'Cam');
INSERT INTO [dbo].[Color] ([Name]) VALUES (N'Cam đất');

INSERT INTO [dbo].[Color] ([Name]) VALUES (N'Hồng');
INSERT INTO [dbo].[Color] ([Name]) VALUES (N'Đỏ');
INSERT INTO [dbo].[Color] ([Name]) VALUES (N'Tím');

INSERT INTO [dbo].[Color] ([Name]) VALUES (N'Nâu nhạt');
INSERT INTO [dbo].[Color] ([Name]) VALUES (N'Nâu đậm');
INSERT INTO [dbo].[Color] ([Name]) VALUES (N'Nâu đất');

INSERT INTO [dbo].[Color] ([Name]) VALUES (N'Xanh lá cây');
INSERT INTO [dbo].[Color] ([Name]) VALUES (N'Xanh lục');
INSERT INTO [dbo].[Color] ([Name]) VALUES (N'Xanh cỏ');

SET IDENTITY_INSERT [dbo].[Color] ON;
INSERT INTO [dbo].[Color] ([ColorID], [Name]) VALUES (20, N'Xanh dương');
INSERT INTO [dbo].[Color] ([ColorID], [Name]) VALUES (27, N'Xanh biển');
INSERT INTO [dbo].[Color] ([ColorID], [Name]) VALUES (28, N'Xanh da trời');
INSERT INTO [dbo].[Color] ([ColorID], [Name]) VALUES (29, N'Đen');
SET IDENTITY_INSERT [dbo].[Color] OFF;
-- Xóa pattern này.
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (1, 1, 0.6);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (1, 29, 0.4);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (2, 6, 0.5);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (2, 1, 0.25);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (2, 29, 0.25);
--
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (3, 1, 0.5);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (3, 12, 0.35);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (3, 29, 0.15);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (4, 1, 0.5);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (4, 12, 0.4);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (4, 29, 0.1);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (5, 29, 0.4);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (5, 12, 0.3);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (5, 1, 0.3);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (6, 29, 0.4);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (6, 6, 0.4);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (6, 12, 0.2);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (7, 1, 0.6);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (7, 12, 0.4);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (8, 1, 0.6);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (8, 12, 0.4);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (9, 29, 0.4);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (9, 1, 0.6);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (10, 29, 0.4);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (10, 12, 0.6);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (11, 29, 0.4);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (11, 7, 0.6);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (12, 20, 0.5);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (12, 1, 0.4);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (12, 12, 0.1);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (13, 20, 0.5);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (13, 1, 0.3);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (13, 12, 0.2);
--Xóa con này
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (14, 20, 0.6);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (14, 1, 0.3);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (14, 12, 0.1);
--
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (15, 12, 0.7);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (15, 27, 0.15);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (15, 1, 0.15);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (16, 5, 1);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (17, 4, 0.8);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (17, 29, 0.2);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (18, 29, 0.85);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (18, 12, 0.15);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (19, 1, 0.7);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (19, 12, 0.15);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (19, 29, 0.15);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (20, 9, 0.9);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (20, 29, 0.1);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (21, 6, 0.8);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (21, 29, 0.2);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (22, 29, 0.4);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (22, 1, 0.3);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (22, 12, 0.3);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (23, 1, 0.5);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (23, 12, 0.5);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (24, 6, 1);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (25, 6, 0.8);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (25, 1, 0.1);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (25, 29, 0.1);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (26, 12, 1);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (27, 9, 1);
-- Đổi PatternID lại cho đúng
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (28, 7, 0.6);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (28, 29, 0.4);
--
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (29, 8, 1);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (30, 8, 0.7);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (30, 29, 0.3);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (31, 1, 0.5);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (31, 29, 0.5);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (32, 1, 0.6);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (32, 9, 0.4);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (33, 1, 0.4);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (33, 12, 0.4);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (33, 29, 0.2);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (34, 1, 0.3);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (34, 12, 0.5);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (34, 29, 0.2);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (35, 1, 0.3);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (35, 9, 0.6);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (35, 27, 0.1);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (36, 1, 1);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (37, 1, 0.8);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (37, 29, 0.2);

--select * from [dbo].[Pattern] where [VarietyID] = 7
--select * from [dbo].[Variety]
--select * from [dbo].[PatternColor] where [PatternID] = 35
--select * from [dbo].[Color]
--Xóa loại này
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName], [ImageURL]) VALUES (1, N'Shiro Utsuri', N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FUtsuri%2FShiro%20Utsuri%2FShiro-Utsuri.jpg?alt=media&token=4d21716f-642b-437f-8a0a-baa765a6bbee');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName]) VALUES (1, N'Yamabuki Shiro Utsuri');
--
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName], [ImageURL]) VALUES (2, N'Taisho Sanke', N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FSanke%2FTaisho-Sanke.jpg?alt=media&token=cc98e1eb-e8c0-4390-91a7-efdafe4d410b');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName], [ImageURL]) VALUES (2, N'Yamato Nishiki', N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FSanke%2FYamato-Nishiki.jpg?alt=media&token=0d75c7f8-e30c-40ff-a54f-51d6ac73ee66');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName], [ImageURL]) VALUES (3, N'Showa Sanke', N'');
--
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName]) VALUES (3, N'Yamabuki Showa');
--
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName], [ImageURL]) VALUES (4, N'Kohaku', N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FKohaku%2FKohaku.jpg?alt=media&token=6f01b2f0-50a2-4280-9851-b5d623f30f84');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName], [ImageURL]) VALUES (4, N'Kohaku Maruten', N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FKohaku%2FMaruten-Kohaku.jpg?alt=media&token=e6529947-e1e3-43ac-86ec-356abe212b9f');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName], [ImageURL]) VALUES (5, N'Shiro Utsuri', N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FUtsuri%2FShiro%20Utsuri%2FShiro-Utsuri.jpg?alt=media&token=4d21716f-642b-437f-8a0a-baa765a6bbee');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName], [ImageURL]) VALUES (5, N'Hi Utsuri', N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FUtsuri%2FHi-Utsuri.jpg?alt=media&token=0b1920a6-bf37-48b6-b573-fdda6ac03db7');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName], [ImageURL]) VALUES (5, N'Ki Utsuri', N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FUtsuri%2FKi-Utsuri.jpg?alt=media&token=6c22adde-59b6-4bab-8e3e-36bda066228b');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName], [ImageURL]) VALUES (6, N'Asagi', N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FAsagi%2FAsagi.jpg?alt=media&token=06058be9-7fbb-4316-818c-3df56d81a87a');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName], [ImageURL]) VALUES (6, N'Asagi Shusui', N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FAsagi%2FAsagi.jpg?alt=media&token=06058be9-7fbb-4316-818c-3df56d81a87a');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName], [ImageURL]) VALUES (7, N'Shusui', N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FShusui%2FShusui.jpg?alt=media&token=b7cfc9cf-3301-4339-9ee7-de23a0475022');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName], [ImageURL]) VALUES (7, N'Doitsu Shusui', N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FShusui%2FShusui.jpg?alt=media&token=b7cfc9cf-3301-4339-9ee7-de23a0475022');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName], [ImageURL]) VALUES (8, N'Yamabuki Ogon', N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FHikari%20Muji%2FOgon%2FYamabuki-Ogon.jpg?alt=media&token=883d442a-75eb-4a31-9477-d08c4611c73f');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName], [ImageURL]) VALUES (8, N'Gin Matsuba', N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FHikari%20Muji%2FMatsuba%2FGin-Matsuba.jpg?alt=media&token=5679c7a0-3ed6-4db9-895f-f84ed77551e2');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName], [ImageURL]) VALUES (9, N'Tancho Kohaku', N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FKohaku%2FTancho-Kohaku.jpg?alt=media&token=8b55c477-d348-4815-b161-38d7fd57e78a');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName], [ImageURL]) VALUES (9, N'Tancho Sanke', N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FKohaku%2FTancho%20Sanke.png?alt=media&token=b82b41b6-e40f-4671-a390-c1181328fa0b');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName], [ImageURL]) VALUES (10, N'Matsuba', N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FHikari%20Muji%2FMatsuba%2FMatsuba.jpg?alt=media&token=2f80db4d-0f43-482e-97f6-a6cf45375a2f');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName], [ImageURL]) VALUES (10, N'Ki Matsuba', N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FHikari%20Muji%2FMatsuba%2FKin-Matsuba.jpg?alt=media&token=d05512e8-4934-4075-a1a6-4e5c84e953c9');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName], [ImageURL]) VALUES (11, N'Goshiki', N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FGoshiki%2FGoshiki.jpg?alt=media&token=fbeeecb5-5b4e-4ab8-a4ee-e9581d181228');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName], [ImageURL]) VALUES (11, N'Goshiki Doitsu', N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FGoshiki%2FDoitsu-Goshiki.jpg?alt=media&token=51e0bc53-c5f4-4bf6-b40e-8213b192f018');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName], [ImageURL]) VALUES (12, N'Yamabuki Ogon', N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FHikari%20Muji%2FOgon%2FYamabuki-Ogon.jpg?alt=media&token=883d442a-75eb-4a31-9477-d08c4611c73f');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName], [ImageURL]) VALUES (12, N'Yamabuki Matsuba', N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FHikari%20Muji%2FMatsuba%2FKin-Matsuba.jpg?alt=media&token=d05512e8-4934-4075-a1a6-4e5c84e953c9');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName], [ImageURL]) VALUES (13, N'Benigoi', N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FBenigoi%2FBenigoi.jpg?alt=media&token=7a929e28-e2c1-4023-892e-fc505327241b');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName], [ImageURL]) VALUES (13, N'Benigoi Doitsu', N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FBenigoi%2FDoitsu-Benigoi.jpg?alt=media&token=1d1492ce-837f-47f2-881e-b90490760c55');
-- Đổi id thành Utsuri
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName], [ImageURL]) VALUES (14, N'Ki Utsuri', N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FUtsuri%2FKi-Utsuri.jpg?alt=media&token=6c22adde-59b6-4bab-8e3e-36bda066228b');
--
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName], [ImageURL]) VALUES (15, N'Chagoi', N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FChagoi%2FChagoi.jpg?alt=media&token=674fd910-a553-46d4-bcfa-bfd9a0cfa286');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName], [ImageURL]) VALUES (15, N'Chagoi Doitsu', N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FChagoi%2FChagoi%20Doitsu.jpg?alt=media&token=59177106-4e75-4942-8835-0a1ccc81909c');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName], [ImageURL]) VALUES (16, N'Soragoi', N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FSoragoi%2FSoragoi.jpg?alt=media&token=2bb14ebe-77ad-45c0-b8c7-f1e0fb0e7540');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName], [ImageURL]) VALUES (17, N'Doitsu Kohaku', N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FKohaku%2FDoitsu%20Kohaku.png?alt=media&token=1b65e987-5df8-4a5e-8108-546ecc3a527a');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName], [ImageURL]) VALUES (17, N'Doitsu Sanke', N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FSanke%2FDoitsu%20Sanke.png?alt=media&token=6c1f5951-2cbc-45e7-ba7f-25d2627e5fbf');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName], [ImageURL]) VALUES (17, N'Doitsu Showa', N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FShowa%2FDoitsu-Showa.jpg?alt=media&token=bc49cae4-c28b-499e-b430-76577921bf9f');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName], [ImageURL]) VALUES (18, N'Hikari Shusui', N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FShusui%2FShusui.jpg?alt=media&token=b7cfc9cf-3301-4339-9ee7-de23a0475022');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName], [ImageURL]) VALUES (19, N'Platinum Ogon', N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FHikari%20Muji%2FOgon%2FPlatinum-Ogon.jpg?alt=media&token=7b3ba4f4-3795-4e48-9af3-f36d88f645d2');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName], [ImageURL]) VALUES (20, N'Shiro Bekko', N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FBekko%2FShiro-Bekko.jpg?alt=media&token=56d3368d-07c1-4d78-87e9-919c163b5c39');
-- Xóa pattern này
INSERT INTO [dbo].[Variety] ([VarietyName], [Description]) VALUES ('Koi Shiro Utsuri', N'Cá Koi Shiro Utsuri có màu trắng với các đốm đen, thể hiện sự tương phản nổi bật.');
--
INSERT INTO [dbo].[Variety] ([VarietyName], [Description]) VALUES ('Koi Sanke', N'Sanke có màu trắng với các đốm đỏ và đen, mang đến vẻ đẹp cân đối và thanh thoát.');
INSERT INTO [dbo].[Variety] ([VarietyName], [Description]) VALUES ('Koi Showa', N'Showa có nền màu đen với các đốm đỏ và trắng, thể hiện sự mạnh mẽ và cá tính.');
INSERT INTO [dbo].[Variety] ([VarietyName], [Description]) VALUES ('Koi Kohaku', N'Kohaku có nền màu trắng với các đốm đỏ, được coi là dòng cá Koi kinh điển.');
INSERT INTO [dbo].[Variety] ([VarietyName], [Description]) VALUES ('Koi Utsuri', N'Utsuri có nền màu đen với các màu sắc khác, thường mang lại cảm giác bí ẩn và sang trọng.');
INSERT INTO [dbo].[Variety] ([VarietyName], [Description]) VALUES ('Koi Asagi', N'Asagi có màu xanh lam với các đốm đỏ, thường được yêu thích bởi sự thanh lịch.');
INSERT INTO [dbo].[Variety] ([VarietyName], [Description]) VALUES ('Koi Shusui', N'Shusui là một biến thể của Asagi nhưng không có vảy, tạo cảm giác mềm mại và độc đáo.');
INSERT INTO [dbo].[Variety] ([VarietyName], [Description]) VALUES ('Koi Hikari Muji', N'Hikari Muji có màu kim loại đồng nhất, thể hiện sự sang trọng và hiện đại.');
INSERT INTO [dbo].[Variety] ([VarietyName], [Description]) VALUES ('Koi Tancho', N'Tancho có một dấu đỏ trên đầu, mang đến vẻ đẹp thuần khiết và dễ nhận biết.');
INSERT INTO [dbo].[Variety] ([VarietyName], [Description]) VALUES ('Koi Matsuba', N'Matsuba có các đốm màu trên nền màu vàng hoặc trắng, tạo nên vẻ đẹp tự nhiên.');
INSERT INTO [dbo].[Variety] ([VarietyName], [Description]) VALUES ('Koi Goshiki', N'Goshiki có màu xanh đen với các đốm đỏ, trắng và đen, mang lại cảm giác phong phú.');
INSERT INTO [dbo].[Variety] ([VarietyName], [Description]) VALUES ('Koi Yamabuki', N'Yamabuki có màu vàng sáng, biểu thị sự thịnh vượng và may mắn.');
INSERT INTO [dbo].[Variety] ([VarietyName], [Description]) VALUES ('Koi Benigoi', N'Benigoi có màu đỏ đậm, thể hiện sự mạnh mẽ và cá tính.');
-- Pattern của Utsuri
INSERT INTO [dbo].[Variety] ([VarietyName], [Description]) VALUES ('Koi Ki Utsuri', N'Ki Utsuri có nền màu vàng với các đốm đen, mang lại cảm giác mới mẻ.');
--
INSERT INTO [dbo].[Variety] ([VarietyName], [Description]) VALUES ('Koi Chagoi', N'Chagoi có màu nâu hoặc xanh lá cây, biểu thị sự thân thiện và dễ gần.');
INSERT INTO [dbo].[Variety] ([VarietyName], [Description]) VALUES ('Koi Soragoi', N'Soragoi có màu xám hoặc xanh xám, thường mang lại vẻ đẹp thanh thoát.');
INSERT INTO [dbo].[Variety] ([VarietyName], [Description]) VALUES ('Koi Doitsu', N'Doitsu có bề mặt trơn và không có vảy, tạo cảm giác hiện đại.');
INSERT INTO [dbo].[Variety] ([VarietyName], [Description]) VALUES ('Koi Hikari Shusui', N'Hikari Shusui là một biến thể kim loại của Shusui, thể hiện vẻ đẹp quý phái.');
INSERT INTO [dbo].[Variety] ([VarietyName], [Description]) VALUES ('Koi Platinum', N'Platinum có màu bạc bóng, thể hiện sự sang trọng và thanh lịch.');
INSERT INTO [dbo].[Variety] ([VarietyName], [Description]) VALUES ('Koi Shiro Bekko', N'Shiro Bekko có nền màu trắng với các đốm đen, mang lại sự thanh lịch và tinh khiết.');


/****** ========================================================================================================================================================================================================================================================================================================================================================================  ******/
/****** Object:  Table [dbo].[Advertisement]    Script Date: 24/09/24 7:10PM  ******/

ALTER TABLE [dbo].[Advertisement]  WITH CHECK ADD  CONSTRAINT [FK_Advertisement_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[Advertisement] CHECK CONSTRAINT [FK_Advertisement_User]
GO

ALTER TABLE [dbo].[Advertisement]  WITH CHECK ADD  CONSTRAINT [FK_Advertisement_Package] FOREIGN KEY([PackageID])
REFERENCES [dbo].[Package] ([PackageID])
GO
ALTER TABLE [dbo].[Advertisement] CHECK CONSTRAINT [FK_Advertisement_Package]
GO

ALTER TABLE [dbo].[Advertisement]  WITH CHECK ADD  CONSTRAINT [FK_Advertisement_AdsTypes] FOREIGN KEY([AdsTypeId])
REFERENCES [dbo].[AdsTypes] ([AdsTypeId])
GO
ALTER TABLE [dbo].[Advertisement] CHECK CONSTRAINT [FK_Advertisement_AdsTypes]
GO

ALTER TABLE [dbo].[Advertisement]  WITH CHECK ADD  CONSTRAINT [FK_Advertisement_Status] FOREIGN KEY([StatusId])
REFERENCES [dbo].[Status] ([StatusId])
GO
ALTER TABLE [dbo].[Advertisement] CHECK CONSTRAINT [FK_Advertisement_Status]
GO

/****** Object:  Table [dbo].[User]    Script Date: 24/09/24 7:10PM  ******/

ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_Role] FOREIGN KEY([RoleID])
REFERENCES [dbo].[Role] ([RoleID])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_User_Role]
GO

/****** Object:  Table [dbo].[Transaction]    Script Date: 24/09/24 7:10PM  ******/
--Hasn't Constraint to Element Table due to unavailable.


ALTER TABLE [dbo].[Transaction]  WITH CHECK ADD  CONSTRAINT [FK_Transaction_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[Transaction] CHECK CONSTRAINT [FK_Transaction_User]
GO


ALTER TABLE [dbo].[Transaction]  WITH CHECK ADD  CONSTRAINT [FK_Transaction_Advertisement] FOREIGN KEY([AdsId])
REFERENCES [dbo].[Advertisement] ([AdsId])
GO
ALTER TABLE [dbo].[Transaction] CHECK CONSTRAINT [FK_Transaction_Advertisement]
GO

/*
ALTER TABLE [dbo].[Transaction]  WITH CHECK ADD  CONSTRAINT [FK_Transaction_Package] FOREIGN KEY([PackageID])
REFERENCES [dbo].[Package] ([PackageID])
GO
ALTER TABLE [dbo].[Transaction] CHECK CONSTRAINT [FK_Transaction_Package]
GO
*/


/****** Object:  Table [dbo].[Pond]    Script Date:   ******/

ALTER TABLE [dbo].[Pond]  WITH CHECK ADD  CONSTRAINT [FK_Pond_Element] FOREIGN KEY([ElementID])
REFERENCES [dbo].[Element] ([ElementID])
GO
ALTER TABLE [dbo].[Pond] CHECK CONSTRAINT [FK_Pond_Element]
GO

ALTER TABLE [dbo].[Pond]  WITH CHECK ADD  CONSTRAINT [FK_Pond_Shape] FOREIGN KEY([ShapeID])
REFERENCES [dbo].[Shape] ([ShapeID])
GO
ALTER TABLE [dbo].[Pond] CHECK CONSTRAINT [FK_Pond_Shape]
GO

/****** Object:  Table [dbo].[ElementQuantity]    Script Date:   ******/

ALTER TABLE [dbo].[ElementQuantity]  WITH CHECK ADD  CONSTRAINT [FK_ElementQuantity_Element] FOREIGN KEY([ElementID])
REFERENCES [dbo].[Element] ([ElementID])
GO
ALTER TABLE [dbo].[ElementQuantity] CHECK CONSTRAINT [FK_ElementQuantity_Element]
GO

/****** Object:  Table [dbo].[Direction]    Script Date:   ******/

ALTER TABLE [dbo].[Direction]  WITH CHECK ADD  CONSTRAINT [FK_Direction_DirectionGroup] FOREIGN KEY([GroupID])
REFERENCES [dbo].[DirectionGroup] ([GroupID])
GO
ALTER TABLE [dbo].[Direction] CHECK CONSTRAINT [FK_Direction_DirectionGroup]
GO

/****** Object:  Table [dbo].[General]    Script Date:   ******/

ALTER TABLE [dbo].[General]  WITH CHECK ADD  CONSTRAINT [FK_General_Kua] FOREIGN KEY([KuaID])
REFERENCES [dbo].[Kua] ([KuaID])
GO
ALTER TABLE [dbo].[General] CHECK CONSTRAINT [FK_General_Kua]
GO

ALTER TABLE [dbo].[General]  WITH CHECK ADD  CONSTRAINT [FK_General_Element] FOREIGN KEY([ElementID])
REFERENCES [dbo].[Element] ([ElementID])
GO
ALTER TABLE [dbo].[General] CHECK CONSTRAINT [FK_General_Element]
GO

/****** Object:  Table [dbo].[Auspicious]    Script Date:   ******/

ALTER TABLE [dbo].[Auspicious]  WITH CHECK ADD  CONSTRAINT [FK_Auspicious_Kua] FOREIGN KEY([KuaID])
REFERENCES [dbo].[Kua] ([KuaID])
GO
ALTER TABLE [dbo].[Auspicious] CHECK CONSTRAINT [FK_Auspicious_Kua]
GO

ALTER TABLE [dbo].[Auspicious]  WITH CHECK ADD  CONSTRAINT [FK_Auspicious_Direction] FOREIGN KEY([DirectionID])
REFERENCES [dbo].[Direction] ([DirectionID])
GO
ALTER TABLE [dbo].[Auspicious] CHECK CONSTRAINT [FK_Auspicious_Direction]
GO

/****** Object:  Table [dbo].[Inauspicious]    Script Date:   ******/

ALTER TABLE [dbo].[Inauspicious]  WITH CHECK ADD  CONSTRAINT [FK_Inauspicious_Kua] FOREIGN KEY([KuaID])
REFERENCES [dbo].[Kua] ([KuaID])
GO
ALTER TABLE [dbo].[Inauspicious] CHECK CONSTRAINT [FK_Inauspicious_Kua]
GO

ALTER TABLE [dbo].[Inauspicious]  WITH CHECK ADD  CONSTRAINT [FK_Inauspicious_Direction] FOREIGN KEY([DirectionID])
REFERENCES [dbo].[Direction] ([DirectionID])
GO
ALTER TABLE [dbo].[Inauspicious] CHECK CONSTRAINT [FK_Inauspicious_Direction]
GO

/****** Object:  Table [dbo].[Pattern]    Script Date:   ******/

ALTER TABLE [dbo].[Pattern]  WITH CHECK ADD  CONSTRAINT [FK_Pattern_Variety] FOREIGN KEY([VarietyID])
REFERENCES [dbo].[Variety] ([VarietyID])
GO
ALTER TABLE [dbo].[Pattern] CHECK CONSTRAINT [FK_Pattern_Variety]
GO

/****** Object:  Table [dbo].[PatternColor]    Script Date:   ******/

ALTER TABLE [dbo].[PatternColor]  WITH CHECK ADD  CONSTRAINT [FK_PatternColor_Pattern] FOREIGN KEY([PatternID])
REFERENCES [dbo].[Pattern] ([PatternID])
GO
ALTER TABLE [dbo].[PatternColor] CHECK CONSTRAINT [FK_PatternColor_Pattern]
GO

ALTER TABLE [dbo].[PatternColor]  WITH CHECK ADD  CONSTRAINT [FK_PatternColor_Color] FOREIGN KEY([ColorID])
REFERENCES [dbo].[Color] ([ColorID])
GO
ALTER TABLE [dbo].[PatternColor] CHECK CONSTRAINT [FK_PatternColor_Color]
GO

/****** Object:  Table [dbo].[ElementColor]    Script Date:   ******/

ALTER TABLE [dbo].[ElementColor]  WITH CHECK ADD  CONSTRAINT [FK_ElementColor_Color] FOREIGN KEY([ColorID])
REFERENCES [dbo].[Color] ([ColorID])
GO
ALTER TABLE [dbo].[ElementColor] CHECK CONSTRAINT [FK_ElementColor_Color]
GO

ALTER TABLE [dbo].[ElementColor]  WITH CHECK ADD  CONSTRAINT [FK_ElementColor_Element] FOREIGN KEY([ElementID])
REFERENCES [dbo].[Element] ([ElementID])
GO
ALTER TABLE [dbo].[ElementColor] CHECK CONSTRAINT [FK_ElementColor_Element]
GO


/**** 


Remember to fix Transaction -> Advertisement Only


****/
