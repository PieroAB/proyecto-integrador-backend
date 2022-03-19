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
    public class HojaVidaApiController : ApiController
    {
        readonly string cadena = new Conexion().GetConexion();

        [HttpGet]
        [Route("api/HojaVida/candidato/{id}")]
        public IHttpActionResult ObtenerPersona(int id)
        {
            Persona per = null;
            SqlConnection cn = new SqlConnection(cadena);
            using (SqlCommand cmd = new SqlCommand("sp_informacion_candidato", cn))
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
                        descCargo = dr.GetString(4),
                        dniPersona = dr.GetString(5),
                        lugarCandidato = dr.GetString(6),
                        sexoPersona = dr.GetString(7),
                        nombPaisNac = dr.GetString(8),
                        nombDepartamentoNac = dr.GetString(9),
                        nombProvinciaNac = dr.GetString(10),
                        nombDistritoNac = dr.GetString(11),
                        nombDepartamentoRes = dr.GetString(12),
                        nombProvinciaRes = dr.GetString(13),
                        nombDistritoRes = dr.GetString(14),
                        direccRes = dr.GetString(15),
                        fotoPersona = dr.GetString(16),
                        hojaVidaPer = dr.GetString(17),
                        fecnacPersona = dr.GetDateTime(18),
                        nombrePartido = dr.GetString(19)
                    };
                    dr.Close();
                    cn.Close();
                }

            }
            return Ok(per);
        }

        [HttpGet]
        [Route("api/HojaVida/candidato/{id}/eduBasica")]
        public IHttpActionResult ObtenerEducacionBasicaHV(int id)
        {
            EducacionBasicaHV edu = null;
            SqlConnection cn = new SqlConnection(cadena);
            using (SqlCommand cmd = new SqlCommand("sp_hojavida_edubasica", cn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@idper", id);
                cn.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    edu = new EducacionBasicaHV()
                    {
                        idHojaVida = dr.GetInt32(0),
                        primaria = dr.GetString(1),
                        secundaria = dr.GetString(2)
                    };
                }
                else
                {
                    edu = new EducacionBasicaHV();
                }
                dr.Close();
                cn.Close();
            }
            return Ok(edu);
        }


        [HttpGet]
        [Route("api/HojaVida/candidato/{id}/estTecnicos")]
        public IHttpActionResult ObtenerEstudiosTecnicosHV(int id)
        {
            var temporal = new List<EstudiosTecnicosHV>();
            SqlConnection cn = new SqlConnection(cadena);
            using (SqlCommand cmd = new SqlCommand("sp_hojavida_tecnicos", cn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@idper", id);
                cn.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    var reg = new EstudiosTecnicosHV()
                    {
                        idHojaVida = dr.GetInt32(0),
                        nroEstTec = dr.GetInt32(1),
                        centEstTec = dr.GetString(2),
                        carEstTec = dr.GetString(3),
                        conEstTec = dr.GetString(4)
                    };
                    temporal.Add(reg);
                }
                if (temporal.Count() == 0)
                {
                    var element = new EstudiosTecnicosHV();
                    temporal.Add(element);
                }
                dr.Close();
                cn.Close();
            }
            return Ok(temporal);
        }

        [HttpGet]
        [Route("api/HojaVida/candidato/{id}/estNoUniversitarios")]
        public IHttpActionResult ObtenerEstudiosNoUniversitariosHV(int id)
        {
            var temporal = new List<EstudiosNoUniversitariosHV>();
            SqlConnection cn = new SqlConnection(cadena);
            using (SqlCommand cmd = new SqlCommand("sp_hojavida_nouniversitarios", cn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@idper", id);
                cn.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    var reg = new EstudiosNoUniversitariosHV()
                    {
                        idHojaVida = dr.GetInt32(0),
                        nroEstNoUni = dr.GetInt32(1),
                        cenEstNoUni = dr.GetString(2),
                        carEstNoUni = dr.GetString(3),
                        conEstNoUni = dr.GetString(4)
                    };
                    temporal.Add(reg);
                }
                if (temporal.Count() == 0)
                {
                    var element = new EstudiosNoUniversitariosHV();
                    temporal.Add(element);
                }
                dr.Close();
                cn.Close();
            }
            return Ok(temporal);
        }

        [HttpGet]
        [Route("api/HojaVida/candidato/{id}/estUniversitarios")]
        public IHttpActionResult ObtenerEstudiosUniversitariosHV(int id)
        {
            var temporal = new List<EstudiosUniversitariosHV>();
            SqlConnection cn = new SqlConnection(cadena);
            using (SqlCommand cmd = new SqlCommand("sp_hojavida_universitarios", cn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@idper", id);
                cn.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    var reg = new EstudiosUniversitariosHV()
                    {
                        idHojaVida = dr.GetInt32(0),
                        nroEstUni = dr.GetInt32(1),
                        cenEstUni = dr.GetString(2),
                        carEstUni = dr.GetString(3),
                        conEstUni = dr.GetString(4)
                    };
                    temporal.Add(reg);
                }
                if (temporal.Count() == 0)
                {
                    var element = new EstudiosUniversitariosHV();
                    temporal.Add(element);
                }
                dr.Close();
                cn.Close();
            }
            return Ok(temporal);
        }

        [HttpGet]
        [Route("api/HojaVida/candidato/{id}/estPostgrado")]
        public IHttpActionResult ObtenerEstudiosPostgradoHV(int id)
        {
            var temporal = new List<EstudiosPostgradoHV>();
            SqlConnection cn = new SqlConnection(cadena);
            using (SqlCommand cmd = new SqlCommand("sp_hojavida_postgrado", cn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@idper", id);
                cn.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    var reg = new EstudiosPostgradoHV()
                    {
                        idHojaVida = dr.GetInt32(0),
                        nroEstPos = dr.GetInt32(1),
                        cenEstPos = dr.GetString(2),
                        espEstPos = dr.GetString(3),
                        conEstPos = dr.GetString(4),
                        graEstPos = dr.GetString(5)
                    };
                    temporal.Add(reg);
                }
                if (temporal.Count() == 0)
                {
                    var element = new EstudiosPostgradoHV();
                    temporal.Add(element);
                }
                dr.Close();
                cn.Close();
            }
            return Ok(temporal);
        }

        [HttpGet]
        [Route("api/HojaVida/candidato/{id}/trabajos")]
        public IHttpActionResult ObtenerTrabajosHV(int id)
        {
            var temporal = new List<TrabajosHV>();
            SqlConnection cn = new SqlConnection(cadena);
            using (SqlCommand cmd = new SqlCommand("sp_hojavida_trabajos", cn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@idper", id);
                cn.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    var reg = new TrabajosHV()
                    {
                        idHojaVida = dr.GetInt32(0),
                        nroTra = dr.GetInt32(1),
                        cenTra = dr.GetString(2),
                        ocuTra = dr.GetString(3),
                        perTra = dr.GetString(4)
                    };
                    temporal.Add(reg);
                }
                if (temporal.Count() == 0)
                {
                    var element = new TrabajosHV();
                    temporal.Add(element);
                }
                dr.Close();
                cn.Close();
            }
            return Ok(temporal);
        }

        [HttpGet]
        [Route("api/HojaVida/candidato/{id}/ambitosPenales")]
        public IHttpActionResult ObtenerAmbitosPenalesHV(int id)
        {
            var temporal = new List<AmbitosPenalesHV>();
            SqlConnection cn = new SqlConnection(cadena);
            using (SqlCommand cmd = new SqlCommand("sp_hojavida_ambitospenales", cn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@idper", id);
                cn.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    var reg = new AmbitosPenalesHV()
                    {
                        idHojaVida = dr.GetInt32(0),
                        nroAmb = dr.GetInt32(1),
                        delAmb = dr.GetString(2),
                        falAmb = dr.GetString(3),
                        desMod = dr.GetString(4),
                        cumAmb = dr.GetString(5)
                    };
                    temporal.Add(reg);
                }
                if (temporal.Count() == 0)
                {
                    var element = new AmbitosPenalesHV();
                    temporal.Add(element);
                }
                dr.Close();
                cn.Close();
            }
            return Ok(temporal);
        }

        [HttpGet]
        [Route("api/HojaVida/candidato/{id}/otrasPenalidades")]
        public IHttpActionResult ObtenerOtrasPenalidadesHV(int id)
        {
            var temporal = new List<OtrasPenalidadesHV>();
            SqlConnection cn = new SqlConnection(cadena);
            using (SqlCommand cmd = new SqlCommand("sp_hojavida_otraspenalidades", cn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@idper", id);
                cn.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    var reg = new OtrasPenalidadesHV()
                    {
                        idHojaVida = dr.GetInt32(0),
                        nroOtroPen = dr.GetInt32(1),
                        delOtroPen = dr.GetString(2),
                        falOtroPen = dr.GetString(3),
                    };
                    temporal.Add(reg);
                }
                if (temporal.Count() == 0)
                {
                    var element = new OtrasPenalidadesHV();
                    temporal.Add(element);
                }
                dr.Close();
                cn.Close();
            }
            return Ok(temporal);
        }
    }
}
