using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using DVDLibrary.Models;

namespace DVDLibrary.UI.Models
{
    public class AddDVDVM //: IValidatableObject
    {
        public Movie Movie { get; set; }
        [Required]
        [Range(1, int.MaxValue, ErrorMessage = "Please enter a value bigger than 0.")]
        public int Quantity { get; set; }
        [Required]
        public string DVDType { get; set; }

        public List<SelectListItem> DVDTypesList { get; set; }

        public AddDVDVM()
        {
            Movie = new Movie();
            DVDTypesList = new List<SelectListItem>()
            {
                new SelectListItem()
                {
                    Text = "DVD",
                    Value = "DVD"
                },
                new SelectListItem()
                {
                    Text = "Blu-ray",
                    Value = "Blu-ray"
                },
                new SelectListItem()
                {
                    Text = "3D Blu-ray",
                    Value = "3D Blu-ray"
                },
                new SelectListItem()
                {
                    Text = "DVD Special Edition",
                    Value = "DVD Special Edition"
                },
                new SelectListItem()
                {
                    Text = "Blu-ray Special Edition",
                    Value = "Blu-ray Special Edition"
                },
                new SelectListItem()
                {
                    Text = "HD-DVD",
                    Value = "HD=DVD"
                },
                new SelectListItem()
                {
                    Text = "VHS",
                    Value = "VHS"
                },
                new SelectListItem()
                {
                    Text = "Other",
                    Value = "Other"
                }
            };
        }

        
    }
}