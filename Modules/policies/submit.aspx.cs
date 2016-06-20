using System;
using System.Collections.Specialized;

namespace StudentOrientation.Modules.policies
{
    public partial class submit : StudentOrientation.ModuleTypes.multipleChoiceScoredActivitySubmit
    {
        private const string MODULE_TITLE = "Policies and Procedures";

        protected void Page_PreLoad(object sender, EventArgs e)
        {
            int score = 0;
            int maxScore = 0;

            NameValueCollection parameters = Request.Params;

            score = TallyScore(MODULE_TITLE, parameters);
            maxScore = pointsPossible(MODULE_TITLE);
            SubmitScore(MODULE_TITLE, score, maxScore);
        }
    }
}