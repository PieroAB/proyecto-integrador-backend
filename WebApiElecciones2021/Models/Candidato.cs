using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebApiElecciones2021.Models
{
    public class Candidato
    {
        public int idCandidato { get; set; }

        public int idPersona { get; set; }
        public string dniCandidato { get; set; }
        public string nombreCandidato { get; set; }
        public string apepatCandidato { get; set; }
        public string apematCandidato { get; set; }
        public int codPartido { get; set; }
        public string nombrePartido { get; set; }
        public string fotoCandidato { get; set; }
        public int nroCandidato { get; set; }
        public int idCargo { get; set; }

        public string descCargo { get; set; }

        public int cantVotos { get; set; }
    }
}