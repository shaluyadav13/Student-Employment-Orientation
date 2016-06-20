using System;

namespace StudentOrientation.Modules.workmansComp
{
    public partial class submit : StudentOrientation.ModuleTypes.scoredActivitySubmit
    {
        protected const string MODULE_TITLE = "Worker's Compensation";
        protected const int MAXSCORE = 5;

        protected void Page_PreLoad(object sender, EventArgs e)
        {
            int score = 0;

            try
            {
                #region XML Handling
                XMLDataSource dataSource = new XMLDataSource();
                ActivityModule xmlModule = dataSource.GetModule(MODULE_TITLE);
                Question question = xmlModule.Questions[0]; // There's only one question for this module.

                var users_answers_line = Request.Params["answers"];

                // Ported java algorithm for Largest Subsequnces Problem from Survey of Algorithms class to C#.
                string[] users_answers = users_answers_line.Remove(users_answers_line.Length - 1, 1).Split('\0');
                int c_users_answer_length = users_answers.Length;
                for (int i = 0; i < c_users_answer_length; i++)
                {
                    users_answers[i] = users_answers[i].Trim();
                }

                string[] actual_answers = new string[question.OptionAnswer.Keys.Count];
                int c_actual_answer_length = actual_answers.Length;

                int[,] c = new int[c_users_answer_length + 1, c_actual_answer_length + 1];

                foreach (string key in question.OptionAnswer.Keys)
                    actual_answers[question.OptionAnswer[key] - 1] = key;

                // Checking to see if answers are correct;
                // Survey of Algorithm: Largest Subsequence Problem
                for (int i = 0; i <= c_users_answer_length; i++)
                    c[i, 0] = 0;

                for (int j = 0; j <= c_actual_answer_length; j++)
                    c[0, j] = 0;

                for (int i = 1; i <= c_users_answer_length; i++)
                    for (int j = 1; j <= c_actual_answer_length; j++)
                        if (!users_answers[i - 1].Equals(actual_answers[i - 1]))
                            c[i, j] = Math.Max(c[i - 1, j], c[i, j - 1]);
                        else
                            c[i, j] = 1 + c[i - 1, j - 1];
                #endregion

                score = c[c_users_answer_length, c_actual_answer_length];
                SubmitScore(MODULE_TITLE, score, MAXSCORE);
            }
            catch (Exception)
            {
                // TODO: Impement exception logger.
            }
        }
    }
}