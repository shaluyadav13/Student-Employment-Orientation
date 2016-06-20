using System;
using System.Net.Mail;
using System.Linq;

namespace StudentOrientation
{
    public class Global : System.Web.HttpApplication
    {
        protected void Application_Start(object sender, EventArgs e)
        {

        }

        protected void Session_Start(object sender, EventArgs e)
        {

        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {

        }

        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {

        }

        protected void Application_Error(object sender, EventArgs e)
        {

        }

        protected void Session_End(object sender, EventArgs e)
        {
            try
            {
                DatabaseDataContext db = new DatabaseDataContext();

                User user = (from i in db.Users
                             where i.UserID == Int32.Parse(Session["UserID"].ToString())
                             select i).Single();

                Session["LoggedIn"] = false;
                Session["Role"] = null;
                Session["Username"] = null;
                Session["Name"] = null;
                Session["UserID"] = null;


                db.Users.DeleteOnSubmit(user);

                //new SmtpClient("smtp.nwmissouri.edu").Send("s509465@nwmissourui.edu", "s509465@nwmissourui.edu", "Session Ended!", 
                  //  Session["UserID"].ToString() + Session["Username"].ToString());
            }
            catch(Exception ex)
            {
               // new SmtpClient("smtp.nwmissouri.edu").Send("s515782@nwmissourui.edu", "s515782@nwmissourui.edu", "Error in Session End", ex.Message);
            }
        }

        protected void Application_End(object sender, EventArgs e)
        {

        }
    }
}