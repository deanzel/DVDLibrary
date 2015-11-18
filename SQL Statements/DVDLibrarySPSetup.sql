USE [DVDLibrary]
GO

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

Go
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

Go 
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

Go
Create procedure [dbo].[AddNewMovieToMovies](
	@DirectorID int,
	@StudioID int,
	@MovieTitle nchar(50),
	@MovieTMDBNum int,
	@Rating nvarchar(10),
	@ReleaseDate date,
	@DurationInMin int,
	@Synopsis nvarchar(500),
	@PosterUrl nvarchar(200),
	@YouTubeTrailer nvarchar(200),
	@MovieID int output
	) 	
	as
begin
	insert into Movies (DirectorID, StudioID, MovieTitle, MovieTMDBNum, Rating, ReleaseDate, DurationInMin, Synopsis, PosterUrl, YouTubeTrailer)
	values(@DirectorID, @StudioID, @MovieTitle, @MovieTMDBNum, @Rating, @ReleaseDate, @DurationInMin, @Synopsis, @PosterUrl, @YouTubeTrailer)

	set @MovieID = SCOPE_IDENTITY();
end

--ADD BORROWERS--11.12

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

--ADD USER RATING--11.12

go
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

--ADD USER NOTES--11.12

go
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

go
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

go
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

go
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

go
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
go
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

go
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


--REMOVE DVD--11.12

go
create procedure [dbo].[RemoveDVDFromDVDs](
	@DVDID int
	)
	as
begin
	delete from DVDs
	where DVDID = @DVDID
end

--REMOVE MOVIE--11.12

go
create procedure [dbo].RemoveMovieFromMovies(
	@MovieID int
	)
	as
begin
	delete from Movies
	where @MovieID = MovieID
end

--REMOVE ACTOR--11.12

go
create procedure [dbo].[RemoveActorFromActors](
	@ActorID int
	)
	as
begin
	delete from Actors
	where ActorID = @ActorID
end

--REMOVE DIRECTOR--11.12

go 
create procedure [dbo].[RemoveDirectorFromDirectors](
	@DirectorID int
	)
	as
begin
	delete from Directors
	where @DirectorID = DirectorID
end

--REMOVE MOVIE ALIASES--11.12

go
create procedure [dbo].[RemoveMovieAliasesFromMovieAliases](
	@MovieID int
	)
	as
begin
	delete from MovieAliases
	where @MovieID = MovieID
end

--REMOVE STUDIO--11.12

go
create procedure [dbo].[RemoveStudioFromStudios](
	@StudioID int
	)
	as
begin
	delete from Studios
	where @StudioID = StudioID
end

--REMOVE USER NOTES--11.12

go 
create procedure [dbo].[RemoveUserNotesFromUserNotes](
	@UserNoteID int
	)
	as
begin
	delete from UserNotes
	where @UserNoteID = UserNoteID
end

--REMOVE USER RATING--11.12

go 
create procedure [dbo].[RemoveUserRatingFromUserRatings](
	@UserRatingID int
	)
	as
begin
	delete from UserRatings
	where @UserRatingID = UserRatingID
end	

--REMOVE BORROWER STATUS X DVD

go
create procedure [dbo].[RemoveBorrowerStatusDVDFromBorrowersStatusesDVDs](
	@BorrowerStatusID int,
	@DVDID int
	)
	as
begin
	delete from BorrowerStatusesDVDs
	where @BorrowerStatusID = BorrowerStatusID
	and @DVDID = DVDID
end

--REMOVE ACTOR X MOVIE--11.12

go
create procedure [dbo].[RemoveActorMovieFromActorsMovies](
	@ActorID int,
	@MovieID int
	)
	as
begin
	delete from ActorsMovies
	where @ActorID = ActorID
	and @MovieID = MovieID
end

--REMOVE GENRE X MOVIE--11.12

go
create procedure [dbo].[RemoveGenreMovieFromGenresMovies](
	@GenreID int,
	@MovieID int
	)
	as
begin
	delete from GenresMovies
	where @GenreID = GenreID
	and @MovieID = MovieID
end



	






