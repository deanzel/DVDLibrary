using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DVDLibrary.Models;
using TMDbLib.Client;
using Movie = TMDbLib.Objects.Movies.Movie;

namespace DVDLibrary.Data
{
    public class DVDLibraryRepo
    {
        private List<DVD> ListOfDVDs;

        public DVDLibraryRepo()
        {
            ListOfDVDs = new List<DVD>();
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

            Movie movie = client.GetMovie(tmdbNum);

            Models.Movie movieInfo = new Models.Movie();
            movieInfo.MovieTitle = movie.Title;
            movieInfo.MovieTMDBNum = movie.Id;
            movieInfo.MpaaRating = movie.Releases.Countries.FirstOrDefault(m => m.Iso_3166_1 == "US").Certification;
            movieInfo.ReleaseDate = movie.ReleaseDate.Value;
            movieInfo.Synopsis = movie.Overview;
            movieInfo.Duration = movie.Runtime.Value;
            movieInfo.PosterUrl = "https://imagetmdb.org/t/p/original/" + movie.Images.Posters[0].FilePath;

            foreach (var g in movie.Genres)
            {
                movieInfo.Genres.Add(g.Name);
            }

            //movieInfo.Director.



            return movieInfo;
        }

    }
}
