using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebApiElecciones2021.Utils
{
    public class Conexion
    {
        public string GetConexion()
        {
            string cadena = "server=.;database=Elecciones_2021; integrated security=true";
            //string cadena = "server=LAPTOP-1SEI7VDO\\PRUEBAS2019; database=Elecciones_2021; integrated security=true";
            //string cadena = "Server=tcp:eleccionesserver.database.windows.net,1433;Initial Catalog=elecciones2021;Persist Security Info=False;User ID=pablojamiro;Password=ElFutre23;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;";
            return cadena;
        }
    }
}