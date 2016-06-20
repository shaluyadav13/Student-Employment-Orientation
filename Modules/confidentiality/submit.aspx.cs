using System;

namespace StudentOrientation.Modules.confidentiality
{
    public partial class submit : StudentOrientation.ModuleTypes.scoredActivitySubmit
    {
        protected const string MODULE_TITLE = "Confidentiality";

        protected void Page_PreLoad(object sender, EventArgs e)
        {
            int score = 1;
            int MaxScore = 1;
            SubmitScore(MODULE_TITLE, score, MaxScore);
        }
    }
}