using System;
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
        public List<SelectListItem> BorrowersList { get; set; }

        public ViewMovieDVDsVM()
        {
            DVDs = new List<DVD>();
            BorrowersList = new List<SelectListItem>();
            CreateBorrowerList();
        }

        public void CreateBorrowerList()
        {
            DVDLibaryOperations oops = new DVDLibaryOperations();

            List<Borrower> listofBorrowers = oops.ReturnBorrowersList();

            BorrowersList = new List<SelectListItem>();

            foreach (Borrower borrower in listofBorrowers)
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