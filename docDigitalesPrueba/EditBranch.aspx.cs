using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace docDigitalesPrueba
{
    public partial class EditBranch : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        [System.Web.Services.WebMethod]
        static public string GetSucursal(string nombre_sucursal)
        {
            return Sucursal.GetValueSucursal(nombre_sucursal);
        }
        [System.Web.Services.WebMethod]
        static public string GetEmpleadosSucursal(string nombre_sucursal)
        {
            return Empleado.GetEmpleadoSucursal(nombre_sucursal);
        }
        [System.Web.Services.WebMethod]
        static public string UpdateBranch(string nombre_sucursal, string calle, string colonia, string numero_ext, string numero_int, string cp, string ciudad, string pais, string nombreAnterior)
        {
            return Sucursal.UpdateSucursal(nombre_sucursal, calle, colonia, int.Parse(numero_ext), int.Parse(numero_int), int.Parse(cp), ciudad, pais, nombreAnterior);
        }
       
    }
}