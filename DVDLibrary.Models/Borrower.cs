using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading.Tasks;

namespace DVDLibrary.Models
{
    public class Borrower
    {
        public int BorrowerId { get; set; }
        [Required(ErrorMessage="Please enter your first name")]
        public string FirstName { get; set; }
        [Required(ErrorMessage = "Please enter your last name")]
        public string LastName { get; set; }
        [Required(ErrorMessage = "Mark if you are the owner of the collection or not.")]
        public bool IsOwner { get; set; }
        [DataType(DataType.EmailAddress)]
        [Required(ErrorMessage = "Please enter your email")]
        public string Email { get; set; }
        [Required(ErrorMessage = "Please enter your street address")]
        public string Address { get; set; }
        [Required(ErrorMessage = "Please enter your city")]
        public string City { get; set; }
        [Required(ErrorMessage = "Please choose your state")]
        public string State { get; set; }
        [DataType(DataType.PostalCode)]
        [Required(ErrorMessage = "Please enter your zipcode")]
        public string Zipcode { get; set; }
        [DataType(DataType.PhoneNumber)]
        [Required(ErrorMessage = "Please enter your phone number")]
        public string Phone { get; set; }
    }
}
