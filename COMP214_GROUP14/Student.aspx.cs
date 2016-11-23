using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Oracle.ManagedDataAccess.Client;
using COMP214_GROUP14.App_Code;

namespace COMP214_GROUP14
{
    public partial class Student : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnAdd_ServerClick(object sender, EventArgs e)
        {
            DbContext db = new DbContext();
            OracleCommand cmd = new OracleCommand("INSERT INTO sc_students values (sc_student_id_seq.nextval,:v_fname,:v_lname,0)");

            OracleParameter para1 = new OracleParameter("v_fname ", txtfName.Text);
            OracleParameter para2 = new OracleParameter("v_lname", txtlName.Text);
            cmd.Parameters.Add(para1);
            cmd.Parameters.Add(para2);
            db.ExecuteNonQuery(cmd);
            ListView1.DataBind();
            divMessage.Attributes.Remove("class");
            divMessage.Attributes.Add("class", "alert alert-success");
            divMessage.InnerText = "Student was saved successfully.";
        }


        protected void ListView1_ItemCommand(object sender, System.Web.UI.WebControls.ListViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteItem")
            {
                DbContext db = new DbContext();
                OracleCommand cmd = new OracleCommand("DELETE sc_students where student_id= :v_studentid");
                cmd.CommandType = System.Data.CommandType.StoredProcedure;

                OracleParameter para1 = new OracleParameter("v_studentid ", Convert.ToInt32(e.CommandArgument));
                cmd.Parameters.Add(para1);
                db.ExecuteNonQuery(cmd);

                ListView1.DataBind();
                divMessage.Attributes.Remove("class");
                divMessage.Attributes.Add("class", "alert alert-success");
                divMessage.InnerText = "Student was delete successfully.";
                return;
            }
            if (e.CommandName == "SelecteItem")
            {
                divCourse.Visible = true;
                divStuentID.InnerText = e.CommandArgument.ToString();

                DbContext db = new DbContext();
                OracleCommand cmd = new OracleCommand("SELECT * FROM vw_courseEnroll where student_id=:v_studentid");

                OracleParameter para1 = new OracleParameter("v_studentid ", Convert.ToInt32(e.CommandArgument));
                cmd.Parameters.Add(para1);
                OracleDataReader reader = db.ExecuteReader(cmd);
                cblCourses.Items.Clear();
                while (reader.Read())
                {
                    ListItem item = new ListItem(reader["title"].ToString(), reader["course_id"].ToString());
                    item.Selected = ((reader["IsEnrolled"].ToString()) == "1");
                    cblCourses.Items.Add(item);
                }

            }

        }

        protected void btnSave_ServerClick(object sender, EventArgs e)
        {
            string studentid = divStuentID.InnerText;

            DbContext db = new DbContext();

            db.BeginTransaction();
            OracleCommand cmd = new OracleCommand("DELETE FROM sc_courseenrollments WHERE student_id= :v_student_id");
            OracleParameter para = new OracleParameter("v_student_id ", studentid);
            cmd.Parameters.Add(para);
            db.AddCommand(cmd);

            foreach (ListItem item in cblCourses.Items)
            {
                if (item.Selected)
                {
                    OracleCommand cmd2 = new OracleCommand("INSERT INTO sc_courseenrollments values (:v_course_id,:v_student_id)");
                    OracleParameter para1 = new OracleParameter("v_course_id ", item.Value);
                    cmd2.Parameters.Add(para1);
                    OracleParameter para2 = new OracleParameter("v_student_id ", studentid);
                    cmd2.Parameters.Add(para2);
                    db.AddCommand(cmd2);
                }
            }
            db.Commit();
            divMessage.Attributes.Remove("class");
            divMessage.Attributes.Add("class", "alert alert-success");
            divMessage.InnerText = "Courses for the student were saved successfully.";

        }
    }
}