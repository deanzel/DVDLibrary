using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DVDLibrary.Models;
using TMDbLib.Client;
using TMDbLib.Objects.Movies;
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

            InitializeMockDataRepo();
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
                    UserNoteId = (i - 10) * 100,
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
                    UserRatingId = (i - 10) * 100,
                    Owner = false
                };
                newDVD.Movie.UserRatings.Add(newUserRating2);

                ListOfDVDs.Add(newDVD);
                ListOfMovies.Add(newDVD.Movie);
            }
        }

        //Return DVDList
        public List<DVD> RetrieveDVDsList()
        {
            return ListOfDVDs;
        }

        //Return MoviesList
        public List<Models.Movie> RetrieveMoviesList()
        {
            return ListOfMovies;
        }
        
        //Build ListOfDVDs list from SQL Database method


        //Add New DVD to SQL Database that is a new Movie
        //Need to create a parameterized stored query
        public void AddNewDVDToDBViaTMDB(DVD newDVD)
        {
            
        }

        //Retrieve TMDB info with a TMDBNum
        public Models.Movie ReturnMovieInfoFromTMDB(int tmdbNum)
        {
            TMDbClient client = new TMDbClient("1fee8f2397ff73412985de2bb825f020");

            Movie movie = client.GetMovie(tmdbNum, MovieMethods.AlternativeTitles | MovieMethods.Credits | MovieMethods.Images | MovieMethods.Releases);

            Models.Movie movieInfo = new Models.Movie();
            movieInfo.MovieTitle = movie.Title;
            movieInfo.MovieTMDBNum = movie.Id;
            movieInfo.MpaaRating = movie.Releases.Countries.FirstOrDefault(m => m.Iso_3166_1 == "US").Certification;
            movieInfo.ReleaseDate = movie.ReleaseDate.Value;
            movieInfo.Synopsis = movie.Overview;
            movieInfo.Duration = movie.Runtime.Value;
            movieInfo.PosterUrl = "http://image.tmdb.org/t/p/w185" + movie.Images.Posters[0].FilePath;

            foreach (var g in movie.Genres)
            {
                movieInfo.Genres.Add(g.Name);
            }

            movieInfo.Director.DirectorName = movie.Credits.Crew.FirstOrDefault(d => d.Job == "Director").Name;
            movieInfo.Director.DirectorTMDBNum = movie.Credits.Crew.FirstOrDefault(d => d.Job == "Director").Id;
            movieInfo.Studio.StudioName = movie.ProductionCompanies[0].Name;
            movieInfo.Studio.StudioTMDBNum = movie.ProductionCompanies[0].Id;

            foreach (var t in movie.AlternativeTitles.Titles)
            {
                if (t.Iso_3166_1 == "US")
                {
                    movieInfo.MovieAliases.Add(t.Title);
                }
            }

            if (movie.Credits.Cast.Count() < 6)
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
                for (int i = 0; i < 6; i++)
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

    }
}
