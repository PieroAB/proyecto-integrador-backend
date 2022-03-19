using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebApiElecciones2021.Models
{
    public class PlanGobierno
    {
        public int codPartido { get; set; }
        public int nroPro { get; set; }
        public string socPro { get; set; }
        public string ecoPro { get; set; }
        public string natPro { get; set; }
        public string insPro { get; set; }
    }
}