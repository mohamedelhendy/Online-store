using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

public partial class registeration : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void register(object sender, EventArgs e)
    {
        string connStr = ConfigurationManager.ConnectionStrings["connstr"].ToString();
        SqlConnection conn = new SqlConnection(connStr);
        SqlCommand cmd = new SqlCommand("vendorRegister", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        string username = txt_username.Text;
        string fname = txt_fname.Text;
        string lname = txt_lname.Text;
        string password = txt_pass.Text;
        string email = txt_email.Text;
        string bankacc = txt_bankacc.Text;
        string company = txt_company.Text;
        if(username==""||fname==""||lname== "" || password == "" || email == "" || bankacc == "" || company == "")
        {
            Response.Write("one or more field(s) are empty make sure to enter them");
            Response.End();
        }
        cmd.Parameters.Clear();
        cmd.Parameters.Add(new SqlParameter("@username", username));
        cmd.Parameters.Add(new SqlParameter("@first_name", fname));
        cmd.Parameters.Add(new SqlParameter("@last_name", lname));
        cmd.Parameters.Add(new SqlParameter("@password", password));
        cmd.Parameters.Add(new SqlParameter("@email", email));
        cmd.Parameters.Add(new SqlParameter("@company_name", company));
        cmd.Parameters.Add(new SqlParameter("@bank_acc_no", bankacc));
        try
        {

            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
        }

        catch(SqlException x)
        {
            switch (x.Number)
            {
                case 2627:
                    Response.Write("username is already taken");
                    Response.End();
                    break;
                default:
                    throw;
   

            }



        }
         Response.Redirect("login.aspx", true);


    }
}
