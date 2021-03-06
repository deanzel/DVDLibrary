USE [master]
GO
/****** Object:  Database [DVDLibrary]    Script Date: 12/3/2015 9:27:24 AM ******/
CREATE DATABASE [DVDLibrary]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DVDLibrary', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQL2014\MSSQL\DATA\DVDLibrary.mdf' , SIZE = 3264KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'DVDLibrary_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQL2014\MSSQL\DATA\DVDLibrary_log.ldf' , SIZE = 832KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [DVDLibrary] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DVDLibrary].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DVDLibrary] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DVDLibrary] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DVDLibrary] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DVDLibrary] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DVDLibrary] SET ARITHABORT OFF 
GO
ALTER DATABASE [DVDLibrary] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [DVDLibrary] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DVDLibrary] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DVDLibrary] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DVDLibrary] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DVDLibrary] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DVDLibrary] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DVDLibrary] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DVDLibrary] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DVDLibrary] SET  ENABLE_BROKER 
GO
ALTER DATABASE [DVDLibrary] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DVDLibrary] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DVDLibrary] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DVDLibrary] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DVDLibrary] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DVDLibrary] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DVDLibrary] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DVDLibrary] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [DVDLibrary] SET  MULTI_USER 
GO
ALTER DATABASE [DVDLibrary] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DVDLibrary] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DVDLibrary] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DVDLibrary] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [DVDLibrary] SET DELAYED_DURABILITY = DISABLED 
GO
USE [DVDLibrary]
GO
/****** Object:  Table [dbo].[Actors]    Script Date: 12/3/2015 9:27:24 AM ******/
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
/****** Object:  Table [dbo].[ActorsMovies]    Script Date: 12/3/2015 9:27:24 AM ******/
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
/****** Object:  Table [dbo].[Borrowers]    Script Date: 12/3/2015 9:27:24 AM ******/
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
/****** Object:  Table [dbo].[BorrowerStatuses]    Script Date: 12/3/2015 9:27:24 AM ******/
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
/****** Object:  Table [dbo].[DeletedDVDs]    Script Date: 12/3/2015 9:27:24 AM ******/
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
/****** Object:  Table [dbo].[Directors]    Script Date: 12/3/2015 9:27:24 AM ******/
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
/****** Object:  Table [dbo].[DVDs]    Script Date: 12/3/2015 9:27:24 AM ******/
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
/****** Object:  Table [dbo].[Genres]    Script Date: 12/3/2015 9:27:24 AM ******/
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
/****** Object:  Table [dbo].[GenresMovies]    Script Date: 12/3/2015 9:27:24 AM ******/
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
/****** Object:  Table [dbo].[MovieAliases]    Script Date: 12/3/2015 9:27:24 AM ******/
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
/****** Object:  Table [dbo].[Movies]    Script Date: 12/3/2015 9:27:24 AM ******/
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
/****** Object:  Table [dbo].[Studios]    Script Date: 12/3/2015 9:27:24 AM ******/
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
/****** Object:  Table [dbo].[UserNotes]    Script Date: 12/3/2015 9:27:24 AM ******/
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
/****** Object:  Table [dbo].[UserRatings]    Script Date: 12/3/2015 9:27:24 AM ******/
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
/****** Object:  StoredProcedure [dbo].[AddDVDtoDeletedDVDs]    Script Date: 12/3/2015 9:27:25 AM ******/
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
/****** Object:  StoredProcedure [dbo].[AddNewActorMovieToActorsMovies]    Script Date: 12/3/2015 9:27:25 AM ******/
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
/****** Object:  StoredProcedure [dbo].[AddNewActorToActors]    Script Date: 12/3/2015 9:27:25 AM ******/
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
/****** Object:  StoredProcedure [dbo].[AddNewBorrowerToBorrowers]    Script Date: 12/3/2015 9:27:25 AM ******/
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
/****** Object:  StoredProcedure [dbo].[AddNewDirectorToDirectors]    Script Date: 12/3/2015 9:27:25 AM ******/
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
/****** Object:  StoredProcedure [dbo].[AddNewDVDToDVDs]    Script Date: 12/3/2015 9:27:25 AM ******/
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
/****** Object:  StoredProcedure [dbo].[AddNewGenreMovieToGenresMovies]    Script Date: 12/3/2015 9:27:25 AM ******/
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
/****** Object:  StoredProcedure [dbo].[AddNewGenreToGenres]    Script Date: 12/3/2015 9:27:25 AM ******/
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
/****** Object:  StoredProcedure [dbo].[AddNewMovieAliasToMovieAliases]    Script Date: 12/3/2015 9:27:25 AM ******/
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
/****** Object:  StoredProcedure [dbo].[AddNewMovieToMovies]    Script Date: 12/3/2015 9:27:25 AM ******/
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
/****** Object:  StoredProcedure [dbo].[AddNewStudioToStudios]    Script Date: 12/3/2015 9:27:25 AM ******/
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
/****** Object:  StoredProcedure [dbo].[AddNewUserNoteToUserNotes]    Script Date: 12/3/2015 9:27:25 AM ******/
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
/****** Object:  StoredProcedure [dbo].[AddNewUserRatingToUserRatings]    Script Date: 12/3/2015 9:27:25 AM ******/
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
/****** Object:  StoredProcedure [dbo].[ChangeInCollectionBoolean]    Script Date: 12/3/2015 9:27:25 AM ******/
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
/****** Object:  StoredProcedure [dbo].[GetActorsListByMovieID]    Script Date: 12/3/2015 9:27:25 AM ******/
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
/****** Object:  StoredProcedure [dbo].[GetBorrowerStatusesByDVDID]    Script Date: 12/3/2015 9:27:25 AM ******/
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
/****** Object:  StoredProcedure [dbo].[GetDVDInfoByMovieID]    Script Date: 12/3/2015 9:27:25 AM ******/
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
/****** Object:  StoredProcedure [dbo].[GetGenresListByMovieID]    Script Date: 12/3/2015 9:27:25 AM ******/
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
/****** Object:  StoredProcedure [dbo].[GetMovieAliasesByMovieID]    Script Date: 12/3/2015 9:27:25 AM ******/
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
/****** Object:  StoredProcedure [dbo].[GetMovieInfoByMovieId]    Script Date: 12/3/2015 9:27:25 AM ******/
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
/****** Object:  StoredProcedure [dbo].[GetUserNotesByMovieID]    Script Date: 12/3/2015 9:27:25 AM ******/
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
/****** Object:  StoredProcedure [dbo].[GetUserRatingsByMovieID]    Script Date: 12/3/2015 9:27:25 AM ******/
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
/****** Object:  StoredProcedure [dbo].[RemoveBorrowerStatusOnDVDID]    Script Date: 12/3/2015 9:27:25 AM ******/
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
/****** Object:  StoredProcedure [dbo].[RemoveDVDFromDVDs]    Script Date: 12/3/2015 9:27:25 AM ******/
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
/****** Object:  StoredProcedure [dbo].[RemoveUserNotesFromUserNotes]    Script Date: 12/3/2015 9:27:25 AM ******/
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
/****** Object:  StoredProcedure [dbo].[RemoveUserRatingFromUserRatings]    Script Date: 12/3/2015 9:27:25 AM ******/
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
/****** Object:  StoredProcedure [dbo].[RentDVDToBorrowerStatuses]    Script Date: 12/3/2015 9:27:25 AM ******/
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
/****** Object:  StoredProcedure [dbo].[ReturnDVDToBorrowerStatuses]    Script Date: 12/3/2015 9:27:25 AM ******/
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
/****** Object:  StoredProcedure [dbo].[UpdateUserRating]    Script Date: 12/3/2015 9:27:25 AM ******/
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
ALTER DATABASE [DVDLibrary] SET  READ_WRITE 
GO
