﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using DVDLibrary.BLL;
using DVDLibrary.Models;

namespace DVDLibrary.UI.Models
{
    public class ViewMovieDVDsVM
    {
        public List<DVD> DVDs { get; set; }
        public Borrower Borrower { get; set; }
        public int DVDIdToRent { get; set; }
        public int MovieId { get; set; }
        public string Owner { get; set; }
        public List<SelectListItem> BorrowersList { get; set; }

        public int Rating { get; set; }

        public ViewMovieDVDsVM()
        {
            DVDs = new List<DVD>();
            BorrowersList = new List<SelectListItem>();
            CreateBorrowerList();
        }

        public void CreateBorrowerList()
        {
            DVDLibaryOperations oops = new DVDLibaryOperations();

            List<Borrower> listOfBorrowers = oops.ReturnSmallBorrowersList();

            if (listOfBorrowers.FirstOrDefault(b => b.IsOwner) != null)
            {
                 Owner = listOfBorrowers.FirstOrDefault(b => b.IsOwner).FirstName;
            }
           
            BorrowersList = new List<SelectListItem>();

            foreach (Borrower borrower in listOfBorrowers)
            {
                SelectListItem newItem = new SelectListItem();

                if (borrower.IsOwner)
                {
                    newItem.Text = borrower.FirstName + " " + borrower.LastName + " *";
                }
                else
                {
                    newItem.Text = borrower.FirstName + " " + borrower.LastName;
                }
                newItem.Value = borrower.BorrowerId.ToString();

                BorrowersList.Add(newItem);
            }
        }
    }
}