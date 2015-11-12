﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using DVDLibrary.Models;

namespace DVDLibrary.UI.Controllers
{
    public class HomeController : Controller
    {
        // GET: Home
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult ViewAllDvds()
        {
            List<Movie> movies = new List<Movie>()
            {
                new Movie
                {
                    MovieId = 1,
                    MovieTitle = "Frozen",
                    MpaaRating = "G",
                    ReleaseDate = DateTime.Parse("06/15/2013"),
                    Synopsis = "It's a girly movie",
                    Duration = 120
                },
                new Movie
                {
                    MovieId = 2,
                    MovieTitle = "DieHard",
                    MpaaRating = "R",
                    ReleaseDate = DateTime.Parse("10/20/1989"),
                    Synopsis = "Great Action Film",
                    Duration = 180
                },
                new Movie
                {
                    MovieId = 3,
                    MovieTitle = "Dumb and Dumber",
                    MpaaRating = "PG-13",
                    ReleaseDate = DateTime.Parse("05/10/1995"),
                    Synopsis = "Funny movie",
                    Duration = 200
                }
            };

            return View(movies);
        }

        public ActionResult SelectDvd(int id)
        {
            List<Movie> movies = new List<Movie>()
            {
                new Movie
                {
                    MovieId = 1,
                    MovieTitle = "Frozen",
                    MpaaRating = "G",
                    ReleaseDate = DateTime.Parse("06/15/2013"),
                    Synopsis = "It's a girly movie",
                    Duration = 120
                },
                new Movie
                {
                    MovieId = 2,
                    MovieTitle = "DieHard",
                    MpaaRating = "R",
                    ReleaseDate = DateTime.Parse("10/20/1989"),
                    Synopsis = "Great Action Film",
                    Duration = 180
                },
                new Movie
                {
                    MovieId = 3,
                    MovieTitle = "Dumb and Dumber",
                    MpaaRating = "PG-13",
                    ReleaseDate = DateTime.Parse("05/10/1995"),
                    Synopsis = "Funny movie",
                    Duration = 200
                }
            };

            var result = movies.Where(m => m.MovieId == id).First();

            return View(result);
        }
    }
}