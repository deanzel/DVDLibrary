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
            //Need to add a little SQL database check for if movie is already in the database and send
            //to a different view that only adds more copies of it and not edit metadata

            var newDVDVM = new AddDVDVM();
            newDVDVM.Movie = _oops.ReturnMovie(id);

            return View(newDVDVM);
        }

        [HttpPost]
        public ActionResult SendNewMovieInfoToDB(AddDVDVM newDVDs)
        {
            if (ModelState.IsValid)
            {
                List<DVD> listOfDVDsAdded = new List<DVD>();

                for (int i = 0; i < newDVDs.Quantity; i++)
                {
                    var newDVD = new DVD();
                    newDVD.Movie = newDVDs.Movie;
                    newDVD.DVDType = newDVDs.DVDType;

                    listOfDVDsAdded.Add(_oops.AddMovieToDB(newDVD));
                }

                return View("SuccessfullyAddedNewMovie", listOfDVDsAdded);
            }
            else
            {
                return View("AddMovieByTMDBId", newDVDs);
            }
        }
    }
}