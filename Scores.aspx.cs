using System;
using StudentOrientation.ModuleTypes;
using System.Web;
using System.Web.Configuration;
using System.Web.Security;
using System.Data;
using System.Data.Sql;
using System.Data.SqlTypes;
using System.Data.SqlClient;
using System.Collections;
using System.Collections.Generic;
using Cite.DomainAuthentication;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Linq;
using System.IO;
using System.Drawing;
using System.Text;




namespace StudentOrientation
{
    public partial class Scores : System.Web.UI.Page
    {

        string query = "Select  a.UserName,a.LastName,a.FirstName, d.DeptName,s.StartDate, s.EndDate,(SUM(Score*100/MaxScore)/10) as Score from [Answer],[User] As a LEFT JOIN [Department] As d ON d.DeptID = a.DeptID LEFT JOIN [StudentEmployee] As s ON s.UserID = a.UserID Where a.UserID = [Answer].UserID group by a.UserName,a.LastName,a.FirstName, d.DeptName, s.StartDate, s.EndDate";
        loginDetails det = new loginDetails();
        DatabaseDataContext dataContext = new DatabaseDataContext();
        List<String> list = new List<string>();

        protected void Page_Load(object sender, EventArgs e)
        {
            //SearchTextBox.Visible = false;
            
            if (Session["LoggedIn"] == null || !(bool)Session["LoggedIn"] || Session["Role"] == null)
            {
                Response.Redirect("~/Login.aspx");
            }
            // Delete Guest data visible to Admin only 

            if ("Admin" == Session["Role"].ToString())
            {
                deleteGuestData.Visible = true;

            }
            else
            {
                deleteGuestData.Visible = false;
            }
            if (!IsPostBack)
            {
                ArrayList SearchArrayList = new ArrayList();

                SearchArrayList.Add("Select One");
                SearchArrayList.Add("Department");
                SearchArrayList.Add("FirstName");
                SearchArrayList.Add("LastName");
                SearchArrayList.Add("UserName");
                SearchArrayList.Add("Date");



                list.Add("Select Department Name");
                var deptList = (from dept in dataContext.Departments
                                orderby dept.DeptName
                                select dept.DeptName);
                foreach (string name in deptList)
                {
                    list.Add(name);
                }


                DropDownList1.DataSource = SearchArrayList;
                DropDownList1.DataBind();

                searchDepartment.DataSource = list;
                searchDepartment.DataBind();
            }

        }


        protected void DropDownChange(object sender, EventArgs e)
        {

            string cmd = DropDownList1.SelectedValue.ToString();
            Session["Command"] = cmd;

            if (DropDownList1.SelectedValue == "Department")
            {
                searchDepartment.Visible = true;
                SearchTextBox.Visible = false;

                startDate.Visible = false;
                endDate.Visible = false;
                StartDateLbl.Visible = false;
                EndDateLbl.Visible = false;
                CalenderImageButton.Visible = false;
                EndDateimageButton.Visible = false;


            }
            else if (DropDownList1.SelectedValue == "Date")
            {
                searchDepartment.Visible = false;
                SearchTextBox.Visible = false;

                startDate.Visible = true;
                endDate.Visible = true;
                StartDateLbl.Visible = true;
                EndDateLbl.Visible = true;
                CalenderImageButton.Visible = true;
                EndDateimageButton.Visible = true;

            }
            else
            {
                searchDepartment.Visible = false;
                if (DropDownList1.SelectedValue == "Select One")
                {
                    SearchTextBox.Visible = false;
                }
                else
                {
                    SearchTextBox.Visible = true;
                    SearchTextBox.Focus();
                    SearchTextBox.Text = "";
                }
                startDate.Visible = false;
                endDate.Visible = false;
                StartDateLbl.Visible = false;
                EndDateLbl.Visible = false;
                CalenderImageButton.Visible = false;
                EndDateimageButton.Visible = false;
            }
        }


        //protected void SearchButton_Click(object sender, EventArgs e)
        //{
        //    DropDownList1.DataBind();
        //    string cmd = DropDownList1.SelectedValue.ToString();


