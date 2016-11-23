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

        private OracleTransaction trans;

        private List<OracleCommand> cmdList;


        public void AddCommand(OracleCommand cmd)
        {
            cmd.Connection = conn;
            cmd.Transaction = trans;
            cmdList.Add(cmd);
        }

        public void BeginTransaction()
        {
            trans = conn.BeginTransaction();
            cmdList = new List<OracleCommand>();
        }

        public void Commit()
        {
            try
            {
                foreach (OracleCommand cmd in cmdList)
                {
                    cmd.ExecuteNonQuery();
                }

                trans.Commit();
            }
            catch (Exception ex)
            {
                try
                {
                    trans.Rollback();
                }
                catch (Exception ex1)
                {
                    throw ex1;
                }
                throw ex;
            }
        }

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