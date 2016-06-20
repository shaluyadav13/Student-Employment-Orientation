using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
//using System.Web;
using System.Web.Configuration;
using System.Web.Security;

namespace StudentOrientation
{
    public partial class Supervisor : System.Web.UI.Page
    {
        loginDetails det = new loginDetails();
        protected void Page_Load(object sender, EventArgs e)
        {
            

            if (Session["LoggedIn"] == null || !(bool)Session["LoggedIn"] || Session["Role"] != "Supervisor")
            {
                Response.Redirect("~/Login.aspx");
                //Response.StatusCode = 403;
                //Response.Write("403 Forbidden");
                //Response.Flush();
                //Response.End();
            }
        }
        protected void logoutBTN_Click(object sender, EventArgs e)
        {

            det.loggedIn = false;
            FormsAuthentication.SignOut();
            FormsAuthentication.RedirectToLoginPage("~/Login.aspx");
            Session["LoggedIn"] = false;
            Session["Username"] = "";
            Session["Name"] = "";
            Session["UserID"] = "";
            Response.Cache.SetExpires(DateTime.UtcNow.AddMinutes(-1));
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetNoStore();


        }
    }
}