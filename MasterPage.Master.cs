using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PSMTaskManagementSystem
{
    public partial class MasterPage : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["user_type"] != null)
            {
                LogBtn.Text = "Logout";
            }
            else
            {
                LogBtn.Text = "Login";
            }

        }

        protected void LogBtn_Click(object sender, EventArgs e)
        {
            if (Session["user_type"] != null)
            {
                Session.Clear();
                Response.Redirect("login.aspx");
            }
            else
            {
                Response.Redirect("login.aspx");
            }
        }
    }
}