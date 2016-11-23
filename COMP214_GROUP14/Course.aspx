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

                <div class="form-group">

                    <div class="col-md-3">
                        <label for="txtTitle" class="control-label">Course Title:</label>
                    </div>
                    <div class="col-md-9">
                        <asp:TextBox ID="txtTitle" runat="server" MaxLength="50"></asp:TextBox>

                        <asp:RequiredFieldValidator ID="rvtxtTitle" runat="server" ControlToValidate="txtTitle" ErrorMessage="Title is mandatory."></asp:RequiredFieldValidator>
                    </div>

                </div>
                <div class="form-group">

                    <div class="col-md-3">
                        <label for="txtCredit" class="control-label">Course Credit:</label>
                    </div>
                    <div class="col-md-9">
                        <asp:TextBox ID="txtCredit" CssClass="form-control" runat="server" MaxLength="50" TextMode="Number"></asp:TextBox>

                        <asp:RequiredFieldValidator ID="rvtxtCredit" runat="server" ControlToValidate="txtCredit" ErrorMessage="Credit is mandatory."></asp:RequiredFieldValidator>
                    </div>

                </div>

                <div class="form-group">

                    <div class="col-md-3">
                        <label for="ddlDepartment" class="control-label">Department:</label>
                    </div>
                    <div class="col-md-9">
                        <uc1:ucDepartment runat="server" ID="ucDepartment1" />
                    </div>

                </div>
            </div>
            <div class="row form-inline">
                <br />
                <div class="col-md-3"></div>
                <div class="col_md-9">
                    <button id="btnAdd"
                        data-toggle="tooltip" data-placement="left"
                        title="This command button will call Create_Course_SP procedure. If department is not exist, it will create the departmet."
                        class="btn btn-primary" runat="server" onserverclick="btnAdd_ServerClick">
                        &nbsp;&nbsp;<span class="glyphicon glyphicon-ok"></span>&nbsp;&nbsp;Save&nbsp;&nbsp;</button>
                    <button id="btnCancel" type="reset" class="btn btn-default" runat="server" causesvalidation="False">&nbsp;&nbsp;<span class="glyphicon glyphicon-remove"></span>&nbsp;&nbsp;Cancel&nbsp;&nbsp;</button>
                </div>
                <br />
            </div>
            <div>
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
                                <asp:Label ID="IDLabel" runat="server" Text='<%# Eval("course_id") %>' />
                            </td>
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
                                <asp:Label ID="Label2" runat="server" Text='<%# Eval("InstructorName") %>' />
                            </td>
                            <td>
                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("NumberOfStudents") %>' />
                            </td>
                            <td>
                                <asp:Button ID="CompletedItemButton"
                                    runat="server"
                                    CssClass="btn btn-info"
                                    CommandName="DeleteItem"
                                    CommandArgument='<%# Eval("COURSE_ID") %>'
                                    Text="Set to Complete"
                                    OnClientClick="return confirm('Are you absolutely sure you want to delete this instructor and his courses?');"
                                    data-toggle="tooltip" data-placement="right"
                                    title="This command button will set the field COMPLETED='Y'. Then Triggers will add credit to the students who enrolled this course" />
                            </td>
                        </tr>
                    </ItemTemplate>
                    <LayoutTemplate>


                        <table id="itemPlaceholderContainer" runat="server" class="table table-hover table-striped">
                            <tr runat="server" style="">
                                <th runat="server">COURSE_ID</th>
                                <th runat="server">TITLE</th>
                                <th runat="server">CREDITS</th>
                                <th runat="server">DEPTNAME</th>
                                <th runat="server">INSTRUCTOR NAME</th>
                                <th runat="server">NUMBER OF STUDENTS</th>
                                <th runat="server"></th>
                            </tr>
                            <tr id="itemPlaceholder" runat="server">
                            </tr>
                        </table>


                    </LayoutTemplate>

                </asp:ListView>
            </div>
        </div>
    </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server"
        ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>"
        SelectCommand="SELECT course_id, title, credits, dept_name DeptName, InstructorName, NumberOfStudents FROM vw_course where completed='N' ORDER BY course_id"></asp:SqlDataSource>


</asp:Content>
