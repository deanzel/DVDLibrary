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
        public bool IsOwner { get; set; }
        [DataType(DataType.EmailAddress)]
        [Required(ErrorMessage = "Please enter your email")]
        //[RegularExpression(@"^\S+@\S+$", ErrorMessage = "the email format isn't valid")]
        public string Email { get; set; }
        public string Address { get; set; }
        public string City { get; set; }
        public string State { get; set; }
        [DataType(DataType.PostalCode)]
        public string Zipcode { get; set; }
        [DataType(DataType.PhoneNumber)]
        [Required(ErrorMessage = "Please enter your phone number")]
        public string Phone { get; set; }
    }
}
