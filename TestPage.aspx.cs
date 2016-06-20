using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StudentOrientation
{
    public partial class TestPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }


        [WebMethod]
        public static String SendData(string requestNo)
        {
            // return "Your request number is " + requestNo;

            int userId = Int32.Parse(HttpContext.Current.Session["UserID"].ToString());
            int requestId = Int32.Parse(requestNo);
            DatabaseDataContext db = new DatabaseDataContext();

            ////Submitting the completed module
            if (requestId == 1)
            {
                var answers = (from ans in db.Answers
                               where ans.UserID == userId
                               select ans);

                String cMod = "";
                foreach (var c in answers)
                {
                    cMod += c.ModuleID + " ";
                }
                return cMod;
            }
            else
            {   //We know the request Id is 2
                int tempRequestId = Int32.Parse(requestId.ToString().Substring(1));
                Answer submitAnswer = new Answer
                {
                    UserID = userId,
                    ModuleID = tempRequestId,
                    Response = "All correct",
                    Score = 10,
                    MaxScore = 10,
                    IsTutorialCompleted = true,
                };

                db.Answers.InsertOnSubmit(submitAnswer);
                try
                {
                    db.SubmitChanges();
                    return "Congratulations you completed this module.";
                }
                catch (Exception ex)
                {
                    return "Could Not Update your score. Please Contact your Supervisor.";
                }
            }
        }
    }
}