using System;
using System.Collections.Generic;
using System.Linq;
using System.Xml.Linq;
using StudentOrientation.Properties;

namespace StudentOrientation
{
    /// <remarks>
    /// Handles all of the XML for the modules, filtering them as needed.
    /// </remarks>
    public class XMLDataSource
    {
        /// <summary>
        /// The XML document for the class.
        /// </summary>
        private XElement xmlDocument { get; set; }

        public XMLDataSource()
        {
            // Lock the file while it's being parsed.
            lock (Resources.questions)
            {
                xmlDocument = XElement.Parse(Resources.questions);
            }
        }

        // ADD MODULE

        // ADD QUESTION

        // DELETE MODULE

        // DELETE QUESTION

        /// <summary>
        /// Gets all the questions from a module in Question form.
        /// </summary>
        /// <param name="title">The title of the module.</param>
        /// <returns>The questions for the module in Question form.</returns>
        public List<Question> GetQuestions(string title)
        {
            // Get the XML for the questions of the module.
            IEnumerable<XElement> xmlQuestions = GetQuestionsXML(title);
            List<Question> questions = new List<Question>();

            // Process each question for the module.
            foreach (XElement xmlQuestion in xmlQuestions)
            {
                Question question = new Question();
                question.Text = xmlQuestion.Element("text").Value;

                // Get the XML for the possible answers to the question. 
                XElement xmlOptions = xmlQuestion.Element("options");

                // Process each possible answer for the question.
                foreach (var xmlOption in xmlOptions.Elements("option"))
                {
                    // Check whether or not the answer is the correct one.
                    var isCorrect = xmlOption.Attribute("correct");

                    // If there was no 'correct' attribute, then it will be false. Stupid mixed implementation.
                    if (isCorrect != null)
                        question.OptionAnswer[xmlOption.Value] = Int32.Parse(xmlOption.Attribute("correct").Value);
                    else
                        question.OptionAnswer[xmlOption.Value] = 0;
                }

                // Add the question to the list.
                questions.Add(question);
            }

            return questions;
        }

        /// <summary>
        /// Gets all the questions from a module in string form.
        /// </summary>
        /// <param name="title">The title of the module.</param>
        /// <returns>The questions for the module in string form.</returns>
        public List<string> GetQuestionsText(string title)
        {
            // Get the XML for the questions of the module.
            IEnumerable<XElement> xmlQuestions = GetQuestionsXML(title);
            List<string> textQuestions = new List<string>();

            // For each question returned, add the text of the question to the list.
            foreach (XElement xmlQuestion in xmlQuestions)
                textQuestions.Add(xmlQuestion.Element("text").Value);

            return textQuestions;
        }

        /// <summary>
        /// Gets the Question for a given module and question text.
        /// </summary>
        /// <param name="title">The title of the module.</param>
        /// <param name="questionText">The text for question.</param>
        /// <returns>The Question for the given module and question text.</returns>
        public Question GetQuestion(string title, string questionText)
        {
            // Get the XML for the question and possible answers.
            XElement xmlQuestion = GetQuestionXML(title, questionText);
            XElement xmlOptions = xmlQuestion.Element("options");

            Question question = new Question();
            question.Text = xmlQuestion.Element("text").Value;

            // Process each possible answer for the question.
            foreach (var xmlOption in xmlOptions.Elements("option"))
            {
                // Check whether or not the answer is the correct one.
                var isCorrect = xmlOption.Attribute("correct");

                // If there was no 'correct' attribute, then it will be false. Stupid mixed implementation.
                if (isCorrect != null)
                    question.OptionAnswer[xmlOption.Value] = Int32.Parse(xmlOption.Attribute("correct").Value);
                else
                    question.OptionAnswer[xmlOption.Value] = 0;
            }

            return question;
        }

        /// <summary>
        /// Gets the ActivityModule for a given module.
        /// </summary>
        /// <param name="title">The title of the module.</param>
        /// <returns>The ActivityModule for the given module.</returns>
        public ActivityModule GetModule(string title)
        {
            ActivityModule module = new ActivityModule();
            module.Title = title;
            module.Questions = GetQuestions(title);

            return module;
        }

        /// <summary>
        /// Gets all the XMLModules.
        /// </summary>
        /// <returns>All the XMLModules.</returns>
        public List<ActivityModule> GetModules()
        {
            // Get the XML for the modules.
            IEnumerable<XElement> xmlModules = xmlDocument.Elements("module");

            List<ActivityModule> modules = new List<ActivityModule>();
            foreach (XElement moduleXML in xmlModules)
                modules.Add(GetModule(moduleXML.Attribute("title").Value));

            return modules;
        }

        /// <summary>
        /// Gets the titles for every module.
        /// </summary>
        /// <returns>The titles for every module.</returns>
        public List<string> GetTitles()
        {
            // Get the XML for the modules.
            IEnumerable<XElement> xmlModules = xmlDocument.Elements("module");

            List<string> titles = new List<string>();
            foreach (XElement moduleXML in xmlModules)
                titles.Add(moduleXML.Attribute("title").Value);

            return titles;
        }

        /// <summary>
        /// Gets all the questions from a module in XML form.
        /// </summary>
        /// <param name="title">The title of the module.</param>
        /// <returns>The questions for the module in XML form.</returns>
        private IEnumerable<XElement> GetQuestionsXML(string title)
        {
            XElement xmlModule = null;

            try
            {
                // Try to get the module from the XML document. Will throw an error if there is 
                // more or less than a single element in the sequence.
                xmlModule = (from xml in xmlDocument.Elements("module")
                             where xml.Attribute("title").Value == title
                             select xml).Single<XElement>();
            }
            catch (Exception)
            {
                // TODO: Implement exception logger.
            }

            return xmlModule.Elements("question");
        }

        /// <summary>
        /// Gets the XML for a given module and question text.
        /// </summary>
        /// <param name="title">The title of the module.</param>
        /// <param name="questionText">The text for question.</param>
        /// <returns>The XML for the given module and question text.</returns>
        private XElement GetQuestionXML(string title, string questionText)
        {
            XElement xmlQuestion = null;

            try
            {
                // Try to get the question from the XML document. Will throw an error if there is 
                // more or less than a single element in the sequence.
                xmlQuestion = (from xml in GetModuleXML(title).Elements("question")
                               where xml.Element("text").Value == questionText.Trim()
                               select xml).Single<XElement>();
            }
            catch (Exception)
            {
                // TODO: Implement exception logger.
            }

            return xmlQuestion;
        }

        /// <summary>
        /// Gets the XML for a given module.
        /// </summary>
        /// <param name="title">The title of the module.</param>
        /// <returns>The XML for the given module.</returns>
        private XElement GetModuleXML(string title)
        {
            XElement xmlModule = null;

            try
            {
                // Try to get the module from the XML document. Will throw an error if there is 
                // more or less than a single element in the sequence.
                xmlModule = (from mod in xmlDocument.Elements("module")
                             where mod.Attribute("title").Value == title
                             select mod).Single<XElement>();
            }
            catch (Exception)
            {
                // TODO: Implement exception logger.
            }

            return xmlModule;
        }

        // UPDATE MODULE TITLE

        // UPDATE QUESTION
    }
}