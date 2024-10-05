USE [master]
GO

--DROP DATABASE [SWP391FengShuiKoiSystem]

/****** Object:  Database [SWP391FengShuiKoiSystem]    Script Date: 24/09/24 7:10PM  ******/
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
	[Password] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[Bio] [nvarchar](250) NULL,
	[ImageUrl] [nvarchar](250) NULL,
	[IsActive] [bit] NULL,
	[Role] [varchar](25) NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
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
	[UserId] [int] NOT NULL,
	[PackageID] [int] NOT NULL,
	[Title] [nvarchar](50) NULL,
	[Content] [nvarchar](500) NULL,
	[Status] [nvarchar] (50) NOT NULL,
	[ElementID] [int] NOT NULL,
	[ExpiredDate] [datetime] NOT NULL,
	[ImageUrl] [nvarchar](250) NULL,
	[PaymentStatus] [bit] NULL,
 CONSTRAINT [PK_Advertisement] PRIMARY KEY CLUSTERED 
(
	[AdsId] ASC
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
	[Price] [decimal](18, 2) NULL,
 CONSTRAINT [PK_PackageID] PRIMARY KEY CLUSTERED 
(
	[PackageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Package]    Script Date: 24/09/24 7:10PM  ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Transaction](
	[TransactionID] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[AdsId] [int] NOT NULL,
	[PackageID] [int] NOT NULL,
	[FromDate] [datetime] NOT NULL,
	[ToDate] [datetime] NOT NULL,
	[PaymentMethod] [nvarchar] (50) NOT NULL,
	[TransactionDate] [datetime] NOT NULL,
	[TotalPrice] [decimal](18, 2) NULL,
 CONSTRAINT [PK_Transaction] PRIMARY KEY CLUSTERED 
(
	[TransactionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([UserId],[UserName],[Password],[Email],[Bio],[ImageUrl],[IsActive],[Role]) VALUES (1, N'Admin', N'1', N'None', N'This is an Admin account', N'None', 1, 'Admin')
INSERT [dbo].[User] ([UserId],[UserName],[Password],[Email],[Bio],[ImageUrl],[IsActive],[Role]) VALUES (2, N'Laazy', N'1', N'None', N'HungDepTrai', N'None', 1, 'Admin')
INSERT [dbo].[User] ([UserId],[UserName],[Password],[Email],[Bio],[ImageUrl],[IsActive],[Role]) VALUES (3, N'User1', N'1', N'None', N'This is an User account', N'None', 1, 'User')
INSERT [dbo].[User] ([UserId],[UserName],[Password],[Email],[Bio],[ImageUrl],[IsActive],[Role]) VALUES (4, N'User2', N'2', N'None', N'This is an User account', N'None', 1, 'User')
INSERT [dbo].[User] ([UserId],[UserName],[Password],[Email],[Bio],[ImageUrl],[IsActive],[Role]) VALUES (5, N'User3', N'3', N'None', N'This is an User account', N'None', 1, 'User')

SET IDENTITY_INSERT [dbo].[User] OFF
GO
SET IDENTITY_INSERT [dbo].[Advertisement] ON 

INSERT [dbo].[Advertisement] ([AdsId],[UserId],[PackageID],[Title],[Content],[Status],[ElementID],[ExpiredDate],[ImageUrl],[PaymentStatus]) VALUES (1,3,1,N'Tiêu đề Quảng cáo #1',N'Nội dung quảng cáo #1',N'Approve',1,CAST(N'2024-09-24T00:00:00.000' AS DateTime),N'None',0)
INSERT [dbo].[Advertisement] ([AdsId],[UserId],[PackageID],[Title],[Content],[Status],[ElementID],[ExpiredDate],[ImageUrl],[PaymentStatus]) VALUES (2,4,1,N'Tiêu đề Quảng cáo #2',N'Nội dung quảng cáo #2',N'Deploying',2,CAST(N'2024-09-25T00:00:00.000' AS DateTime),N'None',1)
INSERT [dbo].[Advertisement] ([AdsId],[UserId],[PackageID],[Title],[Content],[Status],[ElementID],[ExpiredDate],[ImageUrl],[PaymentStatus]) VALUES (3,4,2,N'Tiêu đề Quảng cáo #3',N'Nội dung quảng cáo #3',N'Waiting',3,CAST(N'2024-09-25T00:00:00.000' AS DateTime),N'None',1)
INSERT [dbo].[Advertisement] ([AdsId],[UserId],[PackageID],[Title],[Content],[Status],[ElementID],[ExpiredDate],[ImageUrl],[PaymentStatus]) VALUES (4,5,2,N'Tiêu đề Quảng cáo #4',N'Nội dung quảng cáo #4',N'Expired',4,CAST(N'2024-09-24T00:00:00.000' AS DateTime),N'None',1)

SET IDENTITY_INSERT [dbo].[Advertisement] OFF
GO
SET IDENTITY_INSERT [dbo].[Package] ON 

INSERT [dbo].[Package] ([PackageID],[PackageName],[Price]) VALUES (1,N'Normal Package',20000)
INSERT [dbo].[Package] ([PackageID],[PackageName],[Price]) VALUES (2,N'Exclusive Package',50000)

SET IDENTITY_INSERT [dbo].[Package] OFF
GO
SET IDENTITY_INSERT [dbo].[Transaction] ON 

INSERT [dbo].[Transaction] ([TransactionID],[UserId],[AdsId],[PackageID],[FromDate],[ToDate],[PaymentMethod],[TransactionDate],[TotalPrice]) VALUES (1,3,1,1,CAST(N'2024-09-20T00:00:00.000' AS DateTime),CAST(N'2024-09-30T00:00:00.000' AS DateTime),N'QRCODE',CAST(N'2024-09-19T00:00:00.000' AS DateTime),250000)
INSERT [dbo].[Transaction] ([TransactionID],[UserId],[AdsId],[PackageID],[FromDate],[ToDate],[PaymentMethod],[TransactionDate],[TotalPrice]) VALUES (2,4,2,1,CAST(N'2024-09-20T00:00:00.000' AS DateTime),CAST(N'2024-09-29T00:00:00.000' AS DateTime),N'QRCODE',CAST(N'2024-09-19T00:00:00.000' AS DateTime),300000)
INSERT [dbo].[Transaction] ([TransactionID],[UserId],[AdsId],[PackageID],[FromDate],[ToDate],[PaymentMethod],[TransactionDate],[TotalPrice]) VALUES (3,4,3,2,CAST(N'2024-09-20T00:00:00.000' AS DateTime),CAST(N'2024-09-29T00:00:00.000' AS DateTime),N'QRCODE',CAST(N'2024-09-19T00:00:00.000' AS DateTime),600000)
INSERT [dbo].[Transaction] ([TransactionID],[UserId],[AdsId],[PackageID],[FromDate],[ToDate],[PaymentMethod],[TransactionDate],[TotalPrice]) VALUES (4,5,4,2,CAST(N'2024-09-20T00:00:00.000' AS DateTime),CAST(N'2024-09-30T00:00:00.000' AS DateTime),N'QRCODE',CAST(N'2024-09-19T00:00:00.000' AS DateTime),500000)

SET IDENTITY_INSERT [dbo].[Transaction] OFF
GO

<<<<<<< Updated upstream
=======
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
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (1, 1, 3);  -- Trắng
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (1, 2, 3);  -- Xám
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (1, 3, 3);  -- Ghi
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (1, 4, 3);  -- Bạc
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (1, 5, 3);  -- Vàng ánh kim

INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (1, 6, 2);  -- Vàng nhạt
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (1, 7, 2);  -- Vàng đậm
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (1, 14, 2); -- Nâu nhạt
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (1, 15, 2); -- Nâu đậm

INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (1, 12, -2); -- Đỏ
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (1, 11, -2); -- Hồng
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (1, 13, -2); -- Tím
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (1, 9, -2);  -- Cam

INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (1, 1, -3);  -- Trắng
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (1, 2, -3);  -- Xám
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (1, 3, -3);  -- Ghi
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (1, 4, -3);  -- Bạc
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (1, 5, -3);  -- Vàng ánh kim

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

INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (5, 29, -3); -- Đen
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (5, 20, -3); -- Xanh dương
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (5, 27, -3); -- Xanh biển
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (5, 28, -3); -- Xanh da trời

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

INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (2, 6, -2);  -- Vàng?
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (2, 7, -2);  -- Nâu?
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (2, 15, -2);  -- Nâu đậm

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

INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (3, 17, -2); -- Xanh lá cây
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (3, 18, -2); -- Xanh lục

INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (3, 29, -3); -- Đen
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (3, 20, -3); -- Xanh dương
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (3, 27, -3); -- Xanh biển
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (3, 28, -3); -- Xanh da trời

-- Mệnh Thổ (ElementID = 5)
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (4, 6, 3);  -- Vàng nhạt
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (4, 7, 3);  -- Vàng đậm
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (4, 14, 3); -- Nâu nhạt
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (4, 15, 3); -- Nâu đậm

INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (4, 8, 2);  -- Vàng đất
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (4, 16, 2); -- Nâu đất

INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (4, 17, -2); -- Xanh lá cây
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (4, 18, -2); -- Xanh lục

INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (4, 12, -3); -- Đỏ
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (4, 11, -3); -- Hồng
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (4, 13, -3); -- Tím
INSERT INTO [dbo].[ElementColor] ([ElementID], [ColorID], [Values]) VALUES (4, 9, -3);  -- Cam

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

INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (1, 1, 0.6);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (1, 29, 0.4);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (2, 6, 0.5);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (2, 1, 0.25);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (2, 29, 0.25);
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
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (14, 20, 0.6);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (14, 1, 0.3);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (14, 12, 0.1);
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
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (28, 7, 0.6);
INSERT INTO [dbo].[PatternColor] ([PatternID], [ColorID], [Values]) VALUES (28, 29, 0.4);
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

INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName]) VALUES (1, 'Shiro Utsuri');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName]) VALUES (1, 'Yamabuki Shiro Utsuri');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName]) VALUES (2, 'Taisho Sanke');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName]) VALUES (2, 'Yamato Nishiki');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName]) VALUES (3, 'Showa Sanke');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName]) VALUES (3, 'Yamabuki Showa');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName]) VALUES (4, 'Kohaku');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName]) VALUES (4, 'Kohaku Maruten');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName]) VALUES (5, 'Shiro Utsuri');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName]) VALUES (5, 'Aka Utsuri');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName]) VALUES (5, 'Ki Utsuri');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName]) VALUES (6, 'Asagi');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName]) VALUES (6, 'Asagi Shusui');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName]) VALUES (7, 'Shusui');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName]) VALUES (7, 'Doitsu Shusui');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName]) VALUES (8, 'Hikari Muji');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName]) VALUES (8, 'Hikari Matsuba');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName]) VALUES (9, 'Tancho Kohaku');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName]) VALUES (9, 'Tancho Sanke');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName]) VALUES (10, 'Matsuba');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName]) VALUES (10, 'Ki Matsuba');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName]) VALUES (11, 'Goshiki');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName]) VALUES (11, 'Goshiki Doitsu');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName]) VALUES (12, 'Yamabuki Ogon');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName]) VALUES (12, 'Yamabuki Matsuba');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName]) VALUES (13, 'Benigoi');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName]) VALUES (13, 'Benigoi Doitsu');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName]) VALUES (14, 'Ki Utsuri');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName]) VALUES (15, 'Chagoi');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName]) VALUES (15, 'Chagoi Doitsu');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName]) VALUES (16, 'Soragoi');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName]) VALUES (17, 'Doitsu Kohaku');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName]) VALUES (17, 'Doitsu Sanke');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName]) VALUES (17, 'Doitsu Showa');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName]) VALUES (18, 'Hikari Shusui');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName]) VALUES (19, 'Platinum Ogon');
INSERT INTO [dbo].[Pattern] ([VarietyID], [PatternName]) VALUES (20, 'Shiro Bekko');

