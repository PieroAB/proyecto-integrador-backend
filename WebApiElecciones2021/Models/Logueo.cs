using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;

namespace WebApiElecciones2021.Models
{
    public class Logueo
        {
            [Required(ErrorMessage = "Digite su DNI")]

            [RegularExpression("[0-9]{8}", ErrorMessage = "Formato Incorrecto"), MaxLength(8)]
            public string dni { get; set; }

            [Required(ErrorMessage = "Ingresa fecha de nacimiento")]
            public DateTime fechaNacimiento { get; set; }

            [Required(ErrorMessage = "Ingrese fecha de emisión de su DNI")]
            public DateTime fechaEmision { get; set; }

    }
}