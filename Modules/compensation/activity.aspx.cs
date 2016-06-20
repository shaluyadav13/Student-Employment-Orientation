using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using StudentOrientation.ModuleTypes;

namespace StudentOrientation.Modules.compensation
{
    public partial class activity : CompletableActivity
    {
        protected const string MODULE_TITLE = "Compinsation";
        public List<Question> questions;
        protected XMLDataSource dataSource;
        protected void Page_PreLoad(object sender, EventArgs e)
        {
            dataSource = new XMLDataSource();
            questions = dataSource.GetQuestions(MODULE_TITLE);
        }             
    }
}