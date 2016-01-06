USE [master]
GO

IF  EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = 'TestDVDLibrary')
DROP DATABASE [TestDVDLibrary]
GO

/****** Object:  Database [TestDVDLibrary]    Script Date: 12/2/2015 5:30:09 AM ******/
CREATE DATABASE [TestDVDLibrary]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'TestDVDLibrary', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\TestDVDLibrary.mdf' , SIZE = 3264KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'TestDVDLibrary_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\TestDVDLibrary_log.ldf' , SIZE = 816KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [TestDVDLibrary] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [TestDVDLibrary].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [TestDVDLibrary] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [TestDVDLibrary] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [TestDVDLibrary] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [TestDVDLibrary] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [TestDVDLibrary] SET ARITHABORT OFF 
GO
ALTER DATABASE [TestDVDLibrary] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [TestDVDLibrary] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [TestDVDLibrary] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [TestDVDLibrary] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [TestDVDLibrary] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [TestDVDLibrary] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [TestDVDLibrary] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [TestDVDLibrary] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [TestDVDLibrary] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [TestDVDLibrary] SET  ENABLE_BROKER 
GO
ALTER DATABASE [TestDVDLibrary] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [TestDVDLibrary] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [TestDVDLibrary] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [TestDVDLibrary] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [TestDVDLibrary] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [TestDVDLibrary] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [TestDVDLibrary] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [TestDVDLibrary] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [TestDVDLibrary] SET  MULTI_USER 
GO
ALTER DATABASE [TestDVDLibrary] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [TestDVDLibrary] SET DB_CHAINING OFF 
GO
ALTER DATABASE [TestDVDLibrary] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [TestDVDLibrary] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [TestDVDLibrary] SET DELAYED_DURABILITY = DISABLED 
GO
USE [TestDVDLibrary]
GO
/****** Object:  Table [dbo].[Actors]    Script Date: 12/2/2015 5:30:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Actors](
	[ActorID] [int] IDENTITY(1,1) NOT NULL,
	[ActorName] [nvarchar](100) NOT NULL,
	[ActorTMDBNum] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ActorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ActorsMovies]    Script Date: 12/2/2015 5:30:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ActorsMovies](
	[ActorID] [int] NOT NULL,
	[MovieID] [int] NOT NULL,
	[CharacterName] [nvarchar](50) NULL,
 CONSTRAINT [PK_ActorsMovies] PRIMARY KEY CLUSTERED 
(
	[ActorID] ASC,
	[MovieID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Borrowers]    Script Date: 12/2/2015 5:30:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Borrowers](
	[BorrowerID] [int] IDENTITY(1,1) NOT NULL,
	[IsOwner] [bit] NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](100) NOT NULL,
	[StreetAddress] [nvarchar](100) NULL,
	[City] [nvarchar](100) NULL,
	[State] [nvarchar](100) NULL,
	[Zipcode] [nvarchar](10) NULL,
	[Phone] [nvarchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[BorrowerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BorrowerStatuses]    Script Date: 12/2/2015 5:30:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BorrowerStatuses](
	[BorrowerStatusID] [int] IDENTITY(1,1) NOT NULL,
	[BorrowerID] [int] NOT NULL,
	[DVDID] [int] NOT NULL,
	[DateBorrowed] [date] NOT NULL,
	[DateReturned] [date] NULL,
	[DVDExists] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[BorrowerStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DeletedDVDs]    Script Date: 12/2/2015 5:30:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DeletedDVDs](
	[DVDID] [int] NOT NULL,
	[MovieID] [int] NOT NULL,
	[DVDType] [nvarchar](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[DVDID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Directors]    Script Date: 12/2/2015 5:30:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Directors](
	[DirectorID] [int] IDENTITY(1,1) NOT NULL,
	[DirectorName] [nvarchar](100) NOT NULL,
	[DirectorTMDBNum] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[DirectorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DVDs]    Script Date: 12/2/2015 5:30:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DVDs](
	[DVDID] [int] IDENTITY(1,1) NOT NULL,
	[MovieID] [int] NOT NULL,
	[DVDType] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[DVDID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Genres]    Script Date: 12/2/2015 5:30:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Genres](
	[GenreID] [int] IDENTITY(1,1) NOT NULL,
	[GenreName] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[GenreID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[GenresMovies]    Script Date: 12/2/2015 5:30:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GenresMovies](
	[GenreID] [int] NOT NULL,
	[MovieID] [int] NOT NULL,
 CONSTRAINT [PK_GenresMovies] PRIMARY KEY CLUSTERED 
(
	[GenreID] ASC,
	[MovieID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MovieAliases]    Script Date: 12/2/2015 5:30:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MovieAliases](
	[MovieAliasID] [int] IDENTITY(1,1) NOT NULL,
	[MovieID] [int] NOT NULL,
	[MovieAlias] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MovieAliasID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Movies]    Script Date: 12/2/2015 5:30:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Movies](
	[MovieID] [int] IDENTITY(1,1) NOT NULL,
	[DirectorID] [int] NULL,
	[StudioID] [int] NULL,
	[MovieTitle] [nvarchar](100) NOT NULL,
	[MovieTMDBNum] [int] NOT NULL,
	[Rating] [nvarchar](10) NULL,
	[ReleaseDate] [date] NOT NULL,
	[DurationInMin] [int] NOT NULL,
	[Synopsis] [nvarchar](500) NOT NULL,
	[PosterUrl] [nvarchar](200) NULL,
	[YouTubeTrailer] [nvarchar](200) NULL,
	[InCollection] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MovieID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Studios]    Script Date: 12/2/2015 5:30:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Studios](
	[StudioID] [int] IDENTITY(1,1) NOT NULL,
	[StudioName] [nvarchar](50) NOT NULL,
	[StudioTMDBNum] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[StudioID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UserNotes]    Script Date: 12/2/2015 5:30:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserNotes](
	[UserNoteID] [int] IDENTITY(1,1) NOT NULL,
	[BorrowerID] [int] NOT NULL,
	[MovieID] [int] NOT NULL,
	[Note] [nvarchar](500) NOT NULL,
	[OwnerNote] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserNoteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UserRatings]    Script Date: 12/2/2015 5:30:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRatings](
	[UserRatingID] [int] IDENTITY(1,1) NOT NULL,
	[BorrowerID] [int] NOT NULL,
	[MovieID] [int] NOT NULL,
	[Rating] [int] NOT NULL,
	[OwnerRating] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserRatingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Actors] ON 

INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (1, N'Mark Hamill', 2)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (2, N'Harrison Ford', 3)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (3, N'Carrie Fisher', 4)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (4, N'Peter Cushing', 5)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (5, N'Alec Guinness', 12248)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (6, N'Anthony Daniels', 6)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (7, N'Kenny Baker', 130)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (8, N'Peter Mayhew', 24343)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (9, N'David Prowse', 24342)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (10, N'Phil Brown', 33032)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (11, N'Billy Dee Williams', 3799)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (12, N'James Earl Jones', 15152)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (13, N'Frank Oz', 7908)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (14, N'Ian McDiarmid', 27762)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (15, N'Sebastian Shaw', 28235)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (16, N'Rumi Hiiragi', 19587)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (17, N'Miyu Irino', 19588)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (18, N'Mari Natsuki', 19589)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (19, N'Takashi Naitô', 19590)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (20, N'Yasuko Sawaguchi', 19591)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (21, N'Tatsuya Gashûin', 19592)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (22, N'Yumi Tamai', 19594)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (23, N'Yo Oizumi', 40450)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (24, N'Koba Hayashi', 554423)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (25, N'Tsunehiko Kamijô', 20334)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (26, N'Yōji Matsuda', 622)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (27, N'Yuriko Ishida', 20330)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (28, N'Yūko Tanaka', 20331)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (29, N'Kaoru Kobayashi', 20332)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (30, N'Masahiko Nishimura', 20333)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (31, N'Sumi Shimamoto', 613)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (32, N'Tetsu Watanabe', 20335)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (33, N'Mitsuru Satô', 20336)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (34, N'Akira Nagoya', 20337)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (35, N'Takuya Kimura', 12670)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (36, N'Akihiro Miwa', 20338)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (37, N'Mitsunori Isaki', 40449)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (38, N'Akio Ôtsuka', 40451)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (39, N'Daijiro Harada', 40452)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (40, N'Haruko Kato', 40453)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (41, N'Ryunosuke Kamiki', 225730)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (42, N'Chieko Baishô', 533325)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (43, N'Mahito Tsujimura', 614)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (44, N'Hisako Kyōda', 615)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (45, N'Gorō Naya', 616)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (46, N'Ichirō Nagai', 617)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (47, N'Kōhei Miyauchi', 618)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (48, N'Jôji Yanami', 619)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (49, N'Minoru Yada', 620)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (50, N'Rihoko Yoshida', 621)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (51, N'Tom Hanks', 31)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (52, N'Tim Allen', 12898)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (53, N'Don Rickles', 7167)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (54, N'Jim Varney', 12899)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (55, N'Wallace Shawn', 12900)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (56, N'John Ratzenberger', 7907)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (57, N'Annie Potts', 8873)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (58, N'John Morris', 1116442)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (59, N'Erik von Detten', 12901)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (60, N'Laurie Metcalf', 12133)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (61, N'Ned Beatty', 13726)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (62, N'Joan Cusack', 3234)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (63, N'Michael Keaton', 2232)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (64, N'Whoopi Goldberg', 2395)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (65, N'Bonnie Hunt', 5149)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (66, N'Kelsey Grammer', 7090)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (67, N'Wayne Knight', 4201)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (68, N'Arnold Schwarzenegger', 1100)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (69, N'Linda Hamilton', 2713)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (70, N'Edward Furlong', 820)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (71, N'Robert Patrick', 418)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (72, N'Earl Boen', 2716)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (73, N'Joe Morton', 3977)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (74, N'S. Epatha Merkerson', 3978)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (75, N'Castulo Guerra', 3979)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (76, N'Danny Cooksey', 3980)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (77, N'Jenette Goldstein', 3981)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (78, N'Michael Biehn', 2712)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (79, N'Paul Winfield', 1818)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (80, N'Lance Henriksen', 2714)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (81, N'Bess Motta', 2715)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (82, N'Rick Rossovich', 2717)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (83, N'Bill Paxton', 2053)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (84, N'Brian Thompson', 2719)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (85, N'Marlon Brando', 3084)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (86, N'Al Pacino', 1158)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (87, N'James Caan', 3085)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (88, N'Richard S. Castellano', 3086)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (89, N'Robert Duvall', 3087)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (90, N'Sterling Hayden', 3088)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (91, N'John Marley', 3142)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (92, N'Richard Conte', 3090)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (93, N'Al Lettieri', 3091)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (94, N'Diane Keaton', 3092)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (95, N'Robert De Niro', 380)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (96, N'John Cazale', 3096)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (97, N'Talia Shire', 3094)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (98, N'Lee Strasberg', 3171)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (99, N'Michael V. Gazzo', 3172)
GO
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (100, N'G. D. Spradlin', 3173)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (101, N'Richard Bright', 3174)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (102, N'Michael J. Fox', 521)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (103, N'Christopher Lloyd', 1062)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (104, N'Lea Thompson', 1063)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (105, N'Crispin Glover', 1064)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (106, N'Thomas F. Wilson', 1065)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (107, N'Claudia Wells', 1066)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (108, N'Marc McClure', 1067)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (109, N'Wendie Jo Sperber', 1068)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (110, N'George DiCenzo', 1069)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (111, N'Frances Lee McCain', 1070)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (112, N'Mary Steenburgen', 2453)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (113, N'Elisabeth Shue', 1951)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (114, N'James Tolkan', 1072)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (115, N'Matt Clark', 2454)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (116, N'Christopher Wynne', 2455)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (117, N'Sean Sullivan', 2456)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (118, N'Jeffrey Weissman', 1952)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (119, N'Casey Siemaszko', 1953)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (120, N'Billy Zane', 1954)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (121, N'Darlene Vogel', 1955)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (122, N'Elijah Wood', 109)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (123, N'Sally Field', 35)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (124, N'Robin Wright', 32)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (125, N'Mykelti Williamson', 34)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (126, N'Gary Sinise', 33)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (127, N'Michael Conner Humphreys', 37821)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (128, N'Hanna Hall', 204997)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (129, N'Haley Joel Osment', 9640)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (130, N'Siobhan Fallon', 6751)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (131, N'Afemo Omilami', 37825)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (132, N'Ben Affleck', 880)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (133, N'Jennifer Lopez', 16866)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (134, N'Justin Bartha', 21180)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (135, N'Lainie Kazan', 53647)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (136, N'Lenny Venito', 37157)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (137, N'Missy Crider', 53646)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (138, N'Christopher Walken', 4690)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (139, N'Terry Camilleri', 18359)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (140, N'David Backus', 111243)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (141, N'Sam Neill', 4783)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (142, N'Laura Dern', 4784)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (143, N'Jeff Goldblum', 4785)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (144, N'Richard Attenborough', 4786)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (145, N'Bob Peck', 4789)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (146, N'Martin Ferrero', 4790)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (147, N'Joseph Mazzello', 4787)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (148, N'Ariana Richards', 4788)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (149, N'Samuel L. Jackson', 2231)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (150, N'BD Wong', 14592)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (151, N'Christian Bale', 3894)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (152, N'Heath Ledger', 1810)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (153, N'Aaron Eckhart', 6383)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (154, N'Michael Caine', 3895)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (155, N'Maggie Gyllenhaal', 1579)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (156, N'Gary Oldman', 64)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (157, N'Morgan Freeman', 192)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (158, N'Ron Dean', 57597)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (159, N'Cillian Murphy', 2037)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (160, N'Chin Han', 101015)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (161, N'Anne Hathaway', 1813)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (162, N'Tom Hardy', 2524)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (163, N'Marion Cotillard', 8293)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (164, N'Joseph Gordon-Levitt', 24045)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (165, N'Juno Temple', 36594)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (166, N'Rutger Hauer', 585)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (167, N'Sean Young', 586)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (168, N'Edward James Olmos', 587)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (169, N'Daryl Hannah', 589)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (170, N'William Sanderson', 590)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (171, N'Brion James', 591)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (172, N'Joe Turkel', 592)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (173, N'Joanna Cassidy', 593)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (174, N'James Hong', 20904)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (175, N'Liam Neeson', 3896)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (176, N'Katie Holmes', 3897)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (177, N'Tom Wilkinson', 207)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (178, N'Ken Watanabe', 3899)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (179, N'John Travolta', 8891)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (180, N'Uma Thurman', 139)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (181, N'Bruce Willis', 62)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (182, N'Ving Rhames', 10182)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (183, N'Harvey Keitel', 1037)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (184, N'Eric Stoltz', 7036)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (185, N'Tim Roth', 3129)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (186, N'Amanda Plummer', 99)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (187, N'Maria de Medeiros', 2319)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (188, N'Famke Janssen', 10696)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (189, N'Maggie Grace', 11825)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (190, N'Katie Cassidy', 55775)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (191, N'Holly Valance', 55776)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (192, N'Xander Berkeley', 3982)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (193, N'Olivier Rabourdin', 49278)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (194, N'Leland Orser', 2221)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (195, N'Jon Gries', 9629)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (196, N'Camille Japy', 35893)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (197, N'Owen Wilson', 887)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (198, N'Vince Vaughn', 4937)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (199, N'Rachel McAdams', 53714)
GO
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (200, N'Isla Fisher', 52848)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (201, N'Jane Seymour', 10223)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (202, N'Bradley Cooper', 51329)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (203, N'Henry Gibson', 19439)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (204, N'Keir O''Donnell', 39213)
INSERT [dbo].[Actors] ([ActorID], [ActorName], [ActorTMDBNum]) VALUES (205, N'David Conrad', 43479)
SET IDENTITY_INSERT [dbo].[Actors] OFF
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (1, 1, N'Luke Skywalker')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (1, 2, N'Luke Skywalker')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (1, 3, N'Luke Skywalker')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (2, 1, N'Han Solo')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (2, 2, N'Han Solo')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (2, 3, N'Han Solo')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (2, 23, N'Rick Deckard')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (3, 1, N'Leia Organa')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (3, 2, N'Princess Leia')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (3, 3, N'Princess Leia')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (4, 1, N'Grand Moff Tarkin')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (5, 1, N'Obi-Wan Kenobi')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (6, 1, N'C-3PO')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (6, 2, N'C-3PO')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (6, 3, N'C-3PO')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (7, 1, N'R2-D2')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (7, 2, N'R2-D2')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (8, 1, N'Chewbacca')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (8, 2, N'Chewbacca')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (8, 3, N'Chewbacca')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (9, 1, N'Darth Vader')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (9, 2, N'Darth Vader')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (10, 1, N'Uncle Owen')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (11, 2, N'Lando Calrissian')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (11, 3, N'Lando Calrissian')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (12, 2, N'Darth Vader (Voice)')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (12, 3, N'Voice of Darth Vader (voice)')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (13, 2, N'Yoda (Voice)')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (13, 3, N'Yoda (voice)')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (14, 3, N'The Emperor')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (15, 3, N'Anakin Skywalker')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (16, 4, N'Chihiro')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (17, 4, N'Haku')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (18, 4, N'Yubaba')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (19, 4, N'Chihiro''s Father')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (20, 4, N'Chihiro''s Mother')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (21, 4, N'Aogaeru')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (21, 6, N'Karushifâ')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (22, 4, N'Lin')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (23, 4, N'Bandai-gaeru')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (23, 6, N'Kakashi no Kabu')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (24, 4, N'Kawa no Kami')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (25, 4, N'Chichiyaku')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (25, 5, N'Gonza')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (26, 5, N'Ashitaka')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (26, 7, N'Asbel (Voice)')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (27, 5, N'San')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (28, 5, N'Eboshi-gozen')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (29, 5, N'Jiko-bô')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (30, 5, N'Kouroku')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (31, 5, N'Toki')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (31, 7, N'Nausicaä (Voice)')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (32, 5, N'Yama-inu')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (33, 5, N'Tatari-gami')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (34, 5, N'Usi-kai')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (35, 6, N'Hauru')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (36, 6, N'Arechi no Majo')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (37, 6, N'Koshô')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (38, 6, N'Kokuô')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (39, 6, N'Hin')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (40, 6, N'Sariman')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (41, 6, N'Marukuru')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (42, 6, N'Sofi')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (43, 7, N'Jihl (Voice)')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (44, 7, N'Oh-Baba (Voice)')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (45, 7, N'Yupa (Voice)')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (46, 7, N'Mito (Voice)')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (47, 7, N'Goru (Voice)')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (48, 7, N'Gikkuri (Voice)')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (49, 7, N'Niga (Voice)')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (50, 7, N'Teto / Girl C (Voice)')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (51, 8, N'Woody (voice)')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (51, 9, N'Woody (voice)')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (51, 10, N'Woody (voice)')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (51, 18, N'Forrest Gump')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (52, 8, N'Buzz Lightyear (voice)')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (52, 9, N'Buzz Lightyear (voice)')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (52, 10, N'Buzz Lightyear (voice)')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (53, 8, N'Mr. Potato Head (voice)')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (53, 9, N'Mr. Potato Head (voice)')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (53, 10, N'Mr. Potato Head (voice)')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (54, 8, N'Slinky Dog (voice)')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (54, 10, N'Slinky Dog (voice)')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (55, 8, N'Rex (voice)')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (55, 9, N'Rex (voice)')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (55, 10, N'Rex the Green Dinosaur (voice)')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (56, 8, N'Hamm (voice)')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (56, 9, N'Hamm (voice)')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (56, 10, N'Hamm the Piggy Bank (voice)')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (57, 8, N'Bo Peep (voice)')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (57, 10, N'Bo Peep (voice)')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (58, 8, N'Andy (voice)')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (59, 8, N'Sid (voice)')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (60, 8, N'Andy''s Mom (voice)')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (61, 9, N'Lotso (voice)')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (62, 9, N'Jessie the Yodeling Cowgirl (voice)')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (62, 10, N'Jessie, the Yodeling Cowgirl (voice)')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (63, 9, N'Ken (voice)')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (64, 9, N'Stretch the Octopus (voice)')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (65, 9, N'Purple-haired doll (voice)')
GO
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (66, 10, N'Stinky Pete the Prospector (voice)')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (67, 10, N'Al the Toy Collector (voice)')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (68, 11, N'The Terminator')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (68, 12, N'The Terminator')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (69, 11, N'Sarah Connor')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (69, 12, N'Sarah Connor')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (70, 11, N'John Connor')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (71, 11, N'T-1000')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (72, 11, N'Dr. Peter Silberman')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (72, 12, N'Dr. Peter Silberman')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (73, 11, N'Dr. Miles Bennett Dyson')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (74, 11, N'Tarissa Dyson')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (75, 11, N'Enrique Salceda')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (76, 11, N'Tim')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (77, 11, N'Janelle Voight')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (78, 12, N'Kyle Reese')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (79, 12, N'Lieutenant Ed Traxler')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (80, 12, N'Detective Vukovich')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (81, 12, N'Ginger Ventura')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (82, 12, N'Matt Buchanan')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (83, 12, N'Punk Leader')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (84, 12, N'Punk')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (85, 13, N'Don Vito Corleone')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (86, 13, N'Michael Corleone')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (86, 14, N'Don Michael Corleone')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (86, 19, N'Starkman')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (87, 13, N'Santino ''Sonny'' Corleone')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (88, 13, N'Pete Clemenza')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (89, 13, N'Tom Hagen')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (89, 14, N'Tom Hagen')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (90, 13, N'Capt. Mark McCluskey')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (91, 13, N'Jack Woltz')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (92, 13, N'Emilio Barzini')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (93, 13, N'Virgil ''Der Türke'' Sollozzo')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (94, 13, N'Kay Adams')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (94, 14, N'Kay Corleone')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (95, 14, N'Vito Corleone')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (96, 14, N'Fredo Corleone')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (97, 14, N'Connie Corleone')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (98, 14, N'Hyman Roth')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (99, 14, N'Frankie Pentangeli')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (100, 14, N'Senator Pat Geary')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (101, 14, N'Al Neri')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (102, 15, N'Marty McFly')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (102, 16, N'Marty McFly / Seamus McFly')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (102, 17, N'Marty McFly Sr. / Marty McFly Jr. / Marlene McFly')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (103, 15, N'Dr. Emmett Brown')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (103, 16, N'Dr. Emmett Brown')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (103, 17, N'Dr. Emmett Brown')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (104, 15, N'Lorraine Baines McFly')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (104, 16, N'Maggie McFly / Lorraine McFly')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (104, 17, N'Lorraine')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (105, 15, N'George McFly')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (106, 15, N'Biff Tannen')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (106, 16, N'Buford ''Mad Dog'' Tannen/Biff Tannen')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (107, 15, N'Jennifer Parker')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (108, 15, N'Dave McFly')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (109, 15, N'Linda McFly')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (110, 15, N'Sam Baines')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (111, 15, N'Stella Baines')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (112, 16, N'Clara Clayton')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (113, 16, N'Jennifer Parker')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (113, 17, N'Jennifer Parker / Jennifer McFly')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (114, 16, N'Marshal James Strickland')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (114, 17, N'Mr. Strickland')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (115, 16, N'Chester the Bartender')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (116, 16, N'Buford Tannen''s Gang / Needles'' Gang')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (117, 16, N'Buford Tannen''s Gang (as Sean Gregory Sullivan)')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (118, 17, N'George McFly')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (119, 17, N'3-D')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (120, 17, N'Match')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (121, 17, N'Spike')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (122, 17, N'Video Game Boy')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (123, 18, N'Mrs. Gump')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (124, 18, N'Jenny Curran')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (125, 18, N'Pvt. Benjamin Buford ''Bubba'' Blue')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (126, 18, N'Lt. Dan Taylor')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (127, 18, N'Young Forrest Gump')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (128, 18, N'Young Jenny Curran')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (129, 18, N'Forrest Gump Jr.')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (130, 18, N'School Bus Driver')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (131, 18, N'Drill Sergeant')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (132, 19, N'Larry Gigli')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (133, 19, N'Ricki')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (134, 19, N'Brian')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (135, 19, N'Mother')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (136, 19, N'Louis')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (137, 19, N'Robin')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (138, 19, N'Det. Stanley Jacobellis')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (138, 27, N'Secretary William Cleary')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (139, 19, N'Man in Dryer')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (140, 19, N'Laundry Customer')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (141, 20, N'Dr. Alan Grant')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (142, 20, N'Dr. Ellie Sattler')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (143, 20, N'Dr. Ian Malcolm')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (144, 20, N'John Hammond')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (145, 20, N'Robert Muldoon')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (146, 20, N'Donald Gennaro')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (147, 20, N'Tim Murphy')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (148, 20, N'Lex Murphy')
GO
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (149, 20, N'Ray Arnold')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (149, 25, N'Jules Winfield')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (150, 20, N'Henry Wu')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (151, 21, N'Bruce Wayne')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (151, 22, N'Bruce Wayne / Batman')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (151, 24, N'Bruce Wayne / Batman')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (152, 21, N'Joker')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (153, 21, N'Harvey Dent')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (154, 21, N'Alfred')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (154, 22, N'Alfred')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (154, 24, N'Alfred Pennyworth')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (155, 21, N'Rachel Dawes')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (156, 21, N'Lt. James Gordon')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (156, 22, N'Commissioner Gordon')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (156, 24, N'Jim Gordon')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (157, 21, N'Lucius Fox')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (157, 22, N'Fox')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (157, 24, N'Lucius Fox')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (158, 21, N'Wuertz')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (159, 21, N'Scarecrow')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (159, 22, N'Dr. Jonathan Crane / Scarecrow')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (159, 24, N'Dr. Jonathan Crane / The Scarecrow')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (160, 21, N'Lau')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (161, 22, N'Selina Kyle')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (162, 22, N'Bane')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (163, 22, N'Miranda')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (164, 22, N'Blake')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (165, 22, N'Jen')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (166, 23, N'Roy Batty')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (166, 24, N'Earle')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (167, 23, N'Rachael')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (168, 23, N'Gaff')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (169, 23, N'Pris')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (170, 23, N'J.F. Sebastian')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (171, 23, N'Leon Kowalski')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (172, 23, N'Eldon Tyrell')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (173, 23, N'Zhora')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (174, 23, N'Hannibal Chew')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (175, 24, N'Henri Ducard')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (175, 26, N'Bryan')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (176, 24, N'Rachel Dawes')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (177, 24, N'Carmine Falcone')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (178, 24, N'Ra''s Al Ghul')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (179, 25, N'Vincent Vega')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (180, 25, N'Mia Wallace')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (181, 25, N'Butch Coolidge')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (182, 25, N'Marsellus Wallace')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (183, 25, N'Wolf')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (184, 25, N'Lance')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (185, 25, N'Pumpkin')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (186, 25, N'Honey Bunny')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (187, 25, N'Fabienne')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (188, 26, N'Lenore')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (189, 26, N'Kim')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (190, 26, N'Amanda')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (191, 26, N'Sheerah')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (192, 26, N'Stuart')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (193, 26, N'Jean-Claude')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (194, 26, N'Sam')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (195, 26, N'Casey')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (196, 26, N'Isabelle')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (197, 27, N'John Beckwith')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (198, 27, N'Jeremy Grey')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (199, 27, N'Claire Cleary')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (200, 27, N'Gloria Cleary')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (201, 27, N'Kathleen Cleary')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (202, 27, N'Zachary ''Sack'' Lodge')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (203, 27, N'Father O''Neil')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (204, 27, N'Todd Cleary')
INSERT [dbo].[ActorsMovies] ([ActorID], [MovieID], [CharacterName]) VALUES (205, 27, N'Trap')
SET IDENTITY_INSERT [dbo].[Borrowers] ON 

INSERT [dbo].[Borrowers] ([BorrowerID], [IsOwner], [FirstName], [LastName], [Email], [StreetAddress], [City], [State], [Zipcode], [Phone]) VALUES (1, 1, N'Dean', N'Choi', N'deanchoi@gmail.com', N'8993 Crooked Creek Ln', N'Broadview Heights', N'OH', N'44147', N'440-263-5132')
INSERT [dbo].[Borrowers] ([BorrowerID], [IsOwner], [FirstName], [LastName], [Email], [StreetAddress], [City], [State], [Zipcode], [Phone]) VALUES (2, 0, N'Karen', N'Choi', N'kchoi19@gmail.com', N'1001 Michigan Ave', N'Buffalo', N'NY', N'22498', N'440-382-4155')
INSERT [dbo].[Borrowers] ([BorrowerID], [IsOwner], [FirstName], [LastName], [Email], [StreetAddress], [City], [State], [Zipcode], [Phone]) VALUES (3, 0, N'Ben', N'Choi', N'bchoi56@gmail.com', N'8993 Crooked Creek Ln', N'Broadview Heights', N'OH', N'44147', N'440-915-3592')
INSERT [dbo].[Borrowers] ([BorrowerID], [IsOwner], [FirstName], [LastName], [Email], [StreetAddress], [City], [State], [Zipcode], [Phone]) VALUES (4, 0, N'Jim', N'Shaw', N'jimxshaw@gmail.com', N'4545 Big Horn Dr', N'Dallas', N'TX', N'77980', N'999-444-5555')
INSERT [dbo].[Borrowers] ([BorrowerID], [IsOwner], [FirstName], [LastName], [Email], [StreetAddress], [City], [State], [Zipcode], [Phone]) VALUES (5, 0, N'Chary', N'Gurney', N'charygurney@gmail.com', N'2323 Leafy Ln', N'Stow', N'OH', N'44477', N'440-222-3333')
INSERT [dbo].[Borrowers] ([BorrowerID], [IsOwner], [FirstName], [LastName], [Email], [StreetAddress], [City], [State], [Zipcode], [Phone]) VALUES (6, 0, N'Patty', N'Beauchamp', N'pattrick.beauchamp@gmail.com', N'401 Lofts', N'Orlando', N'FL', N'34983', N'3109993388')
INSERT [dbo].[Borrowers] ([BorrowerID], [IsOwner], [FirstName], [LastName], [Email], [StreetAddress], [City], [State], [Zipcode], [Phone]) VALUES (7, 0, N'Denzel', N'Washington', N'denzelwashington@baller.com', N'1337 Baller St', N'Baller Town', N'NY', N'10001', N'201-555-1337')
INSERT [dbo].[Borrowers] ([BorrowerID], [IsOwner], [FirstName], [LastName], [Email], [StreetAddress], [City], [State], [Zipcode], [Phone]) VALUES (8, 0, N'Barack', N'Obama', N'obama@whitehouse.gov', N'1600 Pennsylvania Ave NW', N'Washington', N'DC', N'20500', N'201-333-1337')
INSERT [dbo].[Borrowers] ([BorrowerID], [IsOwner], [FirstName], [LastName], [Email], [StreetAddress], [City], [State], [Zipcode], [Phone]) VALUES (9, 0, N'LeBron', N'James', N'lbj@nike.com', N'1234 Championship Ave', N'Akron', N'OH', N'44303', N'330-999-1337')
SET IDENTITY_INSERT [dbo].[Borrowers] OFF
SET IDENTITY_INSERT [dbo].[BorrowerStatuses] ON 

INSERT [dbo].[BorrowerStatuses] ([BorrowerStatusID], [BorrowerID], [DVDID], [DateBorrowed], [DateReturned], [DVDExists]) VALUES (1, 1, 1, CAST(N'2015-12-02' AS Date), CAST(N'2015-12-02' AS Date), NULL)
INSERT [dbo].[BorrowerStatuses] ([BorrowerStatusID], [BorrowerID], [DVDID], [DateBorrowed], [DateReturned], [DVDExists]) VALUES (2, 1, 2, CAST(N'2015-12-02' AS Date), CAST(N'2015-12-02' AS Date), NULL)
INSERT [dbo].[BorrowerStatuses] ([BorrowerStatusID], [BorrowerID], [DVDID], [DateBorrowed], [DateReturned], [DVDExists]) VALUES (3, 8, 3, CAST(N'2015-12-02' AS Date), CAST(N'2015-12-02' AS Date), NULL)
INSERT [dbo].[BorrowerStatuses] ([BorrowerStatusID], [BorrowerID], [DVDID], [DateBorrowed], [DateReturned], [DVDExists]) VALUES (4, 4, 10, CAST(N'2015-12-02' AS Date), CAST(N'2015-12-02' AS Date), NULL)
INSERT [dbo].[BorrowerStatuses] ([BorrowerStatusID], [BorrowerID], [DVDID], [DateBorrowed], [DateReturned], [DVDExists]) VALUES (5, 6, 11, CAST(N'2015-12-02' AS Date), CAST(N'2015-12-02' AS Date), NULL)
INSERT [dbo].[BorrowerStatuses] ([BorrowerStatusID], [BorrowerID], [DVDID], [DateBorrowed], [DateReturned], [DVDExists]) VALUES (6, 7, 12, CAST(N'2015-12-02' AS Date), CAST(N'2015-12-02' AS Date), NULL)
INSERT [dbo].[BorrowerStatuses] ([BorrowerStatusID], [BorrowerID], [DVDID], [DateBorrowed], [DateReturned], [DVDExists]) VALUES (7, 9, 1, CAST(N'2015-12-02' AS Date), CAST(N'2015-12-02' AS Date), NULL)
INSERT [dbo].[BorrowerStatuses] ([BorrowerStatusID], [BorrowerID], [DVDID], [DateBorrowed], [DateReturned], [DVDExists]) VALUES (8, 9, 1, CAST(N'2015-12-02' AS Date), NULL, NULL)
INSERT [dbo].[BorrowerStatuses] ([BorrowerStatusID], [BorrowerID], [DVDID], [DateBorrowed], [DateReturned], [DVDExists]) VALUES (9, 1, 21, CAST(N'2015-12-02' AS Date), CAST(N'2015-12-02' AS Date), NULL)
INSERT [dbo].[BorrowerStatuses] ([BorrowerStatusID], [BorrowerID], [DVDID], [DateBorrowed], [DateReturned], [DVDExists]) VALUES (10, 8, 21, CAST(N'2015-12-02' AS Date), NULL, NULL)
INSERT [dbo].[BorrowerStatuses] ([BorrowerStatusID], [BorrowerID], [DVDID], [DateBorrowed], [DateReturned], [DVDExists]) VALUES (11, 1, 19, CAST(N'2015-12-02' AS Date), CAST(N'2015-12-02' AS Date), NULL)
INSERT [dbo].[BorrowerStatuses] ([BorrowerStatusID], [BorrowerID], [DVDID], [DateBorrowed], [DateReturned], [DVDExists]) VALUES (12, 4, 19, CAST(N'2015-12-02' AS Date), CAST(N'2015-12-02' AS Date), NULL)
INSERT [dbo].[BorrowerStatuses] ([BorrowerStatusID], [BorrowerID], [DVDID], [DateBorrowed], [DateReturned], [DVDExists]) VALUES (13, 1, 20, CAST(N'2015-12-02' AS Date), NULL, NULL)
INSERT [dbo].[BorrowerStatuses] ([BorrowerStatusID], [BorrowerID], [DVDID], [DateBorrowed], [DateReturned], [DVDExists]) VALUES (14, 1, 8, CAST(N'2015-12-02' AS Date), CAST(N'2015-12-02' AS Date), NULL)
INSERT [dbo].[BorrowerStatuses] ([BorrowerStatusID], [BorrowerID], [DVDID], [DateBorrowed], [DateReturned], [DVDExists]) VALUES (15, 1, 9, CAST(N'2015-12-02' AS Date), CAST(N'2015-12-02' AS Date), NULL)
INSERT [dbo].[BorrowerStatuses] ([BorrowerStatusID], [BorrowerID], [DVDID], [DateBorrowed], [DateReturned], [DVDExists]) VALUES (17, 1, 17, CAST(N'2015-12-02' AS Date), CAST(N'2015-12-02' AS Date), NULL)
INSERT [dbo].[BorrowerStatuses] ([BorrowerStatusID], [BorrowerID], [DVDID], [DateBorrowed], [DateReturned], [DVDExists]) VALUES (18, 1, 25, CAST(N'2015-12-02' AS Date), CAST(N'2015-12-02' AS Date), NULL)
INSERT [dbo].[BorrowerStatuses] ([BorrowerStatusID], [BorrowerID], [DVDID], [DateBorrowed], [DateReturned], [DVDExists]) VALUES (19, 1, 26, CAST(N'2015-12-02' AS Date), CAST(N'2015-12-02' AS Date), NULL)
INSERT [dbo].[BorrowerStatuses] ([BorrowerStatusID], [BorrowerID], [DVDID], [DateBorrowed], [DateReturned], [DVDExists]) VALUES (20, 1, 25, CAST(N'2015-12-02' AS Date), NULL, NULL)
INSERT [dbo].[BorrowerStatuses] ([BorrowerStatusID], [BorrowerID], [DVDID], [DateBorrowed], [DateReturned], [DVDExists]) VALUES (21, 1, 27, CAST(N'2015-12-02' AS Date), CAST(N'2015-12-02' AS Date), NULL)
INSERT [dbo].[BorrowerStatuses] ([BorrowerStatusID], [BorrowerID], [DVDID], [DateBorrowed], [DateReturned], [DVDExists]) VALUES (22, 1, 37, CAST(N'2015-12-02' AS Date), CAST(N'2015-12-02' AS Date), NULL)
INSERT [dbo].[BorrowerStatuses] ([BorrowerStatusID], [BorrowerID], [DVDID], [DateBorrowed], [DateReturned], [DVDExists]) VALUES (23, 8, 38, CAST(N'2015-12-02' AS Date), CAST(N'2015-12-02' AS Date), NULL)
INSERT [dbo].[BorrowerStatuses] ([BorrowerStatusID], [BorrowerID], [DVDID], [DateBorrowed], [DateReturned], [DVDExists]) VALUES (24, 1, 68, CAST(N'2015-12-02' AS Date), CAST(N'2015-12-02' AS Date), NULL)
INSERT [dbo].[BorrowerStatuses] ([BorrowerStatusID], [BorrowerID], [DVDID], [DateBorrowed], [DateReturned], [DVDExists]) VALUES (25, 1, 58, CAST(N'2015-12-02' AS Date), CAST(N'2015-12-02' AS Date), NULL)
INSERT [dbo].[BorrowerStatuses] ([BorrowerStatusID], [BorrowerID], [DVDID], [DateBorrowed], [DateReturned], [DVDExists]) VALUES (26, 1, 70, CAST(N'2015-12-02' AS Date), CAST(N'2015-12-02' AS Date), NULL)
INSERT [dbo].[BorrowerStatuses] ([BorrowerStatusID], [BorrowerID], [DVDID], [DateBorrowed], [DateReturned], [DVDExists]) VALUES (27, 6, 71, CAST(N'2015-12-02' AS Date), CAST(N'2015-12-02' AS Date), NULL)
INSERT [dbo].[BorrowerStatuses] ([BorrowerStatusID], [BorrowerID], [DVDID], [DateBorrowed], [DateReturned], [DVDExists]) VALUES (28, 7, 72, CAST(N'2015-12-02' AS Date), CAST(N'2015-12-02' AS Date), NULL)
INSERT [dbo].[BorrowerStatuses] ([BorrowerStatusID], [BorrowerID], [DVDID], [DateBorrowed], [DateReturned], [DVDExists]) VALUES (29, 1, 68, CAST(N'2015-12-02' AS Date), NULL, NULL)
SET IDENTITY_INSERT [dbo].[BorrowerStatuses] OFF
INSERT [dbo].[DeletedDVDs] ([DVDID], [MovieID], [DVDType]) VALUES (16, 3, N'DVD')
INSERT [dbo].[DeletedDVDs] ([DVDID], [MovieID], [DVDType]) VALUES (57, 20, N'Blu-ray')
SET IDENTITY_INSERT [dbo].[Directors] ON 

INSERT [dbo].[Directors] ([DirectorID], [DirectorName], [DirectorTMDBNum]) VALUES (1, N'George Lucas', 1)
INSERT [dbo].[Directors] ([DirectorID], [DirectorName], [DirectorTMDBNum]) VALUES (2, N'Irvin Kershner', 10930)
INSERT [dbo].[Directors] ([DirectorID], [DirectorName], [DirectorTMDBNum]) VALUES (3, N'Richard Marquand', 19800)
INSERT [dbo].[Directors] ([DirectorID], [DirectorName], [DirectorTMDBNum]) VALUES (4, N'Hayao Miyazaki', 608)
INSERT [dbo].[Directors] ([DirectorID], [DirectorName], [DirectorTMDBNum]) VALUES (5, N'John Lasseter', 7879)
INSERT [dbo].[Directors] ([DirectorID], [DirectorName], [DirectorTMDBNum]) VALUES (6, N'Lee Unkrich', 8)
INSERT [dbo].[Directors] ([DirectorID], [DirectorName], [DirectorTMDBNum]) VALUES (7, N'James Cameron', 2710)
INSERT [dbo].[Directors] ([DirectorID], [DirectorName], [DirectorTMDBNum]) VALUES (8, N'Francis Ford Coppola', 1776)
INSERT [dbo].[Directors] ([DirectorID], [DirectorName], [DirectorTMDBNum]) VALUES (9, N'Robert Zemeckis', 24)
INSERT [dbo].[Directors] ([DirectorID], [DirectorName], [DirectorTMDBNum]) VALUES (10, N'Martin Brest', 769)
INSERT [dbo].[Directors] ([DirectorID], [DirectorName], [DirectorTMDBNum]) VALUES (11, N'Steven Spielberg', 488)
INSERT [dbo].[Directors] ([DirectorID], [DirectorName], [DirectorTMDBNum]) VALUES (12, N'Christopher Nolan', 525)
INSERT [dbo].[Directors] ([DirectorID], [DirectorName], [DirectorTMDBNum]) VALUES (13, N'Ridley Scott', 578)
INSERT [dbo].[Directors] ([DirectorID], [DirectorName], [DirectorTMDBNum]) VALUES (14, N'Quentin Tarantino', 138)
INSERT [dbo].[Directors] ([DirectorID], [DirectorName], [DirectorTMDBNum]) VALUES (15, N'Pierre Morel', 35453)
INSERT [dbo].[Directors] ([DirectorID], [DirectorName], [DirectorTMDBNum]) VALUES (16, N'David Dobkin', 42994)
SET IDENTITY_INSERT [dbo].[Directors] OFF
SET IDENTITY_INSERT [dbo].[DVDs] ON 

INSERT [dbo].[DVDs] ([DVDID], [MovieID], [DVDType]) VALUES (1, 1, N'Blu-ray')
INSERT [dbo].[DVDs] ([DVDID], [MovieID], [DVDType]) VALUES (2, 1, N'Blu-ray')
INSERT [dbo].[DVDs] ([DVDID], [MovieID], [DVDType]) VALUES (3, 1, N'Blu-ray')
INSERT [dbo].[DVDs] ([DVDID], [MovieID], [DVDType]) VALUES (4, 2, N'Blu-ray')
INSERT [dbo].[DVDs] ([DVDID], [MovieID], [DVDType]) VALUES (5, 2, N'Blu-ray')
INSERT [dbo].[DVDs] ([DVDID], [MovieID], [DVDType]) VALUES (6, 2, N'Blu-ray')
INSERT [dbo].[DVDs] ([DVDID], [MovieID], [DVDType]) VALUES (7, 3, N'Blu-ray')
INSERT [dbo].[DVDs] ([DVDID], [MovieID], [DVDType]) VALUES (8, 3, N'Blu-ray')
INSERT [dbo].[DVDs] ([DVDID], [MovieID], [DVDType]) VALUES (9, 3, N'Blu-ray')
INSERT [dbo].[DVDs] ([DVDID], [MovieID], [DVDType]) VALUES (10, 1, N'DVD')
INSERT [dbo].[DVDs] ([DVDID], [MovieID], [DVDType]) VALUES (11, 1, N'DVD')
INSERT [dbo].[DVDs] ([DVDID], [MovieID], [DVDType]) VALUES (12, 1, N'DVD')
INSERT [dbo].[DVDs] ([DVDID], [MovieID], [DVDType]) VALUES (13, 2, N'DVD')
INSERT [dbo].[DVDs] ([DVDID], [MovieID], [DVDType]) VALUES (14, 2, N'DVD')
INSERT [dbo].[DVDs] ([DVDID], [MovieID], [DVDType]) VALUES (15, 2, N'DVD')
INSERT [dbo].[DVDs] ([DVDID], [MovieID], [DVDType]) VALUES (17, 3, N'DVD')
INSERT [dbo].[DVDs] ([DVDID], [MovieID], [DVDType]) VALUES (18, 3, N'DVD')
INSERT [dbo].[DVDs] ([DVDID], [MovieID], [DVDType]) VALUES (19, 4, N'Blu-ray')
INSERT [dbo].[DVDs] ([DVDID], [MovieID], [DVDType]) VALUES (20, 4, N'Blu-ray')
INSERT [dbo].[DVDs] ([DVDID], [MovieID], [DVDType]) VALUES (21, 5, N'Blu-ray')
INSERT [dbo].[DVDs] ([DVDID], [MovieID], [DVDType]) VALUES (22, 5, N'Blu-ray')
INSERT [dbo].[DVDs] ([DVDID], [MovieID], [DVDType]) VALUES (23, 4, N'DVD')
INSERT [dbo].[DVDs] ([DVDID], [MovieID], [DVDType]) VALUES (24, 5, N'DVD')
INSERT [dbo].[DVDs] ([DVDID], [MovieID], [DVDType]) VALUES (25, 6, N'Blu-ray Special Edition')
INSERT [dbo].[DVDs] ([DVDID], [MovieID], [DVDType]) VALUES (26, 6, N'Blu-ray Special Edition')
INSERT [dbo].[DVDs] ([DVDID], [MovieID], [DVDType]) VALUES (27, 7, N'Blu-ray Special Edition')
INSERT [dbo].[DVDs] ([DVDID], [MovieID], [DVDType]) VALUES (28, 7, N'Blu-ray Special Edition')
INSERT [dbo].[DVDs] ([DVDID], [MovieID], [DVDType]) VALUES (29, 8, N'Blu-ray Special Edition')
INSERT [dbo].[DVDs] ([DVDID], [MovieID], [DVDType]) VALUES (30, 8, N'Blu-ray Special Edition')
INSERT [dbo].[DVDs] ([DVDID], [MovieID], [DVDType]) VALUES (31, 9, N'Blu-ray')
INSERT [dbo].[DVDs] ([DVDID], [MovieID], [DVDType]) VALUES (32, 9, N'Blu-ray')
INSERT [dbo].[DVDs] ([DVDID], [MovieID], [DVDType]) VALUES (33, 9, N'Blu-ray')
INSERT [dbo].[DVDs] ([DVDID], [MovieID], [DVDType]) VALUES (34, 10, N'Blu-ray Special Edition')
INSERT [dbo].[DVDs] ([DVDID], [MovieID], [DVDType]) VALUES (35, 10, N'Blu-ray Special Edition')
INSERT [dbo].[DVDs] ([DVDID], [MovieID], [DVDType]) VALUES (36, 10, N'Blu-ray Special Edition')
INSERT [dbo].[DVDs] ([DVDID], [MovieID], [DVDType]) VALUES (37, 11, N'VHS')
INSERT [dbo].[DVDs] ([DVDID], [MovieID], [DVDType]) VALUES (38, 11, N'Blu-ray')
INSERT [dbo].[DVDs] ([DVDID], [MovieID], [DVDType]) VALUES (39, 11, N'Blu-ray')
INSERT [dbo].[DVDs] ([DVDID], [MovieID], [DVDType]) VALUES (40, 11, N'Blu-ray')
INSERT [dbo].[DVDs] ([DVDID], [MovieID], [DVDType]) VALUES (41, 12, N'DVD Special Edition')
INSERT [dbo].[DVDs] ([DVDID], [MovieID], [DVDType]) VALUES (42, 12, N'DVD Special Edition')
INSERT [dbo].[DVDs] ([DVDID], [MovieID], [DVDType]) VALUES (43, 13, N'Blu-ray')
INSERT [dbo].[DVDs] ([DVDID], [MovieID], [DVDType]) VALUES (44, 13, N'Blu-ray')
INSERT [dbo].[DVDs] ([DVDID], [MovieID], [DVDType]) VALUES (45, 14, N'Blu-ray')
INSERT [dbo].[DVDs] ([DVDID], [MovieID], [DVDType]) VALUES (46, 14, N'Blu-ray')
INSERT [dbo].[DVDs] ([DVDID], [MovieID], [DVDType]) VALUES (47, 14, N'Blu-ray')
INSERT [dbo].[DVDs] ([DVDID], [MovieID], [DVDType]) VALUES (48, 15, N'Blu-ray')
INSERT [dbo].[DVDs] ([DVDID], [MovieID], [DVDType]) VALUES (49, 15, N'Blu-ray')
INSERT [dbo].[DVDs] ([DVDID], [MovieID], [DVDType]) VALUES (50, 16, N'Blu-ray')
INSERT [dbo].[DVDs] ([DVDID], [MovieID], [DVDType]) VALUES (51, 16, N'Blu-ray')
INSERT [dbo].[DVDs] ([DVDID], [MovieID], [DVDType]) VALUES (52, 17, N'Blu-ray')
INSERT [dbo].[DVDs] ([DVDID], [MovieID], [DVDType]) VALUES (53, 17, N'Blu-ray')
INSERT [dbo].[DVDs] ([DVDID], [MovieID], [DVDType]) VALUES (54, 18, N'Blu-ray')
INSERT [dbo].[DVDs] ([DVDID], [MovieID], [DVDType]) VALUES (55, 18, N'Blu-ray')
INSERT [dbo].[DVDs] ([DVDID], [MovieID], [DVDType]) VALUES (56, 19, N'DVD')
INSERT [dbo].[DVDs] ([DVDID], [MovieID], [DVDType]) VALUES (58, 20, N'Blu-ray')
INSERT [dbo].[DVDs] ([DVDID], [MovieID], [DVDType]) VALUES (59, 20, N'DVD')
INSERT [dbo].[DVDs] ([DVDID], [MovieID], [DVDType]) VALUES (60, 21, N'Blu-ray')
INSERT [dbo].[DVDs] ([DVDID], [MovieID], [DVDType]) VALUES (61, 21, N'Blu-ray')
INSERT [dbo].[DVDs] ([DVDID], [MovieID], [DVDType]) VALUES (62, 22, N'Blu-ray')
INSERT [dbo].[DVDs] ([DVDID], [MovieID], [DVDType]) VALUES (63, 22, N'Blu-ray')
INSERT [dbo].[DVDs] ([DVDID], [MovieID], [DVDType]) VALUES (64, 23, N'Blu-ray Special Edition')
INSERT [dbo].[DVDs] ([DVDID], [MovieID], [DVDType]) VALUES (65, 23, N'Blu-ray Special Edition')
INSERT [dbo].[DVDs] ([DVDID], [MovieID], [DVDType]) VALUES (66, 24, N'Blu-ray')
INSERT [dbo].[DVDs] ([DVDID], [MovieID], [DVDType]) VALUES (67, 24, N'Blu-ray')
INSERT [dbo].[DVDs] ([DVDID], [MovieID], [DVDType]) VALUES (68, 25, N'Blu-ray')
INSERT [dbo].[DVDs] ([DVDID], [MovieID], [DVDType]) VALUES (69, 25, N'Blu-ray')
INSERT [dbo].[DVDs] ([DVDID], [MovieID], [DVDType]) VALUES (70, 26, N'Blu-ray Special Edition')
INSERT [dbo].[DVDs] ([DVDID], [MovieID], [DVDType]) VALUES (71, 26, N'Blu-ray Special Edition')
INSERT [dbo].[DVDs] ([DVDID], [MovieID], [DVDType]) VALUES (72, 26, N'Blu-ray Special Edition')
INSERT [dbo].[DVDs] ([DVDID], [MovieID], [DVDType]) VALUES (73, 27, N'Blu-ray')
INSERT [dbo].[DVDs] ([DVDID], [MovieID], [DVDType]) VALUES (74, 27, N'Blu-ray')
SET IDENTITY_INSERT [dbo].[DVDs] OFF
SET IDENTITY_INSERT [dbo].[Genres] ON 

INSERT [dbo].[Genres] ([GenreID], [GenreName]) VALUES (1, N'Adventure')
INSERT [dbo].[Genres] ([GenreID], [GenreName]) VALUES (2, N'Action')
INSERT [dbo].[Genres] ([GenreID], [GenreName]) VALUES (3, N'Science Fiction')
INSERT [dbo].[Genres] ([GenreID], [GenreName]) VALUES (4, N'Fantasy')
INSERT [dbo].[Genres] ([GenreID], [GenreName]) VALUES (5, N'Animation')
INSERT [dbo].[Genres] ([GenreID], [GenreName]) VALUES (6, N'Family')
INSERT [dbo].[Genres] ([GenreID], [GenreName]) VALUES (7, N'Comedy')
INSERT [dbo].[Genres] ([GenreID], [GenreName]) VALUES (8, N'Thriller')
INSERT [dbo].[Genres] ([GenreID], [GenreName]) VALUES (9, N'Drama')
INSERT [dbo].[Genres] ([GenreID], [GenreName]) VALUES (10, N'Crime')
INSERT [dbo].[Genres] ([GenreID], [GenreName]) VALUES (11, N'Romance')
SET IDENTITY_INSERT [dbo].[Genres] OFF
INSERT [dbo].[GenresMovies] ([GenreID], [MovieID]) VALUES (1, 1)
INSERT [dbo].[GenresMovies] ([GenreID], [MovieID]) VALUES (1, 2)
INSERT [dbo].[GenresMovies] ([GenreID], [MovieID]) VALUES (1, 3)
INSERT [dbo].[GenresMovies] ([GenreID], [MovieID]) VALUES (1, 4)
INSERT [dbo].[GenresMovies] ([GenreID], [MovieID]) VALUES (1, 5)
INSERT [dbo].[GenresMovies] ([GenreID], [MovieID]) VALUES (1, 6)
INSERT [dbo].[GenresMovies] ([GenreID], [MovieID]) VALUES (1, 7)
INSERT [dbo].[GenresMovies] ([GenreID], [MovieID]) VALUES (1, 15)
INSERT [dbo].[GenresMovies] ([GenreID], [MovieID]) VALUES (1, 16)
INSERT [dbo].[GenresMovies] ([GenreID], [MovieID]) VALUES (1, 17)
INSERT [dbo].[GenresMovies] ([GenreID], [MovieID]) VALUES (1, 20)
INSERT [dbo].[GenresMovies] ([GenreID], [MovieID]) VALUES (2, 1)
INSERT [dbo].[GenresMovies] ([GenreID], [MovieID]) VALUES (2, 2)
INSERT [dbo].[GenresMovies] ([GenreID], [MovieID]) VALUES (2, 3)
INSERT [dbo].[GenresMovies] ([GenreID], [MovieID]) VALUES (2, 7)
INSERT [dbo].[GenresMovies] ([GenreID], [MovieID]) VALUES (2, 11)
INSERT [dbo].[GenresMovies] ([GenreID], [MovieID]) VALUES (2, 12)
INSERT [dbo].[GenresMovies] ([GenreID], [MovieID]) VALUES (2, 16)
INSERT [dbo].[GenresMovies] ([GenreID], [MovieID]) VALUES (2, 17)
INSERT [dbo].[GenresMovies] ([GenreID], [MovieID]) VALUES (2, 21)
INSERT [dbo].[GenresMovies] ([GenreID], [MovieID]) VALUES (2, 22)
INSERT [dbo].[GenresMovies] ([GenreID], [MovieID]) VALUES (2, 24)
INSERT [dbo].[GenresMovies] ([GenreID], [MovieID]) VALUES (2, 26)
INSERT [dbo].[GenresMovies] ([GenreID], [MovieID]) VALUES (3, 1)
INSERT [dbo].[GenresMovies] ([GenreID], [MovieID]) VALUES (3, 2)
INSERT [dbo].[GenresMovies] ([GenreID], [MovieID]) VALUES (3, 3)
INSERT [dbo].[GenresMovies] ([GenreID], [MovieID]) VALUES (3, 7)
INSERT [dbo].[GenresMovies] ([GenreID], [MovieID]) VALUES (3, 11)
INSERT [dbo].[GenresMovies] ([GenreID], [MovieID]) VALUES (3, 12)
INSERT [dbo].[GenresMovies] ([GenreID], [MovieID]) VALUES (3, 15)
INSERT [dbo].[GenresMovies] ([GenreID], [MovieID]) VALUES (3, 16)
INSERT [dbo].[GenresMovies] ([GenreID], [MovieID]) VALUES (3, 17)
INSERT [dbo].[GenresMovies] ([GenreID], [MovieID]) VALUES (3, 20)
INSERT [dbo].[GenresMovies] ([GenreID], [MovieID]) VALUES (3, 23)
INSERT [dbo].[GenresMovies] ([GenreID], [MovieID]) VALUES (4, 4)
INSERT [dbo].[GenresMovies] ([GenreID], [MovieID]) VALUES (4, 5)
INSERT [dbo].[GenresMovies] ([GenreID], [MovieID]) VALUES (4, 6)
INSERT [dbo].[GenresMovies] ([GenreID], [MovieID]) VALUES (4, 7)
INSERT [dbo].[GenresMovies] ([GenreID], [MovieID]) VALUES (5, 4)
INSERT [dbo].[GenresMovies] ([GenreID], [MovieID]) VALUES (5, 5)
INSERT [dbo].[GenresMovies] ([GenreID], [MovieID]) VALUES (5, 6)
INSERT [dbo].[GenresMovies] ([GenreID], [MovieID]) VALUES (5, 7)
INSERT [dbo].[GenresMovies] ([GenreID], [MovieID]) VALUES (5, 8)
INSERT [dbo].[GenresMovies] ([GenreID], [MovieID]) VALUES (5, 9)
INSERT [dbo].[GenresMovies] ([GenreID], [MovieID]) VALUES (5, 10)
INSERT [dbo].[GenresMovies] ([GenreID], [MovieID]) VALUES (6, 4)
INSERT [dbo].[GenresMovies] ([GenreID], [MovieID]) VALUES (6, 8)
INSERT [dbo].[GenresMovies] ([GenreID], [MovieID]) VALUES (6, 9)
INSERT [dbo].[GenresMovies] ([GenreID], [MovieID]) VALUES (6, 10)
INSERT [dbo].[GenresMovies] ([GenreID], [MovieID]) VALUES (6, 15)
INSERT [dbo].[GenresMovies] ([GenreID], [MovieID]) VALUES (6, 16)
INSERT [dbo].[GenresMovies] ([GenreID], [MovieID]) VALUES (6, 17)
INSERT [dbo].[GenresMovies] ([GenreID], [MovieID]) VALUES (7, 8)
INSERT [dbo].[GenresMovies] ([GenreID], [MovieID]) VALUES (7, 9)
INSERT [dbo].[GenresMovies] ([GenreID], [MovieID]) VALUES (7, 10)
INSERT [dbo].[GenresMovies] ([GenreID], [MovieID]) VALUES (7, 15)
INSERT [dbo].[GenresMovies] ([GenreID], [MovieID]) VALUES (7, 16)
INSERT [dbo].[GenresMovies] ([GenreID], [MovieID]) VALUES (7, 17)
INSERT [dbo].[GenresMovies] ([GenreID], [MovieID]) VALUES (7, 18)
INSERT [dbo].[GenresMovies] ([GenreID], [MovieID]) VALUES (7, 27)
INSERT [dbo].[GenresMovies] ([GenreID], [MovieID]) VALUES (8, 11)
INSERT [dbo].[GenresMovies] ([GenreID], [MovieID]) VALUES (8, 12)
INSERT [dbo].[GenresMovies] ([GenreID], [MovieID]) VALUES (8, 21)
INSERT [dbo].[GenresMovies] ([GenreID], [MovieID]) VALUES (8, 22)
INSERT [dbo].[GenresMovies] ([GenreID], [MovieID]) VALUES (8, 23)
INSERT [dbo].[GenresMovies] ([GenreID], [MovieID]) VALUES (8, 25)
INSERT [dbo].[GenresMovies] ([GenreID], [MovieID]) VALUES (8, 26)
INSERT [dbo].[GenresMovies] ([GenreID], [MovieID]) VALUES (9, 13)
INSERT [dbo].[GenresMovies] ([GenreID], [MovieID]) VALUES (9, 14)
INSERT [dbo].[GenresMovies] ([GenreID], [MovieID]) VALUES (9, 18)
INSERT [dbo].[GenresMovies] ([GenreID], [MovieID]) VALUES (9, 19)
INSERT [dbo].[GenresMovies] ([GenreID], [MovieID]) VALUES (9, 21)
INSERT [dbo].[GenresMovies] ([GenreID], [MovieID]) VALUES (9, 22)
INSERT [dbo].[GenresMovies] ([GenreID], [MovieID]) VALUES (9, 23)
INSERT [dbo].[GenresMovies] ([GenreID], [MovieID]) VALUES (9, 24)
INSERT [dbo].[GenresMovies] ([GenreID], [MovieID]) VALUES (10, 13)
INSERT [dbo].[GenresMovies] ([GenreID], [MovieID]) VALUES (10, 14)
INSERT [dbo].[GenresMovies] ([GenreID], [MovieID]) VALUES (10, 21)
INSERT [dbo].[GenresMovies] ([GenreID], [MovieID]) VALUES (10, 22)
INSERT [dbo].[GenresMovies] ([GenreID], [MovieID]) VALUES (10, 24)
INSERT [dbo].[GenresMovies] ([GenreID], [MovieID]) VALUES (10, 25)
INSERT [dbo].[GenresMovies] ([GenreID], [MovieID]) VALUES (10, 26)
INSERT [dbo].[GenresMovies] ([GenreID], [MovieID]) VALUES (11, 18)
INSERT [dbo].[GenresMovies] ([GenreID], [MovieID]) VALUES (11, 27)
SET IDENTITY_INSERT [dbo].[MovieAliases] ON 

INSERT [dbo].[MovieAliases] ([MovieAliasID], [MovieID], [MovieAlias]) VALUES (1, 1, N'Star Wars Episode IV - A New Hope')
INSERT [dbo].[MovieAliases] ([MovieAliasID], [MovieID], [MovieAlias]) VALUES (2, 1, N'Star Wars Episode 4 - A New Hope')
INSERT [dbo].[MovieAliases] ([MovieAliasID], [MovieID], [MovieAlias]) VALUES (3, 1, N'Star Wars Episode IV')
INSERT [dbo].[MovieAliases] ([MovieAliasID], [MovieID], [MovieAlias]) VALUES (4, 1, N'Star Wars 4')
INSERT [dbo].[MovieAliases] ([MovieAliasID], [MovieID], [MovieAlias]) VALUES (5, 1, N'Star Wars: Episode IV - A New Hope - Despecialized Edition')
INSERT [dbo].[MovieAliases] ([MovieAliasID], [MovieID], [MovieAlias]) VALUES (6, 1, N'Star Wars')
INSERT [dbo].[MovieAliases] ([MovieAliasID], [MovieID], [MovieAlias]) VALUES (7, 2, N'Star Wars Episode V - The Empire Strikes Back')
INSERT [dbo].[MovieAliases] ([MovieAliasID], [MovieID], [MovieAlias]) VALUES (8, 2, N'Star Wars Episode 5 - The Empire Strikes Back')
INSERT [dbo].[MovieAliases] ([MovieAliasID], [MovieID], [MovieAlias]) VALUES (9, 2, N'Star Wars Episode V')
INSERT [dbo].[MovieAliases] ([MovieAliasID], [MovieID], [MovieAlias]) VALUES (10, 2, N'Star Wars 5')
INSERT [dbo].[MovieAliases] ([MovieAliasID], [MovieID], [MovieAlias]) VALUES (11, 2, N'Star Wars - Episode V - The Empire Strikes Back')
INSERT [dbo].[MovieAliases] ([MovieAliasID], [MovieID], [MovieAlias]) VALUES (12, 2, N'Star Wars - Episode 5 - The Empire Strikes Back')
INSERT [dbo].[MovieAliases] ([MovieAliasID], [MovieID], [MovieAlias]) VALUES (13, 2, N'Star Wars Episode V The Empire Strikes Back')
INSERT [dbo].[MovieAliases] ([MovieAliasID], [MovieID], [MovieAlias]) VALUES (14, 2, N'Star Wars - Episode 5 - Despecialized')
INSERT [dbo].[MovieAliases] ([MovieAliasID], [MovieID], [MovieAlias]) VALUES (15, 3, N'Return of the Jedi')
INSERT [dbo].[MovieAliases] ([MovieAliasID], [MovieID], [MovieAlias]) VALUES (16, 3, N'Star Wars: Return of the Jedi')
INSERT [dbo].[MovieAliases] ([MovieAliasID], [MovieID], [MovieAlias]) VALUES (17, 3, N'Star Wars Episode VI - Return of the Jedi')
INSERT [dbo].[MovieAliases] ([MovieAliasID], [MovieID], [MovieAlias]) VALUES (18, 3, N'Star Wars 6')
INSERT [dbo].[MovieAliases] ([MovieAliasID], [MovieID], [MovieAlias]) VALUES (19, 3, N'Star Wars - Episode VI - Return of the Jedi')
INSERT [dbo].[MovieAliases] ([MovieAliasID], [MovieID], [MovieAlias]) VALUES (20, 3, N'Star Wars Episode 6 - Return of the Jedi')
INSERT [dbo].[MovieAliases] ([MovieAliasID], [MovieID], [MovieAlias]) VALUES (21, 3, N'Star Wars Episode VI Return of the Jedi')
INSERT [dbo].[MovieAliases] ([MovieAliasID], [MovieID], [MovieAlias]) VALUES (22, 3, N'Star Wars - Episode 6 - Despecialized')
INSERT [dbo].[MovieAliases] ([MovieAliasID], [MovieID], [MovieAlias]) VALUES (23, 4, N'Studio Ghibli - Spirited Away')
INSERT [dbo].[MovieAliases] ([MovieAliasID], [MovieID], [MovieAlias]) VALUES (24, 4, N'The Spiriting Away Of Sen And Chihiro')
INSERT [dbo].[MovieAliases] ([MovieAliasID], [MovieID], [MovieAlias]) VALUES (25, 6, N'Le Chateau Ambulant')
INSERT [dbo].[MovieAliases] ([MovieAliasID], [MovieID], [MovieAlias]) VALUES (26, 6, N'Howl''s Moving Castle')
INSERT [dbo].[MovieAliases] ([MovieAliasID], [MovieID], [MovieAlias]) VALUES (27, 6, N'Hauru no ugoku shiro')
INSERT [dbo].[MovieAliases] ([MovieAliasID], [MovieID], [MovieAlias]) VALUES (28, 6, N'Studio Ghibli - Howls Moving Castle')
INSERT [dbo].[MovieAliases] ([MovieAliasID], [MovieID], [MovieAlias]) VALUES (29, 7, N'Warriors of the Wind')
INSERT [dbo].[MovieAliases] ([MovieAliasID], [MovieID], [MovieAlias]) VALUES (30, 7, N'Nausicaa of the Valley of the Wind')
INSERT [dbo].[MovieAliases] ([MovieAliasID], [MovieID], [MovieAlias]) VALUES (31, 8, N'Toy Story 1')
INSERT [dbo].[MovieAliases] ([MovieAliasID], [MovieID], [MovieAlias]) VALUES (32, 8, N'Toy Story - 3D')
INSERT [dbo].[MovieAliases] ([MovieAliasID], [MovieID], [MovieAlias]) VALUES (33, 9, N'Toy Story 3 - 3D')
INSERT [dbo].[MovieAliases] ([MovieAliasID], [MovieID], [MovieAlias]) VALUES (34, 10, N'Toy Story II')
INSERT [dbo].[MovieAliases] ([MovieAliasID], [MovieID], [MovieAlias]) VALUES (35, 10, N'Toy Story 2 - 3D')
INSERT [dbo].[MovieAliases] ([MovieAliasID], [MovieID], [MovieAlias]) VALUES (36, 10, N'TOY2_43')
INSERT [dbo].[MovieAliases] ([MovieAliasID], [MovieID], [MovieAlias]) VALUES (37, 11, N'Terminator 2: Judgment Day')
INSERT [dbo].[MovieAliases] ([MovieAliasID], [MovieID], [MovieAlias]) VALUES (38, 12, N'Terminator 1')
INSERT [dbo].[MovieAliases] ([MovieAliasID], [MovieID], [MovieAlias]) VALUES (39, 13, N'The Godfather Part I')
INSERT [dbo].[MovieAliases] ([MovieAliasID], [MovieID], [MovieAlias]) VALUES (40, 13, N'The Godfather Part 1')
INSERT [dbo].[MovieAliases] ([MovieAliasID], [MovieID], [MovieAlias]) VALUES (41, 13, N'Mario Puzo''s The Godfather')
INSERT [dbo].[MovieAliases] ([MovieAliasID], [MovieID], [MovieAlias]) VALUES (42, 13, N'The Godfather: The Coppola Restoration')
INSERT [dbo].[MovieAliases] ([MovieAliasID], [MovieID], [MovieAlias]) VALUES (43, 13, N'The Godfather: Part I')
INSERT [dbo].[MovieAliases] ([MovieAliasID], [MovieID], [MovieAlias]) VALUES (44, 13, N'The Godfather 1')
INSERT [dbo].[MovieAliases] ([MovieAliasID], [MovieID], [MovieAlias]) VALUES (45, 13, N'Godfather, The')
INSERT [dbo].[MovieAliases] ([MovieAliasID], [MovieID], [MovieAlias]) VALUES (46, 14, N'The Godfather Part 2')
INSERT [dbo].[MovieAliases] ([MovieAliasID], [MovieID], [MovieAlias]) VALUES (47, 14, N'Godfather, The - Part II')
INSERT [dbo].[MovieAliases] ([MovieAliasID], [MovieID], [MovieAlias]) VALUES (48, 14, N'Mario Puzo''s The Godfather: Part II')
INSERT [dbo].[MovieAliases] ([MovieAliasID], [MovieID], [MovieAlias]) VALUES (49, 14, N'The Godfather 2')
INSERT [dbo].[MovieAliases] ([MovieAliasID], [MovieID], [MovieAlias]) VALUES (50, 14, N'The Godfather, Part II')
INSERT [dbo].[MovieAliases] ([MovieAliasID], [MovieID], [MovieAlias]) VALUES (51, 14, N'Godfather - Part II, The')
INSERT [dbo].[MovieAliases] ([MovieAliasID], [MovieID], [MovieAlias]) VALUES (52, 15, N'Back to the Future')
INSERT [dbo].[MovieAliases] ([MovieAliasID], [MovieID], [MovieAlias]) VALUES (53, 15, N'Back to the Future I')
INSERT [dbo].[MovieAliases] ([MovieAliasID], [MovieID], [MovieAlias]) VALUES (54, 16, N'Back to the Future 3')
INSERT [dbo].[MovieAliases] ([MovieAliasID], [MovieID], [MovieAlias]) VALUES (55, 16, N'Back to the Future III')
INSERT [dbo].[MovieAliases] ([MovieAliasID], [MovieID], [MovieAlias]) VALUES (56, 16, N'Back to the Future Part 3')
INSERT [dbo].[MovieAliases] ([MovieAliasID], [MovieID], [MovieAlias]) VALUES (57, 17, N'Back to the Future 2')
INSERT [dbo].[MovieAliases] ([MovieAliasID], [MovieID], [MovieAlias]) VALUES (58, 17, N'Back to the Future II')
INSERT [dbo].[MovieAliases] ([MovieAliasID], [MovieID], [MovieAlias]) VALUES (59, 17, N'Paradox')
INSERT [dbo].[MovieAliases] ([MovieAliasID], [MovieID], [MovieAlias]) VALUES (60, 17, N'Back to the Future 2 (1989)')
INSERT [dbo].[MovieAliases] ([MovieAliasID], [MovieID], [MovieAlias]) VALUES (61, 18, N'Forest Gump')
INSERT [dbo].[MovieAliases] ([MovieAliasID], [MovieID], [MovieAlias]) VALUES (62, 20, N'Jurassic Park 3D')
INSERT [dbo].[MovieAliases] ([MovieAliasID], [MovieID], [MovieAlias]) VALUES (63, 20, N'Jurassic Park - 3D')
INSERT [dbo].[MovieAliases] ([MovieAliasID], [MovieID], [MovieAlias]) VALUES (64, 21, N'Batman: The Dark Knight')
INSERT [dbo].[MovieAliases] ([MovieAliasID], [MovieID], [MovieAlias]) VALUES (65, 21, N'Batman The Dark Knight')
INSERT [dbo].[MovieAliases] ([MovieAliasID], [MovieID], [MovieAlias]) VALUES (66, 21, N'Batman 6 - The Dark Knight')
INSERT [dbo].[MovieAliases] ([MovieAliasID], [MovieID], [MovieAlias]) VALUES (67, 22, N'Batman The Dark Knight Rises')
INSERT [dbo].[MovieAliases] ([MovieAliasID], [MovieID], [MovieAlias]) VALUES (68, 22, N'Batman 3 - The Dark Knight Rises')
INSERT [dbo].[MovieAliases] ([MovieAliasID], [MovieID], [MovieAlias]) VALUES (69, 22, N'Batman Dark Knight 3: The Dark Knight Rises')
INSERT [dbo].[MovieAliases] ([MovieAliasID], [MovieID], [MovieAlias]) VALUES (70, 22, N'Batman 7 - The Dark Knight Rises')
INSERT [dbo].[MovieAliases] ([MovieAliasID], [MovieID], [MovieAlias]) VALUES (71, 23, N'Dangerous Days')
INSERT [dbo].[MovieAliases] ([MovieAliasID], [MovieID], [MovieAlias]) VALUES (72, 23, N'Blade Runner (Director''s Cut)')
INSERT [dbo].[MovieAliases] ([MovieAliasID], [MovieID], [MovieAlias]) VALUES (73, 23, N'Blade Runner 30th Anniversary Edition')
INSERT [dbo].[MovieAliases] ([MovieAliasID], [MovieID], [MovieAlias]) VALUES (74, 23, N'Blade Runner - The Final Cut')
INSERT [dbo].[MovieAliases] ([MovieAliasID], [MovieID], [MovieAlias]) VALUES (75, 23, N'Blade Runner (1982) - Theatrical Version')
INSERT [dbo].[MovieAliases] ([MovieAliasID], [MovieID], [MovieAlias]) VALUES (76, 23, N'Blade Runner (International Cut)')
INSERT [dbo].[MovieAliases] ([MovieAliasID], [MovieID], [MovieAlias]) VALUES (77, 24, N'Batman 5: Batman Begins')
INSERT [dbo].[MovieAliases] ([MovieAliasID], [MovieID], [MovieAlias]) VALUES (78, 24, N'Batman Dark Knight 1: Batman Begins')
INSERT [dbo].[MovieAliases] ([MovieAliasID], [MovieID], [MovieAlias]) VALUES (79, 24, N'Batman 5 - Batman Begins')
INSERT [dbo].[MovieAliases] ([MovieAliasID], [MovieID], [MovieAlias]) VALUES (80, 25, N'Pulp Fiction - Chronological Cut')
SET IDENTITY_INSERT [dbo].[MovieAliases] OFF
SET IDENTITY_INSERT [dbo].[Movies] ON 

INSERT [dbo].[Movies] ([MovieID], [DirectorID], [StudioID], [MovieTitle], [MovieTMDBNum], [Rating], [ReleaseDate], [DurationInMin], [Synopsis], [PosterUrl], [YouTubeTrailer], [InCollection]) VALUES (1, 1, 1, N'Star Wars: Episode IV - A New Hope', 11, N'PG', CAST(N'1977-05-25' AS Date), 121, N'Princess Leia is captured and held hostage by the evil Imperial forces in their effort to take over the galactic Empire. Venturesome Luke Skywalker and dashing captain Han Solo team together with the loveable robot duo R2-D2 and C-3PO to rescue the beautiful princess and restore peace and justice in the Empire.', N'http://image.tmdb.org/t/p/w396/tvSlBzAdRE29bZe5yYWrJ2ds137.jpg', N'http://www.youtube.com/embed/vZ734NWnAHA', 1)
INSERT [dbo].[Movies] ([MovieID], [DirectorID], [StudioID], [MovieTitle], [MovieTMDBNum], [Rating], [ReleaseDate], [DurationInMin], [Synopsis], [PosterUrl], [YouTubeTrailer], [InCollection]) VALUES (2, 2, 1, N'Star Wars: Episode V - The Empire Strikes Back', 1891, N'PG', CAST(N'1980-05-17' AS Date), 124, N'The epic saga continues as Luke Skywalker, in hopes of defeating the evil Galactic Empire, learns the ways of the Jedi from aging master Yoda. But Darth Vader is more determined than ever to capture Luke. Meanwhile, rebel leader Princess Leia, cocky Han Solo, Chewbacca, and droids C-3PO and R2-D2 are thrown into various stages of capture, betrayal and despair.', N'http://image.tmdb.org/t/p/w396/6u1fYtxG5eqjhtCPDx04pJphQRW.jpg', N'http://www.youtube.com/embed/KwYa7UpoWtM', 1)
INSERT [dbo].[Movies] ([MovieID], [DirectorID], [StudioID], [MovieTitle], [MovieTMDBNum], [Rating], [ReleaseDate], [DurationInMin], [Synopsis], [PosterUrl], [YouTubeTrailer], [InCollection]) VALUES (3, 3, 1, N'Star Wars: Episode VI - Return of the Jedi', 1892, N'PG', CAST(N'1983-05-25' AS Date), 135, N'As Rebel leaders map their strategy for an all-out attack on the Emperor''s newer, bigger Death Star. Han Solo remains frozen in the cavernous desert fortress of Jabba the Hutt, the most loathsome outlaw in the universe, who is also keeping Princess Leia as a slave girl. Now a master of the Force, Luke Skywalker rescues his friends, but he cannot become a true Jedi Knight until he wages his own crucial battle against Darth Vader, who has sworn to win Luke over to the dark side of the Force.', N'http://image.tmdb.org/t/p/w396/jx5p0aHlbPXqe3AH9G15NvmWaqQ.jpg', N'http://www.youtube.com/embed/2mqRbh7FJ0Y', 1)
INSERT [dbo].[Movies] ([MovieID], [DirectorID], [StudioID], [MovieTitle], [MovieTMDBNum], [Rating], [ReleaseDate], [DurationInMin], [Synopsis], [PosterUrl], [YouTubeTrailer], [InCollection]) VALUES (4, 4, 2, N'Spirited Away', 129, N'PG', CAST(N'2001-07-20' AS Date), 125, N'Spirited Away is an Oscar winning Japanese animated film about a ten year old girl who wanders away from her parents along a path that leads to a world ruled by strange and unusual monster-like animals. Her parents have been changed into pigs along with others inside a bathhouse full of these creatures. Will she ever see the world how it once was?', N'http://image.tmdb.org/t/p/w396/dL11DBPcRhWWnJcFXl9A07MrqTI.jpg', N'http://www.youtube.com/embed/_jGXcSBcvQQ', 1)
INSERT [dbo].[Movies] ([MovieID], [DirectorID], [StudioID], [MovieTitle], [MovieTMDBNum], [Rating], [ReleaseDate], [DurationInMin], [Synopsis], [PosterUrl], [YouTubeTrailer], [InCollection]) VALUES (5, 4, 3, N'Princess Mononoke', 128, N'PG-13', CAST(N'1997-07-12' AS Date), 134, N'Ashitaka, a prince of the disappearing Ainu tribe, is cursed by a demonized boar god and must journey to the west to find a cure. Along the way, he encounters San, a young human woman fighting to protect the forest, and Lady Eboshi, who is trying to destroy it. Ashitaka must find a way to bring balance to this conflict.', N'http://image.tmdb.org/t/p/w396/gzlJkVfWV5VEG5xK25cvFGJgkDz.jpg', NULL, 1)
INSERT [dbo].[Movies] ([MovieID], [DirectorID], [StudioID], [MovieTitle], [MovieTMDBNum], [Rating], [ReleaseDate], [DurationInMin], [Synopsis], [PosterUrl], [YouTubeTrailer], [InCollection]) VALUES (6, 4, 3, N'Howl''s Moving Castle', 4935, N'PG', CAST(N'2004-11-19' AS Date), 119, N'When Sophie, a shy young woman, is cursed with an old body by a spiteful witch, her only chance of breaking the spell lies with a self-indulgent yet insecure young wizard and his companions in his legged, walking home.', N'http://image.tmdb.org/t/p/w396/iMarB2ior30OAXjPa7QIdeyUfM1.jpg', N'http://www.youtube.com/embed/bHTrnAVPens', 1)
INSERT [dbo].[Movies] ([MovieID], [DirectorID], [StudioID], [MovieTitle], [MovieTMDBNum], [Rating], [ReleaseDate], [DurationInMin], [Synopsis], [PosterUrl], [YouTubeTrailer], [InCollection]) VALUES (7, 4, 4, N'Nausicaä of the Valley of the Wind', 81, N'NR', CAST(N'1984-03-11' AS Date), 117, N'Nausicaä, a gentle young princess, has an empathetic bond with the giant mutated insects that evolved in the wake of the destruction of the ecosystem. Traveling by cumbersome flying ship, on the backs of giant birds, and perched atop her beloved glider, Nausicaä and her allies must negotiate peace between kingdoms battling over the last of the world''s precious natural resources.', N'http://image.tmdb.org/t/p/w396/y2rl0OkMfZHpBaQYPfSJmLMOxwp.jpg', N'http://www.youtube.com/embed/fP6DnVzmaAE', 1)
INSERT [dbo].[Movies] ([MovieID], [DirectorID], [StudioID], [MovieTitle], [MovieTMDBNum], [Rating], [ReleaseDate], [DurationInMin], [Synopsis], [PosterUrl], [YouTubeTrailer], [InCollection]) VALUES (8, 5, 2, N'Toy Story', 862, N'G', CAST(N'1995-11-21' AS Date), 81, N'Woody the cowboy is young Andy’s favorite toy. Yet this changes when Andy get the new super toy Buzz Lightyear for his birthday. Now that Woody is no longer number one he plans his revenge on Buzz. Toy Story is a milestone in film history for being the first feature film to use entirely computer animation.', N'http://image.tmdb.org/t/p/w396/agy8DheVu5zpQFbXfAdvYivF2FU.jpg', N'http://www.youtube.com/embed/4KPTXpQehio', 1)
INSERT [dbo].[Movies] ([MovieID], [DirectorID], [StudioID], [MovieTitle], [MovieTMDBNum], [Rating], [ReleaseDate], [DurationInMin], [Synopsis], [PosterUrl], [YouTubeTrailer], [InCollection]) VALUES (9, 6, 2, N'Toy Story 3', 10193, N'G', CAST(N'2010-06-17' AS Date), 103, N'Woody, Buzz, and the rest of Andy''s toys haven''t been played with in years. With Andy about to go to college, the gang find themselves accidentally left at a nefarious day care center. The toys must band together to escape and return home to Andy.', N'http://image.tmdb.org/t/p/w396/tOwAAVeL1p3ls9dhOBo45ElodU3.jpg', N'http://www.youtube.com/embed/TNMpa5yBf5o', 1)
INSERT [dbo].[Movies] ([MovieID], [DirectorID], [StudioID], [MovieTitle], [MovieTMDBNum], [Rating], [ReleaseDate], [DurationInMin], [Synopsis], [PosterUrl], [YouTubeTrailer], [InCollection]) VALUES (10, 5, 2, N'Toy Story 2', 863, N'G', CAST(N'1999-11-24' AS Date), 92, N'During a garage sale Andy’s mother sells some of Andy’s old things including his favorite toy Woody to a collector. Buzz Lightyear and the other toys begin a reckless mission to save their friend. The sequel to the revolutionary computer animated feature film Toy Story.', N'http://image.tmdb.org/t/p/w396/gd12nM0VnrgbaUmZDjte4oBedGZ.jpg', N'http://www.youtube.com/embed/Lu0sotERXhI', 1)
INSERT [dbo].[Movies] ([MovieID], [DirectorID], [StudioID], [MovieTitle], [MovieTMDBNum], [Rating], [ReleaseDate], [DurationInMin], [Synopsis], [PosterUrl], [YouTubeTrailer], [InCollection]) VALUES (11, 7, 5, N'Terminator 2: Judgment Day', 280, N'R', CAST(N'1991-07-01' AS Date), 137, N'Nearly 10 years have passed since Sarah Connor was targeted for termination by a cyborg from the future. Now her son, John, the future leader of the resistance, is the target for a newer, more deadly terminator. Once again, the resistance has managed to send a protector back to attempt to save John and his mother Sarah.', N'http://image.tmdb.org/t/p/w396/2y4dmgWYRMYXdD1UyJVcn2HSd1D.jpg', N'http://www.youtube.com/embed/eajuMYNYtuY', 1)
INSERT [dbo].[Movies] ([MovieID], [DirectorID], [StudioID], [MovieTitle], [MovieTMDBNum], [Rating], [ReleaseDate], [DurationInMin], [Synopsis], [PosterUrl], [YouTubeTrailer], [InCollection]) VALUES (12, 7, 6, N'The Terminator', 218, N'R', CAST(N'1984-10-26' AS Date), 108, N'In the post-apocalyptic future, reigning tyrannical supercomputers teleport a cyborg assassin known as the "Terminator" back to 1984 to kill Sarah Connor, whose unborn son is destined to lead insurgents against 21st century mechanical hegemony. Meanwhile, the human-resistance movement dispatches a lone warrior to safeguard Sarah. Can he stop the virtually indestructible killing machine?', N'http://image.tmdb.org/t/p/w396/q8ffBuxQlYOHrvPniLgCbmKK4Lv.jpg', N'http://www.youtube.com/embed/c4Jo8QoOTQ4', 1)
INSERT [dbo].[Movies] ([MovieID], [DirectorID], [StudioID], [MovieTitle], [MovieTMDBNum], [Rating], [ReleaseDate], [DurationInMin], [Synopsis], [PosterUrl], [YouTubeTrailer], [InCollection]) VALUES (13, 8, 7, N'The Godfather', 238, N'R', CAST(N'1972-03-15' AS Date), 175, N'The story spans the years from 1945 to 1955 and chronicles the fictional Italian-American Corleone crime family. When organized crime family patriarch Vito Corleone barely survives an attempt on his life, his youngest son, Michael, steps in to take care of the would-be killers, launching a campaign of bloody revenge.', N'http://image.tmdb.org/t/p/w396/d4KNaTrltq6bpkFS01pYtyXa09m.jpg', N'http://www.youtube.com/embed/sY1S34973zA', 1)
INSERT [dbo].[Movies] ([MovieID], [DirectorID], [StudioID], [MovieTitle], [MovieTMDBNum], [Rating], [ReleaseDate], [DurationInMin], [Synopsis], [PosterUrl], [YouTubeTrailer], [InCollection]) VALUES (14, 8, 7, N'The Godfather: Part II', 240, N'R', CAST(N'1974-12-20' AS Date), 200, N'The continuing saga of the Corleone crime family tells the story of a young Vito Corleone growing up in Sicily and in 1910s New York; and follows Michael Corleone in the 1950s as he attempts to expand the family business into Las Vegas, Hollywood and Cuba', N'http://image.tmdb.org/t/p/w396/tHbMIIF51rguMNSastqoQwR0sBs.jpg', N'http://www.youtube.com/embed/8PyZCU2vpi8', 1)
INSERT [dbo].[Movies] ([MovieID], [DirectorID], [StudioID], [MovieTitle], [MovieTMDBNum], [Rating], [ReleaseDate], [DurationInMin], [Synopsis], [PosterUrl], [YouTubeTrailer], [InCollection]) VALUES (15, 9, 8, N'Back to the Future', 105, N'PG', CAST(N'1985-07-03' AS Date), 116, N'Eighties teenager Marty McFly is accidentally sent back in time to 1955, inadvertently disrupting his parents'' first meeting and attracting his mother''s romantic interest. Marty must repair the damage to history by rekindling his parents'' romance and - with the help of his eccentric inventor friend Doc Brown - return to 1985.', N'http://image.tmdb.org/t/p/w396/pTpxQB1N0waaSc3OSn0e9oc8kx9.jpg', N'http://www.youtube.com/embed/7i89wUv25QU', 1)
INSERT [dbo].[Movies] ([MovieID], [DirectorID], [StudioID], [MovieTitle], [MovieTMDBNum], [Rating], [ReleaseDate], [DurationInMin], [Synopsis], [PosterUrl], [YouTubeTrailer], [InCollection]) VALUES (16, 9, 8, N'Back to the Future Part III', 196, N'PG', CAST(N'1990-05-25' AS Date), 118, N'The final installment of the Back to the Future trilogy finds Marty digging the trusty DeLorean out of a mineshaft and looking up Doc in the Wild West of 1885. But when their time machine breaks down, the travelers are stranded in a land of spurs. More problems arise when Doc falls for pretty schoolteacher Clara Clayton, and Marty tangles with Buford Tannen.', N'http://image.tmdb.org/t/p/w396/6DmgPTZYaug7QNDjOhUDWyjOQDl.jpg', N'http://www.youtube.com/embed/3C8c3EoEfw4', 1)
INSERT [dbo].[Movies] ([MovieID], [DirectorID], [StudioID], [MovieTitle], [MovieTMDBNum], [Rating], [ReleaseDate], [DurationInMin], [Synopsis], [PosterUrl], [YouTubeTrailer], [InCollection]) VALUES (17, 9, 8, N'Back to the Future Part II', 165, N'PG', CAST(N'1989-11-20' AS Date), 108, N'Marty and Doc are at it again in this wacky sequel to the 1985 blockbuster as the time-traveling duo head to 2015 to nip some McFly family woes in the bud. But things go awry thanks to bully Biff Tannen and a pesky sports almanac. In a last-ditch attempt to set things straight, Marty finds himself bound for 1955 and face to face with his teenage parents -- again.', N'http://image.tmdb.org/t/p/w396/k5dzvCQkXU2CAhLtlj9BHE7xmyK.jpg', N'http://www.youtube.com/embed/MdENmefJRpw', 1)
INSERT [dbo].[Movies] ([MovieID], [DirectorID], [StudioID], [MovieTitle], [MovieTMDBNum], [Rating], [ReleaseDate], [DurationInMin], [Synopsis], [PosterUrl], [YouTubeTrailer], [InCollection]) VALUES (18, 9, 7, N'Forrest Gump', 13, N'PG-13', CAST(N'1994-06-22' AS Date), 142, N'A man with a low IQ has accomplished great things in his life and been present during significant historic events - in each case, far exceeding what anyone imagined he could do. Yet, despite all the things he has attained, his one true love eludes him. ''Forrest Gump'' is the story of a man who rose above his challenges, and who proved that determination, courage, and love are more important than ability.', N'http://image.tmdb.org/t/p/w396/z4ROnCrL77ZMzT0MsNXY5j25wS2.jpg', N'http://www.youtube.com/embed/8dcYw4OwCA0', 1)
INSERT [dbo].[Movies] ([MovieID], [DirectorID], [StudioID], [MovieTitle], [MovieTMDBNum], [Rating], [ReleaseDate], [DurationInMin], [Synopsis], [PosterUrl], [YouTubeTrailer], [InCollection]) VALUES (19, 10, 9, N'Gigli', 8046, N'R', CAST(N'2003-08-01' AS Date), 121, N'Larry Gigli is a low-ranking mobster who is commanded to kidnap the mentally challenged, Baywatch-obsessed younger brother of a powerful federal prosecutor to save his mobster boss from prison. Gigli successfully convinces the young man, Brian, to go off with him by promising to take him "to the Baywatch." However, Gigli''s boss, Louis, does not trust him; he hires a woman calling herself Ricki to take over the job.', N'http://image.tmdb.org/t/p/w396/dpWU4g7XTkGmDt1BLg1ON0a3T4q.jpg', N'http://www.youtube.com/embed/Q_VxogXPAhM', 1)
INSERT [dbo].[Movies] ([MovieID], [DirectorID], [StudioID], [MovieTitle], [MovieTMDBNum], [Rating], [ReleaseDate], [DurationInMin], [Synopsis], [PosterUrl], [YouTubeTrailer], [InCollection]) VALUES (20, 11, 8, N'Jurassic Park', 329, N'PG-13', CAST(N'1993-06-08' AS Date), 127, N'A wealthy entrepreneur secretly creates a theme park featuring living dinosaurs drawn from prehistoric DNA. Before opening day, he invites a team of experts and his two eager grandchildren to experience the park and help calm anxious investors. However, the park is anything but amusing as the security systems go off-line and the dinosaurs escape.', N'http://image.tmdb.org/t/p/w396/msfyV01zy5dxy4JlXCpEVFRXwGO.jpg', N'http://www.youtube.com/embed/QWBKEmWWL38', 1)
INSERT [dbo].[Movies] ([MovieID], [DirectorID], [StudioID], [MovieTitle], [MovieTMDBNum], [Rating], [ReleaseDate], [DurationInMin], [Synopsis], [PosterUrl], [YouTubeTrailer], [InCollection]) VALUES (21, 12, 10, N'The Dark Knight', 155, N'PG-13', CAST(N'2008-07-18' AS Date), 152, N'Batman raises the stakes in his war on crime. With the help of Lt. Jim Gordon and District Attorney Harvey Dent, Batman sets out to dismantle the remaining criminal organizations that plague the streets. The partnership proves to be effective, but they soon find themselves prey to a reign of chaos unleashed by a rising criminal mastermind known to the terrified citizens of Gotham as the Joker.', N'http://image.tmdb.org/t/p/w396/1hRoyzDtpgMU7Dz4JF22RANzQO7.jpg', N'http://www.youtube.com/embed/GVx5K8WfFJY', 1)
INSERT [dbo].[Movies] ([MovieID], [DirectorID], [StudioID], [MovieTitle], [MovieTMDBNum], [Rating], [ReleaseDate], [DurationInMin], [Synopsis], [PosterUrl], [YouTubeTrailer], [InCollection]) VALUES (22, 12, 11, N'The Dark Knight Rises', 49026, N'PG-13', CAST(N'2012-07-20' AS Date), 165, N'Following the death of District Attorney Harvey Dent, Batman assumes responsibility for Dent''s crimes to protect the late attorney''s reputation and is subsequently hunted by the Gotham City Police Department. Eight years later, Batman encounters the mysterious Selina Kyle and the villainous Bane, a new terrorist leader who overwhelms Gotham''s finest. The Dark Knight resurfaces to protect a city that has branded him an enemy.', N'http://image.tmdb.org/t/p/w396/dEYnvnUfXrqvqeRSqvIEtmzhoA8.jpg', N'http://www.youtube.com/embed/7gFwvozMHR4', 1)
INSERT [dbo].[Movies] ([MovieID], [DirectorID], [StudioID], [MovieTitle], [MovieTMDBNum], [Rating], [ReleaseDate], [DurationInMin], [Synopsis], [PosterUrl], [YouTubeTrailer], [InCollection]) VALUES (23, 13, 12, N'Blade Runner', 78, N'R', CAST(N'1982-06-25' AS Date), 117, N'In the smog-choked dystopian Los Angeles of 2019, blade runner Rick Deckard is called out of retirement to kill a quartet of replicants who have escaped to Earth seeking their creator for a way to extend their short life spans.', N'http://image.tmdb.org/t/p/w396/5ig0kdWz5kxR4PHjyCgyI5khCzd.jpg', N'http://www.youtube.com/embed/W_9rhPDLHWk', 1)
INSERT [dbo].[Movies] ([MovieID], [DirectorID], [StudioID], [MovieTitle], [MovieTMDBNum], [Rating], [ReleaseDate], [DurationInMin], [Synopsis], [PosterUrl], [YouTubeTrailer], [InCollection]) VALUES (24, 12, 10, N'Batman Begins', 272, N'PG-13', CAST(N'2005-06-15' AS Date), 140, N'Driven by tragedy, billionaire Bruce Wayne dedicates his life to uncovering and defeating the corruption that plagues his home, Gotham City.  Unable to work within the system, he instead creates a new identity, a symbol of fear for the criminal underworld - The Batman.', N'http://image.tmdb.org/t/p/w396/mYsoCOq82b08juHGxd3WnotiCAh.jpg', N'http://www.youtube.com/embed/dYYRjVof6TU', 1)
INSERT [dbo].[Movies] ([MovieID], [DirectorID], [StudioID], [MovieTitle], [MovieTMDBNum], [Rating], [ReleaseDate], [DurationInMin], [Synopsis], [PosterUrl], [YouTubeTrailer], [InCollection]) VALUES (25, 14, 13, N'Pulp Fiction', 680, N'R', CAST(N'1994-10-14' AS Date), 154, N'A burger-loving hit man, his philosophical partner, a drug-addled gangster''s moll and a washed-up boxer converge in this sprawling, comedic crime caper. Their adventures unfurl in three stories that ingeniously trip back and forth in time.', N'http://image.tmdb.org/t/p/w396/dM2w364MScsjFf8pfMbaWUcWrR.jpg', N'http://www.youtube.com/embed/s7EdQ4FqbhY', 1)
INSERT [dbo].[Movies] ([MovieID], [DirectorID], [StudioID], [MovieTitle], [MovieTMDBNum], [Rating], [ReleaseDate], [DurationInMin], [Synopsis], [PosterUrl], [YouTubeTrailer], [InCollection]) VALUES (26, 15, 14, N'Taken', 8681, N'PG-13', CAST(N'2008-09-25' AS Date), 93, N'While vacationing with a friend in Paris, an American girl is kidnapped by a gang of human traffickers intent on selling her into forced prostitution. Working against the clock, her ex-spy father must pull out all the stops to save her. But with his best years possibly behind him, the job may be more than he can handle.', N'http://image.tmdb.org/t/p/w396/3zlffXmo7QpVBc17QIJWrRfasVr.jpg', N'http://www.youtube.com/embed/CvUxdQ4q-Lg', 1)
INSERT [dbo].[Movies] ([MovieID], [DirectorID], [StudioID], [MovieTitle], [MovieTMDBNum], [Rating], [ReleaseDate], [DurationInMin], [Synopsis], [PosterUrl], [YouTubeTrailer], [InCollection]) VALUES (27, 16, 15, N'Wedding Crashers', 9522, N'R', CAST(N'2005-07-14' AS Date), 119, N'John and his buddy Jeremy are emotional criminals who know how to use a woman''s hopes and dreams for their own carnal gain. And their modus operandi? Crashing weddings. Normally, they meet guests who want to toast the romantic day with a random hook-up. But when John meets Claire, he discovers what true love -- and heartache -- feels like.', N'http://image.tmdb.org/t/p/w396/vlnDz1Y3IcBhPyQAqAVtNghx4Eq.jpg', N'http://www.youtube.com/embed/VYrEQbtV2V4', 1)
SET IDENTITY_INSERT [dbo].[Movies] OFF
SET IDENTITY_INSERT [dbo].[Studios] ON 

INSERT [dbo].[Studios] ([StudioID], [StudioName], [StudioTMDBNum]) VALUES (1, N'Lucasfilm', 1)
INSERT [dbo].[Studios] ([StudioID], [StudioName], [StudioTMDBNum]) VALUES (2, N'Walt Disney Pictures', 2)
INSERT [dbo].[Studios] ([StudioID], [StudioName], [StudioTMDBNum]) VALUES (3, N'Tokuma Shoten', 1779)
INSERT [dbo].[Studios] ([StudioID], [StudioName], [StudioTMDBNum]) VALUES (4, N'Topcraft', 29)
INSERT [dbo].[Studios] ([StudioID], [StudioName], [StudioTMDBNum]) VALUES (5, N'Canal Plus', 104)
INSERT [dbo].[Studios] ([StudioID], [StudioName], [StudioTMDBNum]) VALUES (6, N'Pacific Western', 1280)
INSERT [dbo].[Studios] ([StudioID], [StudioName], [StudioTMDBNum]) VALUES (7, N'Paramount Pictures', 4)
INSERT [dbo].[Studios] ([StudioID], [StudioName], [StudioTMDBNum]) VALUES (8, N'Universal Pictures', 33)
INSERT [dbo].[Studios] ([StudioID], [StudioName], [StudioTMDBNum]) VALUES (9, N'City Light Films', 136)
INSERT [dbo].[Studios] ([StudioID], [StudioName], [StudioTMDBNum]) VALUES (10, N'DC Comics', 429)
INSERT [dbo].[Studios] ([StudioID], [StudioName], [StudioTMDBNum]) VALUES (11, N'Legendary Pictures', 923)
INSERT [dbo].[Studios] ([StudioID], [StudioName], [StudioTMDBNum]) VALUES (12, N'Shaw Brothers', 5798)
INSERT [dbo].[Studios] ([StudioID], [StudioName], [StudioTMDBNum]) VALUES (13, N'Miramax Films', 14)
INSERT [dbo].[Studios] ([StudioID], [StudioName], [StudioTMDBNum]) VALUES (14, N'20th Century Fox', 25)
INSERT [dbo].[Studios] ([StudioID], [StudioName], [StudioTMDBNum]) VALUES (15, N'New Line Cinema', 12)
SET IDENTITY_INSERT [dbo].[Studios] OFF
SET IDENTITY_INSERT [dbo].[UserRatings] ON 

INSERT [dbo].[UserRatings] ([UserRatingID], [BorrowerID], [MovieID], [Rating], [OwnerRating]) VALUES (1, 1, 4, 5, 1)
INSERT [dbo].[UserRatings] ([UserRatingID], [BorrowerID], [MovieID], [Rating], [OwnerRating]) VALUES (2, 1, 5, 5, 1)
INSERT [dbo].[UserRatings] ([UserRatingID], [BorrowerID], [MovieID], [Rating], [OwnerRating]) VALUES (3, 1, 1, 5, 1)
INSERT [dbo].[UserRatings] ([UserRatingID], [BorrowerID], [MovieID], [Rating], [OwnerRating]) VALUES (4, 1, 2, 5, 1)
INSERT [dbo].[UserRatings] ([UserRatingID], [BorrowerID], [MovieID], [Rating], [OwnerRating]) VALUES (5, 1, 3, 5, 1)
INSERT [dbo].[UserRatings] ([UserRatingID], [BorrowerID], [MovieID], [Rating], [OwnerRating]) VALUES (6, 1, 7, 5, 1)
INSERT [dbo].[UserRatings] ([UserRatingID], [BorrowerID], [MovieID], [Rating], [OwnerRating]) VALUES (7, 6, 7, 4, 0)
INSERT [dbo].[UserRatings] ([UserRatingID], [BorrowerID], [MovieID], [Rating], [OwnerRating]) VALUES (8, 1, 6, 4, 1)
INSERT [dbo].[UserRatings] ([UserRatingID], [BorrowerID], [MovieID], [Rating], [OwnerRating]) VALUES (9, 1, 15, 5, 1)
INSERT [dbo].[UserRatings] ([UserRatingID], [BorrowerID], [MovieID], [Rating], [OwnerRating]) VALUES (10, 1, 16, 3, 1)
INSERT [dbo].[UserRatings] ([UserRatingID], [BorrowerID], [MovieID], [Rating], [OwnerRating]) VALUES (11, 1, 17, 5, 1)
INSERT [dbo].[UserRatings] ([UserRatingID], [BorrowerID], [MovieID], [Rating], [OwnerRating]) VALUES (12, 1, 18, 5, 1)
INSERT [dbo].[UserRatings] ([UserRatingID], [BorrowerID], [MovieID], [Rating], [OwnerRating]) VALUES (13, 9, 18, 5, 0)
INSERT [dbo].[UserRatings] ([UserRatingID], [BorrowerID], [MovieID], [Rating], [OwnerRating]) VALUES (14, 1, 23, 5, 1)
INSERT [dbo].[UserRatings] ([UserRatingID], [BorrowerID], [MovieID], [Rating], [OwnerRating]) VALUES (15, 5, 23, 4, 0)
INSERT [dbo].[UserRatings] ([UserRatingID], [BorrowerID], [MovieID], [Rating], [OwnerRating]) VALUES (16, 1, 24, 4, 1)
INSERT [dbo].[UserRatings] ([UserRatingID], [BorrowerID], [MovieID], [Rating], [OwnerRating]) VALUES (17, 4, 24, 5, 0)
INSERT [dbo].[UserRatings] ([UserRatingID], [BorrowerID], [MovieID], [Rating], [OwnerRating]) VALUES (18, 1, 27, 5, 1)
INSERT [dbo].[UserRatings] ([UserRatingID], [BorrowerID], [MovieID], [Rating], [OwnerRating]) VALUES (19, 8, 27, 2, 0)
INSERT [dbo].[UserRatings] ([UserRatingID], [BorrowerID], [MovieID], [Rating], [OwnerRating]) VALUES (20, 1, 12, 4, 1)
INSERT [dbo].[UserRatings] ([UserRatingID], [BorrowerID], [MovieID], [Rating], [OwnerRating]) VALUES (21, 1, 14, 5, 1)
INSERT [dbo].[UserRatings] ([UserRatingID], [BorrowerID], [MovieID], [Rating], [OwnerRating]) VALUES (22, 1, 22, 4, 1)
INSERT [dbo].[UserRatings] ([UserRatingID], [BorrowerID], [MovieID], [Rating], [OwnerRating]) VALUES (23, 1, 21, 5, 1)
INSERT [dbo].[UserRatings] ([UserRatingID], [BorrowerID], [MovieID], [Rating], [OwnerRating]) VALUES (24, 1, 13, 5, 1)
INSERT [dbo].[UserRatings] ([UserRatingID], [BorrowerID], [MovieID], [Rating], [OwnerRating]) VALUES (25, 8, 13, 4, 0)
INSERT [dbo].[UserRatings] ([UserRatingID], [BorrowerID], [MovieID], [Rating], [OwnerRating]) VALUES (26, 1, 11, 5, 1)
INSERT [dbo].[UserRatings] ([UserRatingID], [BorrowerID], [MovieID], [Rating], [OwnerRating]) VALUES (27, 1, 26, 5, 1)
INSERT [dbo].[UserRatings] ([UserRatingID], [BorrowerID], [MovieID], [Rating], [OwnerRating]) VALUES (28, 7, 26, 5, 0)
INSERT [dbo].[UserRatings] ([UserRatingID], [BorrowerID], [MovieID], [Rating], [OwnerRating]) VALUES (29, 4, 26, 5, 0)
INSERT [dbo].[UserRatings] ([UserRatingID], [BorrowerID], [MovieID], [Rating], [OwnerRating]) VALUES (30, 1, 25, 5, 1)
INSERT [dbo].[UserRatings] ([UserRatingID], [BorrowerID], [MovieID], [Rating], [OwnerRating]) VALUES (31, 1, 20, 5, 1)
INSERT [dbo].[UserRatings] ([UserRatingID], [BorrowerID], [MovieID], [Rating], [OwnerRating]) VALUES (32, 2, 20, 4, 0)
INSERT [dbo].[UserRatings] ([UserRatingID], [BorrowerID], [MovieID], [Rating], [OwnerRating]) VALUES (33, 1, 19, 1, 1)
INSERT [dbo].[UserRatings] ([UserRatingID], [BorrowerID], [MovieID], [Rating], [OwnerRating]) VALUES (34, 5, 19, 1, 0)
INSERT [dbo].[UserRatings] ([UserRatingID], [BorrowerID], [MovieID], [Rating], [OwnerRating]) VALUES (35, 4, 19, 1, 0)
SET IDENTITY_INSERT [dbo].[UserRatings] OFF
ALTER TABLE [dbo].[ActorsMovies]  WITH CHECK ADD FOREIGN KEY([ActorID])
REFERENCES [dbo].[Actors] ([ActorID])
GO
ALTER TABLE [dbo].[ActorsMovies]  WITH CHECK ADD FOREIGN KEY([MovieID])
REFERENCES [dbo].[Movies] ([MovieID])
GO
ALTER TABLE [dbo].[BorrowerStatuses]  WITH CHECK ADD FOREIGN KEY([BorrowerID])
REFERENCES [dbo].[Borrowers] ([BorrowerID])
GO
ALTER TABLE [dbo].[BorrowerStatuses]  WITH CHECK ADD FOREIGN KEY([DVDID])
REFERENCES [dbo].[DVDs] ([DVDID])
GO
ALTER TABLE [dbo].[DVDs]  WITH CHECK ADD FOREIGN KEY([MovieID])
REFERENCES [dbo].[Movies] ([MovieID])
GO
ALTER TABLE [dbo].[GenresMovies]  WITH CHECK ADD FOREIGN KEY([GenreID])
REFERENCES [dbo].[Genres] ([GenreID])
GO
ALTER TABLE [dbo].[GenresMovies]  WITH CHECK ADD FOREIGN KEY([MovieID])
REFERENCES [dbo].[Movies] ([MovieID])
GO
ALTER TABLE [dbo].[MovieAliases]  WITH CHECK ADD FOREIGN KEY([MovieID])
REFERENCES [dbo].[Movies] ([MovieID])
GO
ALTER TABLE [dbo].[Movies]  WITH CHECK ADD FOREIGN KEY([DirectorID])
REFERENCES [dbo].[Directors] ([DirectorID])
GO
ALTER TABLE [dbo].[Movies]  WITH CHECK ADD FOREIGN KEY([StudioID])
REFERENCES [dbo].[Studios] ([StudioID])
GO
ALTER TABLE [dbo].[UserNotes]  WITH CHECK ADD FOREIGN KEY([BorrowerID])
REFERENCES [dbo].[Borrowers] ([BorrowerID])
GO
ALTER TABLE [dbo].[UserNotes]  WITH CHECK ADD FOREIGN KEY([MovieID])
REFERENCES [dbo].[Movies] ([MovieID])
GO
ALTER TABLE [dbo].[UserRatings]  WITH CHECK ADD FOREIGN KEY([BorrowerID])
REFERENCES [dbo].[Borrowers] ([BorrowerID])
GO
ALTER TABLE [dbo].[UserRatings]  WITH CHECK ADD FOREIGN KEY([MovieID])
REFERENCES [dbo].[Movies] ([MovieID])
GO
/****** Object:  StoredProcedure [dbo].[AddDVDtoDeletedDVDs]    Script Date: 12/2/2015 5:30:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[AddDVDtoDeletedDVDs](
	@DVDID int,
	@MovieID int,
	@DVDType nvarchar(30)
	)
	as
begin
	insert into DeletedDVDs (DVDID, MovieID, DVDType)
	values (@DVDID, @MovieID, @DVDType)

end

--REMOVE DVD--11.12


GO
/****** Object:  StoredProcedure [dbo].[AddNewActorMovieToActorsMovies]    Script Date: 12/2/2015 5:30:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[AddNewActorMovieToActorsMovies](
	@ActorID int,
	@MovieID int,
	@CharacterName nvarchar(50)
	)
	as
begin
	insert into ActorsMovies(ActorID, MovieID, CharacterName)
	values (@ActorID, @MovieID, @CharacterName)
end


--ADD GENRE X MOVIE--11.12


GO
/****** Object:  StoredProcedure [dbo].[AddNewActorToActors]    Script Date: 12/2/2015 5:30:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[AddNewActorToActors](
	@ActorName nvarchar(100),
	@ActorTMDBNum int, 
	@ActorID int output
	)
	as
begin
	insert into Actors (ActorName, ActorTMDBNum)
	values (@ActorName, @ActorTMDBNum)

	set @ActorID = SCOPE_IDENTITY();
end

-- ADD MOVIES--11.12


GO
/****** Object:  StoredProcedure [dbo].[AddNewBorrowerToBorrowers]    Script Date: 12/2/2015 5:30:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create procedure [dbo].[AddNewBorrowerToBorrowers](
	@IsOwner bit,
	@FirstName nvarchar(50),
	@LastName nvarchar(50),
	@Email nvarchar(100),
	@StreetAddress nvarchar(100),
	@City nvarchar(100),
	@State nvarchar(100),
	@Zipcode nvarchar(10),
	@Phone nvarchar(20),
	@BorrowerID int output
	)
	as
begin
	insert into Borrowers (IsOwner, FirstName, LastName, Email, StreetAddress, City, [State], Zipcode, Phone)
	values (@IsOwner, @FirstName, @LastName, @Email, @StreetAddress, @City, @State, @Zipcode, @Phone)

	set @BorrowerID = SCOPE_IDENTITY();
end

--ADD USER NOTES--11.12


GO
/****** Object:  StoredProcedure [dbo].[AddNewDirectorToDirectors]    Script Date: 12/2/2015 5:30:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create procedure [dbo].[AddNewDirectorToDirectors](
	@DirectorName nvarchar(100),
	@DirectorTMDBNum int,
	@DirectorID int output
	)
	as
begin
	insert into Directors (DirectorName, DirectorTMDBNum)
	values (@DirectorName, @DirectorTMDBNum)

	set @DirectorID = SCOPE_IDENTITY();
end

--ADD ACTORS--11.12


GO
/****** Object:  StoredProcedure [dbo].[AddNewDVDToDVDs]    Script Date: 12/2/2015 5:30:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[AddNewDVDToDVDs](
	@MovieID int,
	@DVDType nvarchar(50),
	@DVDID int output
	)
	as
begin
	insert into DVDs (MovieID, DVDType)
	values (@MovieID, @DVDType)

	set @DVDID = SCOPE_IDENTITY();
end

--RENT DVD--11.18 (Dean)


GO
/****** Object:  StoredProcedure [dbo].[AddNewGenreMovieToGenresMovies]    Script Date: 12/2/2015 5:30:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[AddNewGenreMovieToGenresMovies](
	@GenreID int,
	@MovieID int
	)
	as
begin
	insert into GenresMovies (GenreID, MovieID)
	values (@GenreID, @MovieID)
end


--ADD DVD--11.15 (Dean)

GO
/****** Object:  StoredProcedure [dbo].[AddNewGenreToGenres]    Script Date: 12/2/2015 5:30:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[AddNewGenreToGenres](
	@GenreName nvarchar(50),
	@GenreID int output
	)
	as
begin
	insert into Genres (GenreName)
	values (@GenreName)

	set @GenreID = SCOPE_IDENTITY();
end

--ADD ACTOR X MOVIE--11.12


GO
/****** Object:  StoredProcedure [dbo].[AddNewMovieAliasToMovieAliases]    Script Date: 12/2/2015 5:30:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[AddNewMovieAliasToMovieAliases](
	@MovieID int,
	@MovieAlias nvarchar(100),
	@MovieAliasID int output
	)
	as
begin
	insert into MovieAliases (MovieID, MovieAlias)
	values (@MovieID, @MovieAlias)

	set @MovieAliasID = SCOPE_IDENTITY();
end

--ADD GENRE--11.12


GO
/****** Object:  StoredProcedure [dbo].[AddNewMovieToMovies]    Script Date: 12/2/2015 5:30:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create procedure [dbo].[AddNewMovieToMovies](
	@DirectorID int,
	@StudioID int,
	@MovieTitle nvarchar(100),
	@MovieTMDBNum int,
	@Rating nvarchar(10),
	@ReleaseDate date,
	@DurationInMin int,
	@Synopsis nvarchar(500),
	@PosterUrl nvarchar(200),
	@YouTubeTrailer nvarchar(200),
	@InCollection bit,
	@MovieID int output
	) 	
	as
begin
	insert into Movies (DirectorID, StudioID, MovieTitle, MovieTMDBNum, Rating, ReleaseDate, DurationInMin, Synopsis, PosterUrl, YouTubeTrailer, InCollection)
	values(@DirectorID, @StudioID, @MovieTitle, @MovieTMDBNum, @Rating, @ReleaseDate, @DurationInMin, @Synopsis, @PosterUrl, @YouTubeTrailer, @InCollection)

	set @MovieID = SCOPE_IDENTITY();
end

--ADD BORROWERS--11.12


GO
/****** Object:  StoredProcedure [dbo].[AddNewStudioToStudios]    Script Date: 12/2/2015 5:30:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

----ADD STUDIO--11.12

Create Procedure [dbo].[AddNewStudioToStudios](
	@StudioName nvarchar(50), 
	@StudioTMDBNum int,
	@StudioID int output
	)
	as
begin
	insert into Studios (StudioName, StudioTMDBNum)
	values (@StudioName, @StudioTMDBNum)

	set @StudioID = SCOPE_IDENTITY();
end

--ADD DIRECTOR--11.12


GO
/****** Object:  StoredProcedure [dbo].[AddNewUserNoteToUserNotes]    Script Date: 12/2/2015 5:30:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[AddNewUserNoteToUserNotes](
	@BorrowerID int,
	@MovieID int,
	@Note nvarchar(500),
	@OwnerNote bit,
	@UserNotesID int output
	)
	as
begin
	insert into UserNotes (BorrowerID, MovieID, Note, OwnerNote)
	values (@BorrowerID, @MovieID, @Note, @OwnerNote)

	set @UserNotesID = SCOPE_IDENTITY();
end


--ADD MOVIE ALIASES--11.12


GO
/****** Object:  StoredProcedure [dbo].[AddNewUserRatingToUserRatings]    Script Date: 12/2/2015 5:30:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[AddNewUserRatingToUserRatings](
	@BorrowerID int,
	@MovieID int,
	@Rating int,
	@OwnerRating bit,
	@UserRatingID int output
	)
	as
begin
	insert into UserRatings (BorrowerID, MovieID, Rating, OwnerRating)
	values (@BorrowerID, @MovieID, @Rating, @OwnerRating)

	set @UserRatingID = SCOPE_IDENTITY();
end

--UPDATE PREVIOUS USER RATING --11.20

GO
/****** Object:  StoredProcedure [dbo].[ChangeInCollectionBoolean]    Script Date: 12/2/2015 5:30:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[ChangeInCollectionBoolean](
	@MovieID int,
	@InCollection bit
	)
	as
begin
	update Movies
	set InCollection=@InCollection
	where MovieID=@MovieID

end


--Add DVDID and Info to DeletedDVDs table (Dean) --11.19

GO
/****** Object:  StoredProcedure [dbo].[GetActorsListByMovieID]    Script Date: 12/2/2015 5:30:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[GetActorsListByMovieID](
	@MovieID int
	)
	as
begin
	SELECT am.ActorID, a.ActorName, a.ActorTMDBNum, am.CharacterName
	FROM ActorsMovies am
		LEFT JOIN Actors a on am.ActorID = a.ActorID
	WHERE am.MovieID = @MovieID
end

--Get Genres List for Movie by MovieID


GO
/****** Object:  StoredProcedure [dbo].[GetBorrowerStatusesByDVDID]    Script Date: 12/2/2015 5:30:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[GetBorrowerStatusesByDVDID](
	@DVDID int
	)
	as
begin
	SELECT bs.BorrowerStatusID, bs.BorrowerID, bs.DVDID, bs.DateBorrowed, bs.DateReturned, b.IsOwner, b.FirstName,
	b.LastName, b.Email, b.StreetAddress, b.City, b.[State], b.Zipcode, b.Phone
	FROM BorrowerStatuses bs
		LEFT JOIN Borrowers b on bs.BorrowerID = b.BorrowerID
	WHERE bs.DVDID = @DVDID
end
GO
/****** Object:  StoredProcedure [dbo].[GetDVDInfoByMovieID]    Script Date: 12/2/2015 5:30:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[GetDVDInfoByMovieID](
	@MovieID int
	)
	as
begin
	SELECT d.DVDID, d.MovieID, d.DVDType
	FROM DVDs d
	WHERE d.MovieID = @MovieID

end

--Get BorrowerStatuses for a DVD by DVDID


GO
/****** Object:  StoredProcedure [dbo].[GetGenresListByMovieID]    Script Date: 12/2/2015 5:30:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[GetGenresListByMovieID](
	@MovieID int
	)
	as
begin
	SELECT gm.GenreID, g.GenreName
	FROM GenresMovies gm
		LEFT JOIN Genres g on gm.GenreID = g.GenreID
	WHERE gm.MovieID = @MovieID
end


--Get Movie Aliases List for Movie by MovieID


GO
/****** Object:  StoredProcedure [dbo].[GetMovieAliasesByMovieID]    Script Date: 12/2/2015 5:30:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[GetMovieAliasesByMovieID](
	@MovieID int
	)
	as
begin
	SELECT ma.MovieAliasID, ma.MovieAlias
	FROM MovieAliases ma
	WHERE ma.MovieID = @MovieID
end

--Get UserRatings for Movie by MovieID


GO
/****** Object:  StoredProcedure [dbo].[GetMovieInfoByMovieId]    Script Date: 12/2/2015 5:30:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[GetMovieInfoByMovieId](
	@MovieID int
	)
	as
begin
	SELECT m.MovieID, m.MovieTitle, m.MovieTMDBNum, m.ReleaseDate, m.DurationInMin, m.Rating, m.Synopsis, m.PosterUrl,
	m.YouTubeTrailer, m.DirectorID, d.DirectorName, d.DirectorTMDBNum, m.StudioID, s.StudioName, s.StudioTMDBNum
	FROM Movies m
		LEFT JOIN Directors d on m.DirectorID = d.DirectorID
		LEFT JOIN Studios s on m.StudioID = s.StudioID
	WHERE m.MovieID = @MovieID
end


--Get Actors List for Movie by MovieID


GO
/****** Object:  StoredProcedure [dbo].[GetUserNotesByMovieID]    Script Date: 12/2/2015 5:30:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[GetUserNotesByMovieID](
	@MovieID int
	)
	as
begin
	SELECT un.UserNoteID, un.BorrowerID, un.MovieID, m.MovieTitle, un.Note, un.OwnerNote, b.FirstName, b.LastName
	FROM UserNotes un
		LEFT JOIN Borrowers b on un.BorrowerID = b.BorrowerID
		LEFT JOIN Movies m on un.MovieID = m.MovieID
	WHERE un.MovieID = @MovieID
end


--Get DVDID and DVDType Info by MovieID


GO
/****** Object:  StoredProcedure [dbo].[GetUserRatingsByMovieID]    Script Date: 12/2/2015 5:30:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[GetUserRatingsByMovieID](
	@MovieID int
	)
	as
begin
	SELECT ur.UserRatingID, ur.MovieID, ur.BorrowerID, ur.Rating, ur.OwnerRating, 
	b.FirstName, b.LastName
	FROM UserRatings ur
		LEFT JOIN Borrowers b on ur.BorrowerID = b.BorrowerID
	WHERE ur.MovieID = @MovieID
end

--Get UserNotes for Movie by MovieID


GO
/****** Object:  StoredProcedure [dbo].[RemoveBorrowerStatusOnDVDID]    Script Date: 12/2/2015 5:30:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[RemoveBorrowerStatusOnDVDID](
	@DVDID int
	)
	as
begin
	delete from BorrowerStatuses
	where DVDID=@DVDID
end


--ADD USER RATING--11.12


GO
/****** Object:  StoredProcedure [dbo].[RemoveDVDFromDVDs]    Script Date: 12/2/2015 5:30:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[RemoveDVDFromDVDs](
	@DVDID int
	)
	as
begin
	delete from DVDs
	where DVDID = @DVDID
end


--REMOVE USER NOTES--11.12


GO
/****** Object:  StoredProcedure [dbo].[RemoveUserNotesFromUserNotes]    Script Date: 12/2/2015 5:30:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[RemoveUserNotesFromUserNotes](
	@UserNoteID int
	)
	as
begin
	delete from UserNotes
	where UserNoteID = @UserNoteID
end

--REMOVE USER RATING--11.12


GO
/****** Object:  StoredProcedure [dbo].[RemoveUserRatingFromUserRatings]    Script Date: 12/2/2015 5:30:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[RemoveUserRatingFromUserRatings](
	@UserRatingID int
	)
	as
begin
	delete from UserRatings
	where UserRatingID = @UserRatingID
end	

--REMOVE BORRWERSTATUSES on DVDID

GO
/****** Object:  StoredProcedure [dbo].[RentDVDToBorrowerStatuses]    Script Date: 12/2/2015 5:30:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[RentDVDToBorrowerStatuses](
	@BorrowerID int,
	@DVDID int,
	@DateBorrowed date,
	@BorrowerStatusID int output
	)
	as
begin 
	insert into BorrowerStatuses (BorrowerID, DVDID, DateBorrowed)
	values (@BorrowerID, @DVDID, @DateBorrowed)

	set @BorrowerStatusID = SCOPE_IDENTITY();
end


--RETURN DVD--11.18 (Dean)

GO
/****** Object:  StoredProcedure [dbo].[ReturnDVDToBorrowerStatuses]    Script Date: 12/2/2015 5:30:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[ReturnDVDToBorrowerStatuses](
	@BorrowerStatusID int,
	@DateReturned date
	)
	as
begin 
	update BorrowerStatuses
	set DateReturned=@DateReturned
	where BorrowerStatusID=@BorrowerStatusID
	
end

--Movie is in collection to TRUE (Dean) --11.18

GO
/****** Object:  StoredProcedure [dbo].[UpdateUserRating]    Script Date: 12/2/2015 5:30:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[UpdateUserRating](
	@BorrowerID int,
	@MovieID int,
	@Rating int
	)
	as
begin
	update UserRatings
	set Rating=@Rating
	where BorrowerID=@BorrowerID and MovieID=@MovieID
end

GO
USE [master]
GO
ALTER DATABASE [TestDVDLibrary] SET  READ_WRITE 
GO
