using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Runtime;
using System.Text;
using System.Threading.Tasks;

namespace DVDLibrary.Models
{
   public class Studio
    {
        public int StudioId { get; set; }
        [Required]
        public string StudioName { get; set; }
        public int? StudioTMDBNum { get; set; }
    }
}
