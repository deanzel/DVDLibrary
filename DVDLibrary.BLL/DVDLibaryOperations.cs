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
    }
}
