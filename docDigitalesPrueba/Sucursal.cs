using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;

namespace docDigitalesPrueba
{
    public class Sucursal : DataObject
    {
        static public string GetSucursales()
        {
            String selectSucursales ="";
            DataTable dt = GetRecords("Select S.Nombre_Sucursal, COUNT(E.Nombre_Empleado) as countEmpleados from Tabla_Sucursal as S LEFT JOIN Tabla_Empleado as E ON S.Nombre_Sucursal = E.Nombre_Sucursal WHERE S.Correo_Dueno ='" + HttpContext.Current.Session["user"] + "' Group by (S.Nombre_Sucursal)");
            foreach(DataRow dr in dt.Rows)
            {
                selectSucursales += dr[0].ToString() +"^"+dr[1].ToString()+"^*^";
            }
            if (selectSucursales.Length > 0)
                selectSucursales = selectSucursales.Substring(0,selectSucursales.Length - 1);
            if (selectSucursales == "")
                return "No se encontraron sucursales";
            else
                return selectSucursales;
        }
        static public string GetNombreSucursales()
        {
            String selectSucursales ="";
            DataTable dt = GetRecords("Select Nombre_Sucursal FROM Tabla_Sucursal WHERE Correo_Dueno = '"+HttpContext.Current.Session["user"]+"'");
            foreach(DataRow dr in dt.Rows)
            {
                selectSucursales += dr[0].ToString() +"^";
            }
            if (selectSucursales.Length > 0)
                selectSucursales = selectSucursales.Substring(0,selectSucursales.Length - 1);
            if (selectSucursales == "")
                return "No se encontraron sucursales";
            else
                return selectSucursales;
        }
        static public string GetValueSucursal(string nombre_sucursal)
        {
    
            String selectSucursales = "";
            DataTable dt = GetRecords("Select [Nombre_Sucursal],[Calle],[Colonia],[Num_Ext],[Num_Int],[CP],[Ciudad],[Pais] FROM Tabla_Sucursal WHERE [Nombre_Sucursal] = '"+nombre_sucursal+"'");
            for (int i = 0; i < 8; i++)
                selectSucursales += dt.Rows[0][i].ToString() + "^";
            if (selectSucursales.Length > 0)
                selectSucursales = selectSucursales.Substring(0, selectSucursales.Length - 1);
            if (selectSucursales == "")
                return "No se encontro sucursal";
            else
                return selectSucursales;
        }
        static public string InsertSucursales(string nombre_sucursal, string calle, string colonia, int numero_ext, int numero_int, int cp, string ciudad, string pais, string correo)
        {
            return ExecuteQuery("INSERT INTO Tabla_Sucursal ([Nombre_Sucursal],[Calle],[Colonia],[Num_Ext],[Num_Int],[CP],[Ciudad],[Pais],[Correo_Dueno]) Values('"+nombre_sucursal+"','"+calle+"','"+colonia+"','"+numero_ext+"','"+numero_int+"','"+cp+"','"+ciudad+"','"+pais+"','"+correo+"')") ? "Success" : "Campos no validos.";
        }
        static public string UpdateSucursal(string nombre_sucursal, string calle, string colonia, int numero_ext, int numero_int, int cp, string ciudad, string pais,string nombreAnterior)
        {
            string result;
            if(nombre_sucursal != nombreAnterior)
                ExecuteQuery("UPDATE Tabla_Empleado SET [Nombre_Sucursal] = NULL WHERE [Nombre_Sucursal] ='"+nombreAnterior+"'");
            result = ExecuteQuery("UPDATE Tabla_Sucursal SET [Nombre_Sucursal] ='"+nombre_sucursal+"',[Calle] ='"+calle+"',[Colonia]='"+colonia+"',[Num_Ext]="+numero_ext+",[Num_Int]="+numero_int+",[CP]="+cp+",[Ciudad]='"+ciudad+"',[Pais]='"+pais+"' WHERE [Nombre_Sucursal] ='"+nombreAnterior+"'") ? "Success" : "Campos no validos.";
            if (nombre_sucursal != nombreAnterior)
                ExecuteQuery("UPDATE Tabla_Empleado SET [Nombre_Sucursal] ='"+nombre_sucursal+"' WHERE [Nombre_Sucursal] IS NULL");
            return result;
        }
    }
}