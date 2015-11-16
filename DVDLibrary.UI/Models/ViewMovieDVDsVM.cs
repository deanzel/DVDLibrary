using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
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
            List<Borrower> listofBorrowers = new List<Borrower>
            {
                new Borrower()
                {
                    FirstName = "Dean",
                    LastName = "Choi",
                    BorrowerId = 1,
                    Email = "deanchoi@gmail.com",
                    Phone = "440-263-5132",
                    IsOwner = true
                },
                new Borrower()
                {
                    FirstName = "Tim",
                    LastName = "Lin",
                    BorrowerId = 2,
                    Email = "tim@swcguild.com",
                    Phone = "330-333-2222",
                    IsOwner = false
                },
                new Borrower()
                {
                    FirstName = "Patty",
                    LastName = "Beauchamp",
                    BorrowerId = 3,
                    Email = "patty@swcguild.com",
                    Phone = "330-333-2222",
                    IsOwner = false
                },
                new Borrower()
                {
                    FirstName = "Lara",
                    LastName = "Caves",
                    BorrowerId = 4,
                    Email = "Lara@swcguild.com",
                    Phone = "330-333-2222",
                    IsOwner = false
                }
            };

            BorrowersList = new List<SelectListItem>();

            foreach (Borrower borrower in listofBorrowers)
            {
                SelectListItem newItem = new SelectListItem();

                newItem.Text = borrower.FirstName + " " + borrower.LastName;
                newItem.Value = borrower.BorrowerId.ToString();

                BorrowersList.Add(newItem);
            }
        }
    }
}