        //        if (cmd != "Department")
        //        {

        //            query = "Select  a.UserName,a.LastName,a.FirstName, d.DeptName,s.StartDate, s.EndDate,(SUM(Score*100/MaxScore)/10) as Score from [Answer],[User] As a LEFT JOIN [Department] As d ON d.DeptID = a.DeptID  LEFT JOIN [StudentEmployee] As s ON s.UserID = a.UserID Where a.UserID = [Answer].UserID  AND a." + cmd + "='" + SearchTextBox.Text + "' group by a.UserName,a.LastName,a.FirstName, d.DeptName, s.StartDate, s.EndDate";
        //            // query = "Select  a.UserName,a.LastName,a.FirstName, d.Name, s.StartDate, s.EndDate,(SUM(Score*100/MaxScore)/10) as Score from [Answer], [User] As a JOIN [Department] As d ON d.DeptID = a.DeptID JOIN [StudentEmployee] As s ON s.UserID = a.UserID  AND a." + cmd + "='" + SearchTextBox.Text + "' Where a.UserID = [Answer].UserID group by a.UserName,a.LastName,a.FirstName, d.Name, s.StartDate, s.EndDate";
        //            Session["query"] = query;
        //            cite3.SelectCommand = query;

        //            //string query = "Select  a.UserName,a.LastName,a.FirstName, d.DeptName,s.StartDate, s.EndDate,(SUM(Score*100/MaxScore)/10) as Score from [Answer],[User] As a LEFT JOIN [Department] As d ON d.DeptID = a.DeptID LEFT JOIN [StudentEmployee] As s ON s.UserID = a.UserID Where a.UserID = [Answer].UserID group by a.UserName,a.LastName,a.FirstName, d.DeptName, s.StartDate, s.EndDate";
        //            //// query = "Select  a.UserName,a.LastName,a.FirstName, d.Name, s.StartDate, s.EndDate,(SUM(Score*100/MaxScore)/10) as Score from [Answer], [User] As a JOIN [Department] As d ON d.DeptID = a.DeptID JOIN [StudentEmployee] As s ON s.UserID = a.UserID Where a.UserID = [Answer].UserID group by a.UserName,a.LastName,a.FirstName, d.Name, s.StartDate, s.EndDate";
        //            //Session["query"] = query;
        //            //cite3.SelectCommand = query;    
        //        }

        //        else if (cmd != "Date")
        //        {

        //            try
        //            {
        //                query = "Select  a.UserName,a.LastName,a.FirstName, d.DeptName, s.StartDate, s.EndDate,(SUM(Score*100/MaxScore)/10) as Score from [Answer], [User] As a LEFT JOIN [Department] As d ON d.DeptID = a.DeptID LEFT JOIN [StudentEmployee] As s ON s.UserID = a.UserID  AND s.StartDate>='" + startDate.Text + "' AND s.EndDate<='" + endDate.Text + "' Where a.UserID = [Answer].UserID group by a.UserName,a.LastName,a.FirstName, d.DeptName, s.StartDate, s.EndDate";
        //                // query = "Select  a.UserName,a.LastName,a.FirstName, d.Name, s.StartDate, s.EndDate,(SUM(Score*100/MaxScore)/10) as Score from [Answer], [User] As a JOIN [Department] As d ON d.DeptID = a.DeptID JOIN [StudentEmployee] As s ON s.UserID = a.UserID  AND a." + cmd + "='" + SearchTextBox.Text + "' Where a.UserID = [Answer].UserID group by a.UserName,a.LastName,a.FirstName, d.Name, s.StartDate, s.EndDate";
        //                Session["query"] = query;
        //                cite3.SelectCommand = query;
        //            }
        //            catch (Exception ex) 
        //            {
        //                Response.Redirect("Error.aspx");
        //            }


