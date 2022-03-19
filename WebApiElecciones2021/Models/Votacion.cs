using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebApiElecciones2021.Models
{
    public class Votacion
    {
        public int idVotante { get; set; }
        public string idDepVotante { get; set; }
        public int codPartidoPresidente { get; set; }
        public int codPartidoCongresal { get; set; }
        public int nroCandidato1Congresal { get; set; }
        public int nroCandidato2Congresal { get; set; }
        public int codPartidoParlamental { get; set; }
        public int nroCandidato1Parlamental { get; set; }
        public int nroCandidato2Parlamental { get; set; }
        /*public Votacion()
        {
            nroCandidato1Congresal = "";
            nroCandidato2Congresal = 0;
            nroCandidato1Parlamental = 0;
            nroCandidato2Parlamental = 0;
        }*/
    }
}