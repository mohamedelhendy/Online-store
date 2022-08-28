using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

public partial class Login : System.Web.UI.Page
{
    // The page_load method is called before loading the corresponding HTML file to the browser
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void login(object sender, EventArgs e)
    {
        //Get the information of the connection to the database
        string connStr = ConfigurationManager.ConnectionStrings ["connstr"].ToString();
        
        //create a new connection
        SqlConnection conn = new SqlConnection(connStr);

        /*create a new SQL command which takes as parameters the name of the stored procedure and
         the SQLconnection name*/
        SqlCommand cmd = new SqlCommand("userlogin", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        //To read the input from the user
        string username = txt_username.Text;
        string password = txt_password.Text;

        if (username == "" || password == "")
        {
            Response.Write("username or password field is empty please make sure to enter both of them");
            Response.End();
        }

        cmd.Parameters.Clear();
        //pass parameters to the stored procedure
        cmd.Parameters.Add(new SqlParameter("@username", username));
        cmd.Parameters.Add(new SqlParameter("@password", password));

        //Save the output from the procedure
        SqlParameter count = cmd.Parameters.Add("@count", SqlDbType.Int);
        count.Direction = ParameterDirection.Output;
        SqlParameter type = cmd.Parameters.Add("@type", SqlDbType.Int);
        type.Direction = ParameterDirection.Output;
        //Executing the SQLCommand
        conn.Open();
        cmd.ExecuteNonQuery();
        conn.Close();
        
        if (count.Value.ToString().Equals("1"))
        {
           if (type.Value.ToString().Equals("0"))
            {

                /*ASP.NET session state enables you to store and retrieve values for a user
                as the user navigates ASP.NET pages in a Web application.
                This is how we store a value in the session*/
                Session["user"] = username;

                //To navigate to another webpage
                Response.Redirect("customerhome.aspx",true);
           }
        }
        else
        {
            //To send response data to the client side (HTML)

            Response.Write("username or password is incorrect");
        }
    }
    protected void register(object sender, EventArgs e) {
         Response.Redirect("registeration.aspx",true);



    }

}

