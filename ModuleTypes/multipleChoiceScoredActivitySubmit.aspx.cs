using System.Collections.Generic;
using System.Collections.Specialized;

namespace StudentOrientation.ModuleTypes
{
    public class OptionAnswerNode
    {
        public string Key { get; set; }
        public string Value { get; set; }
    }

    public partial class multipleChoiceScoredActivitySubmit : StudentOrientation.ModuleTypes.scoredActivitySubmit
    {

        List<Question> questions = new List<Question>();
        protected int TallyScore(string moduleTitle, NameValueCollection parameters)
        {
            int score = 0;
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
                Question questionWithCorrectAnswer = dataSource.GetQuestion(moduleTitle, questionToCheck.Text);

                int consistantValues = 0;
                foreach (string key in questionToCheck.OptionAnswer.Keys)
                    if (questionWithCorrectAnswer.OptionAnswer[key] == questionToCheck.OptionAnswer[key])
                        consistantValues++;
                if (consistantValues == questionWithCorrectAnswer.OptionAnswer.Count)
                {
                    if (moduleTitle == "Events")
                    {
                        foreach (var value in questionToCheck.OptionAnswer.Values)
                        {
                            if (value == 1)
                            {
                                score++;
                            }
                        }
                    }
                    else
                        score++;
                }
                else
                {
                    if (moduleTitle == "Events")
                    {
                        foreach (string key in questionToCheck.OptionAnswer.Keys)
                        {
                            if (questionToCheck.OptionAnswer[key] == 1 && questionWithCorrectAnswer.OptionAnswer[key] == 1)
                            {
                                score++;
                            }
                            if(questionToCheck.OptionAnswer[key] == 1 && questionWithCorrectAnswer.OptionAnswer[key] == 0)
                            {
                                score--;
                            }
                        }
                    }
                }
            }

            return score;
        }
        protected int pointsPossible(string moduleTitle)
        {
            int maxScore = 0;

            if (moduleTitle == "Events")
            {
                // Tally the score.
                XMLDataSource dataSource = new XMLDataSource();

                foreach (Question questionToCheck in questions)
                {
                    Question questionWithCorrectAnswer = dataSource.GetQuestion(moduleTitle, questionToCheck.Text);

                    foreach (string key in questionWithCorrectAnswer.OptionAnswer.Keys)
                    {
                        if (questionWithCorrectAnswer.OptionAnswer[key] == 1)
                        {
                            maxScore++;
                        }
                    }
                }
            }
            else
            {
                LinkedList<OptionAnswerNode> optionAnswers = new LinkedList<OptionAnswerNode>();

                // Tally the score.
                XMLDataSource dataSource = new XMLDataSource();
                maxScore = dataSource.GetQuestions(moduleTitle).Count;
            }
            return maxScore;
        }
    }
}