        //            //string query = "Select  a.UserName,a.LastName,a.FirstName, d.DeptName,s.StartDate, s.EndDate,(SUM(Score*100/MaxScore)/10) as Score from [Answer],[User] As a LEFT JOIN [Department] As d ON d.DeptID = a.DeptID LEFT JOIN [StudentEmployee] As s ON s.UserID = a.UserID Where a.UserID = [Answer].UserID group by a.UserName,a.LastName,a.FirstName, d.DeptName, s.StartDate, s.EndDate";
        //            //query = "Select  a.UserName,a.LastName,a.FirstName, d.Name, s.StartDate, s.EndDate,(SUM(Score*100/MaxScore)/10) as Score from [Answer], [User] As a JOIN [Department] As d ON d.DeptID = a.DeptID JOIN [StudentEmployee] As s ON s.UserID = a.UserID Where a.UserID = [Answer].UserID group by a.UserName,a.LastName,a.FirstName, d.Name, s.StartDate, s.EndDate";
        //            //Session["query"] = query;
        //            //cite3.SelectCommand = query;    
        //        }
        //        else
        //        {

        //            query = "Select  a.UserName,a.LastName,a.FirstName, d.DeptName,s.StartDate, s.EndDate,(SUM(Score*100/MaxScore)/10) as Score from [Answer],[User] As a LEFT JOIN [Department] As d ON d.DeptID = a.DeptID LEFT JOIN [StudentEmployee] As s ON s.UserID = a.UserID Where a.UserID = [Answer].UserID  AND d.DeptName='" + searchDepartment.SelectedValue.ToString() + "' group by a.UserName,a.LastName,a.FirstName, d.DeptName,s.StartDate,s.EndDate";
        //            //  query = "Select  a.UserName,a.LastName,a.FirstName, d.Name, s.StartDate, s.EndDate,(SUM(Score*100/MaxScore)/10) as Score from [Answer], [User] As a JOIN [Department] As d ON d.DeptID = a.DeptID  AND d.Name='" + SearchTextBox.Text + "' JOIN [StudentEmployee] As s ON s.UserID = a.UserID  Where a.UserID = [Answer].UserID group by a.UserName,a.LastName,a.FirstName, d.Name, s.StartDate, s.EndDate";
        //            Session["query"] = query;
        //            cite3.SelectCommand = query;





        //        }


        //    DropDownList1.ClearSelection();

        //}

       

        public void setQuery(string queryIn)
        {
            query = queryIn;

        }
        public string getQuery()
        {
            return query;
        }



        protected void BtnExport_Click(object sender, EventArgs e)
        {

            DataTable dataTable = new DataTable();
            string attachment = "attachment; filename=StudentRecords.xls";
            Response.ClearContent();
            Response.AddHeader("content-disposition", attachment);
            Response.ContentType = "application/ms-excel";
            StringWriter stw = new StringWriter();
            HtmlTextWriter htextw = new HtmlTextWriter(stw);
            GridView gvEmployee = new GridView();
            //  if(!IsPostBack)
            try
            {
                cite3.SelectCommand = Session["query"].ToString();
            }
            catch
            {
                cite3.SelectCommand = query;
            }
            gvEmployee.DataSource = cite3;
            gvEmployee.DataBind();
            gvEmployee.RenderControl(htextw);
            Response.Write(stw.ToString());
            Response.End();
        }








        protected void Button2_Click(object sender, EventArgs e)
        {
            Session["query"] = "Select  a.UserName,a.LastName,a.FirstName, d.Name, s.StartDate, s.EndDate,(SUM(Score*100/MaxScore)/10) as Score from [Answer], [User] As a JOIN [Department] As d ON d.DeptID = a.DeptID JOIN [StudentEmployee] As s ON s.UserID = a.UserID  AND s.StartDate>='" + startDate.Text + "' AND s.EndDate<='" + endDate.Text + "' Where a.UserID = [Answer].UserID group by a.UserName,a.LastName,a.FirstName, d.DeptName, s.StartDate, s.EndDate";
            cite3.SelectCommand = Session["query"].ToString();
        }


