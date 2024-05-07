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
    public partial class index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["user_type"] == null)
            {
                Response.Redirect("Login.aspx");
            }
            string user_type = Session["user_type"] as string;
            if (Session["programme_id"] != null)
            {
                string programme_id = Session["programme_id"] as string;
                string user_id = Session["user_id"] as string;
                StudentTaskData.SelectCommand = "SELECT task.task_id, task.task_name, task.task_descrption, FORMAT(task.due_date, 'dd/MM/yyyy') AS 'DATE DUE', FORMAT(task.date_added, 'dd/MM/yyyy') AS 'DATE ADDED', CASE WHEN task_user.task_id IS NULL AND task.due_date < GETDATE() THEN 'OVERDUE' WHEN task_user.task_id IS NULL AND task.due_date > GETDATE() THEN 'PENDING' WHEN task_user.task_id IS NOT NULL AND DATEDIFF(DAY,task_user.date_submit,task.due_date) >= 0 THEN 'SUBMITTED' WHEN task_user.task_id IS NOT NULL AND DATEDIFF(DAY,task_user.date_submit,task.due_date) < 0 THEN 'LATE SUBMIT' END AS STATUS FROM task LEFT OUTER JOIN task_user ON task.task_id=task_user.task_id AND task_user.user_id='" + user_id + "'LEFT OUTER JOIN userinfo ON task_user.user_id = userinfo.user_id WHERE task.task_status='Y' AND task.programme_id='" + programme_id + "'";
                StudentTaskData.DataBind();
                GridView2.DataBind();
            }
            if (user_type == "Staff")
            {
                PanelStaff.Visible = true;
                PanelStudent.Visible = false;
            }
            else
            {
                PanelStaff.Visible = false;
                PanelStudent.Visible = true;
            }
        }

        protected void addTaskBtn_Click(object sender, EventArgs e)
        {
            addTaskPanel.Visible = true;
        }

        protected void saveTask_Click(object sender, EventArgs e)
        {
            string task_name = taskName.Text;
            string task_description = taskDesc.Text;
            string programme_id = programmeList.SelectedValue;
            string due_date = taskDue.SelectedDate.ToShortDateString();

            SqlConnection conn = new SqlConnection("Data Source=(localDb)\\localDBDemo;Initial Catalog=psmtms;Integrated Security=True");

            if (task_name.Equals("") && task_description.Equals("") && programme_id.Equals("") && due_date.Equals(""))
            {
                lblStatus.Text = "Please make sure all form is filled ...";
            }
            else
            {
                try
                {
                    conn.Open();

                    SqlDataAdapter cmd = new SqlDataAdapter();

                    cmd.InsertCommand = new SqlCommand("INSERT INTO task (task_name, task_descrption, date_added, due_date, task_status, programme_id) VALUES (@one, @two, GETDATE(), @three, @four, @five)", conn);

                    cmd.InsertCommand.Parameters.Add("@one", SqlDbType.Text).Value = task_name;
                    cmd.InsertCommand.Parameters.Add("@two", SqlDbType.Text).Value = task_description;
                    cmd.InsertCommand.Parameters.Add("@three", SqlDbType.Date).Value = due_date;
                    cmd.InsertCommand.Parameters.Add("@four", SqlDbType.Char).Value = 'Y';
                    cmd.InsertCommand.Parameters.Add("@five", SqlDbType.Int).Value = programme_id;

                    cmd.InsertCommand.ExecuteNonQuery();

                    Response.Redirect("Task.aspx");
                }
                catch(Exception ex) { Response.Write(ex.ToString()); }finally { conn.Close(); }
                

            }
        }
        protected void OnRowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Select")
            {
                int rowIndex = Convert.ToInt32(e.CommandArgument);

                GridViewRow row = GridView2.Rows[rowIndex];
                SubmitTaskLabel.Text = row.Cells[1].Text;
                TaskID.Value = row.Cells[0].Text;
                if (row.Cells[5].Text == "SUBMITTED")
                {
                    BtnSubmitTask.Enabled = false;
                    CheckBox1.Checked = true;
                    CheckBox1.Enabled = false;
                } else if (row.Cells[5].Text == "LATE SUBMIT")
                {
                    BtnSubmitTask.Enabled = false;
                    CheckBox1.Checked = true;
                    CheckBox1.Enabled = false;
                }
                else if (row.Cells[5].Text == "PENDING")
                {
                    BtnSubmitTask.Enabled = true;
                    CheckBox1.Checked = false;
                    CheckBox1.Enabled = true;
                }
                PanelSubmitTask.Visible = true;

            }
        }

        protected void BtnSubmitTask_Click(object sender, EventArgs e)
        {
            string task_id = TaskID.Value;
            string student_id = Session["user_id"] as string;

            SqlConnection conn = new SqlConnection("Data Source=(localDb)\\localDBDemo;Initial Catalog=psmtms;Integrated Security=True");

            if(CheckBox1.Checked == false)
            {
                Label2.Text = "Please check the checkbox";
            }
            else
            {
                try
                {
                    conn.Open();

                    SqlDataAdapter cmd = new SqlDataAdapter();

                    cmd.InsertCommand = new SqlCommand("INSERT INTO task_user (task_id, user_id, date_submit) VALUES (@one, @two, GETDATE())", conn);

                    cmd.InsertCommand.Parameters.Add("@one", SqlDbType.Int).Value = task_id;
                    cmd.InsertCommand.Parameters.Add("@two", SqlDbType.Int).Value = student_id;

                    cmd.InsertCommand.ExecuteNonQuery();
                    Response.Redirect("Task.aspx");
                }
                catch (Exception ex)
                {
                    Response.Write(ex.ToString());
                }
                finally
                {
                    conn.Close();
                }
            }
        }
    }

    
}