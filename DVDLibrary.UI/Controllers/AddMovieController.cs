using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using DVDLibrary.BLL;
using DVDLibrary.Models;
using DVDLibrary.UI.Models;

namespace DVDLibrary.UI.Controllers
{
    public class AddMovieController : Controller
    {
        private DVDLibaryOperations _oops = new DVDLibaryOperations();

        // GET: AddMovie
        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public ActionResult SearchTMDBForMovies(string movieSearchString)
        {
            var searchTMDBResultsVM = new SearchTMDBResultsVM();

            searchTMDBResultsVM.SearchParameter = movieSearchString;
            searchTMDBResultsVM.ListOfTMDBResults = _oops.ReturnTMDBSearchResults(movieSearchString);

            return View(searchTMDBResultsVM);
        }

        public ActionResult AddMovieByTMDBId(int id)
        {
            var newDVDVM = new AddDVDVM();
            newDVDVM.Movie = _oops.returnMovie(id);

            return View(newDVDVM);
        }

        public ActionResult GivePattyData()
        {
            var newDVDVM = new AddDVDVM();
            newDVDVM.Movie = _oops.returnMovie(11);
            newDVDVM.Quantity = 1;
            newDVDVM.DVDType = "Blu-ray";


            for (int i = 0; i < newDVDVM.Quantity; i++)
            {
                var newDVD = new DVD();
                newDVD.Movie = newDVDVM.Movie;
                newDVD.DVDType = newDVDVM.DVDType;

                _oops.AddMovieToDB(newDVD);
            }

            return View(newDVDVM);
        }
    }
}