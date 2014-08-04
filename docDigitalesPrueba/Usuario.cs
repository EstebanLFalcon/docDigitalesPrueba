using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace docDigitalesPrueba
{
    public class Usuario : DataObject
    {
        static public string BuscarUsuario(string user, string password)
        {
            return VerifySuccess("SELECT Email FROM Tabla_Usuario WHERE  Email = '" + user + "' AND Contrasena = '" + password + "';") ? "Success" : "Usuario o contraseña no validos";
        }
        static public string RegistrarUsuario(string email,string nombre_usuario,string nombre_empresa,string password, string rfc)
        {
            return ExecuteQuery("INSERT INTO Tabla_Usuario (Email,Nombre_Usuario,Nombre_Empresa,Contrasena,RFC) VALUES ('"+email+"','"+nombre_usuario+"','"+nombre_empresa+"','"+password+"','"+rfc+"')")?"Success":"Campos no validos";
        }
    }
}