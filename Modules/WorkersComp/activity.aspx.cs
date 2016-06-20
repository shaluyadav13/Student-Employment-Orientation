using System;
using System.Collections.Generic;
using StudentOrientation.ModuleTypes;

namespace StudentOrientation.Modules.workmansComp
{
    public partial class acitivity : CompletableActivity
    {
        protected const string MODULE_TITLE = "Worker's Compensation";
        protected XMLDataSource dataSource;
        protected IList<Question> questions;
        protected Question question;
        
        protected void Page_PreLoad(object sender, EventArgs e)
        {
            dataSource = new XMLDataSource();
            questions = dataSource.GetQuestions(MODULE_TITLE);
            question = questions[0];
        }
    }
}