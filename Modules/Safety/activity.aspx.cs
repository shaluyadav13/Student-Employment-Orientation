using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using StudentOrientation.ModuleTypes;

namespace StudentOrientation.Modules.Safety
{
    public partial class activity : CompletableActivity
    {
        protected const string MODULE_TITLE = "Safety";
        protected XMLDataSource dataSource;
        protected List<Question> questions;
        protected Question question;

        protected void Page_Load(object sender, EventArgs e)
        {
            XMLDataSource dataSource = new XMLDataSource();
            questions = dataSource.GetQuestions(MODULE_TITLE);
            question = questions[0]; 
        }
    }
}