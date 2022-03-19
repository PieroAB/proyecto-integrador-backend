using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebApiElecciones2021.Models
{
    public class FichaPresidencial
    {
        public int codPartido { get; set; }
        public string imagenPartido { get; set; }
        public string nombrePartido { get; set; }
        public string nombrePresidente { get; set; }
        public string apepatPresidente { get; set; }
        public string apematPresidente { get; set; }
        public string fotoPresidente { get; set; }
    }
}