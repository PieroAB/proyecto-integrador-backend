using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using WebApiElecciones2021.Utils;
using WebApiElecciones2021.Models;
using System.Data.SqlClient;
using System.Data;
using System.Globalization;
using System.Diagnostics;

namespace WebApiElecciones2021.Controllers
{
    public class SecurityApiController : ApiController
    {
        readonly string cadena = new Conexion().GetConexion();

        [HttpPost]
        [Route("api/Login/ingreso")]
        public IHttpActionResult Ingreso([FromBody] Logueo log) {

            SqlConnection cn = new SqlConnection(cadena);
            Persona reg = null;
            if (log == null) {
                return Ok(reg);
            }
            if (ModelState.IsValid == false) {
                return Ok(reg);
            }
            using (SqlCommand cmd = new SqlCommand("sp_ingreso_votacion_persona", cn))
            {
               cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@dni", log.dni);
                    cmd.Parameters.AddWithValue("@fecnac", log.fechaNacimiento);
                    cmd.Parameters.AddWithValue("@fecemi", log.fechaEmision);
                    cn.Open();
                    SqlDataReader dr = cmd.ExecuteReader();
                    if (dr.Read())
                    {
                        reg = new Persona()
                        {
                            idPersona = dr.GetInt32(0),
                            dniPersona = dr.GetString(1),
                            nomPersona = dr.GetString(2),
                            apepatPersona = dr.GetString(3),
                            apematPersona = dr.GetString(4),
                            fecnacPersona = dr.GetDateTime(5),
                            codDepartamento = dr.GetString(6),
                            fotoPersona = dr.GetString(7),
                            sexoPersona = dr.GetString(8),
                            voto = dr.GetInt32(9)
                        };
                    }
                    dr.Close();
                    cn.Close();
                }
            return Ok(reg);
        }
    }
}
