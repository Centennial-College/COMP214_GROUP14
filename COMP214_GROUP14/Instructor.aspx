<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Instructor.aspx.cs" Inherits="COMP214_GROUP14.Instructor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <br />
        <div class="hidden alert-success" runat="server" id="divMessage">
            <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
            <span id="divMessageBody" runat="server">Instuctor was saved successfully.</span>
        </div>
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3><span class="glyphicon glyphicon-user"></span>&nbsp;Instuctor</h3>
            </div>
            <div class="panel-body">

                <asp:ListView ID="ListView1" runat="server" DataKeyNames="INSTRUCTOR_ID" DataSourceID="SqlDataSource1" OnItemCommand="ListView1_ItemCommand">
                    <EmptyDataTemplate>
                        <table runat="server" class="table">
                            <tr>
                                <td>No data was returned.</td>
                            </tr>
                        </table>
                    </EmptyDataTemplate>
                    <ItemTemplate>
                        <tr>
                            <td>
                                <asp:Label ID="INSTRUCTOR_IDLabel" runat="server" Text='<%# Eval("INSTRUCTOR_ID") %>' />
                            </td>
                            <td>
                                <asp:Label ID="FNAMELabel" runat="server" Text='<%# Eval("FNAME") %>' />
                            </td>
                            <td>
                                <asp:Label ID="LNAMELabel" runat="server" Text='<%# Eval("LNAME") %>' />
                            </td>
                            <td>
                                <asp:Button ID="DeleteItemButton"
                                    runat="server"
                                    CssClass="btn btn-primary"
                                    CommandName="DeleteItem"
                                    CommandArgument='<%# Eval("INSTRUCTOR_ID") %>'
                                    Text="Delete"
                                    OnClientClick="return confirm('Are you absolutely sure you want to delete this instructor and his courses?');" 
                                    data-toggle="tooltip" data-placement="bottom"
                                    title="This command button will invoke DELETE_INSTRUCTOR_SP procedure. DELETE ALL course which was FK with instructor."
                                    />
                            </td>
                        </tr>
                    </ItemTemplate>
                    <LayoutTemplate>

                        <table id="itemPlaceholderContainer" runat="server" class="table">
                            <tr runat="server">
                                <th runat="server">INSTRUCTOR_ID</th>
                                <th runat="server">FNAME</th>
                                <th runat="server">LNAME</th>
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
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT &quot;INSTRUCTOR_ID&quot;, &quot;FNAME&quot;, &quot;LNAME&quot; FROM &quot;SC_INSTRUCTORS&quot;"></asp:SqlDataSource>

</asp:Content>
