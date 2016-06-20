using System;
using System.Collections.Generic;
using StudentOrientation.ModuleTypes;

namespace StudentOrientation.Modules.careerPathing
{
    public partial class activity : CompletableActivity
    {
        protected const string MODULE_TITLE = "Career Pathing";
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