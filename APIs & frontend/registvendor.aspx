<%@ Page Language="C#"  AutoEventWireup="true" CodeFile="registvendor.aspx.cs" Inherits="registeration" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<form id="form1" runat="server">
    <p>
        username :&nbsp;
        <asp:TextBox ID="txt_username" runat="server" Height="16px" style="margin-top: 11px"></asp:TextBox>
    </p>
    <p>
        first-name :
        <asp:TextBox ID="txt_fname" runat="server" Height="16px" style="margin-top: 11px"></asp:TextBox>
    </p>
    <p>
        last-name :
        <asp:TextBox ID="txt_lname" runat="server" Height="16px" style="margin-top: 11px"></asp:TextBox>
    </p>
    <p>
        password :&nbsp; <asp:TextBox ID="txt_pass" runat="server" Height="16px" style="margin-top: 11px"></asp:TextBox>
    </p>
    <p>
        e-mail :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="txt_email" runat="server" Height="16px" style="margin-top: 11px"></asp:TextBox>
    </p>
     <p>
        company-name :
        <asp:TextBox ID="txt_company" runat="server" Height="16px" style="margin-top: 11px"></asp:TextBox>
    </p>
    <p>
        bank-acc:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <asp:TextBox ID="txt_bankacc" runat="server" Height="16px" style="margin-top: 11px"></asp:TextBox>
    </p>
    <asp:Button ID="Button1" runat="server" Text="register" onclick="register" Width="198px" />
</form>
