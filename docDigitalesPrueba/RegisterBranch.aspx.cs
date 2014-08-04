using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace docDigitalesPrueba
{
    public partial class RegisterBranch : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        [System.Web.Services.WebMethod]
        public static string InsertBranch(string nombre_sucursal, string calle, string colonia, string numero_ext, string numero_int, string cp, string ciudad, string pais)
        {
            return Sucursal.InsertSucursales(nombre_sucursal, calle, colonia, int.Parse(numero_ext), int.Parse(numero_int), int.Parse(cp), ciudad, pais, HttpContext.Current.Session["user"].ToString());
        }
    }
}