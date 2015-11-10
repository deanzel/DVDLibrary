use master
go

create database DVDLibrary
go

use DVDLibrary
go

create table Categories (
	CategoryID int identity(1,1) primary key,
	Name nvarchar(50) not null
)
go

create table Movies (
	MovieID int identity(1,1) primary key,
	CategoryID int foreign key references Categories(CategoryID),
	Title nvarchar(50) not null,
	MovieTMDBNum int, 
	Rating nvarchar(10),
	ReleaseDate date not null,
	DurationInMin int not null,
	Synopsis nvarchar(500) not null
)
go

create table Borrowers (
	BorrowerID int identity(1,1) primary key,
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

create table BorrowerStatuses (
	BorrowerStatusID int identity(1,1) primary key,
	BorrowerID int foreign key references Borrowers(BorrowerID) not null,
	CheckOutDate date not null,
	CheckInDate date
)
go

create table DVDs (
	DVDID int identity(1,1) primary key,
	MovieID int foreign key references Movies(MovieID) not null,
	BorrowerStatusID int foreign key references [BorrowerStatuses](BorrowerStatusID) not null,
	DVDType nvarchar(25) not null
)
go

create table Directors (
	DirectorID int identity(1,1) primary key,
	MovieID int foreign key references Movies(MovieID) not null,
	DirectorName nvarchar(100) not null,
	DirectorTMDBNum int
)
go

create table Actors (
	ActorID int identity(1,1) primary key,
	MovieID int foreign key references Movies(MovieID) not null,
	ActorName nvarchar(100) not null,
	ActorTMDBID int

)
go

create table Studios (
	StudioID int identity(1,1) primary key,
	MovieID int foreign key references Movies(MovieID) not null,
	StudioName nvarchar(50) not null,
	StudioTMDBNum int
)
go

create table UserRatings (
	UserRatingID int identity(1,1) primary key,
	BorrowerID int foreign key references Borrowers(BorrowerID) not null,
	MovieID int foreign key references Movies(MovieID) not null,
	Rating int not null
)
go

create table UserNotes(
	UserNote int identity(1,1) primary key,
	BorrowerID int foreign key references Borrowers(BorrowerID) not null,
	MovieID int foreign key references Movies(MovieID) not null,
	Note nvarchar(500) not null
)
go

create table MovieAliases (
	MovieAliasID int identity(1,1) primary key,
	MovieID int foreign key references Movies(MovieID) not null,
	MovieAlias nvarchar(100) not null
)
go