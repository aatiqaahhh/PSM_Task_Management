<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Analytic.aspx.cs" Inherits="PSMTaskManagementSystem.Analytic" %>
<%@ Register assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <asp:Panel ID="StudListPanel" runat="server">
            <div class="row">
                <asp:Label ID="Label1" runat="server" Text="Student Analytic" CssClass="fw-bolder fs-1"></asp:Label>
            </div>
            <div class="row">
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
            <div class="row">
                <asp:Label ID="Label2" runat="server" Text="" CssClass="fw-bolder fs-1"></asp:Label>
            </div>
            <div class="row">
                <div class="d-flex justify-content-center">
                <asp:Chart ID="Chart1" runat="server" DataSourceID="StudChart" Palette="Excel">
                    <Titles>
                        <asp:Title Font="Times New Roman, 12pt, style=Bold, Italic" Name="Title1" 
                            Text="Task Completion">
                        </asp:Title>
                    </Titles>
                    <series>
                        <asp:Series Name="Series1" ChartType="Pie" XValueMember="STATUS" YValueMembers="COUNT">
                        </asp:Series>
                    </series>
                    <chartareas>
                        <asp:ChartArea Name="ChartArea1">
                        </asp:ChartArea>
                    </chartareas>
                </asp:Chart>
                <asp:SqlDataSource ID="StudChart" runat="server" ConnectionString="<%$ ConnectionStrings:psmtmsConnectionString %>" SelectCommand="SELECT CASE WHEN task_user.task_id IS NULL AND task.due_date &lt; GETDATE() THEN 'OVERDUE' WHEN task_user.task_id IS NULL AND task.due_date &gt; GETDATE() THEN 'PENDING' WHEN task_user.task_id IS NOT NULL AND DATEDIFF(DAY,task_user.date_submit,task.due_date) &gt;= 0 THEN 'SUBMITTED' WHEN task_user.task_id IS NOT NULL AND DATEDIFF(DAY,task_user.date_submit,task.due_date) &lt; 0 THEN 'LATE SUBMIT' END AS STATUS, COUNT(*) AS 'COUNT' FROM task LEFT OUTER JOIN task_user ON task.task_id=task_user.task_id LEFT OUTER JOIN userinfo ON task_user.user_id = userinfo.user_id WHERE task.task_status='Y' GROUP BY CASE WHEN task_user.task_id IS NULL AND task.due_date &lt; GETDATE() THEN 'OVERDUE' WHEN task_user.task_id IS NULL AND task.due_date &gt; GETDATE() THEN 'PENDING' WHEN task_user.task_id IS NOT NULL AND DATEDIFF(DAY,task_user.date_submit,task.due_date) &gt;= 0 THEN 'SUBMITTED' WHEN task_user.task_id IS NOT NULL AND DATEDIFF(DAY,task_user.date_submit,task.due_date) &lt; 0 THEN 'LATE SUBMIT' END">
                </asp:SqlDataSource>
                </div>
            </div>
        </asp:Panel>
        <asp:Panel ID="TaskListPanel" runat="server">
            <div class="row">
                <asp:Label ID="Label3" runat="server" Text="Task Analytic" CssClass="fw-bolder fs-1"></asp:Label>
            </div>
            <div class="row">
                <asp:DropDownList ID="StudProg2" runat="server" DataSourceID="programme" DataTextField="programme_code" DataValueField="programme_id" OnSelectedIndexChanged="StudProg2_SelectedIndexChanged" AutoPostBack="true" CssClass="form-control w-25">
                    <asp:ListItem Value="NOT NULL">Please Select Programme</asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="row">
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:psmtmsConnectionString %>" SelectCommand="SELECT a.task_id, a.task_name, a.task_descrption, FORMAT(a.date_added, 'dd/MM/yyyy') AS 'ADDED DATE', FORMAT(a.due_date, 'dd/MM/yyyy') AS 'DUE DATE', b.programme_id,  b.programme_code FROM task a, programme b WHERE task_status='y' AND a.programme_id=b.programme_id">
                </asp:SqlDataSource>
                <asp:GridView ID="TaskList" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="task_id,programme_id" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None" HorizontalAlign="Center" Width="100%" OnRowCommand="OnRowCommand2">
                    <AlternatingRowStyle BackColor="White" />
                    <Columns>
                        <asp:BoundField DataField="task_id" HeaderText="task_id" SortExpression="task_id" InsertVisible="False" ReadOnly="True" HeaderStyle-CssClass="hiddencol" ItemStyle-CssClass="hiddencol"/>
                        <asp:BoundField DataField="task_name" HeaderText="TASK NAME" SortExpression="task_name" />
                        <asp:BoundField DataField="task_descrption" HeaderText="TASK DESCRIPTION" SortExpression="task_descrption" HeaderStyle-CssClass="text-center" >
                        <HeaderStyle CssClass="text-center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="ADDED DATE" HeaderText="ADDED DATE" ReadOnly="True" SortExpression="ADDED DATE" HeaderStyle-CssClass="text-center">
                        <HeaderStyle CssClass="text-center" />
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="DUE DATE" HeaderText="DUE DATE" SortExpression="DUE DATE" HeaderStyle-CssClass="text-center" ReadOnly="True">
                        <HeaderStyle CssClass="text-center" />
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="programme_id" HeaderText="programme_id" InsertVisible="False" ReadOnly="True" SortExpression="programme_id" HeaderStyle-CssClass="hiddencol" ItemStyle-CssClass="hiddencol"/>
                        <asp:BoundField DataField="programme_code" HeaderText="PROGRAMME" SortExpression="programme_code">
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
            </div>
        </asp:Panel>
        <asp:Panel ID="TaskDetailPanel" runat="server" Visible="False">
            <div class="row">
                <asp:Label ID="Label4" runat="server" Text="" CssClass="fw-bolder fs-1"></asp:Label>
            </div>
            <div class="row">
                <div class="d-flex justify-content-center">
                    <asp:Chart ID="Chart2" runat="server" DataSourceID="TaskChart">
                        <Titles>
                            <asp:Title Font="Times New Roman, 12pt, style=Bold, Italic" Name="Title1" 
                                Text="Student Completion">
                            </asp:Title>
                        </Titles>
                        <Series>
                            <asp:Series Name="Series1" ChartType="Pie" XValueMember="STATUS" YValueMembers="COUNT"></asp:Series>
                        </Series>
                        <ChartAreas>
                            <asp:ChartArea Name="ChartArea1"></asp:ChartArea>
                        </ChartAreas>
                    </asp:Chart>
                    <asp:SqlDataSource ID="TaskChart" runat="server" ConnectionString="<%$ ConnectionStrings:psmtmsConnectionString %>" SelectCommand="SELECT COUNT(*) AS 'COUNT', CASE WHEN task_user.date_submit IS NULL THEN 'PENDING' WHEN task_user.task_id IS NOT NULL AND DATEDIFF(DAY,task_user.date_submit,task.due_date) &gt;= 0 THEN 'SUBMITTED' WHEN task_user.task_id IS NOT NULL AND DATEDIFF(DAY,task_user.date_submit,task.due_date) &lt; 0 THEN 'LATE SUBMIT' END AS STATUS FROM userinfo LEFT OUTER JOIN task_user ON userinfo.user_id=task_user.user_id LEFT OUTER JOIN task ON task.task_id=task_user.task_id AND task.task_status='y' GROUP BY CASE WHEN task_user.date_submit IS NULL THEN 'PENDING' WHEN task_user.task_id IS NOT NULL AND DATEDIFF(DAY,task_user.date_submit,task.due_date) &gt;= 0 THEN 'SUBMITTED' WHEN task_user.task_id IS NOT NULL AND DATEDIFF(DAY,task_user.date_submit,task.due_date) &lt; 0 THEN 'LATE SUBMIT' END"></asp:SqlDataSource>
                </div>
            </div>
        </asp:Panel>
    </div>
</asp:Content>
