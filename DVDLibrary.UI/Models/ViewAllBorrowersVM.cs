using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DVDLibrary.Models;

namespace DVDLibrary.UI.Models
{
    public class ViewAllBorrowersVM
    {
        public List<Borrower> BorrowersList;

        public ViewAllBorrowersVM()
        {
            BorrowersList = new List<Borrower>();
        }
    }
}