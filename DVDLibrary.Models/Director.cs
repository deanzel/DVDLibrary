using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Runtime;
using System.Text;
using System.Threading.Tasks;

namespace DVDLibrary.Models
{
    public class Director
    {
        public int DirectorId { get; set; }
        [Required]
        public string DirectorName { get; set; }
        public int? DirectorTMDBNum { get; set; }
    }
}
