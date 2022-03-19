using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebApiElecciones2021.Models
{
    public class FichaParlamental
    {
        public int codPartido { get; set; }
        public string imagenPartido { get; set; }
        public string nombrePartido { get; set; }
    }
}