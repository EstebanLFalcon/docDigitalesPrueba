using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace docDigitalesPrueba
{
    public partial class RegisterEmployee : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        [System.Web.Services.WebMethod]
        static public string GetNombreSucursales()
        {
            return Sucursal.GetNombreSucursales();
        }
        [System.Web.Services.WebMethod]
        static public string InsertEmployee(string nombre_empleado, string rfc, string puesto, string nombre_sucursal)
        {
            return Empleado.InsertEmployee(nombre_empleado,rfc,puesto,nombre_sucursal);
        }
    }
}