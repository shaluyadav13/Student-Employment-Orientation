using System;
using System.Collections.Generic;
using System.Linq;
using StudentOrientation.ModuleTypes;

namespace StudentOrientation.Modules.policies
{
    public partial class activity : CompletableActivity
    {
        protected const string MODULE_TITLE = "Policies and Procedures";
        public List<Question> questions;
        protected List<string> videos;
        protected XMLDataSource dataSource;

        protected void Page_PreLoad(object sender, EventArgs e)
        {
            dataSource = new XMLDataSource();
            questions = dataSource.GetQuestions(MODULE_TITLE);
            videos = new List<string>();

            // this is sample code
            // TODO: Remove this code
            for (int i = 0; i < questions.Count; i++)
                videos.Add(@"Modules/policies/videos/sampleVideoPage.aspx");

            if (videos.Count() != questions.Count())
                throw new Exception("There must be a video for every question.");
        }
        public void QuestionDisplay()
        {

        }
    }
}