using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DVDLibrary.Models
{
    public class RentalTicket
    {
        public int DVDId { get; set; }
        public int BorrowerId { get; set; }
        public int MovieId { get; set; }
        [DataType(DataType.Date)]
        public DateTime DateBorrowed { get; set; }
        public int BorrowerStatusId { get; set; }
        //public bool Success { get; set; }
    }
}
