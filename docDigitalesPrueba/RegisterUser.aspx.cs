using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace docDigitalesPrueba
{
    public partial class RegisterUser : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        [System.Web.Services.WebMethod]
        public static string submitUser(string email, string nombre_usuario, string nombre_empresa, string password, string rfc)
        {
            return Usuario.RegistrarUsuario(email,nombre_empresa,nombre_empresa,password,rfc);
        }
    }
}