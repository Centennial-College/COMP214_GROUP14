using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Oracle.ManagedDataAccess.Client;
using System.Configuration;

namespace COMP214_GROUP14.App_Code
{
    
    public class DbContext
    {

       public OracleConnection conn;

        public DbContext()
        {
            conn = new OracleConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
            conn.Open();
        }

        public void ExecuteNonQuery(OracleCommand cmd)
        {
            cmd.Connection = conn;
            cmd.ExecuteNonQuery();
        }

        public object ExecuteScalar(OracleCommand cmd)
        {
            cmd.Connection = conn;
            return cmd.ExecuteScalar();
        }

        public OracleDataReader ExecuteReader(OracleCommand cmd)
        {
            cmd.Connection = conn;
            return cmd.ExecuteReader();
        }

        
    }
}