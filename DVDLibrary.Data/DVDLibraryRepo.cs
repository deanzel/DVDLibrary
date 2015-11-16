﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dapper;
using DVDLibrary.Data.Config;
using DVDLibrary.Models;
using TMDbLib.Client;
using TMDbLib.Objects.General;
using TMDbLib.Objects.Movies;
using TMDbLib.Objects.Search;
using Movie = TMDbLib.Objects.Movies.Movie;

namespace DVDLibrary.Data
{
    public class DVDLibraryRepo
    {
        private List<DVD> ListOfDVDs;
        private List<Models.Movie> ListOfMovies;

        public DVDLibraryRepo()
        {
            ListOfDVDs = new List<DVD>();
            ListOfMovies = new List<Models.Movie>();

            //InitializeMockDataRepo();
        }

        //Initialize a mock list of DVDs and movies
        public void InitializeMockDataRepo()
        {
            for (int i = 11; i < 20; i++)
            {
                DVD newDVD = new DVD();
                newDVD.DVDId = i - 10;
                newDVD.DVDType = "Blu-Ray";

                newDVD.Movie = ReturnMovieInfoFromTMDB(i);
                newDVD.Movie.MovieId = i - 10;

                //**need to show status info:
                //Status status = new Status();
                //{
                //    StatusId = i - 10;
                //}

                UserNote newUserNote = new UserNote()
                {
                    UserNoteId = i - 10,
                    BorrowerId = 1,
                    BorrowerName = "Dean Choi",
                    MovieId = i - 10,
                    Note = "Greatest. Movie. EVAR!!!!!",
                    Owner = true
                };
                newDVD.Movie.UserNotes.Add(newUserNote);

                UserNote newUserNote2 = new UserNote()
                {
                    UserNoteId = (i - 10)*100,
                    BorrowerId = 2,
                    BorrowerName = "Chary Gurney",
                    MovieId = i - 10,
                    Note = "FAIL!!!!!",
                    Owner = false
                };
                newDVD.Movie.UserNotes.Add(newUserNote2);

                UserRating newUserRating = new UserRating()
                {
                    BorrowerId = 1,
                    BorrowerName = "Dean Choi",
                    MovieId = i - 10,
                    Rating = 9,
                    UserRatingId = i - 10,
                    Owner = true
                };
                newDVD.Movie.UserRatings.Add(newUserRating);

                UserRating newUserRating2 = new UserRating()
                {
                    BorrowerId = 2,
                    BorrowerName = "Charey Gurney",
                    MovieId = i - 10,
                    Rating = 2,
                    UserRatingId = (i - 10)*100,
                    Owner = false
                };
                newDVD.Movie.UserRatings.Add(newUserRating2);

                ListOfDVDs.Add(newDVD);
                ListOfMovies.Add(newDVD.Movie);
            }
        }

        //Return DVDList (mock)
        public List<DVD> RetrieveDVDsList()
        {
            return ListOfDVDs;
        }

        //Return MoviesList (mock)
        public List<Models.Movie> RetrieveMoviesList()
        {
            return ListOfMovies;
        }

