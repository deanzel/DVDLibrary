using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using DVDLibrary.Models;

namespace DVDLibrary.UI.Models
{
    public class AddBorrowerVM
    {
        public Borrower Borrower { get; set; }
        public List<SelectListItem> ListOfStates { get; set; }

        public AddBorrowerVM()
        {
            Borrower = new Borrower();
            ListOfStates = new List<SelectListItem>()
            {
                new SelectListItem()
                {
                    Text = "AK",
                    Value = "AK"
                },
                new SelectListItem()
                {
                    Text = "AL",
                    Value = "AL"
                },
                new SelectListItem()
                {
                    Text = "AR",
                    Value = "AR"
                },
                new SelectListItem()
                {
                    Text = "AZ",
                    Value = "AZ"
                },
                new SelectListItem()
                {
                    Text = "CA",
                    Value = "CA"
                },
                new SelectListItem()
                {
                    Text = "CO",
                    Value = "CO"
                },
                new SelectListItem()
                {
                    Text = "CT",
                    Value = "CT"
                },
                new SelectListItem()
                {
                    Text = "DC",
                    Value = "DC"
                },
                new SelectListItem()
                {
                    Text = "DE",
                    Value = "DE"
                },
                new SelectListItem()
                {
                    Text = "FL",
                    Value = "FL"
                },
                new SelectListItem()
                {
                    Text = "GA",
                    Value = "GA"
                },
                new SelectListItem()
                {
                    Text = "HI",
                    Value = "HI"
                },
                new SelectListItem()
                {
                    Text = "IA",
                    Value = "IA"
                },
                new SelectListItem()
                {
                    Text = "ID",
                    Value = "ID"
                },
                new SelectListItem()
                {
                    Text = "IL",
                    Value = "IL"
                },
                new SelectListItem()
                {
                    Text = "IN",
                    Value = "IN"
                },
                new SelectListItem()
                {
                    Text = "KS",
                    Value = "KS"
                },
                new SelectListItem()
                {
                    Text = "KY",
                    Value = "KY"
                },
                new SelectListItem()
                {
                    Text = "LA",
                    Value = "LA"
                },
                new SelectListItem()
                {
                    Text = "MA",
                    Value = "MA"
                },
                new SelectListItem()
                {
                    Text = "MD",
                    Value = "MD"
                },
                new SelectListItem()
                {
                    Text = "ME",
                    Value = "ME"
                },
                new SelectListItem()
                {
                    Text = "MI",
                    Value = "MI"
                },
                new SelectListItem()
                {
                    Text = "MN",
                    Value = "MN"
                },
                new SelectListItem()
                {
                    Text = "MO",
                    Value = "MO"
                },
                new SelectListItem()
                {
                    Text = "MS",
                    Value = "MS"
                },
                new SelectListItem()
                {
                    Text = "MT",
                    Value = "MT"
                },
                new SelectListItem()
                {
                    Text = "NC",
                    Value = "NC"
                },
                new SelectListItem()
                {
                    Text = "ND",
                    Value = "ND"
                },
                new SelectListItem()
                {
                    Text = "NE",
                    Value = "NE"
                },
                new SelectListItem()
                {
                    Text = "NY",
                    Value = "NY"
                },
                new SelectListItem()
                {
                    Text = "OH",
                    Value = "OH"
                },
                new SelectListItem()
                {
                    Text = "OK",
                    Value = "OK"
                },
                new SelectListItem()
                {
                    Text = "OR",
                    Value = "OR"
                },
                new SelectListItem()
                {
                    Text = "PA",
                    Value = "PA"
                },
                new SelectListItem()
                {
                    Text = "RI",
                    Value = "RI"
                },
                new SelectListItem()
                {
                    Text = "SC",
                    Value = "SC"
                },
                new SelectListItem()
                {
                    Text = "SD",
                    Value = "SD"
                },
                new SelectListItem()
                {
                    Text = "TN",
                    Value = "TN"
                },
                new SelectListItem()
                {
                    Text = "TX",
                    Value = "TX"
                },
                new SelectListItem()
                {
                    Text = "UT",
                    Value = "UT"
                },
                new SelectListItem()
                {
                    Text = "VA",
                    Value = "VA"
                },
                new SelectListItem()
                {
                    Text = "VT",
                    Value = "VT"
                },
                new SelectListItem()
                {
                    Text = "WA",
                    Value = "WA"
                },
                new SelectListItem()
                {
                    Text = "WI",
                    Value = "WI"
                },
                new SelectListItem()
                {
                    Text = "WV",
                    Value = "WV"
                },
                new SelectListItem()
                {
                    Text = "WY",
                    Value = "WY"
                },
            };
        }

        
    }
}