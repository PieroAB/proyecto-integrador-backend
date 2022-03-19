using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;

namespace WebApiElecciones2021.Models
{
    public class Persona
    {
	public int idPersona { get; set; }

        [RegularExpression("[0-9]{8}"), MaxLength(8)]
        public string dniPersona { get; set; }
        public string nomPersona { get; set; }
        public string apepatPersona { get; set; }
        public string apematPersona { get; set; }
        public DateTime fecnacPersona { get; set; }
        public DateTime fecemiPersona { get; set; }
        public string fotoPersona { get; set; }
        public string sexoPersona { get; set; }
        public string codDepartamento { get; set; }
        public int voto { get; set; }
        public string imagenPartido { get; set; }
        public string nombrePartido { get; set; }
        public string descCargo { get; set; }
        public string nombPaisNac { get; set; }
        public string nombDepartamentoNac { get; set; }
        public string nombProvinciaNac { get; set; }
        public string nombDistritoNac { get; set; }
        public string nombDepartamentoRes { get; set; }
        public string nombProvinciaRes { get; set; }
        public string nombDistritoRes { get; set; }
        public string direccRes { get; set; }
        public string lugarCandidato { get; set; }

        public string hojaVidaPer { get; set; }
    }
}