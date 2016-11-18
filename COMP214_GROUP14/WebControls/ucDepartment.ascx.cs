using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Oracle.ManagedDataAccess.Client;

namespace COMP214_GROUP14.WebControls
{
    public partial class ucDepartment : System.Web.UI.UserControl
    {

        public string Value
        {
            get
            {
                return ddlDepartment.SelectedIndex == ddlDepartment.Items.Count - 1 ? txtDepartment.Text : ddlDepartment.SelectedValue;
            }
            set
            {
                ddlDepartment.SelectedValue = value;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                BindDepartment();
            }
        }

        private void BindDepartment()
        {
            List<string> list = new List<string>();
            OracleCommand cmd = new OracleCommand("SELECT name FROM sc_departments ORDER BY name");
            OracleDataReader reader = (new COMP214_GROUP14.App_Code.DbContext()).ExecuteReader(cmd);
            while (reader.Read())
            {
                list.Add(reader[0].ToString());
            }
            list.Add("Other");

            ddlDepartment.DataSource = list;
            ddlDepartment.DataBind();
            if (ddlDepartment.Items.Count == 1)
            {
                txtDepartment.Visible = true;
                cvDepartment.Visible = true;
            }

        }

        public int SelectedIndex
        {
            get
            { return ddlDepartment.SelectedIndex; }
            set
            { ddlDepartment.SelectedIndex = value; }
        }
        protected void ddlDepartment_SelectedIndexChanged(object sender, EventArgs e)
        {
            txtDepartment.Visible = (ddlDepartment.SelectedIndex == ddlDepartment.Items.Count - 1);
            cvDepartment.Visible = (ddlDepartment.SelectedIndex == ddlDepartment.Items.Count - 1);

        }


        protected void cvTxtCategory_ServerValidate(object source, System.Web.UI.WebControls.ServerValidateEventArgs args)
        {
            if (txtDepartment.Text.Trim() == string.Empty)
            {
                args.IsValid = false;
                cvDepartment.ErrorMessage = "Department is mandatory.";
            }
            else if (txtDepartment.Text.Trim().ToLower() == "other")
            {
                args.IsValid = false;
                cvDepartment.ErrorMessage = "Department can not be : \"Other.\"";
            }
            else
            {
                args.IsValid = true;
            }
        }
    }
}