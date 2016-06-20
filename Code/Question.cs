using System.Collections.Generic;

namespace StudentOrientation
{
    /// <remarks>
    /// Represents a question for an activity.
    /// </remarks>
    public class Question
    {
        public string Text { get; set; }
        public Dictionary<string, int> OptionAnswer { get; set; }

        public Question()
        {
            OptionAnswer = new Dictionary<string, int>();
        }

        /// <summary>
        /// Checks to see if the question is an ordered question.
        /// </summary>
        /// <returns>True if it's an ordered question, false otherwise.</returns>
        public bool isOrderedQuestion()
        {
            // Check to see if there is an answer with a value of more than 1. 
            foreach (var value in OptionAnswer.Values)
                if (value > 1)
                    return true;

            return false;
        }

        /// <summary>
        /// Checks to see if the question has multiple answers.
        /// </summary>
        /// <returns>True if it has multiple answers, false otherwise.</returns>
        public bool isMultiAnswer()
        {
            int correctAnswers = 0;

            // Check to see if there is more than one correct answer.
            foreach (var value in OptionAnswer.Values)
            {
                if (value == 1)
                    correctAnswers++;
                if (correctAnswers > 1)
                    return true;
            }

            return false;
        }
    }
}