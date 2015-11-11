using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DVDLibrary.Models
{
    public class UserNote
    {
        public int UserNoteId { get; set; }
        public int MovieId { get; set; }
        public int BorrowerId { get; set; }
        public string BorrowerName { get; set; }
        public string Note { get; set; }

    }
}
