USE [master]
GO
/****** Object:  Database [Uchet]    Script Date: 31.03.2025 11:43:41 ******/
CREATE DATABASE [Uchet]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Uchet', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\Uchet.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Uchet_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\Uchet_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [Uchet] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Uchet].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Uchet] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Uchet] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Uchet] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Uchet] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Uchet] SET ARITHABORT OFF 
GO
ALTER DATABASE [Uchet] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [Uchet] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Uchet] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Uchet] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Uchet] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Uchet] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Uchet] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Uchet] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Uchet] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Uchet] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Uchet] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Uchet] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Uchet] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Uchet] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Uchet] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Uchet] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Uchet] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Uchet] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Uchet] SET  MULTI_USER 
GO
ALTER DATABASE [Uchet] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Uchet] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Uchet] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Uchet] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Uchet] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Uchet] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Uchet] SET QUERY_STORE = ON
GO
ALTER DATABASE [Uchet] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [Uchet]
GO
/****** Object:  Table [dbo].[История]    Script Date: 31.03.2025 11:43:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[История](
	[КодПользователя] [int] NULL,
	[Дата] [datetime] NULL,
	[Действие] [varchar](max) NULL,
	[КодИстории] [int] IDENTITY(1,1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[КодИстории] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Оборудование]    Script Date: 31.03.2025 11:43:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Оборудование](
	[КодОборудования] [int] IDENTITY(1,1) NOT NULL,
	[НазваниеОборудования] [nvarchar](100) NULL,
	[ТипОборудования] [nvarchar](50) NULL,
	[СерийныйНомер] [nvarchar](50) NULL,
	[ДатаПокупки] [date] NULL,
	[КодСостояниеОборудования] [int] NOT NULL,
	[КодПоставщика] [int] NOT NULL,
	[Местоположение] [nvarchar](max) NULL,
 CONSTRAINT [PK__Оборудов__E0FA2C6AD0EE3D5B] PRIMARY KEY CLUSTERED 
(
	[КодОборудования] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Пользователи]    Script Date: 31.03.2025 11:43:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Пользователи](
	[КодПользователя] [int] IDENTITY(1,1) NOT NULL,
	[ИмяПользователя] [nvarchar](50) NULL,
	[Пароль] [nvarchar](20) NOT NULL,
	[КодРоли] [int] NOT NULL,
	[ЭлектроннаяПочта] [nvarchar](100) NULL,
	[Телефон] [int] NULL,
	[ФамилияПользователя] [nvarchar](50) NULL,
	[Логин] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK__Пользова__200434A22537E1E9] PRIMARY KEY CLUSTERED 
(
	[КодПользователя] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ПользовательОборудование]    Script Date: 31.03.2025 11:43:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ПользовательОборудование](
	[Код] [int] NOT NULL,
	[КодПользователь] [int] NOT NULL,
	[КодОборудование] [int] NOT NULL,
 CONSTRAINT [PK_ПользовательОборудование] PRIMARY KEY CLUSTERED 
(
	[Код] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Поставщики]    Script Date: 31.03.2025 11:43:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Поставщики](
	[КодПоставщика] [int] IDENTITY(1,1) NOT NULL,
	[НазваниеПоставщика] [nvarchar](100) NOT NULL,
	[КонтактноеЛицо] [nvarchar](100) NULL,
	[Телефон] [nvarchar](20) NULL,
	[ЭлектроннаяПочта] [nvarchar](100) NULL,
	[Адрес] [nvarchar](200) NULL,
	[Код] [int] NOT NULL,
 CONSTRAINT [PK__Поставщи__BF516D74BB05936F] PRIMARY KEY CLUSTERED 
(
	[Код] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Роли]    Script Date: 31.03.2025 11:43:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Роли](
	[КодРоли] [int] IDENTITY(1,1) NOT NULL,
	[НазваниеРоли] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[КодРоли] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[СостояниеОборудования]    Script Date: 31.03.2025 11:43:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[СостояниеОборудования](
	[Код] [int] NOT NULL,
	[Состояние] [nvarchar](50) NULL,
 CONSTRAINT [PK_СостояниеОборудования] PRIMARY KEY CLUSTERED 
(
	[Код] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[История] ON 
GO
INSERT [dbo].[История] ([КодПользователя], [Дата], [Действие], [КодИстории]) VALUES (1, CAST(N'2024-08-29T00:00:00.000' AS DateTime), N'Вход', 1)
GO
INSERT [dbo].[История] ([КодПользователя], [Дата], [Действие], [КодИстории]) VALUES (5, CAST(N'2025-03-27T22:31:59.440' AS DateTime), N'Вход в систему', 2)
GO
INSERT [dbo].[История] ([КодПользователя], [Дата], [Действие], [КодИстории]) VALUES (5, CAST(N'2025-03-27T22:33:17.327' AS DateTime), N'Вход в систему', 3)
GO
INSERT [dbo].[История] ([КодПользователя], [Дата], [Действие], [КодИстории]) VALUES (6, CAST(N'2025-03-27T22:43:08.150' AS DateTime), N'Вход в систему', 4)
GO
INSERT [dbo].[История] ([КодПользователя], [Дата], [Действие], [КодИстории]) VALUES (6, CAST(N'2025-03-27T22:43:30.703' AS DateTime), N'Вход в систему', 5)
GO
INSERT [dbo].[История] ([КодПользователя], [Дата], [Действие], [КодИстории]) VALUES (5, CAST(N'2025-03-27T22:43:33.850' AS DateTime), N'Вход в систему', 6)
GO
INSERT [dbo].[История] ([КодПользователя], [Дата], [Действие], [КодИстории]) VALUES (6, CAST(N'2025-03-27T23:04:41.697' AS DateTime), N'Вход в систему', 7)
GO
INSERT [dbo].[История] ([КодПользователя], [Дата], [Действие], [КодИстории]) VALUES (6, CAST(N'2025-03-27T23:06:15.903' AS DateTime), N'Добавлено оборудование:', 8)
GO
INSERT [dbo].[История] ([КодПользователя], [Дата], [Действие], [КодИстории]) VALUES (6, CAST(N'2025-03-27T23:06:15.903' AS DateTime), N'Добавлено оборудование:', 9)
GO
INSERT [dbo].[История] ([КодПользователя], [Дата], [Действие], [КодИстории]) VALUES (6, CAST(N'2025-03-27T23:06:15.903' AS DateTime), N'Удалено оборудование', 10)
GO
INSERT [dbo].[История] ([КодПользователя], [Дата], [Действие], [КодИстории]) VALUES (6, CAST(N'2025-03-27T23:06:15.903' AS DateTime), N'Изменено оборудование', 11)
GO
INSERT [dbo].[История] ([КодПользователя], [Дата], [Действие], [КодИстории]) VALUES (6, CAST(N'2025-03-27T23:06:15.903' AS DateTime), N'Выход из системы', 12)
GO
INSERT [dbo].[История] ([КодПользователя], [Дата], [Действие], [КодИстории]) VALUES (5, CAST(N'2025-03-27T23:10:16.090' AS DateTime), N'Вход в систему', 13)
GO
INSERT [dbo].[История] ([КодПользователя], [Дата], [Действие], [КодИстории]) VALUES (5, CAST(N'2025-03-27T23:10:32.843' AS DateTime), N'Выход из системы', 14)
GO
INSERT [dbo].[История] ([КодПользователя], [Дата], [Действие], [КодИстории]) VALUES (6, CAST(N'2025-03-29T23:08:12.963' AS DateTime), N'Вход в систему', 15)
GO
INSERT [dbo].[История] ([КодПользователя], [Дата], [Действие], [КодИстории]) VALUES (6, CAST(N'2025-03-29T23:19:21.210' AS DateTime), N'Вход в систему', 16)
GO
INSERT [dbo].[История] ([КодПользователя], [Дата], [Действие], [КодИстории]) VALUES (6, CAST(N'2025-03-29T23:30:24.997' AS DateTime), N'Вход в систему', 17)
GO
INSERT [dbo].[История] ([КодПользователя], [Дата], [Действие], [КодИстории]) VALUES (6, CAST(N'2025-03-29T23:30:37.867' AS DateTime), N'Добавлено оборудование:', 18)
GO
INSERT [dbo].[История] ([КодПользователя], [Дата], [Действие], [КодИстории]) VALUES (6, CAST(N'2025-03-29T23:32:08.293' AS DateTime), N'Вход в систему', 19)
GO
INSERT [dbo].[История] ([КодПользователя], [Дата], [Действие], [КодИстории]) VALUES (6, CAST(N'2025-03-29T23:32:22.230' AS DateTime), N'Добавлено оборудование:', 20)
GO
INSERT [dbo].[История] ([КодПользователя], [Дата], [Действие], [КодИстории]) VALUES (6, CAST(N'2025-03-29T23:32:22.230' AS DateTime), N'Выход из системы', 21)
GO
INSERT [dbo].[История] ([КодПользователя], [Дата], [Действие], [КодИстории]) VALUES (6, CAST(N'2025-03-30T17:43:48.957' AS DateTime), N'Вход в систему', 22)
GO
INSERT [dbo].[История] ([КодПользователя], [Дата], [Действие], [КодИстории]) VALUES (6, CAST(N'2025-03-30T17:45:32.277' AS DateTime), N'Вход в систему', 23)
GO
INSERT [dbo].[История] ([КодПользователя], [Дата], [Действие], [КодИстории]) VALUES (6, CAST(N'2025-03-30T17:49:45.893' AS DateTime), N'Вход в систему', 24)
GO
INSERT [dbo].[История] ([КодПользователя], [Дата], [Действие], [КодИстории]) VALUES (6, CAST(N'2025-03-30T17:50:02.143' AS DateTime), N'Выход из системы', 25)
GO
INSERT [dbo].[История] ([КодПользователя], [Дата], [Действие], [КодИстории]) VALUES (5, CAST(N'2025-03-30T18:11:11.373' AS DateTime), N'Вход в систему', 26)
GO
INSERT [dbo].[История] ([КодПользователя], [Дата], [Действие], [КодИстории]) VALUES (5, CAST(N'2025-03-30T18:18:25.857' AS DateTime), N'Вход в систему', 27)
GO
INSERT [dbo].[История] ([КодПользователя], [Дата], [Действие], [КодИстории]) VALUES (5, CAST(N'2025-03-30T18:19:39.380' AS DateTime), N'Вход в систему', 28)
GO
INSERT [dbo].[История] ([КодПользователя], [Дата], [Действие], [КодИстории]) VALUES (5, CAST(N'2025-03-30T19:08:45.670' AS DateTime), N'Вход в систему', 29)
GO
INSERT [dbo].[История] ([КодПользователя], [Дата], [Действие], [КодИстории]) VALUES (5, CAST(N'2025-03-30T19:13:12.150' AS DateTime), N'Вход в систему', 30)
GO
INSERT [dbo].[История] ([КодПользователя], [Дата], [Действие], [КодИстории]) VALUES (5, CAST(N'2025-03-30T19:13:19.987' AS DateTime), N'Выход из системы', 31)
GO
INSERT [dbo].[История] ([КодПользователя], [Дата], [Действие], [КодИстории]) VALUES (5, CAST(N'2025-03-30T19:13:27.853' AS DateTime), N'Вход в систему', 32)
GO
INSERT [dbo].[История] ([КодПользователя], [Дата], [Действие], [КодИстории]) VALUES (5, CAST(N'2025-03-30T19:14:30.220' AS DateTime), N'Вход в систему', 33)
GO
INSERT [dbo].[История] ([КодПользователя], [Дата], [Действие], [КодИстории]) VALUES (6, CAST(N'2025-03-31T00:16:07.770' AS DateTime), N'Вход в систему', 34)
GO
INSERT [dbo].[История] ([КодПользователя], [Дата], [Действие], [КодИстории]) VALUES (6, CAST(N'2025-03-31T00:17:49.357' AS DateTime), N'Выход из системы', 35)
GO
INSERT [dbo].[История] ([КодПользователя], [Дата], [Действие], [КодИстории]) VALUES (6, CAST(N'2025-03-31T00:36:19.803' AS DateTime), N'Вход в систему', 36)
GO
INSERT [dbo].[История] ([КодПользователя], [Дата], [Действие], [КодИстории]) VALUES (6, CAST(N'2025-03-31T00:36:30.747' AS DateTime), N'Выход из системы', 37)
GO
SET IDENTITY_INSERT [dbo].[История] OFF
GO
SET IDENTITY_INSERT [dbo].[Оборудование] ON 
GO
INSERT [dbo].[Оборудование] ([КодОборудования], [НазваниеОборудования], [ТипОборудования], [СерийныйНомер], [ДатаПокупки], [КодСостояниеОборудования], [КодПоставщика], [Местоположение]) VALUES (4, N'Принтер HP LaserJet Pro M404', N'Принтер', N'HP12345XYZ', CAST(N'2023-01-15' AS Date), 1, 101, N'Москва, офис №2')
GO
INSERT [dbo].[Оборудование] ([КодОборудования], [НазваниеОборудования], [ТипОборудования], [СерийныйНомер], [ДатаПокупки], [КодСостояниеОборудования], [КодПоставщика], [Местоположение]) VALUES (5, N'Ноутбук Dell Inspiron 15', N'Ноутбук', N'D123-INSPIR', CAST(N'2022-10-22' AS Date), 2, 102, N'Санкт-Петербург, склад №3')
GO
INSERT [dbo].[Оборудование] ([КодОборудования], [НазваниеОборудования], [ТипОборудования], [СерийныйНомер], [ДатаПокупки], [КодСостояниеОборудования], [КодПоставщика], [Местоположение]) VALUES (6, N'Сканер Canon DR-C225', N'Сканер', N'C225SCAN789', CAST(N'2023-03-05' AS Date), 1, 103, N'Новосибирск, офис №1')
GO
INSERT [dbo].[Оборудование] ([КодОборудования], [НазваниеОборудования], [ТипОборудования], [СерийныйНомер], [ДатаПокупки], [КодСостояниеОборудования], [КодПоставщика], [Местоположение]) VALUES (7, N'Ноутбук Dell Inspiron 17', N'Ноутбук', N'D123-INSPIR', CAST(N'2022-10-22' AS Date), 2, 102, N'Санкт-Петербург, склад №3')
GO
INSERT [dbo].[Оборудование] ([КодОборудования], [НазваниеОборудования], [ТипОборудования], [СерийныйНомер], [ДатаПокупки], [КодСостояниеОборудования], [КодПоставщика], [Местоположение]) VALUES (9, N'Ноутбук Dell Inspiron 18', N'Ноутбук', N'D123-INSPIR', CAST(N'2022-10-22' AS Date), 2, 103, N'Санкт-Петербург, склад №3')
GO
INSERT [dbo].[Оборудование] ([КодОборудования], [НазваниеОборудования], [ТипОборудования], [СерийныйНомер], [ДатаПокупки], [КодСостояниеОборудования], [КодПоставщика], [Местоположение]) VALUES (10, N'Ноутбук Dell Inspiron 19', N'Ноутбук', N'D123-INSPIR', CAST(N'2022-10-22' AS Date), 2, 102, N'Санкт-Петербург, склад №3')
GO
SET IDENTITY_INSERT [dbo].[Оборудование] OFF
GO
SET IDENTITY_INSERT [dbo].[Пользователи] ON 
GO
INSERT [dbo].[Пользователи] ([КодПользователя], [ИмяПользователя], [Пароль], [КодРоли], [ЭлектроннаяПочта], [Телефон], [ФамилияПользователя], [Логин]) VALUES (5, N'Екатерина', N'123', 1, NULL, NULL, N'Чугунова', N'admin')
GO
INSERT [dbo].[Пользователи] ([КодПользователя], [ИмяПользователя], [Пароль], [КодРоли], [ЭлектроннаяПочта], [Телефон], [ФамилияПользователя], [Логин]) VALUES (6, N'Сотрудник', N'321', 2, N'', NULL, N'Соколов', N'employe')
GO
INSERT [dbo].[Пользователи] ([КодПользователя], [ИмяПользователя], [Пароль], [КодРоли], [ЭлектроннаяПочта], [Телефон], [ФамилияПользователя], [Логин]) VALUES (9, N'Екатерина2', N'123', 2, N'', NULL, N'Чугунова2', N'admin')
GO
SET IDENTITY_INSERT [dbo].[Пользователи] OFF
GO
SET IDENTITY_INSERT [dbo].[Поставщики] ON 
GO
INSERT [dbo].[Поставщики] ([КодПоставщика], [НазваниеПоставщика], [КонтактноеЛицо], [Телефон], [ЭлектроннаяПочта], [Адрес], [Код]) VALUES (1, N'ООО ТехноСнаб', N'Иван Петров', N'+7-495-123-4567', N'ivan.petrov@technosnab.ru', N'Москва, ул. Ленина, д. 10', 101)
GO
INSERT [dbo].[Поставщики] ([КодПоставщика], [НазваниеПоставщика], [КонтактноеЛицо], [Телефон], [ЭлектроннаяПочта], [Адрес], [Код]) VALUES (2, N'ЗАО Индустрия', N'Екатерина Смирнова', N'+7-812-987-6543', N'e.smirnova@industriya.ru', N'Санкт-Петербург, пр-т Невский, д. 25', 102)
GO
INSERT [dbo].[Поставщики] ([КодПоставщика], [НазваниеПоставщика], [КонтактноеЛицо], [Телефон], [ЭлектроннаяПочта], [Адрес], [Код]) VALUES (3, N'ИП Васильев', N'Павел Васильев', N'+7-495-654-7890', N'pavel.vasilyev@ipvasiliev.ru', N'Новосибирск, ул. Кирова, д. 5', 103)
GO
SET IDENTITY_INSERT [dbo].[Поставщики] OFF
GO
SET IDENTITY_INSERT [dbo].[Роли] ON 
GO
INSERT [dbo].[Роли] ([КодРоли], [НазваниеРоли]) VALUES (1, N'Администратор')
GO
INSERT [dbo].[Роли] ([КодРоли], [НазваниеРоли]) VALUES (2, N'Сотрудник')
GO
SET IDENTITY_INSERT [dbo].[Роли] OFF
GO
INSERT [dbo].[СостояниеОборудования] ([Код], [Состояние]) VALUES (1, N'В эксплуатации')
GO
INSERT [dbo].[СостояниеОборудования] ([Код], [Состояние]) VALUES (2, N'На ремонте')
GO
ALTER TABLE [dbo].[Оборудование]  WITH CHECK ADD  CONSTRAINT [FK_Оборудование_Поставщики] FOREIGN KEY([КодПоставщика])
REFERENCES [dbo].[Поставщики] ([Код])
GO
ALTER TABLE [dbo].[Оборудование] CHECK CONSTRAINT [FK_Оборудование_Поставщики]
GO
ALTER TABLE [dbo].[Оборудование]  WITH CHECK ADD  CONSTRAINT [FK_Оборудование_СостояниеОборудования] FOREIGN KEY([КодСостояниеОборудования])
REFERENCES [dbo].[СостояниеОборудования] ([Код])
GO
ALTER TABLE [dbo].[Оборудование] CHECK CONSTRAINT [FK_Оборудование_СостояниеОборудования]
GO
ALTER TABLE [dbo].[Пользователи]  WITH CHECK ADD  CONSTRAINT [FK_Пользователи_Роли] FOREIGN KEY([КодРоли])
REFERENCES [dbo].[Роли] ([КодРоли])
GO
ALTER TABLE [dbo].[Пользователи] CHECK CONSTRAINT [FK_Пользователи_Роли]
GO
ALTER TABLE [dbo].[ПользовательОборудование]  WITH CHECK ADD  CONSTRAINT [FK_ПользовательОборудование_Оборудование] FOREIGN KEY([КодОборудование])
REFERENCES [dbo].[Оборудование] ([КодОборудования])
GO
ALTER TABLE [dbo].[ПользовательОборудование] CHECK CONSTRAINT [FK_ПользовательОборудование_Оборудование]
GO
ALTER TABLE [dbo].[ПользовательОборудование]  WITH CHECK ADD  CONSTRAINT [FK_ПользовательОборудование_Пользователи] FOREIGN KEY([КодПользователь])
REFERENCES [dbo].[Пользователи] ([КодПользователя])
GO
ALTER TABLE [dbo].[ПользовательОборудование] CHECK CONSTRAINT [FK_ПользовательОборудование_Пользователи]
GO
USE [master]
GO
ALTER DATABASE [Uchet] SET  READ_WRITE 
GO
