using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DVDLibrary.Models
{
   public class UserRating
    {
        public int UserRatingId { get; set; }
        public int MovieId { get; set; }
        public int BorrowerId { get; set; }
        public string BorrowerName { get; set; }
        [Range(1, 6, ErrorMessage = "Please enter a rating between 1-5.")]
        [Required]
        public int Rating { get; set; }
        public bool Owner { get; set; }
    }
}
