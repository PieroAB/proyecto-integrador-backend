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
    public class CompararApiController : ApiController
    {
        readonly string cadena = new Conexion().GetConexion();
        [HttpGet]
        [Route("api/Partido/partidoypresidente")]
        public IHttpActionResult PartidosConPresidente()
        {
            using (SqlConnection cn = new SqlConnection(cadena))
            {
                var temporal = new List<PartidoPolitico>();
                SqlCommand cmd = new SqlCommand("sp_carga_planesgobierno_hojasvidapresidente", cn)
                {
                    CommandType = CommandType.StoredProcedure
                };
                cn.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    var reg = new PartidoPolitico()
                    {
                        codPartido = dr.GetInt32(0),
                        nombrePartido = dr.GetString(1)
                    };
                    temporal.Add(reg);
                }
                dr.Close();
                cn.Close();
                return Ok(temporal);
            }
        }

        [HttpGet]
        [Route("api/Candidato/{id}/resumen")]
        public IHttpActionResult ObtenerResumenPersona(int id)
        {
            Persona per = null;
            SqlConnection cn = new SqlConnection(cadena);
            using (SqlCommand cmd = new SqlCommand("sp_res_informacion_candidato", cn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@idper", id);
                cn.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    per = new Persona()
                    {
                        imagenPartido = dr.GetString(0),
                        nomPersona = dr.GetString(1),
                        apepatPersona = dr.GetString(2),
                        apematPersona = dr.GetString(3),
                        fotoPersona = dr.GetString(4),
                        nombrePartido = dr.GetString(5)
                    };
                    dr.Close();
                    cn.Close();
                }

            }
            return Ok(per);
        }

        [HttpGet]
        [Route("api/Partido/{id}/presidente")]
        public IHttpActionResult ObtenerPresidentexPartido(int id)
        {
            PartidoPresidente temporal = null;
            SqlConnection cn = new SqlConnection(cadena);
            using (SqlCommand cmd = new SqlCommand("sp_obtener_presidente_partido", cn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@codPartido", id);
                cn.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    temporal = new PartidoPresidente()
                    {
                        codigo = dr.GetInt32(0)
                    };
                     
                }
            }
            return Ok(temporal);
        }

    }
}