INSERT INTO [dbo].[Variety] ([VarietyName], [Description]) VALUES ('Koi Shiro Utsuri', N'Cá Koi Shiro Utsuri có màu trắng với các đốm đen, thể hiện sự tương phản nổi bật.');
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
INSERT INTO [dbo].[Variety] ([VarietyName], [Description]) VALUES ('Koi Ki Utsuri', N'Ki Utsuri có nền màu vàng với các đốm đen, mang lại cảm giác mới mẻ.');
INSERT INTO [dbo].[Variety] ([VarietyName], [Description]) VALUES ('Koi Chagoi', N'Chagoi có màu nâu hoặc xanh lá cây, biểu thị sự thân thiện và dễ gần.');
INSERT INTO [dbo].[Variety] ([VarietyName], [Description]) VALUES ('Koi Soragoi', N'Soragoi có màu xám hoặc xanh xám, thường mang lại vẻ đẹp thanh thoát.');
INSERT INTO [dbo].[Variety] ([VarietyName], [Description]) VALUES ('Koi Doitsu', N'Doitsu có bề mặt trơn và không có vảy, tạo cảm giác hiện đại.');
INSERT INTO [dbo].[Variety] ([VarietyName], [Description]) VALUES ('Koi Hikari Shusui', N'Hikari Shusui là một biến thể kim loại của Shusui, thể hiện vẻ đẹp quý phái.');
INSERT INTO [dbo].[Variety] ([VarietyName], [Description]) VALUES ('Koi Platinum', N'Platinum có màu bạc bóng, thể hiện sự sang trọng và thanh lịch.');
INSERT INTO [dbo].[Variety] ([VarietyName], [Description]) VALUES ('Koi Shiro Bekko', N'Shiro Bekko có nền màu trắng với các đốm đen, mang lại sự thanh lịch và tinh khiết.');


/****** ========================================================================================================================================================================================================================================================================================================================================================================  ******/
>>>>>>> Stashed changes
/****** Object:  Table [dbo].[[Advertisement]]    Script Date: 24/09/24 7:10PM  ******/

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

ALTER TABLE [dbo].[Transaction]  WITH CHECK ADD  CONSTRAINT [FK_Transaction_Package] FOREIGN KEY([PackageID])
REFERENCES [dbo].[Package] ([PackageID])
GO
ALTER TABLE [dbo].[Transaction] CHECK CONSTRAINT [FK_Transaction_Package]
GO


select * from [dbo].[User]
select * from [dbo].[Package]
select * from [dbo].[Advertisement]
select * from [dbo].[Transaction]