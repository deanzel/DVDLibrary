using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TMDbLib.Client;
using TMDbLib.Objects.Movies;

namespace DVDLibrary.Data
{
    public class DVDLibraryRepo
    {
        

        //Add New DVD to SQL Database that is a new Movie
        public void AddNewDVDToDBViaTMDB(int tmdbNum)
        {
            TMDbClient client = new TMDbClient("1fee8f2397ff73412985de2bb825f020");

            Movie movie = client.GetMovie(11);

            Models.Movie newmovie = new Models.Movie()
            {
                MovieTitle = movie.Title,
                MovieTMDBNum = movie.Id,
            };
        }

    }
}
