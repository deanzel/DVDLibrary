using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DVDLibrary.Models
{
    public class SearchTMDBResult
    {
        public string MovieTitle { get; set; }
        public int TMDBNum { get; set; }
        public DateTime ReleaseDate { get; set; }
        public string Synopsis { get; set; }
        public string PosterUrl { get; set; }
    }
}
