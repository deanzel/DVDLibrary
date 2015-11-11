using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TestMovieDB.Models
{
    public class Studio
    {
        public int StudioId { get; set; }
        public string StudioName { get; set; }
        public int? StudioTMDBNum { get; set; }
    }
}
