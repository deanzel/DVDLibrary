﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DVDLibrary.Models
{
   public class Movie
    {
       public int MovieId { get; set; }
       public string MovieName { get; set; }
       public int? MovieTMDBNum { get; set; }
       public string MpaaRating { get; set; }
       public DateTime ReleaseDate { get; set; }
       public string Synopsis { get; set; }
       public int Duration { get; set; }
       public string PosterUrl { get; set; }
    }
}
