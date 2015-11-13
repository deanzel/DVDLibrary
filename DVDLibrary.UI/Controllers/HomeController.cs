﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Windows.Forms;
using DVDLibrary.BLL;
using DVDLibrary.Models;

namespace DVDLibrary.UI.Controllers
{
    public class HomeController : Controller
    {
        private DVDLibaryOperations _oops;
        
        // GET: Home
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult ViewAllDvds()
        {
            _oops = new DVDLibaryOperations();

            var movies = _oops.ReturnMoviesList();


            return View(movies);
        }

        public ActionResult SelectDvd(int id)
        {
            _oops = new DVDLibaryOperations();

            var movies = _oops.ReturnMoviesList();

            var result = movies.Where(m => m.MovieId == id).First();

            return View(result);
        }

        //public ActionLink AddDvd()
        //{
            
        //}

        [HttpPost]
        public ActionResult DeleteDVD(int id)
        {
            _oops = new DVDLibaryOperations();
            
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

            _oops = new DVDLibaryOperations();
            movie = _oops.returnMovie(movie.MovieId);

            return View("SearchForMoviePost", movie);
        }
    }
}