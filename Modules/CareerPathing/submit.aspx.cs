using System;
using System.Collections.Specialized;
using StudentOrientation.ModuleTypes;

namespace StudentOrientation.Modules.careerPathing
{
    public partial class submit : multipleChoiceScoredActivitySubmit
    {
        private const string MODULE_TITLE = "Career Pathing";

        protected void Page_PreLoad(object sender, EventArgs e)
        {
            int score = 0;

            try
            {
                NameValueCollection parameters = Request.Params;
                
                score = TallyScore(MODULE_TITLE, parameters);
                SubmitScore(MODULE_TITLE, score, 4);
                if (score / 4 < 0.75)
                {
                    
                }
            }
            catch (Exception)
            {
                // TODO: Impement exception logger.
            }
        }
    }   
}