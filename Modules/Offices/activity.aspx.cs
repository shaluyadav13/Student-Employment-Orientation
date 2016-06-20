using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using StudentOrientation.ModuleTypes;

namespace StudentOrientation.Modules.Offices
{
    public partial class activity : CompletableActivity
    {
        protected const string MODULE_TITLE = "Offices";

        protected void Page_Load(object sender, EventArgs e)
        {

            string flashIns = "<object classid=\"clsid:d27cdb6e-ae6d-11cf-96b8-444553540000\"" +
                               "codebase=\"http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=10,0,0,0\"" +
                               "width=\"755\"" +
                               "height=\"500\"" +
                               "align=\"middle\"" +
                               "id=\"Pacman\">" +
                               "<param name=\"allowScriptAccess\" value=\"sameDomain\" />" +
                               "<param name=\"movie\" value=\"flash/AAdminMapCS5.swf\" />" +
                               "<param name=\"quality\" value=\"high\" />" +
                               "<param name=\"wmmode\" value=\"transparent\" />" +
                               "<param name=\"flashVars\" value=\"" + "UserName=" + Session["UserName"] + "\" />" +
                               "<embed src=\"flash/AAdminMapCS5.swf\"" +
                               "width=\"750\"" +
                               "height=\"500\"" +
                               "autostart=\"true\"" +
                               "quality=\"high\"" +
                               "FlashVars=\"UserName=" + Session["UserName"] + "\"" +
                               "name=\"AAdminMapCS5\"" +
                               "align=\"middle\"" +
                               "allowScriptAccess=\"sameDomain\"" +
                               "type=\"application/x-shockwave-flash\"" +
                               "pluginspage=\"http://www.macromedia.com/go/getflashplayer\" />" +
                               "</object>";
            FlashInsert1.Controls.Add(new LiteralControl(flashIns));

            

        }
            

            public void closemodule(object sender, EventArgs e){


                bool sendScore = Convert.ToBoolean(Request["sendBool"]);
                if (sendScore.Equals("true"))
                {
                    
                }

            HttpContext.Current.Response.Write("Hi");
            ClientScriptManager script = Page.ClientScript;
                if (!script.IsStartupScriptRegistered(this.GetType(), "Alert"))
                {
                script.RegisterStartupScript(this.GetType(), "Alert", "alert(document.getElementById('txtName').value)", true);
                }
            }

            }
    }
