use master
go

drop database DVDLibrary
go

create database DVDLibrary
go

use DVDLibrary
go

create table Genres (
	GenreID int identity(1,1) primary key,
	GenreName nvarchar(50) not null
)
go

create table Borrowers (
	BorrowerID int identity(1,1) primary key,
	IsOwner  bit not null,
	FirstName nvarchar(50) not null,
	LastName nvarchar(50) not null,
	Email nvarchar(100) not null,
	StreetAddress nvarchar(100),
	City nvarchar(100),
	[State] nvarchar(100),
	Zipcode nvarchar(10),
	Phone nvarchar(20) not null
)
go

create table Directors (
	DirectorID int identity(1,1) primary key,
	DirectorName nvarchar(100) not null,
	DirectorTMDBNum int
)
go

create table Actors (
	ActorID int identity(1,1) primary key,
	ActorName nvarchar(100) not null,
	ActorTMDBNum int
)
go

create table Studios (
	StudioID int identity(1,1) primary key,
	StudioName nvarchar(50) not null,
	StudioTMDBNum int
)
go

create table Movies (
	MovieID int identity(1,1) primary key,
	DirectorID int foreign key references Directors(DirectorID),
	StudioID int foreign key references Studios(StudioID),
	MovieTitle nvarchar(100) not null,
	MovieTMDBNum int not null,
	Rating nvarchar(10),
	ReleaseDate date not null,
	DurationInMin int not null,
	Synopsis nvarchar(500) not null,
	PosterUrl nvarchar(200),
	YouTubeTrailer nvarchar(200),
	InCollection bit not null
)
go

create table DVDs (
	DVDID int identity(1,1) primary key,
	MovieID int foreign key references Movies(MovieID) not null,
	DVDType nvarchar(50) not null
)
go

create table BorrowerStatuses (
	BorrowerStatusID int identity(1,1) primary key,
	BorrowerID int foreign key references Borrowers(BorrowerID) not null,
	DVDID int foreign key references DVDs(DVDID) not null,
	DateBorrowed date not null,
	DateReturned date,
	DVDExists bit,
)
go

create table UserRatings (
	UserRatingID int identity(1,1) primary key,
	BorrowerID int foreign key references Borrowers(BorrowerID) not null,
	MovieID int foreign key references Movies(MovieID) not null,
	Rating int not null,
	OwnerRating bit not null
)
go

create table UserNotes(
	UserNoteID int identity(1,1) primary key,
	BorrowerID int foreign key references Borrowers(BorrowerID) not null,
	MovieID int foreign key references Movies(MovieID) not null,
	Note nvarchar(500) not null,
	OwnerNote bit not null
)
go

create table MovieAliases (
	MovieAliasID int identity(1,1) primary key,
	MovieID int foreign key references Movies(MovieID) not null,
	MovieAlias nvarchar(100) not null
)
go

create table ActorsMovies (
	ActorID int foreign key references Actors(ActorID) not null,
	MovieID int foreign key references Movies(MovieID) not null,
	CharacterName nvarchar(50),
	Constraint PK_ActorsMovies PRIMARY KEY(ActorID, MovieID)
)
go

create table GenresMovies (
	GenreID int foreign key references Genres(GenreID) not null,
	MovieID int foreign key references Movies(MovieID) not null,
	Constraint PK_GenresMovies PRIMARY KEY(GenreID, MovieID)
)
go

create table DeletedDVDs (
	DVDID int primary key not null,
	MovieID int not null,
	DVDType nvarchar(30) not null
)
go