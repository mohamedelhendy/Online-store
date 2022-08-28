using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

public partial class register : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void regiscustomer (object sender, EventArgs e)
    {
        Response.Redirect("registcustomer.aspx", true);
    }
    protected void regisvendor(object sender, EventArgs e)
    {
        Response.Redirect("registvendor.aspx", true);
    }
}

