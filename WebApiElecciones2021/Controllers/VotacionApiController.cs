using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using WebApiElecciones2021.Models;
using WebApiElecciones2021.Utils;

namespace WebApiElecciones2021.Controllers
{
    public class VotacionApiController : ApiController
    {
        readonly string cadena = new Conexion().GetConexion();

        [HttpGet]
        [Route("api/Votacion/fichapresidencial")]
        public IHttpActionResult FichaPresidencial() {
            SqlConnection cn = new SqlConnection(cadena);
            var temporal = new List<FichaPresidencial>();
            using (SqlCommand cmd = new SqlCommand("sp_ficha_presidencial", cn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cn.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    var reg = new FichaPresidencial()
                    {
                        codPartido = dr.GetInt32(0),
                        imagenPartido = dr.GetString(1),
                        nombrePartido = dr.GetString(2),
                        nombrePresidente = dr.GetString(3),
                        apepatPresidente = dr.GetString(4),
                        apematPresidente = dr.GetString(5),
                        fotoPresidente = dr.GetString(6)
                    };

                    temporal.Add(reg);
                }
                if (temporal.Count() == 0)
                {
                    var reg = new FichaPresidencial()
                    {
                        codPartido = 0,
                        imagenPartido = null,
                        nombrePartido = null,
                        nombrePresidente = null,
                        apepatPresidente = null,
                        apematPresidente = null,
                        fotoPresidente = null
                    };
                    temporal.Add(reg);
                }
            }
            return Ok(temporal);
        }


        [HttpGet]
        [Route("api/Votacion/fichacongresal/{dep}")]
        public IHttpActionResult FichaCongresal(string dep) {
            SqlConnection cn = new SqlConnection(cadena);
            var temporal = new List<FichaCongresal>();
            using (SqlCommand cmd = new SqlCommand("sp_ficha_congresal", cn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@iddep", dep);
                cn.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    var reg = new FichaCongresal()
                    {
                        codPartido = dr.GetInt32(0),
                        imagenPartido = dr.GetString(1),
                        nombrePartido = dr.GetString(2)
                    };
                    temporal.Add(reg);
                }
                dr.Close();
                cn.Close();
                if (temporal.Count() == 0)
                {
                    var reg = new FichaCongresal()
                    {
                        codPartido = 0,
                        imagenPartido = null,
                        nombrePartido = null
                    };
                    temporal.Add(reg);
                }
            }
            return Ok(temporal);
        }

        [HttpGet]
        [Route("api/Votacion/fichaparlamental")]
        public IHttpActionResult FichaParlamental() {
            SqlConnection cn = new SqlConnection(cadena);
            var temporal = new List<FichaParlamental>();
            using (SqlCommand cmd = new SqlCommand("sp_ficha_parlamental", cn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cn.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    var reg = new FichaParlamental()
                    {
                        codPartido = dr.GetInt32(0),
                        imagenPartido = dr.GetString(1),
                        nombrePartido = dr.GetString(2)
                    };
                    temporal.Add(reg);
                }
                dr.Close();
                cn.Close();
                if (temporal.Count() == 0)
                {
                    var reg = new FichaParlamental()
                    {
                        codPartido = 0,
                        imagenPartido = null,
                        nombrePartido = null
                    };
                    temporal.Add(reg);
                }
            }
            return Ok(temporal);
        }

        private int GenerarNroEleccion()
        {
            int temporal = 0;
            SqlConnection cn = new SqlConnection(cadena);
            using (SqlCommand cmd = new SqlCommand("select dbo.fn_generaEleccion() as nroEleccionGenerado", cn))
            {
                cmd.CommandType = CommandType.Text;
                cn.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    temporal = dr.GetInt32(0);
                    
                    dr.Close();
                    cn.Close();
                }
                return temporal;

            }
        }


        [HttpGet]
        private IEnumerable<Candidato> CargaNroCongresistasPorPartidoPorDepartamento(string iddep, int codpar)
        {
            var temporal = new List<Candidato>();
            SqlConnection cn = new SqlConnection(cadena);
            using (SqlCommand cmd = new SqlCommand("sp_nrocongresistas_partido_lugarpostulan", cn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@iddep", iddep);
                cmd.Parameters.AddWithValue("@codpar", codpar);
                cn.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    var reg = new Candidato()
                    {
                        nroCandidato = dr.GetInt32(0)
                    };
                    temporal.Add(reg);
                }
                dr.Close();
                cn.Close();
            }
            return temporal;
        }

        [HttpGet]
        private IEnumerable<Candidato> CargaNroParlamentariosPorPartido(int codpar)
        {
            var temporal = new List<Candidato>();
            SqlConnection cn = new SqlConnection(cadena);
            using (SqlCommand cmd = new SqlCommand("sp_nroparlamentarios_partido", cn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@codpar", codpar);
                cn.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    var reg = new Candidato()
                    {
                        nroCandidato = dr.GetInt32(0)
                    };
                    temporal.Add(reg);
                }
                dr.Close();
                cn.Close();
            }
            return temporal;
        }

