using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using StudentOrientation.ModuleTypes;
//Work Habits
namespace StudentOrientation.Modules.WorkHabits
{
    public partial class activity : CompletableActivity
    {
        //storing the the title "Work Habits and Attitudes in MODULE_TITLE"
        protected const string MODULE_TITLE = "Work Habits and Attitudes";

        protected void Page_Load(object sender, EventArgs e)
        {
            string flashIns = "<object classid=\"clsid:d27cdb6e-ae6d-11cf-96b8-444553540000\"" +
                               "codebase=\"http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=10,0,0,0\"" +
                               "width=\"800\"" +
                               "height=\"500\"" +
                               "align=\"middle\"" +
                               "id=\"Pacman\">" +
                               "<param name=\"allowScriptAccess\" value=\"sameDomain\" />" +
                               "<param name=\"movie\" value=\"flash/Pacman.swf\" />" +
                               "<param name=\"quality\" value=\"high\" />" +
                               "<param name=\"wmmode\" value=\"opaque\" />" +
                               "<param name=\"flashVars\" value=\"" + "UserName=" + Session["UserName"] + "\" />" +
                               "<embed src=\"flash/Pacman.swf\"" +
                               "width=\"800\"" +
                               "height=\"500\"" +
                               "autostart=\"true\"" +
                               "quality=\"high\"" +
                               "wmode=\"opaque\"" +
                               "FlashVars=\"UserName=" + Session["UserName"] + "\"" +
                               "name=\"Pacman\"" +
                               "align=\"middle\"" +
                               "allowScriptAccess=\"sameDomain\"" +
                               "type=\"application/x-shockwave-flash\"" +
                               "pluginspage=\"http://www.macromedia.com/go/getflashplayer\" />" +
                               "</object>";
            
            FlashInsert.Controls.Add(new LiteralControl(flashIns));
            //Response.Cache is used to make sure that user is not allowed to move back
            Response.Cache.SetExpires(DateTime.UtcNow.AddMinutes(-1));
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetNoStore();
            HttpResponse.RemoveOutputCacheItem("/WorkHabits/activity.aspx");
        }
        //public void startGame(object sender, EventArgs e)
        //{
        //    instructions.Visible = false;
        //    FlashInsert.Visible = true;
        //    startgame.Visible = false;
        //}


    }
}