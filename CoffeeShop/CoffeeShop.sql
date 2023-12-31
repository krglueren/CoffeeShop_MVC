USE [master]
GO
/****** Object:  Database [CoffeeShop]    Script Date: 13.6.2023 19:08:41 ******/
CREATE DATABASE [CoffeeShop]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CoffeeShop', FILENAME = N'C:\Users\PC\CoffeeShop.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'CoffeeShop_log', FILENAME = N'C:\Users\PC\CoffeeShop_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [CoffeeShop] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CoffeeShop].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CoffeeShop] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [CoffeeShop] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [CoffeeShop] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [CoffeeShop] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [CoffeeShop] SET ARITHABORT OFF 
GO
ALTER DATABASE [CoffeeShop] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [CoffeeShop] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [CoffeeShop] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [CoffeeShop] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [CoffeeShop] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [CoffeeShop] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [CoffeeShop] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [CoffeeShop] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [CoffeeShop] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [CoffeeShop] SET  DISABLE_BROKER 
GO
ALTER DATABASE [CoffeeShop] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [CoffeeShop] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [CoffeeShop] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [CoffeeShop] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [CoffeeShop] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [CoffeeShop] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [CoffeeShop] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [CoffeeShop] SET RECOVERY FULL 
GO
ALTER DATABASE [CoffeeShop] SET  MULTI_USER 
GO
ALTER DATABASE [CoffeeShop] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [CoffeeShop] SET DB_CHAINING OFF 
GO
ALTER DATABASE [CoffeeShop] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [CoffeeShop] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [CoffeeShop] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [CoffeeShop] SET QUERY_STORE = OFF
GO
USE [CoffeeShop]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
USE [CoffeeShop]
GO
/****** Object:  Table [dbo].[Basket]    Script Date: 13.6.2023 19:08:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Basket](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IpAddress] [nvarchar](50) NULL,
	[CofeeId] [int] NULL,
	[number] [int] NULL,
 CONSTRAINT [PK_Basket] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[coffees]    Script Date: 13.6.2023 19:08:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[coffees](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CofeeName] [nvarchar](100) NULL,
	[CofeePrice] [int] NULL,
	[CofeeImagePath] [nvarchar](250) NULL,
	[CofeeDescription] [nvarchar](250) NULL,
	[CoffeeType] [bit] NULL,
 CONSTRAINT [PK_coffees] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderDetail]    Script Date: 13.6.2023 19:08:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetail](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[OrderId] [int] NULL,
	[OrderCofeeId] [int] NULL,
 CONSTRAINT [PK_OrderDetail] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 13.6.2023 19:08:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[OrderCustomerFullName] [nvarchar](50) NULL,
	[OrderAddress] [nvarchar](300) NULL,
	[OrderDate] [datetime] NULL,
	[OrderTotalPrice] [int] NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 13.6.2023 19:08:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Fullname] [nvarchar](60) NULL,
	[mail] [nvarchar](50) NULL,
	[password] [nvarchar](50) NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[coffees] ON 

INSERT [dbo].[coffees] ([Id], [CofeeName], [CofeePrice], [CofeeImagePath], [CofeeDescription], [CoffeeType]) VALUES (1, N'Latte1', 500, N'images/416345b4-91b4-43bd-906d-9d4f3ed842a6.jpg', N'Latte1 Açıklama', 0)
INSERT [dbo].[coffees] ([Id], [CofeeName], [CofeePrice], [CofeeImagePath], [CofeeDescription], [CoffeeType]) VALUES (5, N'Test', 750, N'images/f9248a4e-f905-455d-b152-6a84979d6d83.jpg', N'test açıklama', 1)
SET IDENTITY_INSERT [dbo].[coffees] OFF
GO
SET IDENTITY_INSERT [dbo].[OrderDetail] ON 

INSERT [dbo].[OrderDetail] ([Id], [OrderId], [OrderCofeeId]) VALUES (1, 8, 1)
INSERT [dbo].[OrderDetail] ([Id], [OrderId], [OrderCofeeId]) VALUES (2, 2, 1)
INSERT [dbo].[OrderDetail] ([Id], [OrderId], [OrderCofeeId]) VALUES (3, 2, 5)
INSERT [dbo].[OrderDetail] ([Id], [OrderId], [OrderCofeeId]) VALUES (4, 3, 5)
INSERT [dbo].[OrderDetail] ([Id], [OrderId], [OrderCofeeId]) VALUES (5, 4, 1)
INSERT [dbo].[OrderDetail] ([Id], [OrderId], [OrderCofeeId]) VALUES (6, 5, 5)
INSERT [dbo].[OrderDetail] ([Id], [OrderId], [OrderCofeeId]) VALUES (7, 6, 1)
INSERT [dbo].[OrderDetail] ([Id], [OrderId], [OrderCofeeId]) VALUES (8, 6, 1)
INSERT [dbo].[OrderDetail] ([Id], [OrderId], [OrderCofeeId]) VALUES (9, 7, 1)
INSERT [dbo].[OrderDetail] ([Id], [OrderId], [OrderCofeeId]) VALUES (10, 7, 5)
INSERT [dbo].[OrderDetail] ([Id], [OrderId], [OrderCofeeId]) VALUES (11, 8, 1)
INSERT [dbo].[OrderDetail] ([Id], [OrderId], [OrderCofeeId]) VALUES (12, 9, 1)
SET IDENTITY_INSERT [dbo].[OrderDetail] OFF
GO
SET IDENTITY_INSERT [dbo].[Orders] ON 

INSERT [dbo].[Orders] ([Id], [OrderCustomerFullName], [OrderAddress], [OrderDate], [OrderTotalPrice]) VALUES (1, N'Fevzi Uzun', N'tuzla', CAST(N'2023-06-03T00:00:00.000' AS DateTime), 230)
INSERT [dbo].[Orders] ([Id], [OrderCustomerFullName], [OrderAddress], [OrderDate], [OrderTotalPrice]) VALUES (2, N'ad soyad', N'adre', CAST(N'2023-06-13T00:00:00.000' AS DateTime), 2250)
INSERT [dbo].[Orders] ([Id], [OrderCustomerFullName], [OrderAddress], [OrderDate], [OrderTotalPrice]) VALUES (3, N'ad soyad2', N'adres2', CAST(N'2023-06-13T00:00:00.000' AS DateTime), 750)
INSERT [dbo].[Orders] ([Id], [OrderCustomerFullName], [OrderAddress], [OrderDate], [OrderTotalPrice]) VALUES (4, N'ad soyad3', N'adres3', CAST(N'2023-06-13T00:00:00.000' AS DateTime), 1000)
INSERT [dbo].[Orders] ([Id], [OrderCustomerFullName], [OrderAddress], [OrderDate], [OrderTotalPrice]) VALUES (5, N'ad soyad4', N'adres4', CAST(N'2023-06-13T00:00:00.000' AS DateTime), 750)
INSERT [dbo].[Orders] ([Id], [OrderCustomerFullName], [OrderAddress], [OrderDate], [OrderTotalPrice]) VALUES (6, N'ad soyad5', N'adres5', CAST(N'2023-06-13T00:00:00.000' AS DateTime), 1000)
INSERT [dbo].[Orders] ([Id], [OrderCustomerFullName], [OrderAddress], [OrderDate], [OrderTotalPrice]) VALUES (7, N'ad soyad6', N'adres6', CAST(N'2023-06-13T00:00:00.000' AS DateTime), 1750)
INSERT [dbo].[Orders] ([Id], [OrderCustomerFullName], [OrderAddress], [OrderDate], [OrderTotalPrice]) VALUES (8, N'test4', N'test4', CAST(N'2023-06-13T00:00:00.000' AS DateTime), 1000)
INSERT [dbo].[Orders] ([Id], [OrderCustomerFullName], [OrderAddress], [OrderDate], [OrderTotalPrice]) VALUES (9, N'ad soyad7', N'adres7', CAST(N'2023-06-13T00:00:00.000' AS DateTime), 2500)
SET IDENTITY_INSERT [dbo].[Orders] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([Id], [Fullname], [mail], [password]) VALUES (1, N'Yasin Efe', N'yasinefe@gmail.com', N'1234')
INSERT [dbo].[Users] ([Id], [Fullname], [mail], [password]) VALUES (2, N'test', N'test@test.com', N'test')
INSERT [dbo].[Users] ([Id], [Fullname], [mail], [password]) VALUES (3, N'test2', N'test2@test2.com', N'test2')
INSERT [dbo].[Users] ([Id], [Fullname], [mail], [password]) VALUES (4, N'test3', N'test3@test3.com', N'test3')
INSERT [dbo].[Users] ([Id], [Fullname], [mail], [password]) VALUES (5, N'test4', N'test4@test3.com', N'test4')
INSERT [dbo].[Users] ([Id], [Fullname], [mail], [password]) VALUES (6, N'test5', N'test5@test3.com', N'test5')
INSERT [dbo].[Users] ([Id], [Fullname], [mail], [password]) VALUES (7, N'test10', N'test10@test.com', N'test10')
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
USE [master]
GO
ALTER DATABASE [CoffeeShop] SET  READ_WRITE 
GO
