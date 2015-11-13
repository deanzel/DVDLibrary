using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DVDLibrary.Models;

namespace DVDLibrary.UI.Models
{
    public class SearchTMDBResultsVM
    {
        public List<SearchTMDBResult> ListOfTMDBResults { get; set; }
        public string SearchParameter { get; set; }

        public SearchTMDBResultsVM()
        {
            ListOfTMDBResults = new List<SearchTMDBResult>();
        }
    }
}