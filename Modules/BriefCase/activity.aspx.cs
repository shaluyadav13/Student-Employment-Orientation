using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using System.Configuration;
using Cite.DomainAuthentication;
using System.Web;

//Brief Case Activity page
namespace StudentOrientation.Modules.BriefCase
{
    public partial class activity : StudentOrientation.ModuleTypes.CompletableActivity
    {   
        protected void Page_Load(object sender, EventArgs e)
        {
            StudentEmployee studentEmpDetails = null;
            DatabaseDataContext dataContext = new DatabaseDataContext();
            int countCompletedModules=0;
            //selecting the module ID and assigning it to the modid by checking the condition whether IstutorialCompleted is true or not
            var modid = (from sup in dataContext.Answers
                        where sup.IsTutorialCompleted == true && sup.UserID == Convert.ToInt32(Session["UserID"].ToString())
                        select sup.ModuleID);

            //Using moduleNames list of type string and iterating the loop in modid where the module ID is stored.
            List<String> moduleNames = new List<string>();                     
            foreach (var id in modid)
            {
                //.single is used for retrieving a single value at a time
                //If the condition is satisfied, the title of the module is stored in the variable name.
                var name = (from sup in dataContext.Modules
                           where sup.ModuleID == id
                           select sup.Title).Single();
                //adding the variable name, which contains the title to the list, so called moduleNames.
                //And incrementing the countCompletedModules by one.
                moduleNames.Add(name);
                countCompletedModules++;
            }
            //Entering the loop, when the coun of the modules is less than 11
            if (countCompletedModules < dataContext.Modules.Count())
            {                
                tab1.Disabled = false;
                tab2.Disabled = true;
            }
            else
            {
                tab2.Disabled = false;
                //tab2.EnableViewState = true;

                studentEmpDetails = new StudentEmployee();
                //var userID = (from usrID in dataContext.Users 
                //             where usrID.Username == Session["Username"].ToString()
                //             select usrID.Username).Single();

                //var endDate = from end in dataContext.StudentEmployees
                //              where end.UserID == Convert.ToInt32(userID)
                //              select end;

                //string query ="";
                //if (endDate.Single().EndDate== null)
                //{
                 string query = "Update [StudentOrientation].[dbo].[StudentEmployee] Set EndDate = '" + DateTime.Now + "' Where UserID = " + Convert.ToInt32(Session["UserID"].ToString());
                //}
                //string query = "Update [StudentOrientation].[dbo].[StudentEmployee] Set EndDate = " + DateTime.Now + " Where UserID = " + Convert.ToInt32(Session["UserID"].ToString());



                
                string connectionString = ConfigurationManager.ConnectionStrings["StudentOrientationConnectionString"].ConnectionString;//"Data Source=CITE3;Initial Catalog=StudentOrientation;Integrated Security=True";
                SqlConnection conn = new SqlConnection(connectionString);
                SqlCommand sqlcmd = new SqlCommand(query, conn);
                try
                {
                    conn.Open();
                    sqlcmd.ExecuteNonQuery();
                }
                catch(Exception ex)
                {

                }
                finally
                {
                    conn.Close();
                }
            }

            String title = " ";
            foreach (String str in moduleNames)
            {
                title += str + " ";
            }
            
            string flashIns = "<object classid=\"clsid:d27cdb6e-ae6d-11cf-96b8-444553540000\"" +
                               "codebase=\"http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=10,0,0,0\"" +
                               "width=\"755\"" +
                               "height=\"500\"" +
                               "align=\"middle\"" +
                               "id=\"Pacman\">" +
                               "<param name=\"allowScriptAccess\" value=\"sameDomain\" />" +
                               "<param name=\"movie\" value=\"flash/BriefCaseFinalWithToolTips/BriefcaseFinal.swf\" />" +
                               "<param name=\"quality\" value=\"high\" />" +
                               "<param name=\"wmmode\" value=\"transparent\" />" +
                               "<param name=\"bgcolor\" value=\"#000000\" /> " +
                               "<param name=\"flashVars\" value=\""+title.Substring(0,title.LastIndexOf(" "))+"\"/>" +
                               "<embed src=\"flash/BriefCaseFinalWithToolTips/BriefcaseFinal.swf\"" +
                               "width=\"755\"" +
                               "height=\"500\"" +
                               "autostart=\"true\"" +
                               "quality=\"high\"" +
                               "FlashVars=\""+title.Substring(0,title.LastIndexOf(" "))+"" +
                               "name=\"BriefCaseFinal\"" +
                               "align=\"middle\"" +
                               "allowScriptAccess=\"sameDomain\"" +
                               "type=\"application/x-shockwave-flash\"" +
                               "pluginspage=\"http://www.macromedia.com/go/getflashplayer\" />" +
                               "</object>";
           FlashInsert.Controls.Add(new LiteralControl(flashIns));
        }
    }
}