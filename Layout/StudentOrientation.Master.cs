using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StudentOrientation
{
    public partial class StudentOrientation : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
#if !DEBUG
            // If not connected through SSL, redirect.
            if (!HttpContext.Current.Request.Url.AbsoluteUri.Contains("https"))
                Response.Redirect(HttpContext.Current.Request.Url.AbsoluteUri.Replace("http", "https"));
#endif
        }
    }
}