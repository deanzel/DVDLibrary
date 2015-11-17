using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DVDLibrary.Models
{
    public class CollectionStats
    {
        public string Owner { get; set; }
        public int MoviesCount { get; set; }
        public int DVDsCount { get; set; }
        public int BorrowersCount { get; set; }
        public int BorrowerStatusesCount { get; set; }
        public int UserRatingsCount { get; set; }
        public int UserNotesCount { get; set; }
        public int DirectorsCount { get; set; }
        public int SutdiosCount { get; set; }
        public int GenresCount { get; set; }
        public int ActorsCount { get; set; }
        public int ActorsRolesCount { get; set; }
    }
}
