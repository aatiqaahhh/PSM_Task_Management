using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PSMTaskManagementSystem
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["user_type"] != null)
            {
                Response.Redirect("Task.aspx");
            }
        }

        protected void LoginBtn_Click(object sender, EventArgs e)
        {
            string username = usernameText.Text;
            string password = pwd.Text;
            string type = DropDownType.Text;

            SqlConnection conn = new SqlConnection("Data Source=(localDb)\\localDBDemo;Initial Catalog=psmtms;Integrated Security=True; MultipleActiveResultSets=true;");
            
            if (username.Equals("") || password.Equals(""))
            {
                LabelStatus.Text = "Please insert all value...";
            }
            else
            {
                try
                {
                    conn.Open();
                    {
                        SqlCommand login = new SqlCommand("SELECT user_id, type, programme_id FROM userinfo WHERE matric_staff_no=@one AND password=@two AND type=@three", conn);
                        login.Parameters.AddWithValue("@one", username);
                        login.Parameters.AddWithValue("@two", password);
                        login.Parameters.AddWithValue("@three", type);

                        using (SqlDataReader reader = login.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                string user_type = String.Format("{0}", reader["type"]);
                                string user_id = String.Format("{0}", reader["user_id"]);
                                Session["user_type"] = user_type;
                                Session["user_id"] = user_id;
                                if (reader["programme_id"] != null)
                                {
                                    Session["programme_id"] = String.Format("{0}", reader["programme_id"]);
                                }
                                Response.Redirect("Task.aspx");
                            }
                            else
                            {
                                LabelStatus.Text = "Invalid No or Password!";
                            }
                        }
                    
                    }
                }
                catch (Exception ex)
                {
                    Response.Write(ex.ToString());
                }
                finally { conn.Close(); }
                
            }
            
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            Response.Redirect("Register.aspx");
        }
    }
}