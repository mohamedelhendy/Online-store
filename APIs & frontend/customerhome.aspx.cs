using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

public partial class home : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void addtelephone (object sender, EventArgs e)
    {
        string connStr = ConfigurationManager.ConnectionStrings["connstr"].ToString();
        SqlConnection conn = new SqlConnection(connStr);
        SqlCommand cmd = new SqlCommand("addmobile", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        string username = Session["user"].ToString();
        string telephone = TextBox1.Text;
        cmd.Parameters.Clear();
        cmd.Parameters.Add(new SqlParameter("@username", username));
        cmd.Parameters.Add(new SqlParameter("@mobile_number", telephone));
        if (telephone == "") { Response.Write("add telephone number");Response.End(); }
        if (username == "") { Response.Write("your session has ended please login again"); Response.Redirect("login.aspx", true); }
        try
        {
            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
        }
        catch (SqlException x)
        {
            switch (x.Number)
            {
                case 2627:
                    Response.Write("you already added this mobile number");
                    Response.End();
                    break;
                default:
                    throw;
            }
        }
           Response.Write("telephone number added succesfully");
    }
    protected void addcc(object sender, EventArgs e)
    {
        string connStr = ConfigurationManager.ConnectionStrings["connstr"].ToString();
        SqlConnection conn = new SqlConnection(connStr);
        SqlCommand cmd = new SqlCommand("AddCreditCard", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        string creditcardnumber = TextBox2.Text;
        string expiry = TextBox3.Text;
        string cvv = TextBox4.Text;
        string username = Session["user"].ToString();
        cmd.Parameters.Clear();
        cmd.Parameters.Add(new SqlParameter("@creditcardnumber", creditcardnumber));
        cmd.Parameters.Add(new SqlParameter("@expirydate", expiry));
        cmd.Parameters.Add(new SqlParameter("@cvv", cvv));
        cmd.Parameters.Add(new SqlParameter("@username", username));
        if (username == "") { Response.Write("your session has ended please login again"); Response.Redirect("login.aspx", true); }
        if (creditcardnumber == "" || expiry == "" || cvv == "") { Response.Write("one or more field is empty please check them");Response.End(); }
        try
        {
            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
        }
        catch (SqlException x)
        {
            switch (x.Number)
            {
                case 2627:
                    Response.Write("you already added this credit cart");
                    Response.End();
                    break;
                default:
                    throw;
            }
        }
        Response.Write("credit card added succesfully");
    }
    protected void showproducts(object sender, EventArgs e)
    {
        Response.Redirect("showproducts.aspx");
    }
    protected void createwishlist(object sender, EventArgs e)
    {
        string connStr = ConfigurationManager.ConnectionStrings["connstr"].ToString();
        SqlConnection conn = new SqlConnection(connStr);
        SqlCommand cmd = new SqlCommand("createWishlist", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        string wishlistname = TextBox5.Text;
        string username = Session["user"].ToString();
        cmd.Parameters.Clear();
        cmd.Parameters.Add(new SqlParameter("@customer", username));
        cmd.Parameters.Add(new SqlParameter("@name", wishlistname));
        if (username == "") { Response.Write("your session has ended please login again"); Response.Redirect("login.aspx", true); }
        if (wishlistname == "") { Response.Write("enter a name for your new wishlist"); Response.End(); }
        try
        {
            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
        }
        catch (SqlException x)
        {
            switch (x.Number)
            {
                case 2627:
                    Response.Write("you already added this wishlist");
                    Response.End();
                    break;
                default:
                    throw;
            }
        }
        Response.Write("wishlist created succesfully");
    }
    protected void addtocart(object sender, EventArgs e)
    {
        string connStr = ConfigurationManager.ConnectionStrings["connstr"].ToString();
        SqlConnection conn = new SqlConnection(connStr);
        SqlCommand cmd = new SqlCommand("addToCart", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        int serial = int.Parse(TextBox6.Text);
        string username = Session["user"].ToString();
        cmd.Parameters.Clear();
        cmd.Parameters.Add(new SqlParameter("@customer", username));
        cmd.Parameters.Add(new SqlParameter("@serial", serial));
        if (username == "") { Response.Write("your session has ended please login again"); Response.Redirect("login.aspx",true); }
        try
        {
            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
        }
        catch (SqlException x)
        {
            switch (x.Number)
            {
                case 2627:
                    Response.Write("you already added this item to your cart");
                    Response.End();
                    break;
                case 201:
                    Response.Write("add serial number of the product");
                    Response.End();
                    break;
                default:
                    throw;
            }
        }
        Response.Write("product added to cart succesfully");
    }
    protected void removefromcart(object sender, EventArgs e)
    {
        string connStr = ConfigurationManager.ConnectionStrings["connstr"].ToString();
        SqlConnection conn = new SqlConnection(connStr);
        SqlCommand cmd = new SqlCommand("removefromCart", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        int serial = int.Parse(TextBox6.Text);
        string username = Session["user"].ToString();
        cmd.Parameters.Clear();
        cmd.Parameters.Add(new SqlParameter("@customer", username));
        cmd.Parameters.Add(new SqlParameter("@serial", serial));
        if (username == "") { Response.Write("your session has ended please login again"); Response.Redirect("login.aspx", true); }
        try
        {
            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
        }
        catch (SqlException x)
        {
            switch (x.Number)
            {
                case 201:
                    Response.Write("add serial number of the product");
                    Response.End();
                    break;
                default:
                    throw;
            }
        }
        Response.Write("product removed from cart succesfully");
    }
    protected void showcart(object sender, EventArgs e)
    {
        Response.Redirect("cart.aspx");
    }
    protected void addtowishlist(object sender, EventArgs e)
    {
        string connStr = ConfigurationManager.ConnectionStrings["connstr"].ToString();
        SqlConnection conn = new SqlConnection(connStr);
        SqlCommand cmd = new SqlCommand("AddtoWishlist", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        string wishlistname = TextBox7.Text;
        string username = Session["user"].ToString();
        int serial = int.Parse(TextBox8.Text);
        cmd.Parameters.Clear();
        cmd.Parameters.Add(new SqlParameter("@customer", username));
        cmd.Parameters.Add(new SqlParameter("@name", wishlistname));
        cmd.Parameters.Add(new SqlParameter("@serial_no", serial));
        if (username == "") { Response.Write("your session has ended please login again"); Response.Redirect("login.aspx", true); }
        if (wishlistname == "") { Response.Write("enter the name of your wishlist"); Response.End(); }
        try
        {
            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
        }
        catch (SqlException x)
        {
            switch (x.Number)
            {
                case 2627:
                    Response.Write("you already added this product");
                    Response.End();
                    break;
                case 201:
                    Response.Write("add serial number of the product");
                    Response.End();
                    break;
                default:
                    throw;
            }
        }
        Response.Write("added to wishlist succesfully");
    }
    protected void removefromwishlist(object sender, EventArgs e)
    {
        string connStr = ConfigurationManager.ConnectionStrings["connstr"].ToString();
        SqlConnection conn = new SqlConnection(connStr);
        SqlCommand cmd = new SqlCommand("removefromWishlist", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        string wishlistname = TextBox7.Text;
        string username = Session["user"].ToString();
        int serial = int.Parse(TextBox8.Text);
        cmd.Parameters.Clear();
        cmd.Parameters.Add(new SqlParameter("@customer", username));
        cmd.Parameters.Add(new SqlParameter("@name", wishlistname));
        cmd.Parameters.Add(new SqlParameter("@serial_no", serial));
        if (username == "") { Response.Write("your session has ended please login again"); Response.Redirect("login.aspx", true); }
        if (wishlistname == "") { Response.Write("enter the name of your wishlist"); Response.End(); }
        try
        {
            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
        }
        catch (SqlException x)
        {
            switch (x.Number)
            {
                case 201:
                    Response.Write("add serial number of the product");
                    Response.End();
                    break;
                default:
                    throw;
            }
        }
        Response.Write("removed from wishlist succesfully");
    }
    protected void showwishlist(object sender, EventArgs e)
    {
        string wishlist = TextBox7.Text;
        if (wishlist == "") { Response.Write("enter the name of your wishlist"); Response.End(); }
        Session["wishname"] = wishlist;
        Response.Redirect("wishlist.aspx");
 
    }



    protected void Button11_Click(object sender, EventArgs e)
    {

        Response.Redirect("customer2.aspx");
    }
}

