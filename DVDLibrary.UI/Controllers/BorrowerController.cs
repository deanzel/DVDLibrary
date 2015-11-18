﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using DVDLibrary.Models;
using DVDLibrary.UI.Models;
using DVDLibrary.BLL;

namespace DVDLibrary.UI.Controllers
{
    public class BorrowerController : Controller
    {
        private DVDLibaryOperations _oops = new DVDLibaryOperations();

        // GET: Borrower
        public ActionResult Index()
        {
            return View();
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
            if (_oops.CheckIfOwnerAlreadyExists().Success)
            {
                if (newBorrower.Borrower.IsOwner)
                {
                    ModelState.AddModelError("IsOwner", "There is already a previous owner for this collection!!");
                }
            }

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
    }
}