using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DVDLibrary.Models
{
    public class Movie
    {
        public int MovieId { get; set; }
        [Required]
        public string MovieTitle { get; set; }
        [Required]
        public int MovieTMDBNum { get; set; }
        [Required]
        public string MpaaRating { get; set; }
        [DataType(DataType.Date)]
        [Required]
        public DateTime ReleaseDate { get; set; }
        [DataType(DataType.MultilineText)]
        [Required]
        public string Synopsis { get; set; }
        [Required]
        public int Duration { get; set; }
        [DataType(DataType.ImageUrl)]
        public string PosterUrl { get; set; }
        [DataType(DataType.Url)]
        public string YouTubeTrailer { get; set; }

        public List<Genre> Genres { get; set; }
        public Director Director { get; set; }
        public Studio Studio { get; set; }
        public List<Actor> MovieActors { get; set; }
        public List<MovieAlias> MovieAliases { get; set; }

        public List<UserRating> UserRatings { get; set; }
        public List<UserNote> UserNotes { get; set; }

        public Movie()
        {
            Genres = new List<Genre>();
            Director = new Director();
            Studio = new Studio();
            MovieActors = new List<Actor>();
            MovieAliases = new List<MovieAlias>();
            UserRatings = new List<UserRating>();
            UserNotes = new List<UserNote>();
        }
    }

}
