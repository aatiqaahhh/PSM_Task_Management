using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection.Emit;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PSMTaskManagementSystem
{
    public partial class Analytic : System.Web.UI.Page
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

            if (programme == "0")
            {
                StudentList.SelectCommand = "SELECT a.user_id, a.user_name, a.matric_staff_no, b.programme_code, b.programme_id FROM userinfo a, programme b WHERE a.programme_id=b.programme_id";
            }
            else
            {
                StudentList.SelectCommand = "SELECT a.user_id, a.user_name, a.matric_staff_no, b.programme_code, b.programme_id FROM userinfo a, programme b WHERE a.programme_id=b.programme_id AND a.programme_id='" + programme + "'";
            }

            StudentList.DataBind();
            StudList.DataBind();
            TaskDetailPanel.Visible = false;
        }

        protected void StudProg2_SelectedIndexChanged(object sender, EventArgs e)
        {
            string programme = StudProg2.Text;

            if (programme == "0")
            {
                SqlDataSource1.SelectCommand = "SELECT a.task_id, a.task_name, a.task_descrption, FORMAT(a.date_added, 'dd/MM/yyyy') AS 'ADDED DATE', FORMAT(a.due_date, 'dd/MM/yyyy') AS 'DUE DATE', b.programme_id,  b.programme_code FROM task a, programme b WHERE task_status='y' AND a.programme_id=b.programme_id";
            }
            else
            {
                SqlDataSource1.SelectCommand = "SELECT a.task_id, a.task_name, a.task_descrption, FORMAT(a.date_added, 'dd/MM/yyyy') AS 'ADDED DATE', FORMAT(a.due_date, 'dd/MM/yyyy') AS 'DUE DATE', b.programme_id,  b.programme_code FROM task a, programme b WHERE task_status='y' AND a.programme_id=b.programme_id AND b.programme_id='"+ programme +"'";
            }

            TaskList.DataBind();
            SqlDataSource1.DataBind();
            StudDetailPanel.Visible = false;
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

                StudChart.SelectCommand = "SELECT CASE WHEN task_user.task_id IS NULL AND task.due_date < GETDATE() THEN 'OVERDUE' WHEN task_user.task_id IS NULL AND task.due_date > GETDATE() THEN 'PENDING' WHEN task_user.task_id IS NOT NULL AND DATEDIFF(DAY,task_user.date_submit,task.due_date) >= 0 THEN 'SUBMITTED' WHEN task_user.task_id IS NOT NULL AND DATEDIFF(DAY,task_user.date_submit,task.due_date) < 0 THEN 'LATE SUBMIT' END AS STATUS, COUNT(*) AS 'COUNT' FROM task LEFT OUTER JOIN task_user ON task.task_id=task_user.task_id AND task_user.user_id='"+ user_id +"' LEFT OUTER JOIN userinfo ON task_user.user_id = userinfo.user_id WHERE task.task_status='Y' AND task.programme_id='"+ programme_id +"' GROUP BY CASE WHEN task_user.task_id IS NULL AND task.due_date < GETDATE() THEN 'OVERDUE' WHEN task_user.task_id IS NULL AND task.due_date > GETDATE() THEN 'PENDING' WHEN task_user.task_id IS NOT NULL AND DATEDIFF(DAY,task_user.date_submit,task.due_date) >= 0 THEN 'SUBMITTED' WHEN task_user.task_id IS NOT NULL AND DATEDIFF(DAY,task_user.date_submit,task.due_date) < 0 THEN 'LATE SUBMIT' END";
                TaskDetailPanel.Visible = false;
            }
        }

        protected void OnRowCommand2(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Select")
            {
                TaskDetailPanel.Visible = true;
                int rowIndex = Convert.ToInt32(e.CommandArgument);

                GridViewRow row = TaskList.Rows[rowIndex];
                Label4.Text = row.Cells[1].Text;
                string task_id = row.Cells[0].Text;
                string programme_id = row.Cells[5].Text;

                TaskChart.SelectCommand = "SELECT COUNT(*) AS 'COUNT', CASE WHEN task_user.date_submit IS NULL THEN 'PENDING' WHEN task_user.task_id IS NOT NULL AND DATEDIFF(DAY,task_user.date_submit,task.due_date) >= 0 THEN 'SUBMITTED' WHEN task_user.task_id IS NOT NULL AND DATEDIFF(DAY,task_user.date_submit,task.due_date) < 0 THEN 'LATE SUBMIT' END AS STATUS FROM userinfo LEFT OUTER JOIN task_user ON userinfo.user_id=task_user.user_id AND task_user.task_id='" + task_id + "' LEFT OUTER JOIN task ON task.task_id=task_user.task_id AND task.task_status='y' WHERE userinfo.programme_id='" + programme_id + "' GROUP BY CASE WHEN task_user.date_submit IS NULL THEN 'PENDING' WHEN task_user.task_id IS NOT NULL AND DATEDIFF(DAY,task_user.date_submit,task.due_date) >= 0 THEN 'SUBMITTED' WHEN task_user.task_id IS NOT NULL AND DATEDIFF(DAY,task_user.date_submit,task.due_date) < 0 THEN 'LATE SUBMIT' END";
                StudDetailPanel.Visible = false;
            }
        }
    }
}