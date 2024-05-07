<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Task.aspx.cs" Inherits="PSMTaskManagementSystem.index" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <div class="container">
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:psmtmsConnectionString %>" SelectCommand="SELECT a.task_id, a.task_name, a.task_descrption, FORMAT(a.date_added, 'dd/MM/yyyy') AS 'ADDED DATE', FORMAT(a.due_date, 'dd/MM/yyyy') AS 'DUE DATE',  b.programme_code FROM task a, programme b WHERE task_status='y' AND a.programme_id=b.programme_id" DeleteCommand="UPDATE task SET task_status='n' WHERE task_id=@task_id; DELETE FROM task_user WHERE task_id=@task_id" UpdateCommand="UPDATE task SET task_name=@task_name, task_descrption=@task_descrption WHERE task_id=@task_id">
        <DeleteParameters>
            <asp:Parameter Name="task_id" />
        </DeleteParameters>
        </asp:SqlDataSource>
        <asp:Panel ID="PanelStaff" runat="server">
            <div class="row">
                <div class="col">
                    <asp:Label ID="Label1" runat="server" Text="Task Management" CssClass="fw-bolder fs-1"></asp:Label>
                </div>
                <div class="col">
                    <asp:Button ID="addTaskBtn" runat="server" CssClass="btn btn-light float-end" OnClick="addTaskBtn_Click" Text="ADD TASK" />
                </div>
            </div>
            <div class="row">
                <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="task_id" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None" HorizontalAlign="Center" Width="100%">
                    <AlternatingRowStyle BackColor="White" />
                    <Columns>
                        <asp:BoundField DataField="task_name" HeaderText="TASK NAME" SortExpression="task_name" />
                        <asp:BoundField DataField="task_descrption" HeaderText="TASK DESCRIPTION" SortExpression="task_descrption" />
                        <asp:BoundField DataField="ADDED DATE" HeaderText="ADDED DATE" SortExpression="ADDED DATE" HeaderStyle-CssClass="text-center" ReadOnly="True" >
                        <HeaderStyle CssClass="text-center" />
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="DUE DATE" HeaderText="DUE DATE" ReadOnly="True" SortExpression="DUE DATE" HeaderStyle-CssClass="text-center">
                        <HeaderStyle CssClass="text-center" />
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="programme_code" HeaderText="PROGRAMME" SortExpression="programme_code" HeaderStyle-CssClass="text-center" ReadOnly="True">
                        <HeaderStyle CssClass="text-center" />
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:CommandField ShowEditButton="True" />
                        <asp:CommandField ShowDeleteButton="True" />
                    </Columns>
                    <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
                    <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
                    <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
                    <SortedAscendingCellStyle BackColor="#FDF5AC" />
                    <SortedAscendingHeaderStyle BackColor="#4D0000" />
                    <SortedDescendingCellStyle BackColor="#FCF6C0" />
                    <SortedDescendingHeaderStyle BackColor="#820000" />
                </asp:GridView>
            </div>
        </asp:Panel>
        <asp:Panel ID="addTaskPanel" runat="server" Visible="False">
            <div class="row">
                <h1 id="addTaskHeader" class="fw-bolder fs-1">Add Task</h1>
            </div>
            <div class="row py-2">
                <div class="col">
                    Task Name:
                </div>
                <div class="col">
                    <asp:TextBox ID="taskName" CssClass="form-control" runat="server"></asp:TextBox>
                </div>
            </div>
            <div class="row py-2">
                <div class="col">
                    Description:
                </div>
                <div class="col">
                    <asp:TextBox ID="taskDesc" CssClass="form-control" runat="server" TextMode="MultiLine"></asp:TextBox>
                </div>
            </div>
            <div class="row py-2">
                <div class="col">
                    Due Date: 
                </div>
                <div class="col">
                    <asp:Calendar ID="taskDue" runat="server" ></asp:Calendar>
                </div>
            </div>
            <div class="row py-2">
                <div class="col">
                    Assigned to:
                </div>
                <div class="col">
                    <asp:RadioButtonList ID="programmeList" runat="server" DataSourceID="progamme" DataTextField="programme_code" DataValueField="programme_id">
                    </asp:RadioButtonList>
                </div>
            </div>
            <div class="row py-2">
                <div class="col">
                    <asp:Button ID="saveTask" runat="server" CssClass="btn btn-light" OnClick="saveTask_Click" Text="Save" />
                </div>
                <div class="row">
                    <asp:Label ID="lblStatus" runat="server"></asp:Label>
                </div>
            </div>
            <asp:SqlDataSource ID="progamme" runat="server" ConnectionString="<%$ ConnectionStrings:psmtmsConnectionString %>" SelectCommand="SELECT [programme_id], [programme_code] FROM [programme]"></asp:SqlDataSource>

                
        </asp:Panel>
        <asp:Panel ID="PanelStudent" runat="server">
            <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataKeyNames="task_id" DataSourceID="StudentTaskData" OnRowCommand="OnRowCommand" CellPadding="4" ForeColor="#333333" GridLines="None" Width="100%" AllowPaging="True" AllowSorting="True">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:BoundField DataField="task_id" HeaderText="#" InsertVisible="False" ReadOnly="True" SortExpression="task_id" Visible="True" ItemStyle-CssClass="hiddencol" HeaderStyle-CssClass="hiddencol"/>
                    <asp:BoundField DataField="task_name" HeaderText="NAME" SortExpression="task_name" />
                    <asp:BoundField DataField="task_descrption" HeaderText="DESCRIPTION" SortExpression="task_descrption" />
                    <asp:BoundField DataField="DATE DUE" HeaderText="DATE DUE" SortExpression="due_date" HeaderStyle-CssClass="text-center">
                    <HeaderStyle />
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="DATE ADDED" HeaderText="DATE ADDED" SortExpression="date_added" HeaderStyle-CssClass="text-center">
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="STATUS" HeaderText="STATUS" ReadOnly="True" SortExpression="STATUS" HeaderStyle-CssClass="text-center">
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:CommandField ShowSelectButton="True" />
                    
                </Columns>
                <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
                <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
                <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
                <SortedAscendingCellStyle BackColor="#FDF5AC" />
                <SortedAscendingHeaderStyle BackColor="#4D0000" />
                <SortedDescendingCellStyle BackColor="#FCF6C0" />
                <SortedDescendingHeaderStyle BackColor="#820000" />
            </asp:GridView>
            <asp:SqlDataSource ID="StudentTaskData" runat="server" ConnectionString="<%$ ConnectionStrings:psmtmsConnectionString %>" SelectCommand="SELECT task.task_id, task.task_name, task.task_descrption, FORMAT(task.due_date, 'dd/MM/yyyy') AS 'DATE DUE', FORMAT(task.date_added, 'dd/MM/yyyy') AS 'DATE ADDED', CASE WHEN task_user.task_id IS NULL AND task.due_date < GETDATE() THEN 'OVERDUE' WHEN task_user.task_id IS NULL AND task.due_date > GETDATE() THEN 'PENDING' WHEN task_user.task_id IS NOT NULL AND task_user.date_submit < task.due_date THEN 'SUBMITTED' WHEN task_user.task_id IS NOT NULL AND task_user.date_submit > task.due_date THEN 'LATE SUBMIT' END AS STATUS FROM task LEFT OUTER JOIN task_user ON task.task_id=task_user.task_id LEFT OUTER JOIN userinfo ON task_user.user_id = userinfo.user_id WHERE task.task_status='Y'"></asp:SqlDataSource>
        </asp:Panel>
        <asp:Panel ID="PanelSubmitTask" runat="server" Visible="False">
            <asp:Label ID="SubmitTaskLabel" runat="server" Text="" CssClass="fw-bolder fs-1"></asp:Label>
            <br />
            <asp:HiddenField ID="TaskID" runat="server" />
            <br />
            <asp:CheckBox ID="CheckBox1" runat="server" Text="Finished?" />
            <br />
            <asp:Label ID="Label2" runat="server" Text=""></asp:Label>
            <br />
            <asp:Button ID="BtnSubmitTask" runat="server" Text="Submit" OnClick="BtnSubmitTask_Click" CssClass="btn btn-secondary"/>
        </asp:Panel>
        </div>
</asp:Content>
