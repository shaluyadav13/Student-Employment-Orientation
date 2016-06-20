using System;
using System.Linq;

namespace StudentOrientation.Modules.Introduction
{
    public partial class submit : System.Web.UI.Page
    {
        protected const string MODULE_TITLE = "Introduction";

        protected void Page_PreLoad(object sender, EventArgs e)
        {
            DatabaseDataContext db = new DatabaseDataContext();

            try
            {
                // Grab user and module from db.
                var user = (from usr in db.Users
                            where usr.Username == Session["Username"].ToString()
                            select usr).Single();

                var module = (from mod in db.Modules
                              where mod.Title == MODULE_TITLE
                              select mod).Single();

                // Create answer to add.
                Answer answer = new Answer();
                answer.Module = module;
                answer.User = user;
                answer.Response = Request.Params["response"];
                answer.Score = 10; //Module's worth 10 points or something.
                answer.MaxScore = 10; //Give them max points just for hitting the submit button.
                answer.IsTutorialCompleted = (answer.Score/answer.MaxScore>0.75)?true:false;
                if (answer.IsTutorialCompleted)
                {
                    db.Answers.InsertOnSubmit(answer);
                    db.SubmitChanges();
                }
            }
            catch (Exception)
            {
                // TODO: Implement exception logger. 
            }
        }
    }
}