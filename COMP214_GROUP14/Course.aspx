<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Course.aspx.cs" Inherits="COMP214_GROUP14.Course" %>

<%@ Register Src="~/WebControls/ucDepartment.ascx" TagPrefix="uc1" TagName="ucDepartment" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">


    <div class="container">
        <br />
        <div class="hidden alert-success" runat="server" id="divMessage">
            <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
            <span id="divMessageBody" runat="server">Courses was saved successfully.</span>
        </div>
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3><span class="glyphicon glyphicon-calendar"></span>&nbsp;Add Courses</h3>
            </div>
            <div class="panel-body">
                <div class="row">
                    <div class="form-inline">
                        <div class="col-md-3">
                            <label for="txtTitle">Course Title:</label>
                        </div>
                        <div class="col-md-4">
                            <asp:TextBox ID="txtTitle" runat="server" MaxLength="50"></asp:TextBox>
                            <br />
                            <asp:RequiredFieldValidator ID="rvtxtTitle" runat="server" ControlToValidate="txtTitle" ErrorMessage="Title is mandatory."></asp:RequiredFieldValidator>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="form-inline">
                        <div class="col-md-3">
                            <label for="txtCredit">Course Credit:</label>
                        </div>
                        <div class="col-md-4">
                            <asp:TextBox ID="txtCredit" runat="server" MaxLength="50" TextMode="Number"></asp:TextBox>
                            <br />
                            <asp:RequiredFieldValidator ID="rvtxtCredit" runat="server" ControlToValidate="txtCredit" ErrorMessage="Credit is mandatory."></asp:RequiredFieldValidator>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="form-inline">
                        <div class="col-md-3">
                            <label for="ddlDepartment">Department:</label>
                        </div>
                        <div class="col-md-4">
                            <uc1:ucDepartment runat="server" ID="ucDepartment1" />
                        </div>
                    </div>
                </div>
            </div>
            <div class="row form-inline">
                <div class="col-md-3"></div>
                <div class="col_md-9">
                    <button id="btnAdd" class="btn btn-primary" runat="server" onserverclick="btnAdd_ServerClick">&nbsp;&nbsp;<span class="glyphicon glyphicon-ok"></span>&nbsp;&nbsp;Save&nbsp;&nbsp;</button>
                    <button id="btnCancel" type="reset" class="btn btn-default" runat="server" causesvalidation="False">&nbsp;&nbsp;<span class="glyphicon glyphicon-remove"></span>&nbsp;&nbsp;Cancel&nbsp;&nbsp;</button>
                </div>
                <br />
            </div>
        </div>

        <asp:ListView ID="ListView1" runat="server" DataSourceID="SqlDataSource1"
            DataKeyNames="COURSE_ID"
            OnItemCommand="ListView1_ItemCommand">

            <EmptyDataTemplate>
                <table runat="server" class="table">
                    <tr>
                        <td>No data was returned.</td>
                    </tr>
                </table>
            </EmptyDataTemplate>

            <ItemTemplate>
                <tr style="">
                    <td>
                        <asp:Label ID="TITLELabel" runat="server" Text='<%# Eval("TITLE") %>' />
                    </td>
                    <td>
                        <asp:Label ID="CREDITSLabel" runat="server" Text='<%# Eval("CREDITS") %>' />
                    </td>
                    <td>
                        <asp:Label ID="DEPTNAMELabel" runat="server" Text='<%# Eval("DEPTNAME") %>' />
                    </td>
                    <td>
                        <asp:Button ID="CompletedItemButton"
                            runat="server"
                            CssClass="btn btn-primary"
                            CommandName="DeleteItem"
                            CommandArgument='<%# Eval("COURSE_ID") %>'
                            Text="Complete"
                            OnClientClick="return confirm('Are you absolutely sure you want to delete this instructor and his courses?');" />
                    </td>
                </tr>
            </ItemTemplate>
            <LayoutTemplate>

                <td runat="server">
                    <table id="itemPlaceholderContainer" runat="server" class="table">
                        <tr runat="server" style="">
                            <th runat="server">TITLE</th>
                            <th runat="server">CREDITS</th>
                            <th runat="server">DEPTNAME</th>
                            <th runat="server">DEPTNAME</th>
                        </tr>
                        <tr id="itemPlaceholder" runat="server">
                        </tr>
                    </table>
                </td>
                </tr>
              
            </LayoutTemplate>

        </asp:ListView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT c.course_id course_id, c.title title, c.credits credits, d.name DeptName FROM sc_courses c inner join sc_departments d using (dept_id) where c.completed='N'"></asp:SqlDataSource>
    </div>
    <script src="Scripts/AlterAutoHidden.js"></script>

</asp:Content>
