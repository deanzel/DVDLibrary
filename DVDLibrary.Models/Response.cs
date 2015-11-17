using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DVDLibrary.Models
{
    public class Response
    {
        public bool Success { get; set; }
        public string Message { get; set; }

        public Borrower Borrower { get; set; }

        public Response()
        {
            Borrower = new Borrower();
        }
    }
}
