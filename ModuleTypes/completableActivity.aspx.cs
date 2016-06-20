using System.Collections.Generic;
using System.Linq;

namespace StudentOrientation.ModuleTypes
{
    public partial class CompletableActivity : System.Web.UI.Page
    {
        DatabaseDataContext db = new DatabaseDataContext();
        //method to check the module completed or not.
        protected bool DidComplete(string moduleTitle)
        {          
            // See if the user answered any questions for the module.
            var answers = from answer in db.Answers
                          where answer.Module.Title == moduleTitle && answer.User.Username == Session["Username"].ToString()
                          select answer;
            
           return answers.Count() > 0;
        }

        protected int ModuleCompleted(string moduleTitle)
        {
            var moduleCompleted = from answer in db.Answers
                                    where answer.IsTutorialCompleted == true && answer.User.Username == Session["Username"].ToString()
                                    select answer.Module.Name;
            List<string> modNames = new List<string>();
            foreach(var mod in moduleCompleted)
            {
                modNames.Add(mod);
            }
            return modNames.Count;
        }
       
        public bool ModuleUpdated(string moduleTitle)
        {
            bool IsModuleCompleted = false;
            try
            {
                var scored = from module in db.Answers
                             where module.UserID.ToString() == Session["UserID"].ToString() && module.Module.Name == moduleTitle
                             select module.Score;
                if (scored != null)
                {
                    IsModuleCompleted = true;
                }
            }
            catch
            {
                IsModuleCompleted = false;
            }
            return IsModuleCompleted;
        }
    }
}