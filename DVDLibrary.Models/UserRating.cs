using System;
using System.Collections.Generic;
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
        public int Rating { get; set; }
    }
}
