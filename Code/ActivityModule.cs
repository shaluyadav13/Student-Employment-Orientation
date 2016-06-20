using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;

namespace StudentOrientation
{
    public class ActivityModule
    {
        public string Title { get; set; }
        public List<Question> Questions { get; set; }

        public ActivityModule() { }

        public static bool DidComplete(string username, string title)
        {
            DatabaseDataContext db = new DatabaseDataContext();

            // See if the user answered any questions for the module.
            var answers = from answer in db.Answers
                          where answer.Module.Title == title && answer.User.Username == username
                          select answer;

            return answers.Count() > 0;
        }

        public static int ScoreMC(string title, NameValueCollection parameters)
        {
            int score = 0;
            List<Question> questions = new List<Question>();
            LinkedList<OptionAnswerNode> optionAnswers = new LinkedList<OptionAnswerNode>();

            for (int i = 0; i < parameters.Count; i++)
            {

                string currentKey = parameters.GetKey(i);
                string[] currentValue = parameters.GetValues(i);

                if (currentKey.Contains("Text"))
                {
                    questions.Add(new Question());
                    questions[questions.Count - 1].Text = currentValue[0];
                }
                else if (currentKey.Contains("Key"))
                {
                    optionAnswers.AddLast(new OptionAnswerNode());
                    optionAnswers.Last.Value.Key = currentValue[0];
                }
                else if (currentKey.Contains("Val"))
                {
                    OptionAnswerNode lastOptionAnswer = optionAnswers.Last.Value;
                    lastOptionAnswer.Value = currentValue[0];

                    // Store
                    Question lastQuestion = questions[questions.Count - 1];
                    if (lastOptionAnswer.Value == "false")
                        lastQuestion.OptionAnswer[lastOptionAnswer.Key] = 0;
                    else if (lastOptionAnswer.Value == "true")
                        lastQuestion.OptionAnswer[lastOptionAnswer.Key] = 1;

                    // Remove temporary data.
                    optionAnswers.RemoveLast();
                }
            }

            // Tally the score.
            XMLDataSource dataSource = new XMLDataSource();

            foreach (Question questionToCheck in questions)
            {
                Question questionWithCorrectAnswer = dataSource.GetQuestion(title, questionToCheck.Text);

                int consistantValues = 0;
                foreach (string key in questionToCheck.OptionAnswer.Keys)
                    if (questionWithCorrectAnswer.OptionAnswer[key] == questionToCheck.OptionAnswer[key])
                        consistantValues++;

                if (consistantValues == questionWithCorrectAnswer.OptionAnswer.Count)
                    score++;
            }

            return score;
        }

        public static int GetPointsPossible(string title)
        {
            // Get the number of questions and return.
            XMLDataSource dataSource = new XMLDataSource();
            return dataSource.GetQuestions(title).Count;
        }

        public static void SubmitScore(string username, string title, int score, int maxScore = 0)
        {
            DatabaseDataContext db = new DatabaseDataContext();

            try
            {
                // Get user and module.
                var user = (from usr in db.Users
                            where usr.Username == username
                            select usr).Single();

                var module = (from mod in db.Modules
                              where mod.Title == title
                              select mod).Single();

                // Create answer to add.
                Answer answer = new Answer();
                answer.User = user;
                answer.Module = module;
                answer.Score = score;
                answer.MaxScore = maxScore;

                db.Answers.InsertOnSubmit(answer);
                db.SubmitChanges();
            }
            catch (Exception)
            {
                // TODO: Impement exception logger.
            }
        }
    }

    public class OptionAnswerNode
    {
        public string Key { get; set; }
        public string Value { get; set; }
    }
}
