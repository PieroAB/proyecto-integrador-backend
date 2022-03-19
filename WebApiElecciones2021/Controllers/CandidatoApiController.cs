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
    public class CandidatoApiController : ApiController
    {
        readonly TextInfo myTI = new CultureInfo("en-US", false).TextInfo;
        readonly string cadena = new Conexion().GetConexion();

        [HttpGet]
        [Route("api/Candidato/departamentos")]
        public IHttpActionResult Departamentos()
        {
            var temporal = new List<Departamento>();
            SqlConnection cn = new SqlConnection(cadena);
            using (SqlCommand cmd = new SqlCommand("sp_departamentos", cn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cn.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    var reg = new Departamento()
                    {
                        idDepartamento = dr.GetString(0),
                        nombreDepartamento = dr.GetString(1)
                    };
                    temporal.Add(reg);
                }
                dr.Close();
                cn.Close();
            }
            return Ok(temporal);
        }

        [HttpGet]
        [Route("api/Candidato/presidencial/{id}")]
        public IHttpActionResult CandidatosPresidenciales(int id)
        {
            var temporal = new List<Candidato>();
            SqlConnection cn = new SqlConnection(cadena);
            using (SqlCommand cmd = new SqlCommand("sp_candidatos_presidenciaxpartido", cn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@partido", id);
                cn.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    Candidato reg = new Candidato()
                    {
                        nombrePartido = dr.GetString(0),
                        idPersona = dr.GetInt32(1),
                        nombreCandidato = myTI.ToUpper(dr.GetString(2)),
                        apepatCandidato = myTI.ToUpper(dr.GetString(3)),
                        apematCandidato = myTI.ToUpper(dr.GetString(4)),
                        fotoCandidato = dr.GetString(5),
                        descCargo = myTI.ToTitleCase(dr.GetString(6))
                    };
                    temporal.Add(reg);
                }
                dr.Close();
                cn.Close();
            }
            return Ok(temporal);
        }

        [HttpGet]
        [Route("api/Candidato/parlamental/{id}")]
        public IHttpActionResult CandidatosParlamentarios(int id)
        {
            var temporal = new List<Candidato>();
            SqlConnection cn = new SqlConnection(cadena);
            using (SqlCommand cmd = new SqlCommand("sp_candidatos_parlamentoxpartido", cn))
            {
                
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@partido", id);
                cn.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    Candidato reg = new Candidato()
                    {
                        nombrePartido = dr.GetString(0),
                        idPersona = dr.GetInt32(1),
                        nombreCandidato = myTI.ToUpper(dr.GetString(2)),
                        apepatCandidato = myTI.ToUpper(dr.GetString(3)),
                        apematCandidato = myTI.ToUpper(dr.GetString(4)),
                        fotoCandidato = dr.GetString(5),
                        descCargo = myTI.ToTitleCase(dr.GetString(6)),
                        nroCandidato = dr.GetInt32(7)
                    };
                    temporal.Add(reg);
                }
                dr.Close();
                cn.Close();
            }
            return Ok(temporal);
        }

        [HttpGet]
        [Route("api/Candidato/congresal/{id}/{depar}")]
        public IHttpActionResult CandidatosCongresistas(int id, string depar = "")
        {
            var temporal = new List<Candidato>();
            using (SqlConnection cn = new SqlConnection(cadena))
            {
                SqlCommand cmd = new SqlCommand("sp_candidatos_congresoxpartido", cn)
                {
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.AddWithValue("@partido", id);
                cmd.Parameters.AddWithValue("@lugar", depar);
                cn.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    Candidato reg = new Candidato()
                    {
                        nombrePartido = dr.GetString(0),
                        idPersona = dr.GetInt32(1),
                        nombreCandidato = myTI.ToUpper(dr.GetString(2)),
                        apepatCandidato = myTI.ToUpper(dr.GetString(3)),
                        apematCandidato = myTI.ToUpper(dr.GetString(4)),
                        fotoCandidato = dr.GetString(5),
                        descCargo = myTI.ToTitleCase(dr.GetString(6)),
                        nroCandidato = dr.GetInt32(7),
                        dniCandidato = dr.GetString(8)
                    };
                    temporal.Add(reg);
                }
                dr.Close();
                cn.Close();
            }
            return Ok(temporal.ToList());
        }


    }
}
