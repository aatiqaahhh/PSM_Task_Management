using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PSMTaskManagementSystem
{
    public partial class Student : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string user_type = Session["user_type"] as string;
            if (user_type != "Staff")
            {
                Response.Redirect("Login.aspx");
            }
        }

        protected void StudProg_SelectedIndexChanged(object sender, EventArgs e)
        {
            
            string programme = StudProg.Text;

            if(programme == "0")
            {
                StudentList.SelectCommand = "SELECT a.user_id, a.user_name, a.matric_staff_no, b.programme_code, b.programme_id FROM userinfo a, programme b WHERE a.programme_id=b.programme_id";
            }
            else
            {
                StudentList.SelectCommand = "SELECT a.user_id, a.user_name, a.matric_staff_no, b.programme_code, b.programme_id FROM userinfo a, programme b WHERE a.programme_id=b.programme_id AND a.programme_id='" + programme + "'";
            }

            
            StudentList.DataBind();
            StudList.DataBind();
        }

        protected void OnRowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Select")
            {
                StudDetailPanel.Visible = true;
                int rowIndex = Convert.ToInt32(e.CommandArgument);

                GridViewRow row = StudList.Rows[rowIndex];
                Label2.Text = row.Cells[1].Text;
                string user_id = row.Cells[0].Text;
                string programme_id = row.Cells[4].Text;

                StudTaskList.SelectCommand = "SELECT task.task_name, task.task_descrption, FORMAT(task.due_date, 'dd/MM/yyyy') AS 'DATE DUE', FORMAT(task.date_added, 'dd/MM/yyyy') AS 'DATE ADDED', task_user.date_submit, CASE WHEN task_user.task_id IS NULL AND task.due_date < GETDATE() THEN 'OVERDUE' WHEN task_user.task_id IS NULL AND task.due_date > GETDATE() THEN 'PENDING' WHEN task_user.task_id IS NOT NULL AND DATEDIFF(DAY,task_user.date_submit,task.due_date) >= 0 THEN 'SUBMITTED' WHEN task_user.task_id IS NOT NULL AND DATEDIFF(DAY,task_user.date_submit,task.due_date) < 0 THEN 'LATE SUBMIT' END AS STATUS FROM task LEFT OUTER JOIN task_user ON task.task_id=task_user.task_id AND task_user.user_id='" + user_id + "' LEFT OUTER JOIN userinfo ON task_user.user_id = userinfo.user_id WHERE task.task_status='Y' AND task.programme_id='" + programme_id +"'"; ;
            }
        }

    }
}