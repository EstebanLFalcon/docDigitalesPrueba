using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;

namespace docDigitalesPrueba
{
    public class Empleado : DataObject
    {
        static public string GetEmpleadoSucursal(string nombre_sucursal)
        {
            String selectEmpleados = "";
            String puesto;
            DataTable dt = GetRecords("Select [Nombre_Empleado], [RFC], [Puesto] FROM Tabla_Empleado WHERE [Nombre_Sucursal] = '"+nombre_sucursal+"'");
            foreach (DataRow dr in dt.Rows)
            {
                if(dr[2].ToString() == "")
                    puesto= "-";
                else
                    puesto=dr[2].ToString();
                     
                selectEmpleados += dr[0].ToString() + "^" + dr[1].ToString() + "^" +  puesto +"^*^";
            }
            if (selectEmpleados.Length > 0)
                selectEmpleados = selectEmpleados.Substring(0, selectEmpleados.Length - 1);
            if (selectEmpleados == "")
                return "No se encontraron Empleados";
            else
                return selectEmpleados;
        }

        static public string InsertEmployee(string nombre_empleado, string rfc, string puesto, string nombre_sucursal)
        {
            return ExecuteQuery("Insert INTO Tabla_Empleado ([Nombre_Empleado], [RFC], [Puesto], [Nombre_Sucursal]) VALUES ('"+nombre_empleado+"','"+rfc+"','"+puesto+"','"+nombre_sucursal+"')")? "Success": "Campos no validos.";
        }
        static public string GetEmpleado(string rfc)
        {
            String selectEmpleados = "";
            DataTable dt = GetRecords("Select [Nombre_Empleado], [RFC], [Puesto], [Nombre_Sucursal] FROM Tabla_Empleado WHERE [RFC] = '" + rfc + "'");
            for (int i = 0; i < 4; i++)
                selectEmpleados += dt.Rows[0][i].ToString() + "^";
            if (selectEmpleados.Length > 0)
                selectEmpleados = selectEmpleados.Substring(0, selectEmpleados.Length - 1);
            if (selectEmpleados == "")
                return "No se encontro empleado.";
            else
                return selectEmpleados;
        }
        static public string UpdateEmployee(string nombre_empleado, string rfc, string puesto, string nombre_sucursal)
        {
            return ExecuteQuery("UPDATE Tabla_Empleado SET [Nombre_Empleado]='" + nombre_empleado + "', [Puesto]='" + puesto + "', [Nombre_Sucursal] = '" + nombre_sucursal + "' WHERE [RFC] ='" + rfc + "'") ? "Success" : "Campos no validos.";
        }
    }
}