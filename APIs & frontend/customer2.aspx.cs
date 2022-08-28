using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;


public partial class customer2 : System.Web.UI.Page
{

    // The page_load method is called before loading the corresponding HTML file to the browser
    protected void Page_Load(object sender, EventArgs e)
    {

    }


    protected void order(object sender, EventArgs e)
    {
        //Get the information of the connection to the database
        string connStr = ConfigurationManager.ConnectionStrings["connstr"].ToString();

        //create a new connection
        SqlConnection conn = new SqlConnection(connStr);

        /*create a new SQL command which takes as parameters the name of the stored procedure and
         the SQLconnection name*/
        SqlCommand cmd = new SqlCommand("makeOrder", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        string username = Session["user"].ToString();
        //pass parameters to the stored procedure
        cmd.Parameters.Add(new SqlParameter("@customer", username));
        SqlParameter orderid = cmd.Parameters.Add("@orderid", SqlDbType.Int);
        orderid.Direction = ParameterDirection.Output;
        SqlParameter total = cmd.Parameters.Add("@totalamount", SqlDbType.Decimal);
        total.Direction = ParameterDirection.Output;
        //Executing the SQLCommand
        conn.Open();
        cmd.ExecuteNonQuery();
        conn.Close();

    }





    protected void choose(object sender, EventArgs e)
    {
        //Get the information of the connection to the database
        string connStr = ConfigurationManager.ConnectionStrings["connstr"].ToString();

        //create a new connection
        SqlConnection conn = new SqlConnection(connStr);

        /*create a new SQL command which takes as parameters the name of the stored procedure and
         the SQLconnection name*/
        SqlCommand cmd = new SqlCommand("ChooseCreditCard", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        string creditcard = TextBox_creditcard.Text;
        string orderid = TextBox_creditid.Text;
        
        //pass parameters to the stored procedure
        cmd.Parameters.Add(new SqlParameter("@creditcard", creditcard));
        cmd.Parameters.Add(new SqlParameter("@orderID", orderid));



        //Executing the SQLCommand
        conn.Open();
        cmd.ExecuteNonQuery();
        conn.Close();
        Response.Write("success");


    }


    protected void cancel(object sender, EventArgs e)
    {
        //Get the information of the connection to the database
        string connStr = ConfigurationManager.ConnectionStrings["connstr"].ToString();

        //create a new connection
        SqlConnection conn = new SqlConnection(connStr);

        /*create a new SQL command which takes as parameters the name of the stored procedure and
         the SQLconnection name*/
        SqlCommand cmd = new SqlCommand("cancelOrder", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        string orderid = TextBox_orderID.Text;
        //pass parameters to the stored procedure

        cmd.Parameters.Add(new SqlParameter("@orderID", orderid));



        //Executing the SQLCommand
        conn.Open();
        cmd.ExecuteNonQuery();
        conn.Close();


    }



    protected void pay(object sender, EventArgs e)
    {
        //Get the information of the connection to the database
        string connStr = ConfigurationManager.ConnectionStrings["connstr"].ToString();

        //create a new connection
        SqlConnection conn = new SqlConnection(connStr);

        /*create a new SQL command which takes as parameters the name of the stored procedure and
         the SQLconnection name*/
        SqlCommand cmd = new SqlCommand("SpecifyAmount", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        string orderid = TextBox_IDpay.Text;
        string username = Session["user"].ToString();
        string cash = TextBox_cash.Text;
        string credit = TextBox_creditamount.Text;

        //pass parameters to the stored procedure

        cmd.Parameters.Add(new SqlParameter("@customer", username));
        cmd.Parameters.Add(new SqlParameter("@orderID", orderid));
        cmd.Parameters.Add(new SqlParameter("@cash", cash));
        cmd.Parameters.Add(new SqlParameter("@credit", credit));



        //Executing the SQLCommand
        conn.Open();
        cmd.ExecuteNonQuery();
        conn.Close();


    }
















    protected void Button1_Click(object sender, EventArgs e)
    {
        Response.Redirect("orders.aspx");
    }
}