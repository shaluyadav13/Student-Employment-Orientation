using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using StudentOrientation.ModuleTypes;

namespace StudentOrientation.Modules.Events
{
    public partial class activity : CompletableActivity
    {
        DatabaseDataContext db = new DatabaseDataContext();
        protected const string MODULE_TITLE = "Events";
        protected XMLDataSource dataSource;
        protected List<Question> questions;
        protected void Page_PreLoad(object sender, EventArgs e)
        {
            dataSource = new XMLDataSource();
            questions = dataSource.GetQuestions(MODULE_TITLE);
        }
        /**
         * checking whether the module score will be in database
         * Returns true if score is in database; otherwise false
         **/
        
        
    }
}