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
using System.Configuration;

namespace StudentOrientation
{
    public partial class Orientation : System.Web.UI.Page
    {
        loginDetails det = new loginDetails();
        DatabaseDataContext dataContext = new DatabaseDataContext();
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                DeptName.Visible = false;
                if (Session["LoggedIn"] == null || !(bool)Session["LoggedIn"] || Session["Role"] == null)
                {
                    Response.Redirect("~/Login.aspx");
                }
                var deptid = (from id in dataContext.Users
                              where id.UserID == Convert.ToInt32(Session["UserID"].ToString())
                              select id.DeptID).Single();

                if (deptid != null)
                {
                    var deptname = (from deptName in dataContext.Departments
                                    where deptName.DeptID == Convert.ToInt32(deptid.ToString())
                                    select deptName.DeptName).Single();
                    DeptName.Visible = true;
                    DeptName.Text = deptname;
                    
                    //DeptList1.Visible = false;
                   
                    //Response.Redirect(Request.RawUrl);
                    if (!Session["Name"].ToString().Contains("Guest"))
                    {
                        if (!IsPostBack)
                        {

                            List<String> list = new List<string>();
                            list.Add("Select DepartName");
                            var deptList = (from dept in dataContext.Departments
                                            select dept.DeptName);
                            foreach (string name in deptList)
                            {
                                list.Add(name);
                            }
                            

                            DeptList1.DataSource = list;
                            DeptList1.DataBind();
                        }
                    }
                    else
                    {
                        Response.Redirect("~/ssa/story.html");
                        DeptList1.Visible = false;
                        DeptName.Visible = false;
                      
                    }
                }

            }
            catch
            {
                FormsAuthentication.RedirectToLoginPage("~/Orientation.aspx");
            }
        }
        public void Dropdownshow(object sender, EventArgs e)
        {
            try
            {
                DeptList1.Visible = true;
                editDept_lbl.Visible = false;
            }
            catch
            {
                FormsAuthentication.RedirectToLoginPage("~/Orientation.aspx");
            }
        }
        protected void SelectedDept(object sender, EventArgs e)
        {
            if (DeptList1.SelectedValue != "Select DepartName")
            {
                page.Visible = true;
                var deptID = (from dept in dataContext.Departments
                              where dept.DeptName == DeptList1.SelectedValue.ToString()
                              select dept.DeptID).Single();
                string query = "Update [StudentOrientation].[dbo].[User] Set DeptID = " + deptID + " Where UserID = " + Convert.ToInt32(Session["UserID"].ToString());
                string connectionString = ConfigurationManager.ConnectionStrings["StudentOrientationConnectionString"].ConnectionString;
                SqlConnection conn = new SqlConnection(connectionString);
                SqlCommand sqlcmd = new SqlCommand(query, conn);
                try
                {
                    conn.Open();
                    sqlcmd.ExecuteNonQuery();
                }
                catch
                {
                }
                finally
                {
                    conn.Close();
                }
                Response.Redirect(Request.RawUrl);
                DeptList1.Visible = false;
                editDept_lbl.Visible = true;

            }
            else
            {
                DeptList1.Visible = true;
                page.Visible = false;
            }
        }
        protected void logoutBTN_Click(object sender, EventArgs e)
        {
            try
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
            catch (Exception ex)
            {
                FormsAuthentication.RedirectToLoginPage("~/Login.aspx");
            }
        }

        protected void btnToOrientation_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/ssa/story.html");
            //Response.Redirect("TestPage.aspx");
        }
    }
}