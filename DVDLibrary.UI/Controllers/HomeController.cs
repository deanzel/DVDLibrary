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
            var response = _oops.ReturnDVD(id);

            return RedirectToAction("ViewDVDsStatus", "Home", new {id = response.MovieId});
        }

        //Remove DVD via DVDID (and return MovieId for redirect)
        public ActionResult DeleteDVD(int id)
        {
            var response = _oops.RemoveDVD(id);

            if (response.DVDsLeft)
            {
                return RedirectToAction("ViewDVDsStatus", "Home", new {id = response.MovieId});
            }
            else
            {
                return RedirectToAction("ViewAllDvds", "Home");
            }

        }

        //Submit Rating
        [HttpPost]
        public ActionResult SubmitRating()
        {
            if (Request["hiddenRating"] == "")
            {
                MessageBox.Show("You must select a rating between 1-5 stars to submit it!!");

                return RedirectToAction("SelectMovie", "Home", new { id = int.Parse(Request["MovieId"]) });
            }

            var newUserRating = new UserRating();

            newUserRating.BorrowerId = int.Parse(Request["BorrowerId"]);
            newUserRating.MovieId = int.Parse(Request["MovieId"]);
            newUserRating.Rating = int.Parse(Request["hiddenRating"]);

            //Send to DB
            var response = _oops.AddUserRating(newUserRating);
            MessageBox.Show(response.Message);

            return RedirectToAction("SelectMovie", "Home", new {id = newUserRating.MovieId});
        }

    }
}