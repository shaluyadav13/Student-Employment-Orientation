using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StudentOrientation.Modules.WorkHabits
{
    public partial class submit : StudentOrientation.ModuleTypes.scoredActivitySubmit
    {
        protected const string MODULE_TITLE = "Work Habits and Attitudes";
        protected void Page_Load(object sender, EventArgs e)
        {
            string score = Request["score1"];
            //Console.WriteLine("Score1 : "+score);
            int maxScore = 10;
            //SubmitScore(MODULE_TITLE, Convert.ToInt32(score), maxScore);          

            // Code - for testing
            int directsubmitscore = 10;
            //SubmitScore(MODULE_TITLE, directsubmitscore, maxScore);
            SubmitScore(MODULE_TITLE, Convert.ToInt32(score), maxScore);
        }
    }
}