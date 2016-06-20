using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Net.Mail;
using System.Xml;

namespace StudentOrientation
{
    public struct getAnswers
    {
        public int userID;
        public int moduleID;
        public int score;
        public int maxScore;
        bool isModuleCompleted;
    }

    public struct getModuleNames
    {
        public string moduleID;
        public string title;
        public string moduleDesction;
        public string moduleName;
    }


    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    [System.Web.Script.Services.ScriptService]
    public class WebService : System.Web.Services.WebService
    {
        private DatabaseDataContext dataContext = new DatabaseDataContext();
        private String ANY_KEYWORD = "---ALL---";
       
        [WebMethod]
        public int GetProgress(String UserName, int score)
        {
            int progress = 20;

            return progress;
        }

        List<int> ids = new List<int>();
        List<string> moduleNames = new List<string>();

        [WebMethod]
        public void getModuleID(int userid)
        {
            var mod = (from sup in dataContext.Answers
                       where sup.IsTutorialCompleted == true && sup.UserID == userid
                       select sup.ModuleID);
            ids = mod.ToList();
        }

        [WebMethod]
    
        public string[] getModuleNames(int userID)
        {
            IEnumerable<string> moduleNames = null;

            foreach(var i in ids){
                moduleNames = (from sup in dataContext.Modules
                               where sup.ModuleID == ids[i]
                               select sup.Title);
            }
            List<string> titles = moduleNames.ToList<string>();
            titles.Insert(0, ANY_KEYWORD);
            return titles.Distinct().ToArray<string>();
        }

        
    }
}

