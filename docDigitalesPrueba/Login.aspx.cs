using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace docDigitalesPrueba
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        [System.Web.Services.WebMethod]
        public static string validateLogin(string user, string password)
        {
            string sessionAccepted;
            sessionAccepted = Usuario.BuscarUsuario(user, password);
            if (sessionAccepted == "Success")
            {
                HttpContext.Current.Session["user"] = user;
            }
            return sessionAccepted;
        }
    }
}