using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DVDLibrary.Data;
using DVDLibrary.Models;
using TMDbLib.Client;
using Movie = TMDbLib.Objects.Movies.Movie;

namespace DVDLibrary.BLL
{
    public class DVDLibaryOperations
    {
        private DVDLibraryRepo _repo;

        public DVDLibaryOperations()
        {
            _repo = new DVDLibraryRepo();    
        }

        public List<DVD> ReturnDVDsList()
        {
            return _repo.RetrieveDVDsList();
        }

        public List<Models.Movie> ReturnMoviesList()
        {
            return _repo.RetrieveMoviesList();
        }

        public string returnDelete(int id)
        {
            return _repo.DeleteDVD(id);
        }

        public Models.Movie returnMovie(int id)
        {
            return _repo.ReturnMovieInfoFromTMDB(id);
        }

        //Add movie to SQL Database (for Patty)
        public void AddMovieToDB(DVD addDVDInfo)
        {
            _repo.AddNewDVDToDBViaTMDB(addDVDInfo);
        }
        
        
        //Getting TMDB Search results depending on Movie name string
        public List<SearchTMDBResult> ReturnTMDBSearchResults(string movieName)
        {
            return _repo.RetrieveTMDBSearchResults(movieName);
        }

    }
}
