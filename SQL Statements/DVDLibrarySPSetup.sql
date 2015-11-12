USE [DVDLibrary]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--ADD STUDIO

Create Procedure [dbo].[AddNewStudioFromMovie](
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

--ADD DIRECTOR

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

--ADD ACTORS

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

-- ADD MOVIES

Go
Create procedure [dbo].[AddNewMovieToMovies](
	@MovieTitle nchar(50),
	@MovieTMDBNum int,
	@Rating nvarchar(10),
	@ReleaseDate date,
	@DurationInMin int,
	@Synopsis nvarchar(500),
	@PosterUrl nvarchar(200),
	@MovieID int output
	) 	
	as
begin
	insert into Movies (MovieTitle, MovieTMDBNum, Rating, ReleaseDate, DurationInMin, Synopsis, PosterUrl)
	values(@MovieTitle, @MovieTMDBNum, @Rating, @ReleaseDate, @DurationInMin, @Synopsis, @PosterUrl)

	set @MovieID = SCOPE_IDENTITY();
end

--ADD BORROWERS

GO
Create procedure [dbo].[AddBorrowerToBorrowers](
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
	insert into Borrowers (FirstName, LastName, Email, StreetAddress, City, [State], Zipcode, Phone)
	values (@FirstName, @LastName, @Email, @StreetAddress, @City, @State, @Zipcode, @Phone)

	set @BorrowerID = SCOPE_IDENTITY();
end

--ADD USER RATING

go
create procedure [dbo].[AddUserRatingToUserRatings](
	@BorrowerID int,
	@MovieID int,
	@Rating int,
	@UserRatingID int output
	)
	as
begin
	insert into UserRatings (BorrowerID, MovieID, Rating)
	values (@BorrowerID, @MovieID, @Rating)

	set @UserRatingID = SCOPE_IDENTITY();
end

--ADD USER NOTES

go
create procedure [dbo].[AddUserNotesToUserNotes](
	@BorrowerID int,
	@MovieID int,
	@Note nvarchar(500),
	@UserNotesID int output
	)
	as
begin
	insert into UserNotes (BorrowerID, MovieID, Note)
	values (@BorrowerID, @MovieID, @Note)

	set @UserNotesID = SCOPE_IDENTITY();
end

--ADD BORROWER STATUSES

go
create procedure [dbo].[AddBorrowerStatusesToBorrowerStatuses](
	@BorrowerID int,
	@CheckOutDate date,
	@CheckInDate date,
	@BorrowerStatusID int output
	)
	as
begin 
	insert into BorrowerStatuses (BorrowerID, CheckOutDate, CheckInDate)
	values (@BorrowerID, @CheckOutDate, @CheckInDate)

	set @BorrowerStatusID = SCOPE_IDENTITY();
end

--ADD MOVIE ALIASES

go
create procedure [dbo].[AddMovieAlisesToMovieAliases](
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

--REMOVE DVD

go
create procedure [dbo].[RemoveDVDFromDVDs](
	@DVDID int
	)
	as
begin
	delete from DVDs
	where DVDID = @DVDID
end

--REMOVE MOVIE

go
create procedure [dbo].RemoveMovieFromMovies(
	@MovieID int
	)
	as
begin
	delete from Movies
	where @MovieID = MovieID
end

--REMOVE ACTOR

go
create procedure [dbo].[RemoveActorFromActors](
	@MovieID int
	)
	as
begin
	delete from Actors
	where @MovieID = MovieID
end

--REMOVE DIRECTOR

go 
create procedure [dbo].[RemoveDirectorFromDirectors](
	@MovieID int
	)
	as
begin
	delete from Directors
	where @MovieID = MovieID
end

--REMOVE MOVIE ALIASES

go
create procedure [dbo].[RemoveMovieAliasesFromMovieAliases](
	@MovieID int
	)
	as
begin
	delete from MovieAliases
	where @MovieID = MovieID
end

--REMOVE STUDIO

go
create procedure [dbo].[RemoveStudioFromStudios](
	@MovieID int
	)
	as
begin
	delete from Studios
	where @MovieID = MovieID
end

--REMOVE USER NOTES

go 
create procedure [dbo].[RemoveUserNotesFromUserNotes](
	@MovieID int
	)
	as
begin
	delete from UserNotes
	where @MovieID = MovieID
end

--REMOVE USER RATING

go 
create procedure [dbo].[RemoveUserRatingFromUserRatings](
	@MovieID int
	)
	as
begin
	delete from UserRatings
	where @MovieID = MovieID
end	
	

	






