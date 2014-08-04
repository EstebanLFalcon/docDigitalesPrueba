using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace docDigitalesPrueba
{
    public partial class EditEmployee : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        [System.Web.Services.WebMethod]
        static public string GetEmpleado(string rfc)
        {
            return Empleado.GetEmpleado(rfc);
        }
        [System.Web.Services.WebMethod]
        static public string UpdateEmployee(string nombre_empleado, string rfc, string puesto, string nombre_sucursal)
        {
            return Empleado.UpdateEmployee(nombre_empleado, rfc, puesto, nombre_sucursal);
        }
    }
}