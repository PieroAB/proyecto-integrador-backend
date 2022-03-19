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
    public class PartidoPoliticoApiController : ApiController
    {
        readonly string cadena = new Conexion().GetConexion();

        [HttpGet]
        [Route("api/Partido/partidos")]
        public IHttpActionResult Partidos()
        {
            using (SqlConnection cn = new SqlConnection(cadena))
            {
                var temporal = new List<PartidoPolitico>();
                SqlCommand cmd = new SqlCommand("sp_carga_partidos", cn)
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
                        imagenPartido = dr.GetString(1),
                        nombrePartido = dr.GetString(2),
                        pdfPartido = dr.GetString(3),
                        paginaPartido = dr.GetString(4)
                    };
                    temporal.Add(reg);
                }
                dr.Close();
                cn.Close();
                return Ok(temporal);
            }
        }

        
        [HttpGet]
        [Route("api/Partido/partidos/{id}")]
        public IHttpActionResult PartidoPoliticoPorId(int id)
        {
            PartidoPolitico partido = null;
            using (SqlConnection cn = new SqlConnection(cadena))
            {
                SqlCommand cmd = new SqlCommand("sp_carga_partidos_id", cn)
                {
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.AddWithValue("@partido", id);
                cn.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    partido = new PartidoPolitico()
                    {
                        codPartido = dr.GetInt32(0),
                        imagenPartido = dr.GetString(1),
                        nombrePartido = dr.GetString(2),
                        pdfPartido = dr.GetString(3),
                        paginaPartido = dr.GetString(4)
                    };
                }
                dr.Close();
                cn.Close();
            }
            return Ok(partido);
        }

        [HttpGet]
        [Route("api/Partido/planesGobierno/{id}")]
        public IHttpActionResult PlanDeGobiernoPorId(int id)
        {
            var temporal = new List<PlanGobierno>();
            using (SqlConnection cn = new SqlConnection(cadena))
            {
                SqlCommand cmd = new SqlCommand("sp_carga_plan_gobierno_id", cn)
                {
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.AddWithValue("@codpart", id);
                cn.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    PlanGobierno reg = new PlanGobierno()
                    {
                        codPartido = dr.GetInt32(0),
                        nroPro = dr.GetInt32(1),
                        socPro = dr.GetString(2),
                        ecoPro = dr.GetString(3),
                        natPro = dr.GetString(4),
                        insPro = dr.GetString(5)
                    };
                    temporal.Add(reg);
                }
                dr.Close();
                cn.Close();
            }
            return Ok(temporal);
        }

    }

}