        protected void logoutBTN_Click(object sender, EventArgs e)
        {

            det.loggedIn = false;
            FormsAuthentication.SignOut();
            FormsAuthentication.RedirectToLoginPage("~/Login.aspx");
            Session["LoggedIn"] = false;
            Session["Username"] = "";
            Session["Name"] = "";
            Session["UserID"] = "";
            Response.Cache.SetExpires(DateTime.UtcNow.AddMinutes(-1));
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetNoStore();


        }


        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DataRowView rv = (DataRowView)e.Row.DataItem;
                Int32 totalScore = Convert.ToInt32(rv.Row.ItemArray[6]);
                if (totalScore < 120)
                {
                    e.Row.Cells[6].BackColor = Color.Red;
                    e.Row.Cells[6].ForeColor = Color.White;
                }
            }
        }


        protected void DeleteGuestData(object sender, EventArgs e)
        {
            SqlConnection connection = new SqlConnection(GetConnectionString());

            string sqlStatement = "DELETE FROM [User] WHERE FirstName = 'Guest'";
            try
            {
                connection.Open();
                SqlCommand cmd = new SqlCommand(sqlStatement, connection);
                cmd.ExecuteNonQuery();
            }

            catch (System.Data.SqlClient.SqlException ex)
            {

                string msg = "Deletion Error:";

                msg += ex.Message;

                throw new Exception(msg);

            }

            finally
            {

                connection.Close();

            }
            string query = "Select  a.UserName,a.LastName,a.FirstName, d.DeptName,s.StartDate, s.EndDate,(SUM(Score*100/MaxScore)/10) as Score from [Answer],[User] As a LEFT JOIN [Department] As d ON d.DeptID = a.DeptID LEFT JOIN [StudentEmployee] As s ON s.UserID = a.UserID Where a.UserID = [Answer].UserID group by a.UserName,a.LastName,a.FirstName, d.DeptName, s.StartDate, s.EndDate";
            // query = "Select  a.UserName,a.LastName,a.FirstName, d.Name, s.StartDate, s.EndDate,(SUM(Score*100/MaxScore)/10) as Score from [Answer], [User] As a JOIN [Department] As d ON d.DeptID = a.DeptID JOIN [StudentEmployee] As s ON s.UserID = a.UserID Where a.UserID = [Answer].UserID group by a.UserName,a.LastName,a.FirstName, d.Name, s.StartDate, s.EndDate";
            Session["query"] = query;
            cite3.SelectCommand = query;

        }

        private string GetConnectionString()
        {

            //Where MyConsString is the connetion string that was set up in the web config file

            return System.Configuration.ConfigurationManager.ConnectionStrings["StudentOrientationConnectionString"].ConnectionString;

        }

        protected void instructionsButton_Click(object sender, EventArgs e)
        {

        }

        protected void StartDateCalender_SelectionChanged(object sender, EventArgs e)
        {

            bool startDateSet = false;
            Session["StartDate"] = "";
            startDate.Text = Session["StartDate"].ToString();
            if (startDateSet == false && startDate.Text == "")
            {
                startDate.Text = StartDateCalender.SelectedDate.ToShortDateString();
                Session["StartDate"] = startDate.Text.ToString();
                StartDateCalender.Visible = false;
                startDateSet = true;

            }



        }
        protected void EndateCalender_SelectionChanged(object sender, EventArgs e)
        {

            bool endDateSet = false;
            Session["EndDate"] = "";
            endDate.Text = Session["EndDate"].ToString();
            if (endDateSet == false && endDate.Text == "")
            {
                endDate.Text = EndDateCalender.SelectedDate.ToShortDateString();
                Session["EndDate"] = endDate.Text.ToString();
                EndDateCalender.Visible = false;
                endDateSet = true;

            }
}


        protected void startDate_TextChanged(object sender, EventArgs e)
        {

        }

        protected void Calender_Click(object sender, ImageClickEventArgs e)
        {
            StartDateCalender.Visible = true;
        }
        protected void EndDateCalender_Click(object sender, ImageClickEventArgs e)
        {
            EndDateCalender.Visible = true;
        }

        public class MessageBox
        {
            private static Hashtable m_executingPages = new Hashtable();
            private MessageBox() { }
            public static void Show(string sMessage)
            {
                // If this is the first time a page has called this method then
                if (!m_executingPages.Contains(HttpContext.Current.Handler))
                {
                    // Attempt to cast HttpHandler as a Page.
                    Page executingPage = HttpContext.Current.Handler as Page;
                    if (executingPage != null)
                    {
                        // Create a Queue to hold one or more messages.
                        Queue messageQueue = new Queue();
                        // Add our message to the Queue
                        messageQueue.Enqueue(sMessage);
                        // Add our message queue to the hash table. Use our page reference
                        // (IHttpHandler) as the key.
                        m_executingPages.Add(HttpContext.Current.Handler, messageQueue);
                        // Wire up Unload event so that we can inject
                        // some JavaScript for the alerts.
                        executingPage.Unload += new EventHandler(ExecutingPage_Unload);
                    }
                }
                else
                {
                    // If were here then the method has allready been
                    // called from the executing Page.
                    // We have allready created a message queue and stored a
                    // reference to it in our hastable.
                    Queue queue = (Queue)m_executingPages[HttpContext.Current.Handler];
                    // Add our message to the Queue
                    queue.Enqueue(sMessage);
                }
            }

            // Our page has finished rendering so lets output the
            // JavaScript to produce the alert's
            private static void ExecutingPage_Unload(object sender, EventArgs e)
            {
                // Get our message queue from the hashtable
                Queue queue = (Queue)m_executingPages[HttpContext.Current.Handler];
                if (queue != null)
                {
                    StringBuilder sb = new StringBuilder();
                    // How many messages have been registered?
                    int iMsgCount = queue.Count;
                    // Use StringBuilder to build up our client slide JavaScript.
                    sb.Append("<script language='javascript'>");
                    // Loop round registered messages
                    string sMsg;
                    while (iMsgCount-- > 0)
                    {
                        sMsg = (string)queue.Dequeue();
                        sMsg = sMsg.Replace("\n", "\\n");
                        sMsg = sMsg.Replace("\"", "'");
                        sb.Append(@"alert( """ + sMsg + @""" );");
                    }
                    // Close our JS
                    sb.Append(@"</script>");
                    // Were done, so remove our page reference from the hashtable
                    m_executingPages.Remove(HttpContext.Current.Handler);
                    // Write the JavaScript to the end of the response stream.
                    HttpContext.Current.Response.Write(sb.ToString());
                }
            }
        }



        protected void GridViewScores_NextPage(object sender, GridViewPageEventArgs e)
        {
            DataGrid_Supervisor.PageIndex = e.NewPageIndex;
            searchBTN_Click(sender, e);
        }

        protected void GridViewScores_Sorting(object sender, GridViewSortEventArgs e)
        {
            searchBTN_Click(sender, e);
        }
        public void searchBTN_Click(object sender, EventArgs e)
        {

            DropDownList1.DataBind();
            //if (DropDownList1.SelectedValue == "Select One")
            //{
            //    cite3.SelectCommand = "Select  a.UserName,a.LastName,a.FirstName, d.DeptName,s.StartDate, s.EndDate,(SUM(Score*100/MaxScore)/10) as Score from [Answer],[User] As a LEFT JOIN [Department] As d ON d.DeptID = a.DeptID LEFT JOIN [StudentEmployee] As s ON s.UserID = a.UserID Where a.UserID = [Answer].UserID group by a.UserName,a.LastName,a.FirstName, d.DeptName, s.StartDate, s.EndDate";
            //}
            if (/*Session["Command"].ToString()*/ DropDownList1.SelectedValue == "Department")
            {


                query = "Select  a.UserName,a.LastName,a.FirstName, d.DeptName,s.StartDate, s.EndDate,(SUM(Score*100/MaxScore)/10) as Score from [Answer],[User] As a LEFT JOIN [Department] As d ON d.DeptID = a.DeptID LEFT JOIN [StudentEmployee] As s ON s.UserID = a.UserID Where a.UserID = [Answer].UserID  AND d.DeptName='" + searchDepartment.SelectedValue.ToString() + "' group by a.UserName,a.LastName,a.FirstName, d.DeptName,s.StartDate,s.EndDate";

                // query = "Select  a.UserName,a.LastName,a.FirstName, d.Name, s.StartDate, s.EndDate,(SUM(Score*100/MaxScore)/10) as Score from [Answer], [User] As a JOIN [Department] As d ON d.DeptID = a.DeptID JOIN [StudentEmployee] As s ON s.UserID = a.UserID  AND a." + cmd + "='" + SearchTextBox.Text + "' Where a.UserID = [Answer].UserID group by a.UserName,a.LastName,a.FirstName, d.Name, s.StartDate, s.EndDate";
                Session["query"] = query;
                cite3.SelectCommand = query;

                //string query = "Select  a.UserName,a.LastName,a.FirstName, d.DeptName,s.StartDate, s.EndDate,(SUM(Score*100/MaxScore)/10) as Score from [Answer],[User] As a LEFT JOIN [Department] As d ON d.DeptID = a.DeptID LEFT JOIN [StudentEmployee] As s ON s.UserID = a.UserID Where a.UserID = [Answer].UserID group by a.UserName,a.LastName,a.FirstName, d.DeptName, s.StartDate, s.EndDate";
                //// query = "Select  a.UserName,a.LastName,a.FirstName, d.Name, s.StartDate, s.EndDate,(SUM(Score*100/MaxScore)/10) as Score from [Answer], [User] As a JOIN [Department] As d ON d.DeptID = a.DeptID JOIN [StudentEmployee] As s ON s.UserID = a.UserID Where a.UserID = [Answer].UserID group by a.UserName,a.LastName,a.FirstName, d.Name, s.StartDate, s.EndDate";
                //Session["query"] = query;
                //cite3.SelectCommand = query;    
            }

            else if (DropDownList1.SelectedValue == "Date")
            {

                try
                {
                    DateTime EndDate = Convert.ToDateTime(endDate.Text).AddDays(1);
                    query = "Select u.UserName,u.LastName,u.FirstName, d.DeptName, s.StartDate, s.EndDate,(SUM(Score*100/MaxScore)/10) as Score from [User] as u inner join Answer As a on a.UserID=u.UserID inner join Department As d on d.DeptID=u.DeptID inner join StudentEmployee As s on s.UserID=u.UserID where s.StartDate>='" + Convert.ToDateTime(startDate.Text) + "' And s.EndDate<='" + EndDate + "' group by u.UserID,s.StartDate,s.EndDate,d.DeptName,u.Username,u.FirstName,u.LastName;";
                    // query = "Select  a.UserName,a.LastName,a.FirstName, d.Name, s.StartDate, s.EndDate,(SUM(Score*100/MaxScore)/10) as Score from [Answer], [User] As a JOIN [Department] As d ON d.DeptID = a.DeptID JOIN [StudentEmployee] As s ON s.UserID = a.UserID  AND a." + cmd + "='" + SearchTextBox.Text + "' Where a.UserID = [Answer].UserID group by a.UserName,a.LastName,a.FirstName, d.Name, s.StartDate, s.EndDate";
                    Session["query"] = query;
                    cite3.SelectCommand = query;
                }
                catch (Exception ex)
                {
                    Response.Redirect("Error.aspx");
                }


                //string query = "Select  a.UserName,a.LastName,a.FirstName, d.DeptName,s.StartDate, s.EndDate,(SUM(Score*100/MaxScore)/10) as Score from [Answer],[User] As a LEFT JOIN [Department] As d ON d.DeptID = a.DeptID LEFT JOIN [StudentEmployee] As s ON s.UserID = a.UserID Where a.UserID = [Answer].UserID group by a.UserName,a.LastName,a.FirstName, d.DeptName, s.StartDate, s.EndDate";
                //query = "Select  a.UserName,a.LastName,a.FirstName, d.Name, s.StartDate, s.EndDate,(SUM(Score*100/MaxScore)/10) as Score from [Answer], [User] As a JOIN [Department] As d ON d.DeptID = a.DeptID JOIN [StudentEmployee] As s ON s.UserID = a.UserID Where a.UserID = [Answer].UserID group by a.UserName,a.LastName,a.FirstName, d.Name, s.StartDate, s.EndDate";
                //Session["query"] = query;
                //cite3.SelectCommand = query;    
            }
            else if (DropDownList1.SelectedValue == "FirstName" || DropDownList1.SelectedValue == "LastName" || DropDownList1.SelectedValue == "UserName")
            {
                searchBTN.Attributes.Clear();
                if (!SearchTextBox.Text.Contains("'"))
                {
                    query = "Select  a.UserName,a.LastName,a.FirstName, d.DeptName,s.StartDate, s.EndDate,(SUM(Score*100/MaxScore)/10) as Score from [Answer],[User] As a LEFT JOIN [Department] As d ON d.DeptID = a.DeptID  LEFT JOIN [StudentEmployee] As s ON s.UserID = a.UserID Where a.UserID = [Answer].UserID  AND a." + Session["Command"].ToString() + " like '" + SearchTextBox.Text + "%'  group by a.UserName,a.LastName,a.FirstName, d.DeptName, s.StartDate, s.EndDate";
                    //  query = "Select  a.UserName,a.LastName,a.FirstName, d.Name, s.StartDate, s.EndDate,(SUM(Score*100/MaxScore)/10) as Score from [Answer], [User] As a JOIN [Department] As d ON d.DeptID = a.DeptID  AND d.Name='" + SearchTextBox.Text + "' JOIN [StudentEmployee] As s ON s.UserID = a.UserID  Where a.UserID = [Answer].UserID group by a.UserName,a.LastName,a.FirstName, d.Name, s.StartDate, s.EndDate";
                    Session["query"] = query;
                    cite3.SelectCommand = query;
                }
                else
                {
                    searchBTN.Attributes.Add("onClick", "javascript:alert('Please enter valid characters in the text field');");
                    
                }
            }
            else
            {

                cite3.SelectCommand = "Select  a.UserName,a.LastName,a.FirstName, d.DeptName,s.StartDate, s.EndDate,(SUM(Score*100/MaxScore)/10) as Score from [Answer],[User] As a LEFT JOIN [Department] As d ON d.DeptID = a.DeptID LEFT JOIN [StudentEmployee] As s ON s.UserID = a.UserID Where a.UserID = [Answer].UserID group by a.UserName,a.LastName,a.FirstName, d.DeptName, s.StartDate, s.EndDate";
            }

           
        }

        protected void ShowAllFunction(object sender, EventArgs e)
        {

            DropDownList1.ClearSelection();

            searchDepartment.Visible = false;
            SearchTextBox.Visible = false;
            startDate.Visible = false;
            endDate.Visible = false;
            StartDateLbl.Visible = false;
            EndDateLbl.Visible = false;
            CalenderImageButton.Visible = false;
            EndDateimageButton.Visible = false;
            
            string query = "Select  a.UserName,a.LastName,a.FirstName, d.DeptName,s.StartDate, s.EndDate,(SUM(Score*100/MaxScore)/10) as Score from [Answer],[User] As a LEFT JOIN [Department] As d ON d.DeptID = a.DeptID LEFT JOIN [StudentEmployee] As s ON s.UserID = a.UserID Where a.UserID = [Answer].UserID group by a.UserName,a.LastName,a.FirstName, d.DeptName, s.StartDate, s.EndDate";
            // query = "Select  a.UserName,a.LastName,a.FirstName, d.Name, s.StartDate, s.EndDate,(SUM(Score*100/MaxScore)/10) as Score from [Answer], [User] As a JOIN [Department] As d ON d.DeptID = a.DeptID JOIN [StudentEmployee] As s ON s.UserID = a.UserID Where a.UserID = [Answer].UserID group by a.UserName,a.LastName,a.FirstName, d.Name, s.StartDate, s.EndDate";
            Session["query"] = query;
            cite3.SelectCommand = query;

        }
    }
}
