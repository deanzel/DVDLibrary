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

        //Rent DVD from DVDs Statuses Page with drop down user
        public ActionResult RentDVD(ViewMovieDVDsVM vM)
        {
            //Library method to rent DVD based on DVDID and BorrowerID
            var rentalTicket = new RentalTicket();
            rentalTicket.BorrowerId = vM.Borrower.BorrowerId;
            rentalTicket.DVDId = vM.DVDIdToRent;
            rentalTicket.DateBorrowed = DateTime.Now.Date;
            rentalTicket.MovieId = vM.MovieId;

            var newRentalTicket = _oops.RentDVD(rentalTicket);

            return RedirectToAction("ViewDVDsStatus", "Home", new {id = newRentalTicket.MovieId});
        }

        //Return DVD based on *StatusId (BorrowerStatusID) from DVDs Statuses Page
        public ActionResult ReturnDVD(int id)
        {
            var movieId = _oops.ReturnDVD(id);

            return RedirectToAction("ViewDVDsStatus", "Home", new {id = movieId});
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