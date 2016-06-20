using System;
using System.Collections.Generic;
using StudentOrientation.ModuleTypes;

namespace StudentOrientation.Modules.fedWorkStudy
{
    public partial class activity : CompletableActivity
    {
        protected const string MODULE_TITLE = "Federal Work Study";
        protected XMLDataSource dataSource;
        protected List<Question> questions;

        protected void Page_PreLoad(object sender, EventArgs e)
        {
            dataSource = new XMLDataSource();
            questions = dataSource.GetQuestions(MODULE_TITLE);
        }
    }
}