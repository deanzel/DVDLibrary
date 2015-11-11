using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TestMovieDB.Models
{
    public class DVD
    {
        public int DVDId { get; set; }
        public string DVDType { get; set; }
        public Movie Movie { get; set; }
        public List<Status> Statuses { get; set; }

        public DVD()
        {
            Movie = new Movie();
            Statuses = new List<Status>();
        }
    }
}
