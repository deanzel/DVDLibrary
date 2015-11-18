using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Windows.Forms;
using DVDLibrary.BLL;
using DVDLibrary.Models;
using DVDLibrary.UI.Models;

namespace DVDLibrary.UI.Controllers
{
    public class HomeController : Controller
    {
        private DVDLibaryOperations _oops = new DVDLibaryOperations();

        // GET: Home
        public ActionResult Index()
        {
            var stats = _oops.ReturnCollectionStats();

            return View(stats);
        }

        public ActionResult ViewAllDvds()
        {
            var movies = _oops.ReturnMoviesListFromDB().OrderBy(m => m.MovieTitle).ToList();

            return View(movies);
        }

        public ActionResult SelectMovie(int id)
        {
            var dvdsList = _oops.ReturnDvdsFromDbForMovieId(id);

            var viewMovieDVDsVM = new ViewMovieDVDsVM();
            viewMovieDVDsVM.DVDs = dvdsList;

            return View(viewMovieDVDsVM);
        }


        //Grab all DVD statuses based on MovieID
        public ActionResult ViewDVDsStatus(int id)
        {
            var vM = new ViewMovieDVDsVM();

            //lighter weight return
            vM.DVDs = _oops.ReturnPartialDVDsInfo(id);

            return View(vM);
        }




        //[HttpPost]
        //public ActionResult DeleteDVD(int id)
        //{
        //    var message = _oops.returnDelete(id);

        //    MessageBox.Show(message);


        //    return RedirectToAction("ViewAllDvds");
        //}

        //public ActionResult SearchForMovie()
        //{
        //    return View();
        //}

        //[HttpPost]
        //public ActionResult SearchForMoviePost()
        //{
        //    Movie movie = new Movie();
        //    movie.MovieId = int.Parse(Request.Form["movieID"]);

        //    movie = _oops.returnMovie(movie.MovieId);

        //    return View("SearchForMoviePost", movie);
        //}

        //[HttpPost]
        //public ActionResult BorrowDvdPost(ViewMovieVM newBorrowerSelection)
        //{
        //    ViewMovieVM vm = new ViewMovieVM();

        //    vm.borrower = newBorrowerSelection.borrower;

        //    if (ModelState.IsValid)
        //    return View("BorrowDvdPost", vm);
        //    else
        //    {
        //        return View("AddBorrower");
        //    }
        //}
    }
}