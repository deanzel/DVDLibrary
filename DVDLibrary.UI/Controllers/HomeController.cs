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
            return View();
        }

        public ActionResult ViewAllDvds()
        {
            var movies = _oops.ReturnMoviesListFromDB().OrderBy(m => m.MovieTitle).ToList();

            return View(movies);
        }

        //For Mock
        public ActionResult SelectDvd(int id)
        {
            var movies = _oops.ReturnMoviesList();

            var viewMovieVM = new ViewMovieVM();

            viewMovieVM.Movie = movies.Where(m => m.MovieId == id).FirstOrDefault();
            return View(viewMovieVM);
        }

        //For Real SQL DB
        public ActionResult SelectMovie(int id)
        {
            var dvdsList = _oops.ReturnDvdsFromDbForMovieId(id);

            var viewMovieDVDsVM = new ViewMovieDVDsVM();
            viewMovieDVDsVM.DVDs = dvdsList;

            return View(viewMovieDVDsVM);
        }


        [HttpPost]
        public ActionResult DeleteDVD(int id)
        {
            var message = _oops.returnDelete(id);

            MessageBox.Show(message);


            return RedirectToAction("ViewAllDvds");
        }

        public ActionResult SearchForMovie()
        {
            return View();
        }

        [HttpPost]
        public ActionResult SearchForMoviePost()
        {
            Movie movie = new Movie();
            movie.MovieId = int.Parse(Request.Form["movieID"]);

            movie = _oops.returnMovie(movie.MovieId);

            return View("SearchForMoviePost", movie);
        }

        //Real to DB
        public ActionResult AddNewBorrower()
        {
            var addBorrowerVM = new AddBorrowerVM();

            return View(addBorrowerVM);
        }

        [HttpPost]
        public ActionResult AddNewBorrower(AddBorrowerVM newBorrower)
        {
            if (ModelState.IsValid)
            {
                var addedBorrower = _oops.AddNewBorrower(newBorrower.Borrower);

                return View("SuccessfullyAddedNewBorrower", addedBorrower);
            }
            else
            {
                return View("AddNewBorrower", newBorrower);
            }
        }

        public ActionResult AddBorrower()
        {
            return View();
        }

        [HttpPost]
        public ActionResult AddBorrowerPost()
        {
            Borrower borrower = new Borrower();
            borrower.FirstName = Request.Form["firstName"];
            borrower.LastName = Request.Form["lastName"];
            borrower.Email = Request.Form["email"];
            borrower.Phone = Request.Form["phone"];

            return View("AddBorrowerPost", borrower);
        }

        [HttpPost]
        public ActionResult BorrowDvdPost(ViewMovieVM newBorrowerSelection)
        {
            ViewMovieVM vm = new ViewMovieVM();

            vm.borrower = newBorrowerSelection.borrower;

            if (ModelState.IsValid)
            return View("BorrowDvdPost", vm);
            else
            {
                return View("AddBorrower");
            }
        }
    }
}