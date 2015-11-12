using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TestMovieDB.Models
{
    public class Director
    {
        public int DirectorId { get; set; }
        public string DirectorName { get; set; }
        public int? DirectorTMDBNum { get; set; }
    }
}
