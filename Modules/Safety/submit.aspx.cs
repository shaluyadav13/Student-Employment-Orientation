using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections.Specialized;
using StudentOrientation.ModuleTypes;

namespace StudentOrientation.Modules.Safety
{
    public partial class submit : multipleChoiceScoredActivitySubmit
    {
        protected const string MODULE_TITLE = "Safety";

        protected void Page_PreLoad(object sender, EventArgs e)
        {
            int score = 0;

            try
            {
                NameValueCollection parameters = Request.Params;

                score = TallyScore(MODULE_TITLE, parameters);
                SubmitScore(MODULE_TITLE, score, 5);
                if (score / 5 < 0.75)
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