        [HttpPost]
        [Route("api/Votacion/nuevoVoto")]
        public IHttpActionResult RegistraVoto([FromBody] Votacion votacion)
        {
            string mensaje = "";
            SqlConnection cn = new SqlConnection(cadena);

            if (ModelState.IsValid == false)
            {
                mensaje = "Complete los campos";
                return Ok(mensaje);
            }
            if (votacion.idVotante == 0 || votacion.idDepVotante == null) {
                mensaje = "Complete los campos";
                return Ok(mensaje);
            }
            if (votacion.codPartidoPresidente == 0 || votacion.codPartidoCongresal == 0 || votacion.codPartidoParlamental == 0) {
                mensaje = "Complete los campos";
                return Ok(mensaje);
            }
            cn.Open();
            SqlTransaction t = cn.BeginTransaction(IsolationLevel.Serializable);
            var nrosCongresistas = (List<Candidato>)CargaNroCongresistasPorPartidoPorDepartamento(votacion.idDepVotante, votacion.codPartidoCongresal);
            var nroParlamentarios = (List<Candidato>)CargaNroParlamentariosPorPartido(votacion.codPartidoParlamental);
            var eleccion = GenerarNroEleccion();

            /*insertar voto congresal*/
            var obtenercongresistas = nrosCongresistas.Where(x => x.nroCandidato == votacion.nroCandidato1Congresal);
            if (obtenercongresistas.Count() == 0) {
                var obtener = nrosCongresistas;
                Random rdm = new Random();
                var a = rdm.Next(obtener.Count());

                for (int i = 0; i < obtener.Count(); i++)
                {
                    var objeto = obtener[i];
                    if (i == a)
                    {
                        votacion.nroCandidato1Congresal = objeto.nroCandidato;
                        break;
                    }
                }
            }
            var obtenercongresistas2 = nrosCongresistas.Where(x => x.nroCandidato == votacion.nroCandidato2Congresal);
            if (obtenercongresistas2.Count() == 0)
            {
                var obtener = nrosCongresistas;
                Random rdm = new Random();
                var obtener2 = obtener.Where(x => x.nroCandidato != votacion.nroCandidato1Congresal).ToList();
                var a = rdm.Next(obtener2.Count());

                for (int i = 0; i < obtener2.Count(); i++)
                {
                    var objeto = obtener2[i];
                    if (i == a)
                    {
                        votacion.nroCandidato2Congresal = objeto.nroCandidato;
                        break;
                    }
                }
            }

            /*insertar voto parlamental*/
            var obtenerparlamentarios = nroParlamentarios.Where(x => x.nroCandidato == votacion.nroCandidato1Parlamental);
            if (obtenerparlamentarios.Count() == 0)
            {
                var obtener = nroParlamentarios;
                Random rdm = new Random();
                var a = rdm.Next(obtener.Count());

                for (int i = 0; i < obtener.Count(); i++)
                {
                    var objeto = obtener[i];
                    if (i == a)
                    {
                        votacion.nroCandidato1Parlamental = objeto.nroCandidato;
                        break;
                    }
                }
            }

            var obtenerparlamentarios2 = nroParlamentarios.Where(x => x.nroCandidato == votacion.nroCandidato2Parlamental);
            if (obtenerparlamentarios2.Count() == 0)
            {
                var obtener = nroParlamentarios;
                Random rdm = new Random();
                var a = rdm.Next(obtener.Count());
                var obtener2 = obtener.Where(x => x.nroCandidato != votacion.nroCandidato1Parlamental).ToList();
                for (int i = 0; i < obtener2.Count(); i++)
                {
                    var objeto = obtener2[i];
                    if (i == a)
                    {
                        votacion.nroCandidato2Parlamental = objeto.nroCandidato;
                        break;
                    }
                }
            }

            try
            {
                /*insertar cabecera voto*/
                SqlCommand cmd = new SqlCommand("sp_nuevo_eleccion", cn, t)
                {
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.AddWithValue("@idelec", eleccion);
                cmd.Parameters.AddWithValue("@idper", votacion.idVotante);
                cmd.ExecuteNonQuery();

                /*insertar voto presidencial*/
                cmd = new SqlCommand("sp_registra_voto_presidencial", cn, t)
                {
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.AddWithValue("@eleccion", eleccion);
                cmd.Parameters.AddWithValue("@codpar", votacion.codPartidoPresidente);
                cmd.ExecuteNonQuery();

                
                cmd = new SqlCommand("sp_registra_voto_congresal", cn, t)
                {
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.AddWithValue("@eleccion", eleccion);
                cmd.Parameters.AddWithValue("@iddep", votacion.idDepVotante);
                cmd.Parameters.AddWithValue("@codpar", votacion.codPartidoCongresal);
                cmd.Parameters.AddWithValue("@nro1", votacion.nroCandidato1Congresal);
                cmd.Parameters.AddWithValue("@nro2", votacion.nroCandidato2Congresal);
                cmd.ExecuteNonQuery();

                

                cmd = new SqlCommand("sp_registra_voto_parlamental", cn, t)
                {
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.AddWithValue("@eleccion", eleccion);
                cmd.Parameters.AddWithValue("@codpar", votacion.codPartidoParlamental);
                cmd.Parameters.AddWithValue("@nro1", votacion.nroCandidato1Parlamental);
                cmd.Parameters.AddWithValue("@nro2", votacion.nroCandidato2Parlamental);
                cmd.ExecuteNonQuery();
                t.Commit();
                mensaje = string.Format("Su voto fue registrado con éxito");
            }
            catch (Exception ex)
            {
                t.Rollback();
                mensaje = "No se pudo registrar su voto error: "+ex.Message;
            }
            finally
            {
                cn.Close();
            }
            return Ok(mensaje);
        }
    }
}
