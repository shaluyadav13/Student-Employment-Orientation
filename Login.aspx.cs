using System;
using System.Linq;
using System.Web;
using Cite.DomainAuthentication;

namespace StudentOrientation
{
    public struct loginDetails
    {
        public bool loggedIn;
    }
    public partial class Login : System.Web.UI.Page
    {
        loginDetails det = new loginDetails();
        protected void Page_Load(object sender, EventArgs e)
        {
            det.loggedIn = false;
            username.Focus();
            Session["LoggedIn"] = false;
            Session["Role"] = null;
#if !DEBUG
            // If not connected through SSL, redirect.
            if (!HttpContext.Current.Request.Url.AbsoluteUri.Contains("https"))
                Response.Redirect(HttpContext.Current.Request.Url.AbsoluteUri.Replace("http", "https"));
#endif
            if ((bool)Session["LoggedIn"])
            {
                Response.Redirect("~/Orientation.aspx");
            }

            // Make sure the user is not logged in.
            

            error.Visible = false;
        }

        protected void loginBtn_Click(object sender, EventArgs e)
        {
            if (username.Text == "" || password.Text == "")
            {
                error.Text = "UserName and Password must not be empty";
                error.Visible = true;
                return;
            }
            try
            {
                // Attempt to authenticate account.
                DomainAccount account = new DomainAccount(username.Text.Split('@')[0], password.Text);

                if (account.IsAuthenticated)
                {
                    Supervisor super = new Supervisor();
                    User login = null;
                    StudentEmployee studentEmpDetails = null;

                    if (account.OU == OrganizationalUnit.FacultyUsers || account.OU == OrganizationalUnit.StaffUsers)
                    {
                        DatabaseDataContext db = new DatabaseDataContext();
                        try
                        {
                            var role = (from sup in db.Supervisors
                                        where sup.FirstName == account.FirstName && sup.LastName == account.LastName
                                        select sup).Single();
                            
                            if (account.FirstName == "Kriss" && account.LastName == "Backo")
                            {
                                login = new User();
                                studentEmpDetails = new StudentEmployee();
                                login.Role = 2;
                                login.Username = account.Username;
                                login.FirstName = account.FirstName;
                                login.LastName = account.LastName;
                                db.Users.InsertOnSubmit(login);
                                db.SubmitChanges();
                            }
                            else
                            {
                                if (role.FirstName != null)
                                {
                                    try
                                    {
                                        login = (from user in db.Users
                                                 where user.Username == account.Username
                                                 select user).Single();
                                    }
                                    catch (InvalidOperationException)
                                    {
                                        // User not in database. Add to the database.

                                        login = new User();
                                        studentEmpDetails = new StudentEmployee();
                                        login.Role = 1;
                                        login.Username = account.Username;
                                        login.FirstName = account.FirstName;
                                        login.LastName = account.LastName;
                                        db.Users.InsertOnSubmit(login);
                                        db.SubmitChanges();
                                    }
                                    det.loggedIn = true;
                                    Session["LoggedIn"] = true;
                                    Session["Username"] = account.Username;
                                    Session["Name"] = account.FirstName + " " + account.LastName;
                                    Session["UserID"] = login.UserID;
                                    try
                                    {
                                        var userID = (from student in db.StudentEmployees
                                                      where student.UserID == Convert.ToInt32(Session["UserID"].ToString())
                                                      select student.UserID).Single();
                                        if (userID == Convert.ToInt32(Session["UserID"].ToString()))
                                        {

                                        }
                                    }
                                    catch (Exception ex)
                                    {
                                        studentEmpDetails.UserID = login.UserID;
                                        studentEmpDetails.StartDate = DateTime.Now;
                                        db.StudentEmployees.InsertOnSubmit(studentEmpDetails);
                                        db.SubmitChanges();
                                    }
                                }
                                else
                                {
                                    error.Text = "You have no credentials to logon.";
                                    error.Visible = true;
                                }
                            }
                        }
                        catch (Exception)
                        {
                            error.Text = "You have no credentials to logon.";
                            error.Visible = true;

                        }
                    }


                    if (account.OU == OrganizationalUnit.StudentUsers || account.OU == OrganizationalUnit.Unknown)
                    {


                        DatabaseDataContext db = new DatabaseDataContext();

                        // Attempt to get User from database.


                        try
                        {
                            login = (from user in db.Users
                                     where user.Username == account.Username
                                     select user).Single();
                        }
                        catch (InvalidOperationException)
                        {
                            // User not in database. Add to the database.


                            login = new User();
                            studentEmpDetails = new StudentEmployee();
                            if (account.LastName == "Kande"||account.LastName=="Zweifel")
                            {
                                login.Role = 2;
                            }
                            else
                            {
                                login.Role = 0;
                            }

                            login.FirstName = account.FirstName;
                            login.LastName = account.LastName;
                            login.Username = account.Username;
                            login.DeptID = 1;
                            db.Users.InsertOnSubmit(login);
                            db.SubmitChanges();
                        }
                        det.loggedIn = true;
                        Session["LoggedIn"] = true;
                        Session["Username"] = account.Username;
                        Session["Name"] = account.FirstName + " " + account.LastName;
                        Session["UserID"] = login.UserID;
                        try
                        {
                            var userID = (from student in db.StudentEmployees
                                         where student.UserID == Convert.ToInt32(Session["UserID"].ToString())
                                         select student.UserID).Single();
                            if (userID == Convert.ToInt32(Session["UserID"].ToString()))
                            {
                                
                            }
                        }
                        catch (Exception ex)
                        {
                            studentEmpDetails.UserID = login.UserID;
                            studentEmpDetails.StartDate = DateTime.Now;
                            db.StudentEmployees.InsertOnSubmit(studentEmpDetails);
                            db.SubmitChanges();
                        }
                        
                        // Switch on the administrator field. If the field

                    }
                    switch (login.Role)
                    {
                        case 0:
                            Session["Role"] = "Student";
                            Response.Redirect("~/Orientation.aspx");
                            break;
                        case 1:
                            Session["Role"] = "Supervisor";
                            Response.Redirect("~/Supervisor.aspx");
                            break;
                        case 2:
                            Session["Role"] = "Admin";
                            Response.Redirect("~/Admin.aspx");
                            break;
                    }
                }
                else
                {
                    // Output unable to authenticate error.
                    error.Text = "The username or password you entered is incorrect.";
                    error.Visible = true;
                }
            }
            catch (Exception ex)
            {
                // Output generic error.
                //error.Text = "There was an unexpected error. Please try again later or call the cite3 Office at (660)562-1532.";
                if (ex.Message == "Sequence contains no elements ")
                {
                    error.Text = "You have no credentials to logon.";
                    error.Visible = true;
                }
                error.Text = ex.Message.ToString();
                error.Visible = true;
            }
        }

        protected void guestButton_Click(object sender, EventArgs e)
        {
            try
            {
                DatabaseDataContext db = new DatabaseDataContext();

                // Attempt to get User from database.
                User login = new User();

                login.Role = 0;
                login.FirstName = "Guest";
                login.LastName = "";
                login.Username = Guid.NewGuid().ToString().Replace("-", "").Substring(0, 9);
                
                db.Users.InsertOnSubmit(login);
                db.SubmitChanges();
                det.loggedIn = true;
                Session["LoggedIn"] = true;
                Session["Username"] = login.Username;
                Session["Name"] = login.FirstName;
                Session["UserID"] = login.UserID;

                Session["Role"] = "Student";
                Response.Redirect("~/ssa/story.html");
            }
            catch (Exception ex)
            {
                // Output generic error.
                //error.Text = "There was an unexpected error. Please try again later or call the cite3 Office at (660)562-1532.";
                if (ex.Message == "Sequence contains no elements ")
                {
                    error.Text = "You have no credentials to logon.";
                    error.Visible = true;
                }
                else
                {
                    error.Text = ex.Message;
                    error.Visible = true;
                }
            }
        }
    }
}