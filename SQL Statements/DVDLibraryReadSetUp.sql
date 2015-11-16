USE [DVDLibrary]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--GET MOVIE INFO including Director & Studio BY MOVIEID

go
Create Procedure [dbo].[GetMovieInfoByMovieId](
	@MovieID int
	)
	as
begin
	SELECT m.MovieID, m.MovieTitle, m.MovieTMDBNum, m.ReleaseDate, m.Rating, m.Synopsis, m.PosterUrl,
	m.YouTubeTrailer, m.DirectorID, d.DirectorName, d.DirectorTMDBNum, m.StudioID, s.StudioName, s.StudioTMDBNum
	FROM Movies m
		LEFT JOIN Directors d on m.DirectorID = d.DirectorID
		LEFT JOIN Studios s on m.StudioID = s.StudioID
	WHERE m.MovieID = @MovieID
end


--Get Actors List for Movie by MovieID

go
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

go
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

go
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

go
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

go
Create Procedure [dbo].[GetUserNotesByMovieID](
	@MovieID int
	)
	as
begin
	SELECT un.UserNoteID, un.BorrowerID, un.MovieID, un.Note, un.OwnerNote, b.FirstName, b.LastName
	FROM UserNotes un
		LEFT JOIN Borrowers b on un.BorrowerID = b.BorrowerID
	WHERE un.MovieID = @MovieID
end


--Get DVDID and DVDType Info by MovieID

go
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

go
Create Procedure [dbo].[GetBorrowerStatusesByDVDID](
	@DVDID int
	)
	as
begin
	SELECT bs.BorrowerStatusID, bs.BorrowerID, bs.DVDID, bs.CheckOutDate, bs.CheckInDate, b.IsOwner, b.FirstName,
	b.LastName, b.Email, b.StreetAddress, b.City, b.[State], b.Zipcode, b.Phone
	FROM BorrowerStatuses bs
		LEFT JOIN Borrowers b on bs.BorrowerID = b.BorrowerID
	WHERE bs.DVDID = @DVDID
end