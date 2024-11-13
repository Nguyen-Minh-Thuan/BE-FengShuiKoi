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
	[UserName] [nvarchar](250) NOT NULL,
	[Password] [nvarchar](300) NOT NULL,
	[Email] [nvarchar](250) NOT NULL,
	[Bio] [nvarchar](500) NULL,
	[ImageUrl] [nvarchar](250) NULL,
	[IsActive] [bit] NULL,
	[RoleID] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Interact]    Script Date: 24/09/24 7:10PM  ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Interact](
	[InteractId] [int] IDENTITY(1,1) NOT NULL,
	[AdsId] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Interact] PRIMARY KEY CLUSTERED 
(
	[InteractId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 24/09/24 7:10PM  ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[RoleID] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar] (250) NOT NULL,
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
	[Title] [nvarchar](250) NOT NULL,
	[Content] [nvarchar](3000) NULL,
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
	[Title] [nvarchar](250) NOT NULL,
	[Content] [nvarchar](3000) NULL,
	[StatusId] [int]  NOT NULL,
	[ElementID] [int] NOT NULL,
	[StartedDate] [datetime] NULL,
	[ExpiredDate] [datetime] NULL,
	[Duration] [int] NULL,
	[ImageUrl] [nvarchar](250) NULL,
	[Reason] [nvarchar](500) NULL,
	[PaymentStatus] [bit] NULL,
	[CreatedDate] [datetime] NOT NULL,
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
	[PackageName] [nvarchar](250) NULL,
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
	[PaymentMethod] [nvarchar] (250) NOT NULL,
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
	[Element] [nvarchar] (250) NOT NULL,
	[Description] [nvarchar] (500)  NULL,
	[IsActive] [bit] NULL,
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
	[ElementID] [int] NULL,
	[KuaID] [int] NULL,
	[CreatedDate] [datetime] NOT NULL,
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
	[KuaName] [nvarchar] (250) NOT NULL,
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
	[DirectionName] [nvarchar] (250) NOT NULL,
	[IsActive] [bit] NULL,
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
	[GroupName] [nvarchar] (250) NOT NULL,
	[Description] [nvarchar] (300) NOT NULL,
	[IsActive] [bit] NULL,
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
	[Shape] [nvarchar] (250) NOT NULL,
	[IsActive] [bit] NULL,
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
	[Name] [nvarchar] (250) NOT NULL,
	[IsActive] [bit] NULL,
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
	[PatternName] [nvarchar] (250) NOT NULL,
	[ImageURL] [nvarchar] (250) NULL,
	[IsActive] [bit] NULL,
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
	[VarietyName] [nvarchar] (250) NOT NULL,
	[ImageURL] [nvarchar] (250) NULL,
	[Description] [nvarchar] (1500) NULL,
	[IsActive] [bit] NULL,
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

INSERT [dbo].[User] ([UserId],[UserName],[Password],[Email],[Bio],[ImageUrl],[IsActive],[RoleID],[CreatedDate]) VALUES (1, N'Admin', N'AQAAAAIAAYagAAAAEGWQ2ceLUyQuWZu7/w00GKLr54HUuzrmkPMr5gXbvtrvVfUXoUiTR2q7F9z2J9H+nw==', N'None', N'This is an Admin account', N'None', 1, 1,CAST(N'2024-11-11T00:00:00.000' AS DateTime))
INSERT [dbo].[User] ([UserId],[UserName],[Password],[Email],[Bio],[ImageUrl],[IsActive],[RoleID],[CreatedDate]) VALUES (2, N'Staff', N'AQAAAAIAAYagAAAAEGWQ2ceLUyQuWZu7/w00GKLr54HUuzrmkPMr5gXbvtrvVfUXoUiTR2q7F9z2J9H+nw==', N'None', N'HungDepTrai', N'None', 1, 2,CAST(N'2024-11-12T00:00:00.000' AS DateTime))
INSERT [dbo].[User] ([UserId],[UserName],[Password],[Email],[Bio],[ImageUrl],[IsActive],[RoleID],[CreatedDate]) VALUES (3, N'User1', N'AQAAAAIAAYagAAAAEGWQ2ceLUyQuWZu7/w00GKLr54HUuzrmkPMr5gXbvtrvVfUXoUiTR2q7F9z2J9H+nw==', N'None', N'This is an User account', N'None', 1, 3,CAST(N'2024-11-13T00:00:00.000' AS DateTime))
INSERT [dbo].[User] ([UserId],[UserName],[Password],[Email],[Bio],[ImageUrl],[IsActive],[RoleID],[CreatedDate]) VALUES (4, N'User2', N'AQAAAAIAAYagAAAAEBS7udiChbw7EwjTR6Eire4uX2drQOaTizzJMQe9WsfIS6BT516Jx/tWoNP/QhpQ4w==', N'None', N'This is an User account', N'None', 1, 3,CAST(N'2024-11-13T00:00:00.000' AS DateTime))
INSERT [dbo].[User] ([UserId],[UserName],[Password],[Email],[Bio],[ImageUrl],[IsActive],[RoleID],[CreatedDate]) VALUES (5, N'User3', N'AQAAAAIAAYagAAAAEMvFPFtUuXPD2vBcE6J0bcwv4PHlmMO5crxGyQpVNbqEWniejWC7ze4722Ruh+G5Ag==', N'None', N'This is an User account', N'None', 1, 3,CAST(N'2024-11-13T00:00:00.000' AS DateTime))
INSERT [dbo].[User] ([UserId],[UserName],[Password],[Email],[Bio],[ImageUrl],[IsActive],[RoleID],[CreatedDate]) VALUES (6, N'Tester', N'AQAAAAIAAYagAAAAEGWQ2ceLUyQuWZu7/w00GKLr54HUuzrmkPMr5gXbvtrvVfUXoUiTR2q7F9z2J9H+nw==', N'None', N'This is an User account', N'None', 1, 3,CAST(N'2024-11-14T00:00:00.000' AS DateTime))

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

-- Add đồ phong thủy
INSERT [dbo].[Advertisement] 
    ([AdsTypeId], [UserId], [PackageID], [Title], [Content], [StatusId], [ElementID], [StartedDate], [ExpiredDate], [ImageUrl], [PaymentStatus], [CreatedDate]) 
VALUES 
    (1, 3, 1, N'Đẹp Cá Koi Nhật Bản Đang Bán', N'Cá Koi chất lượng cao với màu sắc sống động và họa tiết độc đáo, lý tưởng cho bất kỳ hồ cá nào. Còn bán trong thời gian có hạn!', 5, 1, CAST(N'2024-09-20T00:00:00.000' AS DateTime), CAST(N'2025-09-24T00:00:00.000' AS DateTime), N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FHikari%20Muji%2FMatsuba%2FMatsuba.jpg?alt=media&token=2f80db4d-0f43-482e-97f6-a6cf45375a2f', 0, DATEADD(day, -1, GETDATE())),
    (1, 4, 1, N'Bộ Sưu Tập Cá Koi Nhập Khẩu Cao Cấp', N'Khám phá bộ sưu tập cá Koi cao cấp của chúng tôi, được nhập khẩu trực tiếp từ Nhật Bản. Làm đẹp hồ cá của bạn với những chú cá tuyệt vời này!', 5, 2, CAST(N'2024-09-20T00:00:00.000' AS DateTime), CAST(N'2024-12-25T00:00:00.000' AS DateTime), N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FHikari%20Muji%2FMatsuba%2FKin-Matsuba.jpg?alt=media&token=d05512e8-4934-4075-a1a6-4e5c84e953c9', 1, DATEADD(day, -1, GETDATE())),
    (1, 4, 2, N'Koi Cá Phiên Bản Giới Hạn Đang Bán', N'Hãy sở hữu những giống cá Koi hiếm có với họa tiết độc quyền. Hoàn hảo cho những người sưu tầm và đam mê!', 5, 3, CAST(N'2024-09-21T00:00:00.000' AS DateTime), CAST(N'2024-09-25T00:00:00.000' AS DateTime), N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FHikari%20Muji%2FMatsuba%2FGin-Matsuba.jpg?alt=media&token=5679c7a0-3ed6-4db9-895f-f84ed77551e2', 1, GETDATE()),
    (1, 5, 2, N' Cá Koi Cho Hồ Cá Mơ Ước Của Bạn', N'Tạo dựng một hồ cá mê hoặc với những chú cá Koi đầy màu sắc của chúng tôi. Có sẵn nhiều kích thước và màu sắc phù hợp với không gian của bạn.', 5, 4, CAST(N'2024-10-20T00:00:00.000' AS DateTime), CAST(N'2024-12-25T00:00:00.000' AS DateTime), N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FHikari%20Muji%2FOgon%2FYamabuki-Ogon.jpg?alt=media&token=883d442a-75eb-4a31-9477-d08c4611c73f', 1, DATEADD(day, -1, GETDATE())),
	(1, 3, 1, N'Koi Nhật Bản Độc Quyền Đang Bán', N'Cá Koi chất lượng cao với những họa tiết độc đáo và màu sắc sống động. Hàng có hạn, nhanh tay sở hữu ngay!', 5, 1, CAST(N'2024-10-20T00:00:00.000' AS DateTime), CAST(N'2024-11-24T00:00:00.000' AS DateTime), N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FHikari%20Muji%2FOgon%2FPlatinum-Ogon.jpg?alt=media&token=7b3ba4f4-3795-4e48-9af3-f36d88f645d2', 0, DATEADD(day, -2, GETDATE())),
    (1, 3, 1, N'Cá Koi Nhật Bản Đặc Biệt Cho Hồ Cá Của Bạn', N'Cá Koi cao cấp với màu sắc sống động và họa tiết độc đáo. Lý tưởng cho những người đam mê hồ cá!', 5, 1, CAST(N'2024-09-20T00:00:00.000' AS DateTime), CAST(N'2024-11-20T00:00:00.000' AS DateTime), N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FHikari%20Muji%2FMatsuba%2FMatsuba.jpg?alt=media&token=2f80db4d-0f43-482e-97f6-a6cf45375a2f', 0, GETDATE()),
    (1, 4, 1, N'Cá Koi Đẹp Cho Vườn Của Bạn', N'Tô điểm vườn nhà bạn với bộ sưu tập cá Koi tuyệt vời của chúng tôi, có sẵn với nhiều kích thước và màu sắc khác nhau!', 5, 1, CAST(N'2024-09-20T00:00:00.000' AS DateTime), CAST(N'2024-10-10T00:00:00.000' AS DateTime), N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FHikari%20Muji%2FOgon%2FMatsuba.jpg?alt=media&token=1122334455', 0, DATEADD(day, -4, GETDATE())),
    (1, 5, 1, N'Cá Koi Chất Lượng Cao Đang Có Sẵn', N'Hãy sở hữu những chú cá Koi tuyệt vời với màu sắc đa dạng, họa tiết đặc biệt và chất lượng tuyệt hảo.', 5, 1, CAST(N'2024-09-21T00:00:00.000' AS DateTime), CAST(N'2024-12-05T00:00:00.000' AS DateTime), N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FHikari%20Muji%2FMatsuba%2FGin-Matsuba.jpg?alt=media&token=5679c7a0-3ed6-4db9-895f-f84ed77551e2', 0, DATEADD(day, -1, GETDATE())),
    (1, 3, 2, N'Cá Koi Tuyệt Vời Đang Cung Cấp', N'Tăng cường vẻ đẹp cho hồ cá của bạn với bộ sưu tập cá Koi tuyệt vời. Đang bán trong thời gian có hạn!', 5, 1, CAST(N'2024-09-21T00:00:00.000' AS DateTime), CAST(N'2024-10-15T00:00:00.000' AS DateTime), N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FHikari%20Muji%2FMatsuba%2FPlatinum-Ogon.jpg?alt=media&token=7b3ba4f4-3795-4e48-9af3-f36d88f645d2', 0, DATEADD(day, -3, GETDATE())),
    (1, 4, 1, N'Bộ Sưu Tập Cá Koi Tuyệt Đẹp Đang Bán', N'Cá Koi cao cấp được chọn lọc kỹ càng, mang đến cho hồ cá của bạn sự nổi bật. Được nhập khẩu trực tiếp từ Nhật Bản!', 5, 2, CAST(N'2024-09-20T00:00:00.000' AS DateTime), CAST(N'2024-12-25T00:00:00.000' AS DateTime), N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FHikari%20Muji%2FOgon%2FOrange-Ogon.jpg?alt=media&token=4f455796-030b-493a-99bd-34f215a3ea84', 1, GETDATE()),
    (1, 4, 2, N'Cá Koi Loại Hiếm Đang Bán', N'Tăng thêm giá trị cho bộ sưu tập của bạn với các giống cá Koi hiếm. Lý tưởng cho những người yêu thích cá Koi!', 5, 3, CAST(N'2024-09-20T00:00:00.000' AS DateTime), CAST(N'2024-10-30T00:00:00.000' AS DateTime), N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FUtsuri%2FKi-Utsuri.jpg?alt=media&token=6c22adde-59b6-4bab-8e3e-36bda066228b', 1, DATEADD(day, -4, GETDATE())),
    (1, 5, 2, N'Cá Koi Màu Sắc Tươi Sáng Cho Hồ Cá Của Bạn', N'Tô điểm cho hồ cá của bạn với những chú cá Koi sắc màu rực rỡ, được chọn lựa thủ công. Có sẵn với nhiều màu sắc và họa tiết đa dạng!', 5, 4, CAST(N'2024-09-20T00:00:00.000' AS DateTime), CAST(N'2024-12-24T00:00:00.000' AS DateTime), N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FUtsuri%2FHi-Utsuri.jpg?alt=media&token=0b1920a6-bf37-48b6-b573-fdda6ac03db7', 1, DATEADD(day, -3, GETDATE())),
    (1, 3, 1, N'Cá Koi Được Chọn Lọc Cẩn Thận Đang Bán', N'Cá Koi được chọn lọc kỹ lưỡng với những đặc điểm độc đáo, lý tưởng cho một hồ cá đẹp mắt. Hàng giới hạn, hãy nhanh tay sở hữu!', 5, 1, CAST(N'2024-09-20T00:00:00.000' AS DateTime), CAST(N'2024-10-15T00:00:00.000' AS DateTime), N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FUtsuri%2FShiro%20Utsuri%2FShiro-Utsuri.jpg?alt=media&token=4d21716f-642b-437f-8a0a-baa765a6bbee', 0, DATEADD(day, -1, GETDATE())),
    (1, 4, 1, N'Cá Koi Nhật Bản – Tô Điểm Cho Hồ Cá Của Bạn', N'Tô điểm cho hồ cá của bạn với những chú cá Koi Nhật Bản rực rỡ sắc màu. Còn bán trong thời gian có hạn!', 5, 2, CAST(N'2024-09-20T00:00:00.000' AS DateTime), CAST(N'2024-11-30T00:00:00.000' AS DateTime), N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FUtsuri%2FShiro%20Utsuri%2FGinrin-Shiro-Utsuri.jpg?alt=media&token=9adb852e-7de4-47db-aa1a-9f1aec1bf940', 1, DATEADD(day, -2, GETDATE())),
    (1, 4, 2, N'Bộ Sưu Tập Cá Koi Chất Lượng Cao', N'Những chú cá Koi với màu sắc sống động và sức khỏe tốt. Sự lựa chọn hoàn hảo cho những người yêu thích cá Koi.', 5, 3, CAST(N'2024-09-20T00:00:00.000' AS DateTime), CAST(N'2024-10-15T00:00:00.000' AS DateTime), N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FUtsuri%2FShiro%20Utsuri%2FDoitsu-Shiro-Utsuri.jpg?alt=media&token=3ecfbc0b-dcd0-48ad-ad9c-371b0ec5a0ca', 1, DATEADD(day, -3, GETDATE())),
    (1, 5, 2, N'Cá Koi Hiếm Và Đẹp', N'Chọn lựa các giống cá Koi với hoa văn độc đáo. Lựa chọn tuyệt vời cho những nhà sưu tập và chủ hồ cá.', 5, 4, CAST(N'2024-09-20T00:00:00.000' AS DateTime), CAST(N'2024-11-24T00:00:00.000' AS DateTime), N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FAsagi%2FAsagi.jpg?alt=media&token=06058be9-7fbb-4316-818c-3df56d81a87a', 1, DATEADD(day, -5, GETDATE())),
    (1, 3, 1, N'Cá Koi Nhập Khẩu Chính Hãng Từ Nhật Bản', N'Cá Koi nhập khẩu với màu sắc rực rỡ và sức khỏe tuyệt vời. Sự bổ sung tuyệt vời cho một hồ cá đẹp mắt!', 5, 1, CAST(N'2024-09-20T00:00:00.000' AS DateTime), CAST(N'2024-10-24T00:00:00.000' AS DateTime), N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FAsagi%2FGinrin-Asagi.jpg?alt=media&token=51a76d75-179c-473f-a8b3-a713ca8a0bdd', 0, GETDATE()),
    (1, 4, 1, N'Cá Koi Màu Sắc Nổi Bật Đang Bán', N'Cá Koi với họa tiết và màu sắc hấp dẫn. Lý tưởng để tạo nên không gian hồ cá thanh bình.', 5, 2, CAST(N'2024-09-20T00:00:00.000' AS DateTime), CAST(N'2024-12-25T00:00:00.000' AS DateTime), N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FAsagi%2FKonjo-Asagi.jpg?alt=media&token=22be26a5-bab5-46ec-959e-4f10de008f93', 1, DATEADD(day, -3, GETDATE())),
    (1, 4, 2, N'Cá Koi Độc Quyền Từ Nhật Bản', N'Cá Koi cao cấp, nhập khẩu với màu sắc nổi bật để biến hồ cá của bạn thành tuyệt tác.', 5, 3, CAST(N'2024-09-20T00:00:00.000' AS DateTime), CAST(N'2024-10-30T00:00:00.000' AS DateTime), N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FBenigoi%2FBenigoi.jpg?alt=media&token=7a929e28-e2c1-4023-892e-fc505327241b', 1, DATEADD(day, -3, GETDATE())),
    (1, 5, 2, N'Cá Koi Cho Hồ Cá Tuyệt Đẹp', N'Tăng thêm vẻ đẹp cho hồ cá của bạn với những chú cá Koi đầy màu sắc và khỏe mạnh. Có nhiều họa tiết để phù hợp với phong cách của bạn!', 5, 4, CAST(N'2024-09-20T00:00:00.000' AS DateTime), CAST(N'2024-12-24T00:00:00.000' AS DateTime), N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FBenigoi%2FDoitsu-Benigoi.jpg?alt=media&token=1d1492ce-837f-47f2-881e-b90490760c55', 1, GETDATE());




-- Add Koi
/*
SET IDENTITY_INSERT [dbo].[Advertisement] ON;

INSERT [dbo].[Advertisement] 
    ([AdsId], [AdsTypeId], [UserId], [PackageID], [Title], [Content], [StatusId], [ElementID], [StartedDate], [ExpiredDate], [ImageUrl], [PaymentStatus], [CreatedDate]) 
VALUES 
    (5, 2, 3, 1, N'Tiêu đề Quảng cáo #5', N'Nội dung quảng cáo #1', 5, 1, CAST(N'2024-09-20T00:00:00.000' AS DateTime), CAST(N'2024-10-24T00:00:00.000' AS DateTime), N'None', 0, GETDATE()),
    (6, 2, 4, 1, N'Tiêu đề Quảng cáo #6', N'Nội dung quảng cáo #2', 5, 2, CAST(N'2024-09-20T00:00:00.000' AS DateTime), CAST(N'2024-12-25T00:00:00.000' AS DateTime), N'None', 1, GETDATE()),
    (7, 2, 4, 2, N'Tiêu đề Quảng cáo #7', N'Nội dung quảng cáo #3', 5, 3, CAST(N'2024-09-20T00:00:00.000' AS DateTime), CAST(N'2024-10-30T00:00:00.000' AS DateTime), N'None', 1, GETDATE()),
    (8, 2, 5, 2, N'Tiêu đề Quảng cáo #8', N'Nội dung quảng cáo #4', 5, 4, CAST(N'2024-09-20T00:00:00.000' AS DateTime), CAST(N'2024-12-24T00:00:00.000' AS DateTime), N'None', 1, GETDATE());

SET IDENTITY_INSERT [dbo].[Advertisement] OFF;
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
INSERT INTO [dbo].[Status] ([StatusId], [Status]) VALUES (7, N'Sold Out');
SET IDENTITY_INSERT [dbo].[Status] OFF;
GO

SET IDENTITY_INSERT [dbo].[Package] ON 

INSERT [dbo].[Package] ([PackageID],[PackageName],[Duration] ,[Price]) VALUES (1,N'Weekly Package',1 ,35000)
INSERT [dbo].[Package] ([PackageID],[PackageName],[Duration] ,[Price]) VALUES (2,N'Weekly Package',7 ,200000)
INSERT [dbo].[Package] ([PackageID],[PackageName],[Duration] ,[Price]) VALUES (3,N'Monthly Package',30 ,1500000)
INSERT [dbo].[Package] ([PackageID],[PackageName],[Duration] ,[Price]) VALUES (4,N'Yearly Package',365 ,100000000)

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

INSERT [dbo].[Element] ([ElementID], [Element], [Description], [IsActive]) VALUES (1, N'Kim', N'Hành Kim tượng trưng cho sức mạnh, tính cách kiên định và nghiêm túc.', 1)
INSERT [dbo].[Element] ([ElementID], [Element], [Description], [IsActive]) VALUES (2, N'Thủy', N'Hành Thủy tượng trưng cho nước, có tính tàng chứa.', 1)
INSERT [dbo].[Element] ([ElementID], [Element], [Description], [IsActive]) VALUES (3, N'Hỏa', N'Hành Hỏa tượng trưng cho sự may mắn, hạnh phúc, danh vọng và thành công.', 1)
INSERT [dbo].[Element] ([ElementID], [Element], [Description], [IsActive]) VALUES (4, N'Thổ', N'Hành Thổ tượng trưng cho sự nuôi dưỡng, màu mỡ và được coi là trung tâm của sự cân bằng, ổn định.', 1)
INSERT [dbo].[Element] ([ElementID], [Element], [Description], [IsActive]) VALUES (5, N'Mộc', N'Hành Mộc tượng trưng cho cây, có tính động, khởi đầu.', 1)

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


INSERT INTO [dbo].[Blog] ( UserId, Title, Content, ElementID, CreatedDate, ImageUrl, IsActive) 
VALUES 
( 2, 'Introduction to Feng Shui', 'Feng Shui is an ancient Chinese art focusing on the placement of objects to create harmony...',  2, CAST(N'2023-10-01 08:00:00' AS DateTime), 'https://example.com/image1.jpg', 0),

( 2, N'Những lợi ích của hồ cá Koi', N'<div><h2>Những Lợi Ích Của Hồ Cá Koi</h2><p><strong>Tăng cường sức khỏe tinh thần:</strong><br>Hồ cá Koi mang lại cảm giác thư giãn và giúp giảm căng thẳng. Ngồi bên hồ, ngắm cá bơi lội có thể giúp cải thiện tâm trạng, giảm triệu chứng lo âu và huyết áp. Nghiên cứu cũng cho thấy tiếp xúc thường xuyên với nước có thể hỗ trợ tinh thần và mang lại năng lượng tích cực.</p><p><strong>Yếu tố phong thủy và may mắn:</strong><br>Cá Koi tượng trưng cho sự kiên cường, tài lộc và may mắn. Trong văn hóa Nhật Bản và Trung Quốc, cá Koi được cho là mang lại thành công và may mắn nhờ sức sống mạnh mẽ và khả năng bơi ngược dòng. Những chú cá Koi màu sắc đặc trưng còn đại diện cho các khía cạnh khác nhau trong cuộc sống như tài chính, sự nghiệp, tình yêu và gia đình.</p><p><strong>Gia tăng giá trị thẩm mỹ và bất động sản:</strong><br>Hồ cá Koi không chỉ làm đẹp cho không gian sống mà còn tăng giá trị tài sản, thu hút người mua tiềm năng. Một hồ cá Koi thiết kế tinh tế sẽ khiến ngôi nhà của bạn thêm phần hấp dẫn, tạo không gian lý tưởng cho các buổi gặp gỡ bạn bè và gia đình.</p><p><strong>Gắn kết tình cảm:</strong><br>Cá Koi là một loại thú cưng dễ chăm sóc và có thể phát triển mối quan hệ với chủ nhân. Các chú cá có thể nhận ra người cho ăn và được huấn luyện ăn từ tay, mang lại niềm vui và sự gắn bó cho gia đình. Đây là một sở thích đáng giá, đem đến trải nghiệm chăm sóc và thưởng thức thú vị cho người nuôi.</p><p>Hồ cá Koi không chỉ làm đẹp không gian mà còn giúp chủ nhân có thêm nhiều lợi ích tinh thần và tài lộc. Hãy thử tạo một hồ cá Koi nhỏ trong khu vườn để tận hưởng vẻ đẹp tự nhiên và cảm giác thư thái mà nó mang lại.</p></div>',  5, '2024-10-15 10:30:00', 'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FpondKoi.jpg?alt=media&token=aed67039-c48e-4142-ab0e-dca6c222f42f', 1),

( 2, N'Phong thủy cho Sự Thịnh Vượng', N'<div><h2>Cách Sử Dụng Phong Thủy Để Thu Hút Sự Thịnh Vượng</h2><p><strong>Chọn Khu Vực Tài Lộc:</strong><br>Theo phong thủy, khu vực Đông Nam của ngôi nhà đại diện cho tài lộc. Để tối đa hóa sự thịnh vượng, hãy giữ khu vực này sạch sẽ và thông thoáng, có thể trang trí với yếu tố nước như đài phun hoặc hồ cá, giúp thu hút năng lượng tài chính dồi dào.</p><p><strong>Màu Sắc May Mắn:</strong><br>Sử dụng các màu sắc thuộc hành Mộc như xanh lá cây và xanh dương trong khu vực tài lộc. Màu tím cũng rất hữu ích vì nó biểu trưng cho sự giàu có và có thể đặt trong các vật dụng nhỏ hoặc tranh ảnh để kích hoạt nguồn năng lượng tích cực.</p><p><strong>Bổ Sung Cây Cảnh và Hoa:</strong><br>Đặt cây cảnh hoặc hoa tươi trong khu vực này, như cây tiền hoặc cây phát tài, sẽ tăng cường năng lượng Mộc, giúp phát triển và sinh sôi tài lộc.</p><p><strong>Gương và Đồ Vật Phong Thủy:</strong><br>Gương sáng bóng tượng trưng cho sự rõ ràng về tài chính. Đặt gương trong khu vực tài lộc giúp khuếch đại năng lượng thịnh vượng. Các vật phong thủy như rồng vàng, tượng Phật Di Lặc, hay ếch ba chân cầm đồng xu cũng mang lại may mắn và tài lộc.</p><p><strong>Khuyến Nghị Khác:</strong><br>Hãy giữ cửa chính sạch sẽ và không có vật cản để thu hút cơ hội mới, đồng thời sửa chữa các vòi nước rò rỉ để tránh tài lộc "chảy đi". Một vài lời khuyên hữu ích khác bao gồm bật đèn cửa ba tiếng mỗi ngày, đặt bát cam để tượng trưng cho thịnh vượng, và chơi nhạc vui vẻ để kích thích năng lượng tích cực.</p><p><br>Với những điều chỉnh phong thủy trên, bạn có thể tận dụng không gian sống để thúc đẩy sự giàu có và phát triển tài chính trong gia đình.</p></div>',  1, '2023-10-22 15:45:00', 'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2Ffengshui.jpg?alt=media&token=b6736dbc-d00f-4236-9d97-848b437ddbde', 1),

( 2, N'Những lựa chọn cá Koi với người mệnh Kim', N'<div>"Kim" đại diện cho kim loại, với các màu bản mệnh là trắng, xám, hoặc ghi, vì thế khi chọn dòng cá Koi mang những màu sắc này, gia chủ mệnh Kim sẽ gia tăng vượng khí, giúp công việc thăng tiến, cuộc sống gia đình thuận lợi.</div>
<p>Một số dòng cá Koi mang màu sắc này: Mukashi (trắng bạc), Platinum Ogon (trắng),...</p><p><br /></p><p>Do Thổ sinh Kim nên người mệnh Kim cũng phù hợp với các dòng cá Koi mang màu sắc nâu đất, vàng,... Một số dòng cá Koi có thể tham khảo: Shunsui (vàng), Yamabuki Ogon (vàng kim), Chagoi (nâu trà),...</p><p><br /></p><p>Mệnh Kim nên hạn chế chọn các loại cá cảnh có màu tương khắc như màu đỏ, hồng, tím. Đây là những màu sắc của mệnh Hỏa, trong ngũ hành thì Hỏa lại khắc Kim, nên nuôi những loài cá này có thể ảnh hưởng xấu, giảm tài lộc cho người mệnh Kim.</p>',  1, '2024-10-22 15:45:00', 'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2F2791300984_5386362a7c_w.jpg?alt=media&token=95fbd688-f2e7-4d5c-b6f2-7e3998327c46', 1),

( 2, N'Hi-Kui – Bệnh ăn sắc tố đỏ trên cá Koi (1)', N'<div>Hi-kui chỉ tấn công da của koi có sắc tố đỏ, đặc biệt là các giống Go Sanke, tức là Kohaku, Showa và Sanke. Thuật ngữ Hi-kui bao gồm hai yếu tố - hi có nghĩa là màu đỏ và kui dịch là ăn, vì vậy Hi-kui có thể được mô tả là một căn bệnh ăn các vùng sắc tố màu đỏ trên cá koi. Hi-kui được sử dụng rộng rãi để mô tả một loạt các điều kiện, mặc dù nguyên nhân thực tế có thể là một số điều. Hi-kui có thể được sử dụng để mô tả các vấn đề như tình trạng xù da nhẹ, cục bộ, mà thông thường có thể dễ dàng điều trị bằng cách sử dụng các phương pháp được mô tả dưới đây.</span></span></span></p><p>Nhìn chung, bệnh ngoài da ở cá ít được chú ý về nguồn gốc và bệnh lý của chúng và bệnh Hi-kui ở cá koi cũng không phải là ngoại lệ. Vì nó cũng có thể bao gồm sự phát triển ác tính hoặc ung thư, hãy luôn tìm lời khuyên của bác sĩ chuyên khoa nếu nghi ngờ. Trong khi Hi-kui dường như chỉ ảnh hưởng đến cá koi chất lượng tốt và có thể làm giảm giá trị cá, tình trạng này có thể xảy ra trên sắc tố đỏ của bất kỳ cá koi nào.</span></span></span></p><h2><span><div><h2><span><strong style=" font-weight: bolder">Nhận biết</strong></span></span></span></h2><span>Bệnh Hi-kui có thể tự biểu hiện theo một số cách. Đầu tiên, bạn có thể nhận thấy sự đổi màu nhỏ của một vùng sắc tố đỏ, làm cho sắc tố đỏ trông nhạt đi so với phần còn lại của màu đỏ trên cá koi. Khu vực này cũng có thể trông mờ và trũng xuống và thiếu ánh sáng như phần còn lại của cá. Thứ hai, một vùng sắc tố đỏ có thể có màu nâu và trông nổi lên so với vùng xung quanh. Thứ ba, các vùng nhỏ màu nâu sẫm có thể xuất hiện với đường kính từ đầu đinh nhọn đến kích thước bằng đồng xu nhỏ.</span></span></span></p><span>Dù cá koi của bạn có biểu hiện triệu chứng nào đi chăng nữa thì vấn đề là do sự dày lên của các mô biểu bì bên trên có thể do một số yếu tố gây ra. Trong khi các nhà lai tạo cá koi Nhật Bản coi việc tiếp xúc với ánh sáng mặt trời là nguyên nhân gây ra bệnh Hi-kui, rõ ràng một số tình trạng da khác nhau không rõ nguyên nhân đã được đưa vào thuật ngữ &nbsp;này. Tác động của ánh sáng mặt trời trong việc gây ra Hi-kui có thể đúng, nhưng có những yếu tố khác liên quan đến sắc tố đỏ.</span></span></span></p></div></div>',  3, '2024-11-12 20:43:10', 'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2Fbenh-hu-kui.jpg?alt=media&token=f61ce885-76ab-4641-a6f2-a253b9ba9825', 1),

( 2, N'Hi-Kui – Bệnh ăn sắc tố đỏ trên cá Koi (2)', N'<div>Vì tiếp xúc quá nhiều với ánh sáng mặt trời được coi là nguyên nhân gây ra bệnh Hi-kui, nên che nắng cho ao. Vì lý do này, nhiều người nuôi tin rằng cá koi được nuôi trong nước xanh ít có khả năng mắc bệnh Hi-kui, mặc dù đây không phải là giải pháp hấp dẫn cho những người có sở thích muốn xem cá koi của họ trong một làn nước trong. Việc bảo trì hệ thống tốt và thường xuyên xả chất thải trong hồ sẽ giúp ích cho bạn. Chúng không nhất thiết ngăn chặn Hi-kui xảy ra, nhưng chúng giúp ngăn chặn các bệnh lây nhiễm khác đang diễn ra. Điều cần thiết là đảm bảo rằng mức oxy tối ưu được duy trì mọi lúc, đặc biệt là ở nhiệt độ cao thường trùng với việc tiếp xúc nhiều với ánh sáng mặt trời. Bất chấp những biện pháp phòng ngừa này, có thể không thể ngăn chặn sự bùng phát của Hi-kui vì nó có thể chỉ xuất hiện mà không do lỗi của bạn. Thật không may, nó có xu hướng dễ xảy ra hơn trên cá koi chất lượng cao với màu hi (màu đỏ) mạnh và ổn định, và nếu bộ sưu tập của bạn chứa những con cá thuộc loại này, hãy cảnh báo rằng điều đó có thể xảy ra!</span></span></span></p><h2><span><div><h2><span><strong style=" font-weight: bolder">Xử lí</strong></span></span></span></h2><span>Hi-kui không lây nhiễm và trong điều kiện thực tế, nó không ảnh hưởng đến sức khỏe tổng thể của cá koi, miễn là hệ thống nuôi nhốt chúng phải đạt tiêu chuẩn phù hợp và được duy trì tốt. Tác hại chính của Hi-kui là thẩm mỹ - nó làm giảm vẻ ngoài của cá của bạn và trong trường hợp cá koi có giá trị cao, nó có thể làm mất giá trị của chúng. Cho dù bạn quyết định điều trị hay không là một vấn đề của sự lựa chọn cá nhân.</span></span></span></p><span>Nếu bạn quyết định điều trị, cá koi sẽ cần được tiến hành gây mê trước khi tiến hành bất kỳ phương pháp điều trị  nào. Sau khi gây mê cho cá, bác sĩ thú y hoặc chuyên gia cá koi sẽ cạo sạch khu vực của Hi-kui bằng dao mổ đã được khử trùng sạch sẽ cho đến khi các bộ phận nổi lên của Hi-kui biến mất hoặc ít nhất là giảm kích thước nếu một khu vực lớn bị ảnh hưởng. Sau đó, một phương pháp điều trị tại chỗ phù hợp có thể được áp dụng cho khu vực để ngăn chặn nhiễm trùng thứ cấp, chẳng hạn như nấm. Keo ong là một phương pháp điều trị tốt để áp dụng mặc dù có màu xanh malachite hoặc tương tự.</span></span></span></p><span>Cá koi sau đó có thể được đưa trở lại ao, nhưng vùng da được xử lý phải được theo dõi thường xuyên để đảm bảo rằng không có sự lây nhiễm thứ cấp nào xảy ra. Có thể cần lặp lại điều trị tại chỗ một cách thường xuyên cho đến khi vết thương lành. Nên sử dụng thuốc kháng khuẩn, chẳng hạn như Virkon S Aqua, kết hợp với bất kỳ phương pháp điều trị nào khác để giảm khả năng nhiễm trùng thứ cấp. Đáng tiếc, vì bệnh lý cơ bản của Hi-kui chưa được hiểu rõ, nên rất khó để chắc chắn rằng bất kỳ phương pháp điều trị nào sẽ thành công trong thời gian dài và tình trạng có thể sẽ tái phát.</span></span></span></p><span></span></span></span></p></div></div>',  3, '2024-11-12 20:43:10', 'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2Fbenh-hu-kui-1.jpg?alt=media&token=712f7bb3-cc60-4f32-bfb8-ee79f98344c6', 1),

( 2, N'Những lựa chọn cá Koi với người mệnh Thủy', N'<div><h2>Những Lựa Chọn Cá Koi Với Người Mệnh Thủy</h2><p><strong>Màu sắc phù hợp:</strong><br>Người mệnh Thủy hợp với màu xanh dương và đen, mang lại năng lượng tích cực và tài lộc. Một số dòng cá Koi phù hợp với mệnh Thủy gồm Asagi (xanh dương), Shiro Utsuri (đen và trắng), Showa (đen, đỏ, trắng). Các màu này đại diện cho yếu tố nước, hỗ trợ công danh và cuộc sống hài hòa.</p><p><strong>Lựa chọn thêm từ hành Kim:</strong><br>Theo phong thủy, Kim sinh Thủy nên các dòng cá Koi có màu trắng, bạc như Platinum Ogon hay Mukashi cũng rất phù hợp, giúp tăng cường may mắn và ổn định.</p><p><strong>Lưu ý về màu sắc tương khắc:</strong><br>Người mệnh Thủy nên tránh cá Koi có màu vàng, nâu (thuộc hành Thổ) vì Thổ khắc Thủy, có thể cản trở sự thuận lợi trong công việc và cuộc sống.</p><p><br>Lựa chọn cá Koi hợp mệnh giúp gia chủ mệnh Thủy không chỉ tăng thêm vẻ đẹp cho không gian sống mà còn thu hút may mắn, thịnh vượng.</p></div>',  2, '2024-10-26 10:58:05', 'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2F900_Goldfishwallart_koi_fish_feng_shui_painting_art__goldfishwallart..jpg?alt=media&token=c92b61d8-e009-47ae-9947-46f1989ed495', 1),

( 2, N'Những lựa chọn cá Koi với người mệnh Hỏa', N'<div><h2>Những Lựa Chọn Cá Koi Với Người Mệnh Hỏa</h2><p><strong>Màu sắc phù hợp:</strong><br>Người mệnh Hỏa hợp với các màu đỏ, hồng, tím, và cam, tượng trưng cho nhiệt huyết, giúp gia tăng tài lộc và năng lượng. Một số dòng cá Koi phù hợp với mệnh Hỏa bao gồm Benigoi (đỏ), Kohaku (đỏ và trắng), Hi Utsuri (đen và đỏ).</p><p><strong>Lựa chọn thêm từ hành Mộc:</strong><br>Mộc sinh Hỏa nên người mệnh Hỏa có thể chọn cá Koi màu xanh lục hoặc có hoa văn xanh, duy trì sự hòa hợp phong thủy.</p><p><strong>Lưu ý về màu sắc tương khắc:</strong><br>Người mệnh Hỏa nên tránh cá Koi màu đen, xanh đậm (thuộc hành Thủy) vì Thủy khắc Hỏa, có thể ảnh hưởng đến may mắn.</p><p><br>Lựa chọn cá Koi hợp mệnh giúp gia chủ mệnh Hỏa thu hút thịnh vượng và tạo không gian sống hài hòa.</p></div>',  3, '2024-10-12 09:52:05', 'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FfireKOi.jpg?alt=media&token=5e50534c-a1fd-4674-b5f4-52755daf593a', 1),

( 2, N'Những lựa chọn cá Koi với người mệnh Thổ', N'<div><h2>Những Lựa Chọn Cá Koi Với Người Mệnh Thổ</h2><p><strong>Màu sắc phù hợp:</strong><br>Người mệnh Thổ hợp với các màu vàng, nâu đất, và cam nhạt, giúp ổn định cuộc sống và tăng tài lộc. Một số dòng cá Koi phù hợp với mệnh Thổ bao gồm Chagoi (nâu trà), Yamabuki Ogon (vàng), và Kigoi (vàng nhạt).</p><p><strong>Lựa chọn thêm từ hành Hỏa:</strong><br>Hỏa sinh Thổ nên cá Koi màu đỏ, hồng cũng có lợi cho mệnh Thổ, tạo sự ấm áp và may mắn.</p><p><strong>Lưu ý về màu sắc tương khắc:</strong><br>Người mệnh Thổ nên tránh cá màu xanh lá cây (thuộc hành Mộc) vì Mộc khắc Thổ, có thể gây cản trở.</p><p><br>Lựa chọn cá Koi hợp mệnh giúp gia chủ mệnh Thổ thu hút tài lộc và duy trì sự hài hòa cho không gian sống.</p></div>',  4, '2024-10-17 14:52:05', 'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FearthKoi.jpg?alt=media&token=c327d803-6e5c-40bb-9523-d04a9ef7863e', 1),

( 2,  N'Những lựa chọn cá Koi với người mệnh Mộc', N'<div><h2>Những Lựa Chọn Cá Koi Với Người Mệnh Mộc</h2><p><strong>Màu sắc phù hợp:</strong><br>Người mệnh Mộc hợp với màu xanh lá cây, giúp tạo sinh khí và may mắn. Một số dòng cá Koi có màu xanh như Asagi (xanh dương pha xanh lục) rất phù hợp với mệnh Mộc.</p><p><strong>Lựa chọn thêm từ hành Thủy:</strong><br>Vì Thủy sinh Mộc nên các dòng cá Koi màu đen, xanh đậm như Shiro Utsuri cũng có lợi, giúp gia tăng sự hài hòa và phát triển.</p><p><strong>Lưu ý về màu sắc tương khắc:</strong><br>Người mệnh Mộc nên tránh cá Koi màu trắng, bạc (thuộc hành Kim) vì Kim khắc Mộc, có thể gây cản trở tài lộc.</p><p><br>Lựa chọn cá Koi hợp mệnh giúp gia chủ mệnh Mộc thu hút may mắn và tạo không gian sống cân bằng.</p></div>',  5, '2024-10-18 15:12:15', 'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2Fimages.jpg?alt=media&token=676fec7b-a955-481d-8121-ca7879e0a73f', 1);


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
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (38, 1, 0.6);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (38, 29, 0.4);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (39, 5, 0.5);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (39, 29, 0.5);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (40, 18, 0.3);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (40, 2, 0.7);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (41, 1, 0.1);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (41, 9, 0.6);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (41, 12, 0.3);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (42, 1, 0.4);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (42, 9, 0.3);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (42, 29, 0.3);

INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (43, 12, 0.3);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (43, 1, 0.6);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (43, 29, 0.3);

INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (44, 12, 0.1);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (44, 1, 0.6);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (44, 29, 0.3);

INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (45, 12, 0.5);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (45, 29, 0.5);

INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (46, 12, 0.2);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (46, 29, 0.2);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (46, 1, 0.6);

INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (47, 12, 0.3);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (47, 29, 0.4);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (47, 1, 0.3);

INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (48, 1, 0.5);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (48, 12, 0.5);

INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (49, 9, 1);
--select * from [dbo].[Pattern] where [VarietyID] = 7
--select * from [dbo].[Variety]
--select * from [dbo].[PatternColor] where [PatternID] = 35
--select * from [dbo].[Color]
--Xóa loại này
INSERT INTO [dbo].[Pattern] ([VarietyID], [IsActive], [PatternName], [ImageURL]) VALUES (1, 0, N'Shiro Utsuri', N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FUtsuri%2FShiro%20Utsuri%2FShiro-Utsuri.jpg?alt=media&token=4d21716f-642b-437f-8a0a-baa765a6bbee');
INSERT INTO [dbo].[Pattern] ([VarietyID], [IsActive], [PatternName]) VALUES (1, 0, N'Yamabuki Shiro Utsuri');
--
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName], [ImageURL]) VALUES (2, N'Taisho Sanke', N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FSanke%2FTaisho-Sanke.jpg?alt=media&token=cc98e1eb-e8c0-4390-91a7-efdafe4d410b');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName], [ImageURL]) VALUES (2, N'Yamato Nishiki', N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FSanke%2FYamato-Nishiki.jpg?alt=media&token=0d75c7f8-e30c-40ff-a54f-51d6ac73ee66');
--
INSERT INTO [dbo].[Pattern] ([VarietyID], [IsActive], [PatternName], [ImageURL]) VALUES (3, 0, N'Showa Sanke', N'');
INSERT INTO [dbo].[Pattern] ([VarietyID], [IsActive], [PatternName]) VALUES (3, 0, N'Yamabuki Showa');
--
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName], [ImageURL]) VALUES (4, N'Kohaku', N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FKohaku%2FKohaku.jpg?alt=media&token=6f01b2f0-50a2-4280-9851-b5d623f30f84');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName], [ImageURL]) VALUES (4, N'Kohaku Maruten', N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FKohaku%2FMaruten-Kohaku.jpg?alt=media&token=e6529947-e1e3-43ac-86ec-356abe212b9f');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName], [ImageURL]) VALUES (5, N'Shiro Utsuri', N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FUtsuri%2FShiro%20Utsuri%2FShiro-Utsuri.jpg?alt=media&token=4d21716f-642b-437f-8a0a-baa765a6bbee');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName], [ImageURL]) VALUES (5, N'Hi Utsuri', N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FUtsuri%2FHi-Utsuri.jpg?alt=media&token=0b1920a6-bf37-48b6-b573-fdda6ac03db7');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName], [ImageURL]) VALUES (5, N'Ki Utsuri', N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FUtsuri%2FKi-Utsuri.jpg?alt=media&token=6c22adde-59b6-4bab-8e3e-36bda066228b');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName], [ImageURL]) VALUES (6, N'Asagi', N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FAsagi%2FAsagi.jpg?alt=media&token=06058be9-7fbb-4316-818c-3df56d81a87a');
INSERT INTO [dbo].[Pattern] ([VarietyID], [IsActive], [PatternName], [ImageURL]) VALUES (6, 0, N'Asagi Shusui', N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FAsagi%2FAsagi.jpg?alt=media&token=06058be9-7fbb-4316-818c-3df56d81a87a');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName], [ImageURL]) VALUES (7, N'Shusui', N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FShusui%2FShusui.jpg?alt=media&token=b7cfc9cf-3301-4339-9ee7-de23a0475022');
--Set Inactive
INSERT INTO [dbo].[Pattern] ([VarietyID], [IsActive], [PatternName], [ImageURL]) VALUES (7, 0, N'Doitsu Shusui', N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FShusui%2FShusui.jpg?alt=media&token=b7cfc9cf-3301-4339-9ee7-de23a0475022');
--
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName], [ImageURL]) VALUES (8, N'Yamabuki Ogon', N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FHikari%20Muji%2FOgon%2FYamabuki-Ogon.jpg?alt=media&token=883d442a-75eb-4a31-9477-d08c4611c73f');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName], [ImageURL]) VALUES (8, N'Gin Matsuba', N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FHikari%20Muji%2FMatsuba%2FGin-Matsuba.jpg?alt=media&token=5679c7a0-3ed6-4db9-895f-f84ed77551e2');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName], [ImageURL]) VALUES (4, N'Tancho Kohaku', N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FKohaku%2FTancho-Kohaku.jpg?alt=media&token=8b55c477-d348-4815-b161-38d7fd57e78a');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName], [ImageURL]) VALUES (4, N'Tancho Sanke', N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FKohaku%2FTancho%20Sanke.png?alt=media&token=b82b41b6-e40f-4671-a390-c1181328fa0b');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName], [ImageURL]) VALUES (8, N'Matsuba', N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FHikari%20Muji%2FMatsuba%2FMatsuba.jpg?alt=media&token=2f80db4d-0f43-482e-97f6-a6cf45375a2f');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName], [ImageURL]) VALUES (8, N'Kin Matsuba', N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FHikari%20Muji%2FMatsuba%2FKin-Matsuba.jpg?alt=media&token=d05512e8-4934-4075-a1a6-4e5c84e953c9');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName], [ImageURL]) VALUES (11, N'Goshiki', N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FGoshiki%2FGoshiki.jpg?alt=media&token=fbeeecb5-5b4e-4ab8-a4ee-e9581d181228');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName], [ImageURL]) VALUES (11, N'Goshiki Doitsu', N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FGoshiki%2FDoitsu-Goshiki.jpg?alt=media&token=51e0bc53-c5f4-4bf6-b40e-8213b192f018');
INSERT INTO [dbo].[Pattern] ([VarietyID], [IsActive], [PatternName], [ImageURL]) VALUES (12, 0, N'Yamabuki Ogon', N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FHikari%20Muji%2FOgon%2FYamabuki-Ogon.jpg?alt=media&token=883d442a-75eb-4a31-9477-d08c4611c73f');
INSERT INTO [dbo].[Pattern] ([VarietyID], [IsActive], [PatternName], [ImageURL]) VALUES (12, 0, N'Yamabuki Matsuba', N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FHikari%20Muji%2FMatsuba%2FKin-Matsuba.jpg?alt=media&token=d05512e8-4934-4075-a1a6-4e5c84e953c9');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName], [ImageURL]) VALUES (13, N'Benigoi', N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FBenigoi%2FBenigoi.jpg?alt=media&token=7a929e28-e2c1-4023-892e-fc505327241b');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName], [ImageURL]) VALUES (13, N'Benigoi Doitsu', N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FBenigoi%2FDoitsu-Benigoi.jpg?alt=media&token=1d1492ce-837f-47f2-881e-b90490760c55');
-- Set Inactive
INSERT INTO [dbo].[Pattern] ([VarietyID], [IsActive], [PatternName], [ImageURL]) VALUES (5, 0, N'Ki Utsuri', N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FUtsuri%2FKi-Utsuri.jpg?alt=media&token=6c22adde-59b6-4bab-8e3e-36bda066228b');
--
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName], [ImageURL]) VALUES (15, N'Chagoi', N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FChagoi%2FChagoi.jpg?alt=media&token=674fd910-a553-46d4-bcfa-bfd9a0cfa286');
--Set Inactive
INSERT INTO [dbo].[Pattern] ([VarietyID], [IsActive], [PatternName], [ImageURL]) VALUES (15, 0, N'Chagoi Doitsu', N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FChagoi%2FChagoi%20Doitsu.jpg?alt=media&token=59177106-4e75-4942-8835-0a1ccc81909c');
--
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName], [ImageURL]) VALUES (16, N'Soragoi', N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FSoragoi%2FSoragoi.jpg?alt=media&token=2bb14ebe-77ad-45c0-b8c7-f1e0fb0e7540');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName], [ImageURL]) VALUES (4, N'Doitsu Kohaku', N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FKohaku%2FDoitsu%20Kohaku.png?alt=media&token=1b65e987-5df8-4a5e-8108-546ecc3a527a');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName], [ImageURL]) VALUES (2, N'Doitsu Sanke', N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FSanke%2FDoitsu%20Sanke.png?alt=media&token=6c1f5951-2cbc-45e7-ba7f-25d2627e5fbf');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName], [ImageURL]) VALUES (3, N'Doitsu Showa', N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FShowa%2FDoitsu-Showa.jpg?alt=media&token=bc49cae4-c28b-499e-b430-76577921bf9f');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName], [ImageURL]) VALUES (18, N'Shusui', N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FShusui%2FShusui.jpg?alt=media&token=b7cfc9cf-3301-4339-9ee7-de23a0475022');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName], [ImageURL]) VALUES (8, N'Platinum Ogon', N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FHikari%20Muji%2FOgon%2FPlatinum-Ogon.jpg?alt=media&token=7b3ba4f4-3795-4e48-9af3-f36d88f645d2');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName], [ImageURL]) VALUES (20, N'Shiro Bekko', N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FBekko%2FShiro-Bekko.jpg?alt=media&token=56d3368d-07c1-4d78-87e9-919c163b5c39');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName], [ImageURL]) VALUES (5, N'Doitsu Shiro Utsuri', N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FUtsuri%2FShiro%20Utsuri%2FDoitsu-Shiro-Utsuri.jpg?alt=media&token=3ecfbc0b-dcd0-48ad-ad9c-371b0ec5a0ca');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName], [ImageURL]) VALUES (5, N'Ginrin Shiro Utsuri', N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FUtsuri%2FShiro%20Utsuri%2FGinrin-Shiro-Utsuri.jpg?alt=media&token=9adb852e-7de4-47db-aa1a-9f1aec1bf940');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName], [ImageURL]) VALUES (16, N'Doitsu Soragoi', N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FSoragoi%2FSoragoi.jpg?alt=media&token=2bb14ebe-77ad-45c0-b8c7-f1e0fb0e7540');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName], [ImageURL]) VALUES (18, N'Hana Shusui', N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FShusui%2FHana-Shusui.jpg?alt=media&token=2d77a411-f1bc-407c-84ef-a3a6fbd1823c');
--42
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName], [ImageURL]) VALUES (3, N'Boke Showa', N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FShowa%2FBoke-Showa.jpg?alt=media&token=4e59144d-b00a-414a-84e7-90d8b0fd8402');
--43
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName], [ImageURL]) VALUES (3, N'Showa', N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FShowa%2FShowa.jpg?alt=media&token=ecd3bd82-3e18-4872-82ee-d8a795f5e3de');
--44
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName], [ImageURL]) VALUES (3, N'Tancho Showa', N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FShowa%2FTancho-Showa.jpg?alt=media&token=650aaf76-ce4e-477d-8e02-a947f8e16417');
--45
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName], [ImageURL]) VALUES (3, N'Hi Showa', N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FShowa%2FHi-Showa.jpg?alt=media&token=ecb14507-8102-41de-8939-b8469a15f7f6');
--46
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName], [ImageURL]) VALUES (3, N'Kindai Showa', N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FShowa%2FKindai-Showa.jpg?alt=media&token=25c7fd36-f549-4733-8cda-c14327246c9b');
--47
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName], [ImageURL]) VALUES (3, N'Maruten Showa', N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FShowa%2FMaruten-Showa.jpg?alt=media&token=03a0888f-9807-454d-b9bf-5738677dad47');
--48
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName], [ImageURL]) VALUES (4, N'Inazuma Kohaku', N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FKohaku%2FInazuma-Kohaku.jpg?alt=media&token=7cefd3bf-a48a-42b9-8710-a156023daccc');
--49
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName], [ImageURL]) VALUES (8, N'Orange Ogon', N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FHikari%20Muji%2FOgon%2FOrange-Ogon.jpg?alt=media&token=4f455796-030b-493a-99bd-34f215a3ea84');
--50
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName], [ImageURL]) VALUES (20, N'Aka Bekko', N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FBekko%2FAka-Bekko.jpg?alt=media&token=7e1dc75b-a9dc-4ee6-ab16-df93d75e9e4d');
--51
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName], [ImageURL]) VALUES (20, N'Ki Bekko', N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FBekko%2FKi-Bekko.jpg?alt=media&token=80fb6816-9ca5-4f5b-ac20-4496ab086120');
--52
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName], [ImageURL]) VALUES (15, N'Green Chagoi', N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FChagoi%2FGreen-Chagoi.jpg?alt=media&token=60839930-b284-4428-90db-9f75eff7f97f');
--53
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName], [ImageURL]) VALUES (6, N'Asagi Ginrin', N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FAsagi%2FGinrin-Asagi.jpg?alt=media&token=51a76d75-179c-473f-a8b3-a713ca8a0bdd');
--54
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName], [ImageURL]) VALUES (6, N'Asagi Konjo', N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FAsagi%2FKonjo-Asagi.jpg?alt=media&token=22be26a5-bab5-46ec-959e-4f10de008f93');
--55
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName], [ImageURL]) VALUES (7, N'Hana Shusui', N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FShusui%2FHana-Shusui.jpg?alt=media&token=2d77a411-f1bc-407c-84ef-a3a6fbd1823c');

INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (50, 9, 0.8);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (50, 29, 0.2);

INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (51, 7, 0.7);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (51, 29, 0.3);

INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (52, 19, 1);

INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (53, 4, 0.7);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (53, 28, 0.2);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (53, 9, 0.1);

INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (54, 9, 0.3);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (54, 1, 0.2);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (54, 20, 0.5);
--INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName], [ImageURL]) VALUES (4, N'Inazuma Kohaku', N'');

INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (55, 15, 0.6);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (55, 28, 0.2);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (55, 15, 0.2);

--Aka Bekko, Ki Bekko

--Green Chagoi

--Asagi Ginrin, Asagi Konjo

--Hana Shusui
--INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName], [ImageURL]) VALUES (4, N'Inazuma Kohaku', N'');



--INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (48, 12, 0.5);




-- Xóa pattern này
INSERT INTO [dbo].[Variety] ([VarietyName], [IsActive], [Description]) VALUES ('Koi Shiro Utsuri', 0 ,N'Cá Koi Shiro Utsuri có màu trắng với các đốm đen, thể hiện sự tương phản nổi bật.');
--
INSERT INTO [dbo].[Variety] ([VarietyName], [Description]) VALUES ('Koi Sanke', N'Sanke có màu trắng với các đốm đỏ và đen, mang đến vẻ đẹp cân đối và thanh thoát.');
INSERT INTO [dbo].[Variety] ([VarietyName], [Description]) VALUES ('Koi Showa', N'Showa có nền màu đen với các đốm đỏ và trắng, thể hiện sự mạnh mẽ và cá tính.');
INSERT INTO [dbo].[Variety] ([VarietyName], [Description]) VALUES ('Koi Kohaku', N'Kohaku có nền màu trắng với các đốm đỏ, được coi là dòng cá Koi kinh điển.');
INSERT INTO [dbo].[Variety] ([VarietyName], [Description]) VALUES ('Koi Utsuri', N'Utsuri có nền màu đen với các màu sắc khác, thường mang lại cảm giác bí ẩn và sang trọng.');
INSERT INTO [dbo].[Variety] ([VarietyName], [Description]) VALUES ('Koi Asagi', N'Asagi có màu xanh lam với các đốm đỏ, thường được yêu thích bởi sự thanh lịch.');
INSERT INTO [dbo].[Variety] ([VarietyName], [Description]) VALUES ('Koi Shusui', N'Shusui là một biến thể của Asagi nhưng không có vảy, tạo cảm giác mềm mại và độc đáo.');
INSERT INTO [dbo].[Variety] ([VarietyName], [Description]) VALUES ('Koi Hikari Muji', N'Hikari Muji có màu kim loại đồng nhất, thể hiện sự sang trọng và hiện đại.');
INSERT INTO [dbo].[Variety] ([VarietyName], [IsActive], [Description]) VALUES ('Koi Tancho', 0, N'Tancho có một dấu đỏ trên đầu, mang đến vẻ đẹp thuần khiết và dễ nhận biết.');
INSERT INTO [dbo].[Variety] ([IsActive], [VarietyName], [Description]) VALUES (0, 'Koi Matsuba', N'Matsuba có các đốm màu trên nền màu vàng hoặc trắng, tạo nên vẻ đẹp tự nhiên.');
INSERT INTO [dbo].[Variety] ([VarietyName], [Description]) VALUES ('Koi Goshiki', N'Goshiki có màu xanh đen với các đốm đỏ, trắng và đen, mang lại cảm giác phong phú.');
INSERT INTO [dbo].[Variety] ([VarietyName], [Description]) VALUES ('Koi Yamabuki', N'Yamabuki có màu vàng sáng, biểu thị sự thịnh vượng và may mắn.');
INSERT INTO [dbo].[Variety] ([VarietyName], [Description]) VALUES ('Koi Benigoi', N'Benigoi có màu đỏ đậm, thể hiện sự mạnh mẽ và cá tính.');
-- Pattern của Utsuri
INSERT INTO [dbo].[Variety] ([IsActive], [VarietyName], [Description]) VALUES (0 ,'Koi Ki Utsuri', N'Ki Utsuri có nền màu vàng với các đốm đen, mang lại cảm giác mới mẻ.');
--
INSERT INTO [dbo].[Variety] ([VarietyName], [Description]) VALUES ('Koi Chagoi', N'Chagoi có màu nâu hoặc xanh lá cây, biểu thị sự thân thiện và dễ gần.');
INSERT INTO [dbo].[Variety] ([VarietyName], [Description]) VALUES ('Koi Soragoi', N'Soragoi có màu xám hoặc xanh xám, thường mang lại vẻ đẹp thanh thoát.');
-- Pattern kh phải loại
INSERT INTO [dbo].[Variety] ([IsActive], [VarietyName], [Description]) VALUES (0, 'Koi Doitsu', N'Doitsu có bề mặt trơn và không có vảy, tạo cảm giác hiện đại.');
--
INSERT INTO [dbo].[Variety] ([VarietyName], [Description]) VALUES ('Koi Hikari Shusui', N'Hikari Shusui là một biến thể kim loại của Shusui, thể hiện vẻ đẹp quý phái.');
INSERT INTO [dbo].[Variety] ([IsActive], [VarietyName], [Description]) VALUES (0, 'Koi Platinum', N'Platinum có màu bạc bóng, thể hiện sự sang trọng và thanh lịch.');
INSERT INTO [dbo].[Variety] ([VarietyName], [Description]) VALUES ('Koi Bekko', N'Cá koi bekko thuộc nhóm koi có vẩy đục, trên thân cá là bản giao hưởng màu sắc giữa màu đỏ, vàng, trắng. Có rất nhiều người nhầm lẫn cá koi bekko với cá koi utsuri vì chúng đều sở hữu những chấm đen điểm xuyết trên mình.');

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

ALTER TABLE [dbo].[Advertisement]  WITH CHECK ADD  CONSTRAINT [FK_Advertisement_Element] FOREIGN KEY([ElementID])
REFERENCES [dbo].[Element] ([ElementID])
GO
ALTER TABLE [dbo].[Advertisement] CHECK CONSTRAINT [FK_Advertisement_Element]
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

/****** Object:  Table [dbo].[Blog]    Script Date:   ******/

ALTER TABLE [dbo].[Blog]  WITH CHECK ADD  CONSTRAINT [FK_Blog_Element] FOREIGN KEY([ElementID])
REFERENCES [dbo].[Element] ([ElementID])
GO
ALTER TABLE [dbo].[Blog] CHECK CONSTRAINT [FK_Blog_Element]
GO

/****** Object:  Table [dbo].[Interact]    Script Date:   ******/

ALTER TABLE [dbo].[Interact]  WITH CHECK ADD  CONSTRAINT [FK_Interact_Advertisement] FOREIGN KEY([AdsId])
REFERENCES [dbo].[Advertisement] ([AdsId])
GO
ALTER TABLE [dbo].[Interact] CHECK CONSTRAINT [FK_Interact_Advertisement]
GO

/**** 

Select * from [dbo].[Variety]
Select * from [dbo].[Pattern] where [VarietyID] = 8
Select * from [dbo].[PatternColor] where [PatternID] = 21
Select * from [dbo].[Color]
Select * from [dbo].[Blog]
Select * from [dbo].[User]
--21 25


****/




INSERT INTO [dbo].[Advertisement] 
([AdsTypeId], [UserId], [PackageID], [Title], [Content], [StatusId], [ElementID], [StartedDate], [ExpiredDate], [Duration], [ImageUrl], [CreatedDate], [IsActive]) 
VALUES 
(1, 3, 1, N'Cá Koi Showa Nhật Size Lớn', N'Cá Koi Showa Nhật Size Lớn là một trong những loài cá được ưa chuộng trong thế giới cá Koi. Với bộ ba màu sắc đặc trưng, Showa có vẻ ngoài bắt mắt và hấp dẫn, rất phù hợp để nuôi trong các hồ cá phong thủy.', 5, 3, '2024-11-12', '2025-11-12', 10, N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/Koi_Images%2Fyamabuki-lon.webp?alt=media&token=37b4cdce-c35b-495a-b7da-5cc374e4918b', '2024-11-8', 1),
(2, 4, 2, N'Đồ Phong Thủy Tượng Quan Âm', N'Tượng Quan Âm bằng đá tự nhiên là một trong những món đồ phong thủy được ưa chuộng. Đặt tượng Quan Âm trong nhà giúp thu hút năng lượng tích cực, mang lại bình an và may mắn cho gia đình.', 5, 2, '2024-11-13', '2025-11-13', 7, N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2Fimages.jpg?alt=media&token=5e449d81-616d-49e3-bdb9-dd2a0e8b1510', '2024-11-5', 1),
(1, 5, 1, N'Cá Koi Sanke Nhật Size Lớn', N'Cá Koi Sanke Nhật Size Lớn có màu sắc đặc trưng với ba màu trắng, đỏ và đen. Loài cá này tượng trưng cho sự thịnh vượng và may mắn, là một lựa chọn tuyệt vời cho những ai yêu thích sự tinh tế trong việc trang trí hồ cá.', 5, 3, '2024-11-14', '2025-11-14', 10, N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/Koi_Images%2Fsp-sanke-7488.png?alt=media&token=3bc39ab0-e735-4333-8ec5-4e39b1d66c30', '2024-11-3', 1),
(2, 3, 2, N'Bộ Đồ Phong Thủy Vòng Tay Bát Quái', N'Vòng tay Bát Quái được làm từ đá tự nhiên, mang lại sự bảo vệ và xua đuổi tà khí. Đây là món quà phong thủy tuyệt vời cho những ai muốn tăng cường năng lượng tích cực trong cuộc sống.', 5, 4, '2024-11-15', '2025-11-15', 7, N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2F679620e9fac079d32317cd956b9f2414.jpg?alt=media&token=b9a0da68-e563-4411-b0d8-7d813598c178', '2024-11-8', 1),
(1, 4, 1, N'Cá Koi Kohaku Nhật Size Lớn', N'Cá Koi Kohaku Nhật là một trong những giống cá Koi nổi bật nhất với màu trắng tinh khiết và những đốm đỏ rực rỡ. Đây là loài cá rất phổ biến trong các hồ cá phong thủy.', 5, 3, '2024-11-16', '2025-11-16', 10, N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2Fimages%20(1).jpg?alt=media&token=bcb4d469-b860-4d0f-96f6-983cbd69bec8', '2024-11-7', 1),
(2, 5, 2, N'Đồ Phong Thủy Tượng Rồng', N'Tượng Rồng phong thủy được cho là mang lại sức mạnh, quyền lực và sự thịnh vượng cho gia chủ. Đây là một trong những biểu tượng phong thủy được ưa chuộng trong việc trang trí nhà cửa, văn phòng.', 5, 2, '2024-11-17', '2025-11-17', 7, N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2Ftuong-rong%20(5).JPG?alt=media&token=f0455fe4-3f28-44ff-ba70-8f51cb1a6684', '2024-11-8', 1),
(1, 3, 1, N'Cá Koi Tancho Nhật Size Lớn', N'Cá Koi Tancho là giống cá nổi bật với vết đỏ hình tròn trên đầu. Tancho là biểu tượng của sự thanh cao, mạnh mẽ, và được xem là biểu tượng may mắn trong phong thủy.', 5, 1, '2024-11-18', '2025-11-18', 10, N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/Koi_Images%2Fca-koi-tancho-5ff10c55-deb0-4b26-ae3c-5c27d8cf8c89.webp?alt=media&token=ee04372c-dde4-4829-bc2c-6161a37ea40d', '2024-11-6', 1),
(2, 4, 2, N'Đồ Phong Thủy Mắt Phật', N'Mắt Phật là một vật phẩm phong thủy mạnh mẽ giúp bảo vệ gia đình khỏi những điều xấu, mang lại sự an lành và bình yên. Sản phẩm này thường được sử dụng trong trang trí nhà cửa.', 5, 5, '2024-11-19', '2025-11-19', 7, N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2Fmat-nhu-lai-dai-nhat.jpg?alt=media&token=45b21036-3b45-44fa-9913-c09f39cc228b', '2024-11-2', 1),
(1, 5, 1, N'Cá Koi Ginrin Nhật Size Lớn', N'Cá Koi Ginrin là giống cá Koi có vảy sáng bóng, phản chiếu ánh sáng giống như một viên ngọc quý. Loài cá này mang lại sự may mắn và thịnh vượng cho gia chủ.', 5, 4, '2024-11-20', '2025-11-20', 10, N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/Koi_Images%2Fca-koi-ginrin-kohaku-fbec4a03-65b9-45cb-897d-9675da7b4cb7.webp?alt=media&token=958bb788-06fb-4326-9822-613ded0422b4', '2024-11-10', 1),
(1, 6, 1, N'Cá Koi Tancho - Đặc Trưng Với Chấm Đỏ', N'Cá Koi Tancho nổi bật với chấm đỏ tròn trên đầu. Đây là dòng cá tượng trưng cho Nhật Bản, mang đến vẻ đẹp thanh nhã và truyền thống.', 2, 4, '2024-11-20', '2025-11-20', 10, N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2Fimage_2024-11-14_023122351.png?alt=media&token=0b8156c3-101e-4b0b-906c-6290b7798381', '2024-11-14', 1),
(1, 6, 1, N'Cá Koi Benigoi - Màu Đỏ Rực Rỡ', N'Benigoi là loại cá koi màu đỏ hoàn toàn, tạo sự nổi bật và thu hút ánh nhìn. Đây là dòng cá yêu thích trong hồ để làm nổi bật các yếu tố phong thủy.', 2, 2, '2024-11-20', '2025-11-20', 10, N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2FKoi_fishes%2FBenigoi%2FBenigoi.jpg?alt=media&token=7a929e28-e2c1-4023-892e-fc505327241b', '2024-11-10', 1),
(1, 6, 1, N'Cá Koi Goshiki - Ngũ Sắc Độc Đáo', N'Goshiki là dòng cá koi đặc biệt với sự pha trộn của năm màu sắc, thường có nền trắng với các đốm màu đen, đỏ, xanh, và xám, tạo nên vẻ đẹp riêng biệt.', 2, 5, '2024-11-20', '2025-11-20', 10, N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2Fimage_2024-11-14_022657154.png?alt=media&token=5fe5edd0-2349-40e5-b636-c933a4dc0f4a', '2024-11-11', 1),
(1, 6, 1, N'Cá Koi Ki Utsuri - Tương Phản Đen Vàng', N'Ki Utsuri là loại cá koi với màu nền đen cùng các vệt vàng, tạo nên sự tương phản mạnh mẽ và vẻ đẹp độc đáo cho hồ cá của bạn.', 2, 4, '2024-11-20', '2025-11-20', 10, N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2Fimage_2024-11-14_022805911.png?alt=media&token=ff35bb88-1b4a-4812-99b6-d1d078afbc33', '2024-11-13', 1),
(1, 6, 1, N'Cá Koi Doitsu - Vảy Ít Đặc Trưng', N'Cá Koi Doitsu có đặc điểm là ít vảy, tạo nên vẻ ngoài mượt mà hơn so với các dòng cá koi truyền thống khác. Đây là dòng cá phù hợp cho người yêu thích sự đơn giản.', 2, 2, '2024-11-20', '2025-11-20', 10, N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2Fimage_2024-11-14_022905616.png?alt=media&token=378375ae-12c9-45a2-b0fd-b30bb1bc7276', '2024-11-11', 1),
(1, 6, 1, N'Cá Koi Ochiba - Lá Thu Rơi', N'Ochiba là dòng cá koi với màu nâu và xám, gợi hình ảnh lá thu rơi trên mặt nước. Cá này mang lại cảm giác thanh bình cho hồ cá.', 2, 5, '2024-11-20', '2025-11-20', 10, N'https://firebasestorage.googleapis.com/v0/b/koi-fengshui.appspot.com/o/images%2Fimage_2024-11-14_022959178.png?alt=media&token=65ccae0a-7812-40ea-b356-d382b5067095', '2024-11-12', 1);

USE [master]