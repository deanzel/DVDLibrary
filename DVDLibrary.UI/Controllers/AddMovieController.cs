using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using DVDLibrary.BLL;
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
    }
}