<%@ Page Language="C#"  AutoEventWireup="true" CodeFile="customerhome.aspx.cs" Inherits="home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<form id="form1" runat="server">
    <p>
        add your telephone :&nbsp;
        <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
&nbsp;<asp:Button ID="Button2" runat="server" Text="add" onclick="addtelephone"  />
    </p>
    <p>
        add credit card </p>
    <p>
        credit card number :
        <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
&nbsp;expiry-date :
        <asp:TextBox ID="TextBox3" runat="server"></asp:TextBox>
&nbsp;cvv :
        <asp:TextBox ID="TextBox4" runat="server" Width="88px"></asp:TextBox>
&nbsp;<asp:Button ID="Button1" runat="server" Text="add" onclick="addcc" />
    </p>
    <asp:Button ID="Button3" runat="server" Height="35px" Text="view products" onclick="showproducts" Width="283px" />
    &nbsp;&nbsp;
    &nbsp;<p>
        create wishlist</p>
    <p>
        name :&nbsp;
        <asp:TextBox ID="TextBox5" runat="server"></asp:TextBox>
&nbsp;
        <asp:Button ID="Button4" runat="server" Text="create" onclick="createwishlist" />
    </p>
    <p>
        cart
    </p>
    <p>
        product-serial-no :
        <asp:TextBox ID="TextBox6" runat="server"></asp:TextBox>
&nbsp;&nbsp;&nbsp; <asp:Button ID="Button5" runat="server" Text="add to your cart" onclick="addtocart" Width="186px" />
&nbsp;&nbsp;&nbsp; <asp:Button ID="Button6" runat="server" Text="remove from your cart" onclick="removefromcart" Width="186px" />
    &nbsp;&nbsp; <asp:Button ID="Button9" runat="server" Text="show your cart" onclick="showcart" Width="186px" />
    </p>
    <p>
        wishlist</p>
    <p>
        wishlistname :
        <asp:TextBox ID="TextBox7" runat="server"></asp:TextBox>
&nbsp; product_serial_no :
        <asp:TextBox ID="TextBox8" runat="server"></asp:TextBox>
    </p>
    <p>
        &nbsp;<asp:Button ID="Button7" runat="server" Text="add to your wishlist" onclick="addtowishlist" Width="210px" />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <asp:Button ID="Button8" runat="server" Text="remove from your wishlist" onclick="removefromwishlist" Width="210px" />
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <asp:Button ID="Button10" runat="server" Text="show wish list" onclick="showwishlist" Width="210px" />
    </p>
    <p>
        <asp:Button ID="Button11" runat="server" OnClick="Button11_Click" Text="advance to customer2" />
    </p>
</form>
