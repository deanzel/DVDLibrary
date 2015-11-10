use master
go

create database DVDLibrary
go

use DVDLibrary
go

create table Category (
	CategoryID int identity(1,1) primary key,
	Name nvarchar(50) not null
)
go

create table Movie (
	MovieID int identity(1,1) primary key,
	CategoryID int foreign key references Category(CategoryID),
	Title nvarchar(50) not null,
	Rating nvarchar(10),
	ReleaseDate date not null,
	DurationInMin int not null,
	Synopsis nvarchar(500) not null
)
go

create table Borrower (
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

create table BorrowerStatus (
	BorrowerStatusID int identity(1,1) primary key,
	BorrowerID int foreign key references Borrower(BorrowerID) not null,
	CheckOutDate date not null,
	CheckInDate date not null
)
go

create table DVD (
	DVDID int identity(1,1) primary key,
	MovieID int foreign key references Movie(MovieID) not null,
	BorrowerStatusID int foreign key references [BorrowerStatus](BorrowerStatusID) not null,
	DVDType nvarchar(25) not null
)
go

create table Director (
	DirectorID int identity(1,1) primary key,
	MovieID int foreign key references Movie(MovieID) not null,
	Name nvarchar(100) not null
)
go

create table Actor (
	ActorID int identity(1,1) primary key,
	MovieID int foreign key references Movie(MovieID) not null,
	Name nvarchar(100) not null
)
go

create table Studio (
	StudioID int identity(1,1) primary key,
	MovieID int foreign key references Movie(MovieID) not null,
	Name nvarchar(50) not null
)
go

create table UserRating (
	UserRatingID int identity(1,1) primary key,
	BorrowerID int foreign key references Borrower(BorrowerID) not null,
	MovieID int foreign key references Movie(MovieID) not null,
	Rating int not null
)
go

create table UserNote(
	UserNote int identity(1,1) primary key,
	BorrowerID int foreign key references Borrower(BorrowerID) not null,
	MovieID int foreign key references Movie(MovieID) not null,
	Note nvarchar(250) not null
)
go

create table MovieAlias (
	MovieAliasID int identity(1,1) primary key,
	MovieID int foreign key references Movie(MovieID) not null,
	MovieAlias nvarchar(100) not null
)
go