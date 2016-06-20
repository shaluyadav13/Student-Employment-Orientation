using System;
using System.Linq;

//Common code for majority of the modules to cross check whether the questions answered is greater than 0.75 or not.
//This one is directed from the Submit.aspx page for majority of the modules.

namespace StudentOrientation.ModuleTypes
{
    public partial class scoredActivitySubmit : System.Web.UI.Page
    {
        //Old version commenting it out -  - 7/31/2012
        //protected void SubmitScore(string moduleTitle, int score, int maxScore)
        //New version writing here - 
        protected void SubmitScore(string moduleTitle, int score, int maxScore)
        {            
            DatabaseDataContext db = new DatabaseDataContext();
            try
            {
                // Retrieving the user name into user from Users table
                var user = (from usr in db.Users
                            where usr.Username == Session["Username"].ToString()
                            select usr).Single();
                /*Retrieveing the module title and storing into module after comparing the moduleTitle parameter passed in the method with 
                the Title in the Module table */
                var module = (from mod in db.Modules
                              where mod.Title == moduleTitle
                              select mod).Single();

                //I wrote to test and now commenting it out - 
                //int directsubmitscore = 10;
                //score = directsubmitscore;
                //Commenting ends here - 
                
                // After retrieving the user and module,Create answer to add.
                Answer answer = new Answer();
                answer.User = user;
                answer.Module = module;
                answer.Score = score;
                answer.MaxScore = maxScore;
                double result = (double)score / maxScore;

                //Console.WriteLine("score" + score + "max score " + maxScore);
                answer.IsTutorialCompleted = ((double)score / maxScore)>=1.0 ? true : false;
                //answer.IsTutorialCompleted = ((double)score / maxScore) >= 0 ? true : false;
                if(answer.IsTutorialCompleted)
                {
                    db.Answers.InsertOnSubmit(answer);
                    db.SubmitChanges();
                }
                //Giving a try and testing - so commenting it out -  - 7/31/2012
                //else
                //{
                    //db.Answers.InsertOnSubmit(answer);
                    //db.SubmitChanges();
                //}
                //Try starts here - 
                if(!answer.IsTutorialCompleted)
                {
                
                }
              }
            catch (Exception)
            {
                // TODO: Impement exception logger.
            }
        }
    }
}