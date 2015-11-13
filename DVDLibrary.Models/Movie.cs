using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DVDLibrary.Models
{
    public class Movie
    {
        public int MovieId { get; set; }
        public string MovieTitle { get; set; }
        public int? MovieTMDBNum { get; set; }
        public string MpaaRating { get; set; }
        public DateTime ReleaseDate { get; set; }
        public string Synopsis { get; set; }
        public int Duration { get; set; }
        public string PosterUrl { get; set; }
        public string YouTubeTrailer { get; set; }

        public List<string> Genres { get; set; }
        public Director Director { get; set; }
        public Studio Studio { get; set; }
        public List<Actor> MovieActors { get; set; }
        public List<string> MovieAliases { get; set; }

        public List<UserRating> UserRatings { get; set; }
        public List<UserNote> UserNotes { get; set; }

        public Movie()
        {
            Genres = new List<string>();
            Director = new Director();
            Studio = new Studio();
            MovieActors = new List<Actor>();
            MovieAliases = new List<string>();
            UserRatings = new List<UserRating>();
            UserNotes = new List<UserNote>();
        }
    }

}