        //Build ListOfMovies list from SQL Database method (just with basic info)
        public List<Models.Movie> RetrieveMoviesListFromDB()
        {
            List<Models.Movie> moviesListFromDB = new List<Models.Movie>();

            using (var cn = new SqlConnection(Settings.ConnectionString))
            {
                var cmd = new SqlCommand();
                cmd.CommandText = ("SELECT [MovieID], [MovieTitle], [ReleaseDate], [Synopsis], [PosterUrl], [Rating] From Movies");
                cmd.Connection = cn;
                cn.Open();

                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        Models.Movie movieToAdd = PopulateMovieFromDataReaderShort(dr);
                        moviesListFromDB.Add(movieToAdd);
                    }
                }
            }
            return moviesListFromDB;
        } 


        //Retrieve Full Movie Info and DVDs based on MovieID from the SQL DB
        public List<DVD> RetrieveFullDVDInfoFromDB(int movieId)
        {
            List<DVD> listOfDVDInfo = new List<DVD>();

            using (var cn = new SqlConnection(Settings.ConnectionString))
            {
                var cmd = new SqlCommand();

                Models.Movie movieInfo = new Models.Movie();

                //Get Movie Info including Director & Studio By MovieId

                cmd.CommandText = "GetMovieInfoByMovieId";
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Connection = cn;
                cmd.Parameters.AddWithValue("@MovieID", movieId);

                cn.Open();
                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        movieInfo.MovieId = int.Parse(dr["MovieID"].ToString());
                        movieInfo.MovieTitle = dr["MovieTitle"].ToString();
                        movieInfo.MovieTMDBNum = int.Parse(dr["MovieTMDBNum"].ToString());
                        movieInfo.ReleaseDate = DateTime.Parse(dr["ReleaseDate"].ToString());
                        movieInfo.MpaaRating = dr["Rating"].ToString();
                        if (dr["Synopsis"] != DBNull.Value)
                        {
                            movieInfo.Synopsis = dr["Synopsis"].ToString();
                        }
                        if (dr["PosterUrl"] != DBNull.Value)
                        {
                            movieInfo.PosterUrl = dr["PosterUrl"].ToString();
                        }
                        if (dr["YouTubeTrailer"] != DBNull.Value)
                        {
                            movieInfo.YouTubeTrailer = dr["YouTubeTrailer"].ToString();
                        }
                        movieInfo.Director.DirectorId = int.Parse(dr["DirectorID"].ToString());
                        movieInfo.Director.DirectorName = dr["DirectorName"].ToString();
                        if (dr["DirectorTMDBNum"] != DBNull.Value)
                        {
                            movieInfo.Director.DirectorTMDBNum = int.Parse(dr["DirectorTMDBNum"].ToString());
                        }
                        movieInfo.Studio.StudioId = int.Parse(dr["StudioID"].ToString());
                        movieInfo.Studio.StudioName = dr["StudioName"].ToString();
                        if (dr["StudioTMDBNum"] != DBNull.Value)
                        {
                            movieInfo.Studio.StudioTMDBNum = int.Parse(dr["StudioTMDBNum"].ToString());
                        }

                    }
                }
                cn.Close();


                //Get Actors List for Movie by MovieID
                cmd.CommandText = "GetActorsListByMovieID";
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Connection = cn;
                cmd.Parameters.Clear();
                cmd.Parameters.AddWithValue("@MovieID", movieId);
                //Perhaps need an option if Actor List is null *****GetActorsListByMovieID has too many arguments specified
                cn.Open();
                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        if (dr["ActorID"] != DBNull.Value)
                        {
                            Actor newActor = new Actor();
                            newActor.ActorId = int.Parse(dr["ActorID"].ToString());

                            if (dr["ActorName"] != DBNull.Value)
                            {
                                newActor.ActorName = dr["ActorName"].ToString();
                            }
                            if (dr["ActorTMDBNum"] != DBNull.Value)
                            {
                                newActor.ActorTMDBNum = int.Parse(dr["ActorTMDBNum"].ToString());
                            }
                            if (dr["CharacterName"] != DBNull.Value)
                            {
                                newActor.CharacterName = dr["CharacterName"].ToString();
                            }
                            movieInfo.MovieActors.Add(newActor);
                        }
                    }
                }
                cn.Close();


                //Get Genres List for Movie by MovieID
                cmd.CommandText = "GetGenresListByMovieID";
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Connection = cn;
                cmd.Parameters.Clear();
                cmd.Parameters.AddWithValue("@MovieID", movieId);

                cn.Open();
                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {

                        if (dr["GenreID"] != DBNull.Value)
                        {
                            Models.Genre newGenre = new Models.Genre();
                            newGenre.GenreId = int.Parse(dr["GenreID"].ToString());

                            if (dr["GenreName"] != DBNull.Value)
                            {
                                newGenre.GenreName = dr["GenreName"].ToString();
                            }
                            movieInfo.Genres.Add(newGenre);
                        }
                    }
                }
                cn.Close();


                //Get Movie Aliases List for Movie by MovieID
                cmd.CommandText = "GetMovieAliasesByMovieID";
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Connection = cn;
                cmd.Parameters.Clear();
                cmd.Parameters.AddWithValue("@MovieID", movieId);

                cn.Open();
                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {

                        if (dr["MovieAliasID"] != DBNull.Value)
                        {
                            MovieAlias newMovieAlias = new MovieAlias();
                            newMovieAlias.MovieAliasId = int.Parse(dr["MovieAliasID"].ToString());

                            if (dr["MovieAlias"] != DBNull.Value)
                            {
                                newMovieAlias.MovieAliasTitle = dr["MovieAlias"].ToString();
                            }
                            movieInfo.MovieAliases.Add(newMovieAlias);
                        }
                    }
                }
                cn.Close();

                //Get User Ratings for Movie by MovieID
                cmd.CommandText = "GetUserRatingsByMovieID";
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Connection = cn;
                cmd.Parameters.Clear();
                cmd.Parameters.AddWithValue("@MovieID", movieId);

                cn.Open();
                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {

                        if (dr["UserRatingID"] != DBNull.Value)
                        {
                            UserRating newUserRating = new UserRating();
                            newUserRating.UserRatingId = int.Parse(dr["UserRatingID"].ToString());

                            if (dr["MovieID"] != DBNull.Value)
                            {
                                newUserRating.MovieId = int.Parse(dr["MovieID"].ToString());
                            }
                            if (dr["BorrowerID"] != DBNull.Value)
                            {
                                newUserRating.BorrowerId = int.Parse(dr["BorrowerID"].ToString());
                            }
                            if (dr["Rating"] != DBNull.Value)
                            {
                                newUserRating.Rating = int.Parse(dr["Rating"].ToString());
                            }
                            if (dr["OwnerRating"] != DBNull.Value)
                            {
                                newUserRating.Owner = bool.Parse(dr["OwnerRating"].ToString());
                            }
                            if (dr["FirstName"] != DBNull.Value)
                            {
                                newUserRating.BorrowerName = (dr["FirstName"].ToString() + " " +
                                                              dr["LastName"].ToString());
                            }
                            movieInfo.UserRatings.Add(newUserRating);
                        }
                    }
                }
                cn.Close();


                //Get User Notes for Movie by MovieID
                cmd.CommandText = "GetUserNotesByMovieID";
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Connection = cn;
                cmd.Parameters.Clear();
                cmd.Parameters.AddWithValue("@MovieID", movieId);

                cn.Open();
                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {

                        if (dr["UserNoteID"] != DBNull.Value)
                        {
                            UserNote newUserNote = new UserNote();
                            newUserNote.UserNoteId = int.Parse(dr["UserNoteID"].ToString());

                            if (dr["MovieID"] != DBNull.Value)
                            {
                                newUserNote.MovieId = int.Parse(dr["MovieID"].ToString());
                            }
                            if (dr["BorrowerID"] != DBNull.Value)
                            {
                                newUserNote.BorrowerId = int.Parse(dr["BorrowerID"].ToString());
                            }
                            if (dr["Note"] != DBNull.Value)
                            {
                                newUserNote.Note = dr["Note"].ToString();
                            }
                            if (dr["OwnerNote"] != DBNull.Value)
                            {
                                newUserNote.Owner = bool.Parse(dr["OwnerNote"].ToString());
                            }
                            if (dr["FirstName"] != DBNull.Value)
                            {
                                newUserNote.BorrowerName = (dr["FirstName"].ToString() + " " + dr["LastName"].ToString());
                            }
                            movieInfo.UserNotes.Add(newUserNote);
                        }
                    }
                }
                cn.Close();


                //Get DVDID and DVDType Info by MovieID
                cmd.CommandText = "GetDVDInfoByMovieID";
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Connection = cn;
                cmd.Parameters.Clear();
                cmd.Parameters.AddWithValue("@MovieID", movieId);

                cn.Open();
                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        if (dr["DVDID"] != DBNull.Value)
                        {
                            DVD newDVD = new DVD();
                            newDVD.DVDId = int.Parse(dr["DVDID"].ToString());
                            if (dr["DVDType"] != DBNull.Value)
                            {
                                newDVD.DVDType = dr["DVDType"].ToString();
                            }
                            newDVD.Movie = movieInfo;

                            listOfDVDInfo.Add(newDVD);
                        }
                    }
                }
                cn.Close();


                //Get Borrower Statuses for a DVD by DVDID
                foreach (var d in listOfDVDInfo)
                {
                    cmd.CommandText = "GetBorrowerStatusesByDVDID";
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Connection = cn;
                    cmd.Parameters.Clear();
                    cmd.Parameters.AddWithValue("@DVDID", d.DVDId);

                    cn.Open();
                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        while (dr.Read())
                        {
                            if (dr["BorrowerStatusID"] != DBNull.Value)
                            {
                                Status newStatus = new Status();
                                newStatus.StatusId = int.Parse(dr["BorrowerStatusID"].ToString());
                                if (dr["BorrowerID"] != DBNull.Value)
                                {
                                    newStatus.Borrower.BorrowerId = int.Parse(dr["BorrowerID"].ToString());
                                }
                                if (dr["DVDID"] != DBNull.Value)
                                {
                                    newStatus.DVDId = int.Parse(dr["DVDID"].ToString());
                                }
                                if (dr["CheckOutDate"] != DBNull.Value)
                                {
                                    newStatus.DateBorrowed = DateTime.Parse(dr["CheckOutDate"].ToString());
                                }
                                if (dr["CheckInDate"] != DBNull.Value)
                                {
                                    newStatus.DateReturned = DateTime.Parse(dr["CheckInDate"].ToString());
                                }
                                if (dr["IsOwner"] != DBNull.Value)
                                {
                                    newStatus.Borrower.IsOwner = bool.Parse(dr["IsOwner"].ToString());
                                }
                                if (dr["FirstName"] != DBNull.Value)
                                {
                                    newStatus.Borrower.FirstName = dr["FirstName"].ToString();
                                }
                                if (dr["LastName"] != DBNull.Value)
                                {
                                    newStatus.Borrower.LastName = dr["LastName"].ToString();
                                }
                                if (dr["Email"] != DBNull.Value)
                                {
                                    newStatus.Borrower.Email = dr["Email"].ToString();
                                }
                                if (dr["StreetAddress"] != DBNull.Value)
                                {
                                    newStatus.Borrower.Address = dr["StreetAddress"].ToString();
                                }
                                if (dr["City"] != DBNull.Value)
                                {
                                    newStatus.Borrower.City = dr["City"].ToString();
                                }
                                if (dr["State"] != DBNull.Value)
                                {
                                    newStatus.Borrower.State = dr["State"].ToString();
                                }
                                if (dr["Zipcode"] != DBNull.Value)
                                {
                                    newStatus.Borrower.Zipcode = dr["Zipcode"].ToString();
                                }
                                if (dr["Phone"] != DBNull.Value)
                                {
                                    newStatus.Borrower.Phone = dr["Phone"].ToString();
                                }
                                d.Statuses.Add(newStatus);
                            }
                        }
                    }
                    cn.Close();
                }

            }

            return listOfDVDInfo;
        } 


        //Adding a New DVD To the SQL Database (Checks if it already exists as well)
        public DVD AddNewDVDToDBViaTMDB(DVD newDVD)
        {
            using (SqlConnection cn = new SqlConnection(Settings.ConnectionString))
            {

                SqlCommand cmd = new SqlCommand();
                
                cmd.CommandText = "select count(movies.movietmdbnum) from movies " +
                                  "where movietmdbnum = @MovieTMDBNum";
                cmd.Parameters.AddWithValue("@MovieTMDBNum", newDVD.Movie.MovieTMDBNum);

                cmd.Connection = cn;
                cn.Open();
                int movieTMDBNumCount = int.Parse(cmd.ExecuteScalar().ToString());

                cn.Close();

                if (movieTMDBNumCount == 0)
                {

                    cmd.CommandText = ("select count(studios.studioname) from studios " +
                                       "where studioname = @StudioName");
                    cmd.Parameters.Clear();
                    cmd.Parameters.AddWithValue("@StudioName", newDVD.Movie.Studio.StudioName);

                    cn.Open();
                    int studioCount = (int) cmd.ExecuteScalar();

                    //Adding Studio
                    if (studioCount == 0)
                    {
                        var p = new DynamicParameters();

                        p.Add("StudioName", newDVD.Movie.Studio.StudioName);
                        p.Add("StudioTMDBNum", newDVD.Movie.Studio.StudioTMDBNum);
                        p.Add("StudioID", DbType.Int32, direction: ParameterDirection.Output);

                        cn.Execute("AddNewStudioToStudios", p, commandType: CommandType.StoredProcedure);

                        newDVD.Movie.Studio.StudioId = p.Get<int>("StudioID");
                    }
                    else
                    {
                        cmd.CommandText = "select studioid from studios " +
                                          "where studioname = @StudioName";
                        cmd.Parameters.Clear();
                        cmd.Parameters.AddWithValue("@StudioName", newDVD.Movie.Studio.StudioName);
                        SqlDataReader rdr = cmd.ExecuteReader();
                        while (rdr.Read())
                        {
                            newDVD.Movie.Studio.StudioId = (int) rdr["StudioID"];
                        }
                    }

                    cn.Close();


                    //Adding Director
                    cmd.CommandText = "select count(directors.directorname) from directors " +
                                      "where directorname = @DirectorName";
                    cmd.Parameters.Clear();
                    cmd.Parameters.AddWithValue("@DirectorName", newDVD.Movie.Director.DirectorName);

                    cn.Open();
                    int directorCount = (int) cmd.ExecuteScalar();

                    if (directorCount == 0)
                    {
                        var p = new DynamicParameters();

                        p.Add("DirectorName", newDVD.Movie.Director.DirectorName);
                        p.Add("DirectorTMDBNum", newDVD.Movie.Director.DirectorTMDBNum);
                        p.Add("DirectorID", DbType.Int32, direction: ParameterDirection.Output);

                        cn.Execute("AddNewDirectorToDirectors", p, commandType: CommandType.StoredProcedure);

                        newDVD.Movie.Director.DirectorId = p.Get<int>("DirectorID");
                    }
                    else
                    {
                        cmd.CommandText = "select directorid from directors " +
                                          "where directorname = @DirectorName";
                        cmd.Parameters.Clear();
                        cmd.Parameters.AddWithValue("@DirectorName", newDVD.Movie.Director.DirectorName);

                        using (SqlDataReader rdr = cmd.ExecuteReader())
                        {
                            while (rdr.Read())
                            {
                                newDVD.Movie.Director.DirectorId = (int) rdr["DirectorID"];
                            }
                        }
                    }
                    cn.Close();


                    //Adding MovieInfo
                    cmd.CommandText = "select count(movies.movietitle) from movies " +
                                      "where movietitle = @MovieTitle";
                    cmd.Parameters.Clear();
                    cmd.Parameters.AddWithValue("@MovieTitle", newDVD.Movie.MovieTitle);

                    cn.Open();

                    int movieTitleCount = (int) cmd.ExecuteScalar();

                    if (movieTitleCount == 0)
                    {
                        var p = new DynamicParameters();

                        p.Add("DirectorID", newDVD.Movie.Director.DirectorId);
                        p.Add("StudioID", newDVD.Movie.Studio.StudioId);
                        p.Add("MovieTitle", newDVD.Movie.MovieTitle);
                        p.Add("MovieTMDBNum", newDVD.Movie.MovieTMDBNum);
                        p.Add("Rating", newDVD.Movie.MpaaRating);
                        p.Add("ReleaseDate", newDVD.Movie.ReleaseDate);
                        p.Add("DurationInMin", newDVD.Movie.Duration);
                        p.Add("Synopsis", newDVD.Movie.Synopsis);
                        p.Add("PosterUrl", newDVD.Movie.PosterUrl);
                        p.Add("YouTubeTrailer", newDVD.Movie.YouTubeTrailer);
                        p.Add("MovieID", DbType.Int32, direction: ParameterDirection.Output);

                        cn.Execute("AddNewMovieToMovies", p, commandType: CommandType.StoredProcedure);

                        newDVD.Movie.MovieId = p.Get<int>("MovieID");
                    }

                    cn.Close();

                    //Adding Actors
                    if (newDVD.Movie.MovieActors.Count != 0)
                    {
                        for (int i = 0; i < newDVD.Movie.MovieActors.Count; i++)
                        {
                            cmd.CommandText = "select count(actors.actorname) from actors " +
                                              "where actorname = @ActorName";
                            cmd.Parameters.Clear();
                            cmd.Parameters.AddWithValue("@ActorName", newDVD.Movie.MovieActors[i].ActorName);

                            cn.Open();

                            int actorNameCount = (int) cmd.ExecuteScalar();

                            if (actorNameCount == 0)
                            {
                                var p = new DynamicParameters();

                                p.Add("ActorName", newDVD.Movie.MovieActors[i].ActorName);
                                p.Add("ActorTMDBNum", newDVD.Movie.MovieActors[i].ActorTMDBNum);
                                p.Add("ActorID", DbType.Int32, direction: ParameterDirection.Output);

                                cn.Execute("AddNewActorToActors", p, commandType: CommandType.StoredProcedure);

                                newDVD.Movie.MovieActors[i].ActorId = p.Get<int>("ActorID");
                            }
                            else
                            {
                                cmd.CommandText = "select actorid from actors " +
                                                  "where actorname = @ActorName";
                                cmd.Parameters.Clear();
                                cmd.Parameters.AddWithValue("@ActorName", newDVD.Movie.MovieActors[i].ActorName);
                                using (SqlDataReader rdr = cmd.ExecuteReader())
                                {
                                    while (rdr.Read())
                                    {
                                        newDVD.Movie.MovieActors[i].ActorId = (int) rdr["ActorID"];
                                    }
                                }
                            }
                            cn.Close();
                        }

                        foreach (var a in newDVD.Movie.MovieActors)
                        {
                            var p = new DynamicParameters();
                            p.Add("ActorID", a.ActorId);
                            p.Add("MovieID", newDVD.Movie.MovieId);
                            p.Add("CharacterName", a.CharacterName);

                            cn.Open();

                            cn.Execute("AddNewActorMovieToActorsMovies", p, commandType: CommandType.StoredProcedure);

                            cn.Close();
                        }
                    }

                    //Adding Genres
                    if (newDVD.Movie.Genres.Count != 0)
                    {
                        for (int i = 0; i < newDVD.Movie.Genres.Count; i++)
                        {
                            cmd.CommandText = "select count(genres.genrename) from genres " +
                                              "where genrename = @GenreName";
                            cmd.Parameters.Clear();
                            cmd.Parameters.AddWithValue("@GenreName", newDVD.Movie.Genres[i].GenreName);
                            cn.Open();

                            int genresCount = (int) cmd.ExecuteScalar();

                            if (genresCount == 0)
                            {
                                var p = new DynamicParameters();

                                p.Add("GenreName", newDVD.Movie.Genres[i].GenreName);
                                p.Add("GenreID", DbType.Int32, direction: ParameterDirection.Output);

                                cn.Execute("AddNewGenreToGenres", p, commandType: CommandType.StoredProcedure);

                                newDVD.Movie.Genres[i].GenreId = p.Get<int>("GenreID");
                            }
                            else
                            {
                                cmd.CommandText = "select genreid from genres " +
                                                  "where genrename = @GenreName";
                                cmd.Parameters.Clear();
                                cmd.Parameters.AddWithValue("@GenreName", newDVD.Movie.Genres[i].GenreName);
                                using (SqlDataReader rdr = cmd.ExecuteReader())
                                {
                                    while (rdr.Read())
                                    {
                                        newDVD.Movie.Genres[i].GenreId = (int) rdr["GenreID"];
                                    }
                                }
                            }
                            cn.Close();
                        }

                        foreach (var g in newDVD.Movie.Genres)
                        {
                            var p = new DynamicParameters();
                            p.Add("GenreID", g.GenreId);
                            p.Add("MovieID", newDVD.Movie.MovieId);

                            cn.Open();

                            cn.Execute("AddNewGenreMovieToGenresMovies", p, commandType: CommandType.StoredProcedure);

                            cn.Close();
                        }
                    }

                    //Adding MovieAliases
                    if (newDVD.Movie.MovieAliases.Count != 0)
                    {
                        for (int i = 0; i < newDVD.Movie.MovieAliases.Count; i++)
                        {
                            cn.Open();

                            var p = new DynamicParameters();

                            p.Add("MovieID", newDVD.Movie.MovieId);
                            p.Add("MovieAlias", newDVD.Movie.MovieAliases[i].MovieAliasTitle);
                            p.Add("MovieAliasID", DbType.Int32, direction: ParameterDirection.Output);

                            cn.Execute("AddNewMovieAliasToMovieAliases", p, commandType: CommandType.StoredProcedure);

                            newDVD.Movie.MovieAliases[i].MovieAliasId = p.Get<int>("MovieAliasID");

                            cn.Close();
                        }
                    }
                }
                else
                {
                    cmd.CommandText = "select movieid from movies " +
                        "where movietmdbnum = @MovieTMDBNum";
                    cmd.Parameters.Clear();
                    cmd.Parameters.AddWithValue("MovieTMDBNum", newDVD.Movie.MovieTMDBNum);
                    cmd.Connection = cn;
                    cn.Open();

                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        while (dr.Read())
                        {
                            newDVD.Movie.MovieId = int.Parse(dr["MovieID"].ToString());
                        }
                    }
                    cn.Close();
                }


                //Add DVD to Database
                cn.Open();

                var pDVD = new DynamicParameters();

                pDVD.Add("MovieID", newDVD.Movie.MovieId);
                pDVD.Add("DVDType", newDVD.DVDType);
                pDVD.Add("DVDID", DbType.Int32, direction: ParameterDirection.Output);

                cn.Execute("AddNewDVDToDVDs", pDVD, commandType: CommandType.StoredProcedure);

                newDVD.DVDId = pDVD.Get<int>("DVDID");

                cn.Close();
            }

            return newDVD;
        }

        //Retrieve TMDB info with a TMDBNum
        public Models.Movie ReturnMovieInfoFromTMDB(int tmdbNum)
        {
            TMDbClient client = new TMDbClient("1fee8f2397ff73412985de2bb825f020");

            Movie movie = client.GetMovie(tmdbNum,
                MovieMethods.AlternativeTitles | MovieMethods.Credits | MovieMethods.Images | MovieMethods.Releases |
                MovieMethods.Videos);

            Models.Movie movieInfo = new Models.Movie();
            movieInfo.MovieTitle = movie.Title;
            movieInfo.MovieTMDBNum = movie.Id;
            if (movie.Releases.Countries.FirstOrDefault(m => m.Iso_3166_1 == "US").Certification != null)
            {
                movieInfo.MpaaRating = movie.Releases.Countries.FirstOrDefault(m => m.Iso_3166_1 == "US").Certification;
            }
            if (movie.ReleaseDate != null)
            {
                movieInfo.ReleaseDate = movie.ReleaseDate.Value.Date;
            }
            if (movie.Overview != null)
            {
                movieInfo.Synopsis = movie.Overview;
            }
            if (movie.Runtime != null)
            {
                movieInfo.Duration = movie.Runtime.Value;
            }
            if (movie.PosterPath != null)
            {
                movieInfo.PosterUrl = "http://image.tmdb.org/t/p/w185" + movie.PosterPath;
            }
            else
            {
                movieInfo.PosterUrl =
                    "http://assets.tmdb.org/assets/7f29bd8b3370c71dd379b0e8b570887c/images/no-poster-w185-v2.png";
            }
            if (movie.Videos.Results.Where(v => v.Type == "Trailer").FirstOrDefault() != null)
            {
                movieInfo.YouTubeTrailer = "http://www.youtube.com/embed/" +
                                           movie.Videos.Results.Where(v => v.Type == "Trailer").FirstOrDefault().Key;
            }
            if (movie.Genres.Count != 0)
            {
                foreach (var g in movie.Genres)
                {
                    var newGenre = new Models.Genre();
                    newGenre.GenreName = g.Name;
                    movieInfo.Genres.Add(newGenre);
                }
            }
            if (movie.Credits.Crew.FirstOrDefault(d => d.Job == "Director").Name != null)
            {
                movieInfo.Director.DirectorName = movie.Credits.Crew.FirstOrDefault(d => d.Job == "Director").Name;
                movieInfo.Director.DirectorTMDBNum = movie.Credits.Crew.FirstOrDefault(d => d.Job == "Director").Id;
            }
            if (movie.ProductionCompanies.Count != 0)
            {
                movieInfo.Studio.StudioName = movie.ProductionCompanies[0].Name;
                movieInfo.Studio.StudioTMDBNum = movie.ProductionCompanies[0].Id;
            }

            if (movie.AlternativeTitles.Titles.Count != 0)
            {
                foreach (var t in movie.AlternativeTitles.Titles)
                {
                    if (t.Iso_3166_1 == "US")
                    {
                        var newMovieAlias = new MovieAlias();
                        newMovieAlias.MovieAliasTitle = t.Title;
                        movieInfo.MovieAliases.Add(newMovieAlias);
                    }
                }
            }

            if (movie.Credits.Cast.Count < 10 && movie.Credits.Cast.Count > 0)
            {
                foreach (var a in movie.Credits.Cast)
                {
                    Actor newActor = new Actor();
                    newActor.ActorName = a.Name;
                    newActor.ActorTMDBNum = a.Id;
                    newActor.CharacterName = a.Character;
                    movieInfo.MovieActors.Add(newActor);
                }
            }
            else
            {
                for (int i = 0; i < 10; i++)
                {
                    Actor newActor = new Actor();
                    newActor.ActorName = movie.Credits.Cast[i].Name;
                    newActor.ActorTMDBNum = movie.Credits.Cast[i].Id;
                    newActor.CharacterName = movie.Credits.Cast[i].Character;
                    movieInfo.MovieActors.Add(newActor);
                }
            }


            return movieInfo;
        }


        public string DeleteDVD(int id)
        {
            return "Your movie has been deleted from the DVD collection";

        }

        //Search TMDB for movies to add depending on Search String
        public List<SearchTMDBResult> RetrieveTMDBSearchResults(string movieName)
        {
            List<SearchTMDBResult> listOfSearchTMDBResults = new List<SearchTMDBResult>();

            TMDbClient client = new TMDbClient("1fee8f2397ff73412985de2bb825f020");

            SearchContainer<SearchMovie> initResults = client.SearchMovie("\"" + movieName + "\"");


            if (initResults.TotalPages >= 1)
            {
                for (int i = 1; i < initResults.TotalPages + 1; i++)
                {
                    SearchContainer<SearchMovie> results = client.SearchMovie("\"" + movieName + "\"", i);

                    foreach (SearchMovie r in results.Results)
                    {
                        SearchTMDBResult newResult = new SearchTMDBResult();
                        newResult.MovieTitle = r.Title;
                        newResult.TMDBNum = r.Id;
                        if (r.ReleaseDate != null)
                        {
                            newResult.ReleaseDate = r.ReleaseDate.Value;
                        }
                        if (r.Overview != null)
                        {
                            newResult.Synopsis = r.Overview;
                        }
                        if (r.PosterPath != null)
                        {
                            newResult.PosterUrl = "http://image.tmdb.org/t/p/w185" + r.PosterPath;
                        }
                        else
                        {
                            newResult.PosterUrl =
                                "http://assets.tmdb.org/assets/7f29bd8b3370c71dd379b0e8b570887c/images/no-poster-w185-v2.png";
                        }

                        listOfSearchTMDBResults.Add(newResult);
                    }
                }
            }

            return listOfSearchTMDBResults;
        }


        //populate movieListFromDataReader
        private Models.Movie PopulateMovieFromDataReaderShort(SqlDataReader dr)
        {
            Models.Movie movie = new Models.Movie();

            movie.MovieId = int.Parse(dr["MovieID"].ToString());
            movie.MovieTitle = dr["MovieTitle"].ToString();
            movie.ReleaseDate = DateTime.Parse(dr["ReleaseDate"].ToString());
            if (dr["Synopsis"] != DBNull.Value)
            {
                movie.Synopsis = dr["Synopsis"].ToString();
            }
            if (dr["PosterUrl"] != DBNull.Value)
            {
                movie.PosterUrl = dr["PosterUrl"].ToString();
            }
            movie.MpaaRating = dr["Rating"].ToString();

            return movie;
        }
    }
}
