<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Student.aspx.cs" Inherits="PSMTaskManagementSystem.Student" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <asp:Panel ID="StudListPanel" runat="server">
            <div class="col">
                <asp:Label ID="Label1" runat="server" Text="Student Management" CssClass="fw-bolder fs-1"></asp:Label>
            </div>
            <div class="col">
                <asp:DropDownList ID="StudProg" runat="server" DataSourceID="programme" DataTextField="programme_code" DataValueField="programme_id" OnSelectedIndexChanged="StudProg_SelectedIndexChanged" AutoPostBack="true" CssClass="form-control w-25">
                    <asp:ListItem Value="NOT NULL">Please Select Programme</asp:ListItem>
                </asp:DropDownList>
                <asp:SqlDataSource ID="programme" runat="server" ConnectionString="<%$ ConnectionStrings:psmtmsConnectionString %>" SelectCommand="SELECT programme_id, programme_code FROM programme UNION SELECT '0' AS programme_id, 'Select Programe' AS programme_code"></asp:SqlDataSource>
            </div>
            <asp:GridView ID="StudList" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="user_id,programme_id" DataSourceID="StudentList" ForeColor="#333333" GridLines="None" Width="100%" OnRowCommand="OnRowCommand">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:BoundField DataField="user_id" HeaderText="user_id" InsertVisible="False" ReadOnly="True" SortExpression="user_id" ItemStyle-CssClass="hiddencol" HeaderStyle-CssClass="hiddencol">
                    <HeaderStyle CssClass="hiddencol" />
                    <ItemStyle CssClass="hiddencol" />
                    </asp:BoundField>
                    <asp:BoundField DataField="user_name" HeaderText="Name" SortExpression="user_name" />
                    <asp:BoundField DataField="matric_staff_no" HeaderText="Matric No" SortExpression="matric_staff_no" >
                    <ItemStyle HorizontalAlign="Center" />
                    <HeaderStyle CssClass="text-center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="programme_code" HeaderText="Programme" SortExpression="programme_code" HeaderStyle-CssClass="text-center">
                    <HeaderStyle CssClass="text-center" />
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="programme_id" HeaderText="programme_id" InsertVisible="False" ReadOnly="True" SortExpression="programme_id" ItemStyle-CssClass="hiddencol" HeaderStyle-CssClass="hiddencol">
                    <HeaderStyle CssClass="hiddencol" />
                    <ItemStyle CssClass="hiddencol" />
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
            <asp:SqlDataSource ID="StudentList" runat="server" ConnectionString="<%$ ConnectionStrings:psmtmsConnectionString %>" SelectCommand="SELECT a.user_id, a.user_name, a.matric_staff_no, b.programme_code, b.programme_id FROM userinfo a, programme b WHERE a.programme_id=b.programme_id"></asp:SqlDataSource>
        </asp:Panel>
        <asp:Panel ID="StudDetailPanel" runat="server" Visible="False">
            <div class="col">
                <asp:Label ID="Label2" runat="server" Text="" CssClass="fw-bolder fs-1"></asp:Label>
            </div>
            <div class="col">
                <asp:GridView ID="StudDetail" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="StudTaskList" ForeColor="#333333" GridLines="None" Width="100%">
                    <AlternatingRowStyle BackColor="White" />
                    <Columns>
                        <asp:BoundField DataField="task_name" HeaderText="TASK NAME" SortExpression="task_name" />
                        <asp:BoundField DataField="task_descrption" HeaderText="TASK DESCRIPTION" SortExpression="task_descrption" />
                        <asp:BoundField DataField="DATE DUE" HeaderText="DATE DUE" ReadOnly="True" SortExpression="DATE DUE">
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="DATE ADDED" HeaderText="DATE ADDED" ReadOnly="True" SortExpression="DATE ADDED">
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="date_submit" HeaderText="DATE SUBMITTED" SortExpression="date_submit">
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="STATUS" HeaderText="STATUS" ReadOnly="True" SortExpression="STATUS">
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
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
                <asp:SqlDataSource ID="StudTaskList" runat="server" ConnectionString="<%$ ConnectionStrings:psmtmsConnectionString %>" SelectCommand="SELECT task.task_name, task.task_descrption, FORMAT(task.due_date, 'dd/MM/yyyy') AS 'DATE DUE', FORMAT(task.date_added, 'dd/MM/yyyy') AS 'DATE ADDED', task_user.date_submit, CASE WHEN task_user.task_id IS NULL AND task.due_date &lt; GETDATE() THEN 'OVERDUE' WHEN task_user.task_id IS NULL AND task.due_date &gt; GETDATE() THEN 'PENDING' WHEN task_user.task_id IS NOT NULL AND DATEDIFF(DAY,task_user.date_submit,task.due_date) &gt;= 0 THEN 'SUBMITTED' WHEN task_user.task_id IS NOT NULL AND DATEDIFF(DAY,task_user.date_submit,task.due_date) &lt; 0 THEN 'LATE SUBMIT' END AS STATUS FROM task LEFT OUTER JOIN task_user ON task.task_id=task_user.task_id LEFT OUTER JOIN userinfo ON task_user.user_id = userinfo.user_id WHERE task.task_status='Y'"></asp:SqlDataSource>
            </div>
        </asp:Panel>
    </div>
</asp:Content>
