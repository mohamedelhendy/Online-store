<%@ Page Language="C#"  AutoEventWireup="true" CodeFile="customer2.aspx.cs" Inherits="customer2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<form id="form1" runat="server">
    <p>
        &nbsp;</p>
    <p>
        <asp:Button ID="Button_choosecreditcard" runat="server" Text="choose credit card" onclick="choose" />
        <asp:TextBox ID="TextBox_creditcard" runat="server"></asp:TextBox>
        <asp:Label ID="orderID_credit" runat="server" Text="orderID"></asp:Label>
        <asp:TextBox ID="TextBox_creditid" runat="server"></asp:TextBox>
    </p>
    <p>
&nbsp;&nbsp;&nbsp;
        </p>
    <p>
        &nbsp;</p>
    <p>
        <asp:Button ID="Button_order" runat="server" Height="49px" Text="Order items in the cart" onclick="order" Width="236px" />
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Button ID="Button1" runat="server" Height="47px" Text="view order details" Width="240px" OnClick="Button1_Click" />
&nbsp;</p>
<p>
    &nbsp;</p>
<p>
    &nbsp;</p>
<p>
    &nbsp;</p>
<p>
    <asp:Button ID="Button_pay" runat="server" Text="pay" onclick="pay" />
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <asp:Label ID="orderid_pay" runat="server" Text="orderID"></asp:Label>
&nbsp;<asp:TextBox ID="TextBox_IDpay" runat="server"></asp:TextBox>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <asp:Label ID="Label_cash" runat="server" Text="Cash amount"></asp:Label>
    &nbsp;&nbsp;&nbsp;
    <asp:TextBox ID="TextBox_cash" runat="server"></asp:TextBox>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <asp:Label ID="Label_creditamount" runat="server" Text="credit amount"></asp:Label>
    &nbsp;
    <asp:TextBox ID="TextBox_creditamount" runat="server"></asp:TextBox>
    </p>
<p>
    &nbsp;</p>
<p>
    &nbsp;</p>
<p>
    <asp:Button ID="Button_cancel" runat="server" Text="Cancel the order" onclick="cancel" />
        <asp:Label ID="Label_orderr" runat="server" Text="orderID"></asp:Label>
        <asp:TextBox ID="TextBox_orderID" runat="server"></asp:TextBox>
    </p>
</form>
<p>
    &nbsp;</p>
<p>
    &nbsp;</p>
<p>
    &nbsp;</p>
<p>
    &nbsp;</p>
<p>
    &nbsp;</p>
</form>

