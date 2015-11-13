USE [DVDLibrary]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--GET ALL TITLES

create procedure [dbo].[GetAllTitles]
	as
begin
	select m.MovieTitle
	from Movies m
end

--GET MOVIE BY TITLE

go
create procedure [dbo].[GetMovieObjectByTitle](
	@MovieTitle
	)
	as
begin
	select m
