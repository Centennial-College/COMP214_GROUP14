<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Department.aspx.cs" Inherits="COMP214_GROUP14.Department" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <br />
        <div class="hidden alert-success" runat="server" id="divMessage">
            <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
            <span id="divMessageBody" runat="server">Courses was saved successfully.</span>
        </div>
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3><span class="glyphicon glyphicon-credit-card"></span>&nbsp;Department List</h3>
            </div>
            <div class="panel-body">
                <asp:ListView ID="listDepartments" runat="server" DataSourceID="SqlDataSource1" DataKeyNames="DEPT_ID">
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
                                <asp:Label ID="DEPT_IDLabel" runat="server" Text='<%# Eval("DEPT_ID") %>' />
                            </td>
                            <td>
                                <asp:Label ID="NAMELabel" runat="server" Text='<%# Eval("NAME") %>' />
                            </td>
                        </tr>
                    </ItemTemplate>
                    <LayoutTemplate>
                        <table id="itemPlaceholderContainer" runat="server" class="table  table-hover table-striped">
                            <tr runat="server">
                                <th runat="server">DEPT_ID</th>
                                <th runat="server">NAME</th>
                            </tr>
                            <tr id="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                    </LayoutTemplate>

                </asp:ListView>

            </div>
        </div>
    </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT &quot;DEPT_ID&quot;, &quot;NAME&quot; FROM &quot;SC_DEPARTMENTS&quot;"></asp:SqlDataSource>
</asp:Content>
