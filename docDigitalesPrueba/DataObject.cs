using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;

namespace docDigitalesPrueba
{
    public class DataObject
    {
        static protected readonly string connectionString = @"Server=ESTEBAN\SQLEXPRESS;Database=docDigitalesPrueba;Trusted_Connection=Yes;";
        static protected SqlConnection connection = new SqlConnection(connectionString);
        static public bool IgnoreMessages = false;

        static protected bool VerifySuccess(string select)
        {
            bool verified = false;
            if (select != null && select != "")
            {
                SqlCommand selectCommand = new SqlCommand(select, connection);
                SqlDataReader reader = null;
                try
                {
                    connection.Open();
                    reader = selectCommand.ExecuteReader();
                    while (reader.Read())
                    {
                    if (reader[0] != null)
                        verified = true;
                    }
                    if (verified)
                        return true;
                    return false;
                }
                catch (Exception e)
                {
                    if (!IgnoreMessages)
                    {
                        Console.Write(e.Message);
                    }
                    return false;
                }finally{
                    connection.Close();
                }
            }

            return false;
        }


        static protected bool ExecuteQuery(string query)
        {
            if (query != null && query != "")
            {
                SqlCommand queryCommand = new SqlCommand(query, connection);

                try
                {
                    connection.Open();
                    queryCommand.ExecuteNonQuery();
                    connection.Close();
                }
                catch (Exception e)
                {
                    if (!IgnoreMessages)
                    {
                        Console.Write(e.Message);
                    }

                    connection.Close();
                    return false;
                }

                return true;
            }

            return false;
        }

        static protected DataTable GetRecords(string select)
        {
            SqlDataAdapter da = new SqlDataAdapter();
            if (select != null && select != "")
            {
                DataTable dt = new DataTable();
                try
                {
                    da = new SqlDataAdapter(select, connection);

                    da.SelectCommand.CommandTimeout = 1000;

                    da.Fill(dt);
                }
                catch (Exception e)
                {
                    if (!IgnoreMessages)
                    {
                        Console.Write(e.Message);
                    }
                }

                return dt;
            }

            return null;
        }

    }
}