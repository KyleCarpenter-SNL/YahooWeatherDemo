using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Home : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    [System.Web.Services.WebMethod]
    public static string setTXT(string city, string temp, string cond)
    {
        string fullTXT = "The temperature in " + city + " is " + temp + "°F and the current conditions are " + cond + ".";

        return fullTXT;
    }
}