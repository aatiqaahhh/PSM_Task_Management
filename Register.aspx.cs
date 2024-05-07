using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PSMTaskManagementSystem
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["user_type"] != null)
            {
                Response.Redirect("Task.aspx");
            }
        }

        protected void BtnSubmit_Click(object sender, EventArgs e)
        {
            string name = TxtName.Text;
            string matric = TxtMatric.Text;
            string pwd = TxtPwd.Text;
            string pwd2 = TxtPwd2.Text;
            string programme_id = programmeList.SelectedValue;

            SqlConnection conn = new SqlConnection("Data Source=(localDb)\\localDBDemo;Initial Catalog=psmtms;Integrated Security=True; MultipleActiveResultSets=true;");

            if (name.Equals("") && matric.Equals("") && pwd.Equals("") && programme_id.Equals(""))
            {
                LblStatus.Text = "Please make sure all field is filled";
            }
            else
            {
                if (pwd == pwd2)
                {
                    LblStatus.Text = "Success";

                    try
                    {
                        conn.Open();
                        SqlCommand checkExist = new SqlCommand("SELECT user_id FROM userinfo WHERE matric_staff_no like @one", conn);
                        checkExist.Parameters.AddWithValue("@one", matric);

                        using(SqlDataReader reader = checkExist.ExecuteReader())
                        {
                            if(reader.Read())
                            {
                                LblStatus.Text = "This Matric Number already registered";
                            }
                            else
                            {
                                SqlDataAdapter adapter = new SqlDataAdapter();

                                adapter.InsertCommand = new SqlCommand("INSERT INTO userinfo (user_name, matric_staff_no, password, type, programme_id) VALUES (@one, @two, @three, @four, @five)", conn);

                                adapter.InsertCommand.Parameters.Add("@one", SqlDbType.Text).Value = name;
                                adapter.InsertCommand.Parameters.Add("@two", SqlDbType.Text).Value = matric;
                                adapter.InsertCommand.Parameters.Add("@three", SqlDbType.Text).Value = pwd;
                                adapter.InsertCommand.Parameters.Add("@four", SqlDbType.Text).Value = "Student";
                                adapter.InsertCommand.Parameters.Add("@five", SqlDbType.Int).Value = programme_id;

                                adapter.InsertCommand.ExecuteNonQuery();

                                Response.Redirect("Login.aspx");
                            }
                        }

                    }catch (Exception ex) { Response.Write(ex.ToString()); }finally { conn.Close(); }
                }
                else
                {
                    LblStatus.Text = "Please make sure that the password is the same";
                }
                
            }
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            Response.Redirect("Login.aspx");
        }
    }
}