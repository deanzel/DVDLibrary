using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DVDLibrary.Models
{
    public class Status
    {
        public int StatusId { get; set; }
        public int DVDId { get; set; }
        public Borrower Borrower { get; set; }
        [DataType(DataType.Date)]
        public DateTime DateBorrowed { get; set; }
        [DataType(DataType.Date)]
        public DateTime? DateReturned { get; set; }

        public Status()
        {
            Borrower = new Borrower();
        }

    }
}
