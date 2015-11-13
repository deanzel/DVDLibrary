using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DVDLibrary.Models
{
    public class DVD
    {
        public int DVDId { get; set; }
        public string DVDType { get; set; }
        public Movie Movie { get; set; }
        //public int MovieID { get; set; }
        //public string MovieTitle { get; set; }
        public List<Status> Statuses { get; set; } 

        public DVD()
        {
            Statuses = new List<Status>();
            Movie = new Movie();
        }
    }
}
