using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Runtime.Serialization;
using System.Runtime.Serialization.Json;
using System.Web.Script.Serialization;

namespace StudentOrientation.Modules
{
    public partial class progress : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //Create json object here, return it. Need to architect said object somehow ;O
            //getProgress();
            buildProgressObject();
        }
        protected void getProgress()
        {
            DatabaseDataContext db = new DatabaseDataContext();
            
            //***selecting the title from Module table in the database and storing it in modules
            var modules = from Title in db.Modules
                          select Title;

            //***storing the completed modules in completedModules by checking the valid user id and maxscore > 0.75
            var completedModules = from ans in db.Answers
                                   where ans.UserID.ToString() == 3.ToString() && ans.Score >= ans.MaxScore * 0.01    //+1 for division by zero protection!
                                   select ans;

            //***Checking for CompletedModules and writing the response back in the Answer's table
            if (completedModules != null)
            {
                if (completedModules.Count() == 0)
                    Response.Write(0);
                else
                    Response.Write((double)completedModules.Count() / (double)modules.Count());
            }
        }
        //***Code for building the progress bar
        protected void buildProgressObject()
        {
            if (Session["UserID"] == null)
            {
                Response.Write("It appears you're not logged in!");
                return;
            }

            DatabaseDataContext db = new DatabaseDataContext();
            //declaring a variable modules to store the mod
            var modules = from mod in db.Modules
                          select mod;
            //Int32.Parse(Session["UserID"].ToString())
            //*** Assigning the ModuleID to variable answers
            var answers = (from ans in db.Answers
                           where ans.UserID == Int32.Parse(Session["UserID"].ToString())
                           select ans).ToDictionary(sr => sr.ModuleID);
            
            //***Taking the seriuos of type dictionary with string and an object type as parameters
            Dictionary<string, object> seriously = new Dictionary<string,object>();
            foreach (var module in modules)
            {
                if (answers.ContainsKey(module.ModuleID))
                {
                    seriously.Add(module.Title, new
                    {                        
                       moduleCompleted = answers[module.ModuleID].IsTutorialCompleted,
                       score = answers[module.ModuleID].Score,
                       maxScore = answers[module.ModuleID].MaxScore,
                       tutorialCompleted = answers[module.ModuleID].IsTutorialCompleted
                    });
                }
                else
                {
                    seriously.Add(module.Title, new
                    {
                        moduleCompleted = false,
                        score = 0,
                        maxScore = 0,
                        tutorialCompleted = false
                    });  
                }
            }
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            Response.Write(serializer.Serialize((object)seriously));
        }
        protected bool DidComplete(string moduleTitle)
        {
            DatabaseDataContext db = new DatabaseDataContext();
            var answers = from ans in db.Answers
                          where ans.Module.Title == moduleTitle && ans.User.Username == Session["Username"]
                          select ans;

            return answers.Count() > 0;
        }
        [Serializable]
        
        public class moduleProgress
        {
            public int score;
            public bool fubar; 
        }
    }
}