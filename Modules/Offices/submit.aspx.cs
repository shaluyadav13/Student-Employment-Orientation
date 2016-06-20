using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;

namespace StudentOrientation.Modules.Offices
{
    public partial class submit : StudentOrientation.ModuleTypes.scoredActivitySubmit
    {
        protected const string MODULE_TITLE = "Offices";
        protected void Page_PreLoad(object sender, EventArgs e)
        {
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "alert('Hi')", true);            
            string score = Request["score"];
            
            //Log.WriteLine("score");
            //string score = "4";
            int maxScore = 4;
            SubmitScore(MODULE_TITLE, Convert.ToInt32(score), maxScore);
        }
    }
}
