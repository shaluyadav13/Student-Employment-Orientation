using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections.Specialized;
using StudentOrientation.ModuleTypes;

namespace StudentOrientation.Modules.Events
{
    public partial class submit : StudentOrientation.ModuleTypes.multipleChoiceScoredActivitySubmit
    {
        protected const string MODULE_TITLE = "Events";
        DatabaseDataContext db = new DatabaseDataContext();
        protected void Page_PreLoad(object sender, EventArgs e)
        {
            int score = 0;
            int maxScore = 0;

            NameValueCollection parameters = Request.Params;

            score = TallyScore(MODULE_TITLE, parameters);
            maxScore = pointsPossible(MODULE_TITLE);
            SubmitScore(MODULE_TITLE, score, maxScore);
            CompletableActivity comp = new CompletableActivity();
            var moduleComplete = comp.ModuleUpdated(MODULE_TITLE);
            if (moduleComplete)
            {                
                Response.Write("<script>alert('New Password is created')</script>");
            }
        }
        
    }
}