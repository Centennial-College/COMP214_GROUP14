using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Oracle.ManagedDataAccess.Client;
using COMP214_GROUP14.App_Code;
using System.Data;

namespace COMP214_GROUP14
{
    public partial class Course : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnAdd_ServerClick(object sender, EventArgs e)
        {
            DbContext db = new DbContext();
            OracleCommand cmd = new OracleCommand("Create_Course_SP");
            cmd.CommandType = System.Data.CommandType.StoredProcedure;

            OracleParameter para1 = new OracleParameter("v_title", txtTitle.Text);
            OracleParameter para2 = new OracleParameter("v_credit", txtCredit.Text);
            OracleParameter para3 = new OracleParameter("v_deptname", ucDepartment1.Value);
            cmd.Parameters.Add(para1);
            db.ExecuteNonQuery(cmd);
            txtCredit.Text = string.Empty;
            txtTitle.Text = string.Empty;
            ucDepartment1.SelectedIndex = 0;

            ListView1.DataBind();

        }


        protected void btnCancel_ServerClick(object sender, EventArgs e)
        {
            Response.Redirect(Request.Url.ToString());
        }

        protected void ListView1_ItemCommand(object sender, System.Web.UI.WebControls.ListViewCommandEventArgs e)
        {
            if (e.CommandName == "CompletedItemButton")
            {
                DbContext db = new DbContext();
                OracleCommand cmd = new OracleCommand("UPDATE sc_courses set completed='Y' where course_id=:v_courseid");
                cmd.CommandType = System.Data.CommandType.StoredProcedure;

                OracleParameter para1 = new OracleParameter("v_courseid ", Convert.ToInt32(e.CommandArgument));
                cmd.Parameters.Add(para1);

                ListView1.DataBind();
                divMessage.Attributes.Remove("class");
                divMessage.Attributes.Add("class", "alert alert-success");
                divMessageBody.InnerText = "The Courses was completed successfully.";

            }
        }
    }
}