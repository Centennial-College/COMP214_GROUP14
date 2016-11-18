<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucDepartment.ascx.cs" Inherits="COMP214_GROUP14.WebControls.ucDepartment" %>
<div class="form-inline">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
                <asp:DropDownList CssClass="form-control" ID="ddlDepartment" runat="server" OnSelectedIndexChanged="ddlDepartment_SelectedIndexChanged" AutoPostBack="True"></asp:DropDownList>
                <asp:TextBox CssClass="form-control" ID="txtDepartment" runat="server" Visible="False"></asp:TextBox>
                <asp:CustomValidator ID="cvDepartment" runat="server" ErrorMessage="Department is mandatory and can't be Other." ControlToValidate="txtDepartment" ValidateEmptyText="True" ClientValidationFunction="validateTxtCategory" Visible="False"></asp:CustomValidator>
        </ContentTemplate>
    </asp:UpdatePanel>
</div>
