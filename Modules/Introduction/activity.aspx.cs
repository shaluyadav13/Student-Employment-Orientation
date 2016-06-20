using System;
using System.Collections.Generic;
using StudentOrientation.ModuleTypes;
using StudentOrientation;

namespace Sortable
{
    public partial class Sortable : CompletableActivity
    {
        protected const string MODULE_TITLE = "Introduction";
        protected XMLDataSource dataSource;
        protected List<Question> questions;
        protected Question question;

        protected void Page_Load(object sender, EventArgs e)
        {
            dataSource = new XMLDataSource();
            questions = dataSource.GetQuestions(MODULE_TITLE);
            question = questions[0];            
        }
    }
}