using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StudentOrientation.ssa
{
    public partial class Services : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static String SendData(string requestNo)
        {
            //Request Number is the form of "userId requestId"
            DatabaseDataContext db = new DatabaseDataContext();

            ////Submitting the completed module
            //Request Id =1 is for fetching the list of modules
            //This is also the case when orientation page loads for the first time
            if (requestNo == "1")
            {
                var userId = Int32.Parse(HttpContext.Current.Session["UserID"].ToString());
                var answers = (from ans in db.Answers
                               where ans.UserID == userId
                               select ans);

                String cMod = userId+ " ";
                foreach (var c in answers)
                {
                    cMod += c.ModuleID + " ";
                }
                return cMod;
            }
            else
            {   //Saving the modules
                string[] data = requestNo.Split(' ');
                int userId = Int32.Parse(data[0]);
                var requestId = data[1];


                int tempRequestId = Int32.Parse(requestId.Substring(1));
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