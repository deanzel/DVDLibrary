﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using DVDLibrary.Models;

namespace DVDLibrary.UI.Models
{
    public class BorrowerToAddVM
    {
        public Borrower borrower { get; set; }
        public List<SelectListItem> borrowers { get; set; }

        public void CreateBorrowerList()
        {
            List<Borrower> listofBorrowers = new List<Borrower>
            {
                new Borrower() {FirstName = "Tim", LastName = "Lin", Email = "tim@swcguild.com", Phone = "330-333-2222"},
                 new Borrower() {FirstName = "Patty", LastName = "Beauchamp", Email = "patty@swcguild.com", Phone = "330-333-2222"},
                  new Borrower() {FirstName = "Lara", LastName = "Caves", Email = "Lara@swcguild.com", Phone = "330-333-2222"}
            };

            borrowers = new List<SelectListItem>();

            foreach (Borrower borrower in listofBorrowers)
            {
                SelectListItem newItem = new SelectListItem();

                newItem.Text = borrower.FirstName + " " + borrower.LastName;
                newItem.Value = borrower.FirstName + borrower.LastName;

                borrowers.Add(newItem);
            }
        } 
    }
}