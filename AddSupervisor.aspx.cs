using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Collections;
using StudentOrientation.ModuleTypes;
using System.Web.Security;
using System.Data.Sql;
using Cite.DomainAuthentication;
using System.IO;
using System.Drawing;

namespace StudentOrientation
{
    public partial class AddSupervisor : System.Web.UI.Page
    {
        loginDetails det = new loginDetails();
        DatabaseDataContext dataContext = new DatabaseDataContext();

        string sqlStatement = "SELECT Supervisor.SupervisorID as SID,FirstName,LastName,deptName from [Supervisor],[Department],[DeptSupervisor]  Where Supervisor.SupervisorID=DeptSupervisor.SupervisorID AND Department.DeptID=DeptSupervisor.DeptID";

        List<String> list = new List<string>();

        protected void Page_Load(object sender, EventArgs e)
        {
            SearchTextBox.Visible = false;
            if (!IsPostBack)
            {
                BindGridView();

                ArrayList SearchArrayList = new ArrayList();

                SearchArrayList.Add("Select One");
                SearchArrayList.Add("Department");
                SearchArrayList.Add("FirstName");
                SearchArrayList.Add("LastName");

                dropdownSearchList.DataSource = SearchArrayList;
                dropdownSearchList.DataBind();

                searchDepartment.DataSource = list;
                searchDepartment.DataBind();

            }
        }


        private string GetConnectionString()
        {

            //Where MyConsString is the connetion string that was set up in the web config file

            return System.Configuration.ConfigurationManager.ConnectionStrings["StudentOrientationConnectionString"].ConnectionString;

        }






        private void BindGridView()
        {

            DataTable dt = new DataTable();

            SqlConnection connection = new SqlConnection(GetConnectionString());

            try
            {

                connection.Open();

                string sqlStatement = "SELECT Supervisor.SupervisorID as SID,FirstName,LastName,deptName from [Supervisor],[Department],[DeptSupervisor]  Where Supervisor.SupervisorID=DeptSupervisor.SupervisorID AND Department.DeptID=DeptSupervisor.DeptID";

                SqlCommand sqlCmd = new SqlCommand(sqlStatement, connection);

                SqlDataAdapter sqlDa = new SqlDataAdapter(sqlCmd);

                sqlDa.Fill(dt);

                if (dt.Rows.Count > 0)
                {

                    GridViewEmployee.DataSource = dt;

                    GridViewEmployee.DataBind();

                }




            }

            catch (System.Data.SqlClient.SqlException ex)
            {

                string msg = "Fetch Error:";

                msg += ex.Message;

                throw new Exception(msg);

            }

            finally
            {

                connection.Close();

            }



        }


        protected void Button1_Click(object sender, EventArgs e)
        {

            //Extract the TextBoxes that is located under the footer template

            TextBox tbFirstName = (TextBox)GridViewEmployee.FooterRow.Cells[1].FindControl("TextBoxFirstName");

            TextBox tbLastName = (TextBox)GridViewEmployee.FooterRow.Cells[2].FindControl("TextBoxLastName");

            DropDownList tbDepartment = (DropDownList)GridViewEmployee.FooterRow.Cells[3].FindControl("TextBoxDepartment");



            if ((tbFirstName.Text == "" || tbLastName.Text == "") || tbDepartment.Text == "Select DepartmentName")
            {
                labelAlert.Text = "Enter all the required fields";
                labelAlert.ForeColor = System.Drawing.Color.Red;
            }
            else
            {
                //call the method for adding new records to database and pass the necessary parameters
                labelAlert.Text = "";
                AddNewRecord(tbFirstName.Text, tbLastName.Text, tbDepartment.Text);

                //Re-Bind the GridView to reflect the changes made

                BindGridView();
            }

        }

        private void AddNewRecord(string firstname, string lastname, string department)
        {

            SqlConnection connection = new SqlConnection(GetConnectionString());

            string sqlStatement1 = "Insert into [Supervisor] (FirstName,LastName,Role) values ('" + firstname + "','" + lastname + "',1)";

            string sqlStatement2 = "Insert into [DeptSupervisor] (DeptID,SupervisorID) values ((Select DeptID from [Department] where DeptName=@Department),(Select SupervisorID from [Supervisor] where FirstName='" + firstname + "' AND LastName='" + lastname + "'))";

            try
            {



                connection.Open();

                SqlCommand cmd1 = new SqlCommand(sqlStatement1, connection);



                cmd1.CommandType = CommandType.Text;

                cmd1.ExecuteNonQuery();
                connection.Close();
                connection.Open();

                SqlCommand cmd2 = new SqlCommand(sqlStatement2, connection);

                cmd2.Parameters.AddWithValue("@Department", department);

                cmd2.CommandType = CommandType.Text;

                cmd2.ExecuteNonQuery();

            }

            catch (System.Data.SqlClient.SqlException ex)
            {

                string msg = "Insert/Update Error:";

                msg += ex.Message;

                throw new Exception(msg);

            }

            finally
            {

                connection.Close();

            }

        }


        protected void GridViewEmployee_RowEditing(object sender, GridViewEditEventArgs e)
        {

            GridViewEmployee.EditIndex = e.NewEditIndex; // turn to edit mode

            BindGridView(); // Rebind GridView to show the data in edit mode

        }



        protected void GridViewEmployee_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {

            GridViewEmployee.EditIndex = -1; //swicth back to default mode

            BindGridView(); // Rebind GridView to show the data in default mode

        }



        protected void GridViewEmployee_PageChanging(object sender, GridViewPageEventArgs e)
        {
            string cmd = dropdownSearchList.SelectedValue.ToString();
            GridViewEmployee.PageIndex = e.NewPageIndex;

            if (cmd == "Department" || cmd == "FirstName" || cmd == "LastName")
                search_Click(sender, e);
            else
                BindGridView();

        }
        protected void GridViewEmployee_Sorting(object sender, GridViewSortEventArgs e)
        {
            search_Click(sender, e);
        }

        protected void GridViewEmployee_RowDatabound(object sender, GridViewRowEventArgs e)
        {
            if (GridViewEmployee.EditIndex == e.Row.RowIndex)
            {
                DropDownList ddList = (DropDownList)e.Row.Cells[0].FindControl("TextBoxEditDepartment");


                list.Add("Select DepartmentName");
                var deptList = (from dept in dataContext.Departments
                                orderby dept.DeptName
                                select dept.DeptName);
                foreach (string name in deptList)
                {
                    list.Add(name);
                }

                if (ddList != null)
                {
                    ddList.DataSource = list;

                    ddList.SelectedValue = "CITE";


                    ddList.DataBind();
                }
            }

            if (e.Row.RowType == DataControlRowType.Footer)
            {
                DropDownList dropDownList = (DropDownList)e.Row.FindControl("TextBoxDepartment");

                list.Add("Select DepartmentName");
                var deptList = (from dept in dataContext.Departments
                                orderby dept.DeptName
                                select dept.DeptName);
                foreach (string name in deptList)
                {
                    list.Add(name);
                }

                if (dropDownList != null)
                {
                    dropDownList.DataSource = list;



                    dropDownList.DataBind();
                }
            }
        }


        private void UpdateRecord(string supervisorid, string firstname, string lastname, string department)
        {
            Int32 id = Convert.ToInt32(supervisorid);
            SqlConnection connection = new SqlConnection(GetConnectionString());

            string sqlStatement1 = "UPDATE [Supervisor]  SET Supervisor.FirstName='" + firstname + "',Supervisor.LastName='" + lastname + "' WHERE SupervisorID='" + id + "'";

            string sqlStatement2 = "UPDATE [DeptSupervisor] SET [DeptSupervisor].DeptID=(Select DeptID from [Department] where DeptName='" + department + "')  WHERE SupervisorID='" + id + "'";




            try
            {



                connection.Open();

                SqlCommand cmd1 = new SqlCommand(sqlStatement1, connection);



                cmd1.CommandType = CommandType.Text;

                cmd1.ExecuteNonQuery();
                connection.Close();
                connection.Open();

                SqlCommand cmd2 = new SqlCommand(sqlStatement2, connection);

                cmd2.Parameters.AddWithValue("@Department", department);

                cmd2.CommandType = CommandType.Text;

                cmd2.ExecuteNonQuery();

            }

            catch (System.Data.SqlClient.SqlException ex)
            {

                string msg = "Insert/Update Error:";

                msg += ex.Message;

                throw new Exception(msg);

            }

            finally
            {

                connection.Close();

            }

        }


        protected void GridViewEmployee_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {

            // Accessing Edited values from the GridView

            string id = ((TextBox)GridViewEmployee.Rows[e.RowIndex].Cells[0].FindControl("TextBoxEditSupervisorID")).Text; //ID

            string firstname = ((TextBox)GridViewEmployee.Rows[e.RowIndex].Cells[1].FindControl("TextBoxEditFirstName")).Text; //Employee

            string lastname = ((TextBox)GridViewEmployee.Rows[e.RowIndex].Cells[2].FindControl("TextBoxEditLastName")).Text; //Position

            //    string department = ((TextBox)GridViewEmployee.Rows[e.RowIndex].Cells[3].FindControl("TextBoxEditDepartment")).Text; //Team

            DropDownList department = (DropDownList)GridViewEmployee.Rows[e.RowIndex].Cells[3].FindControl("TextBoxEditDepartment");


            string dept = department.SelectedValue.ToString();

            UpdateRecord(id, firstname, lastname, dept); // call update method



            GridViewEmployee.EditIndex = -1; //Turn the Grid to read only mode



            BindGridView(); // Rebind GridView to reflect changes made



            Response.Write("Update Seccessful!");

        }


        private void DeleteRecord(string ID)
        {

            SqlConnection connection = new SqlConnection(GetConnectionString());

            string sqlStatement = "DELETE FROM [Supervisor] WHERE SupervisorID = @Id";



            try
            {

                connection.Open();

                SqlCommand cmd = new SqlCommand(sqlStatement, connection);

                cmd.Parameters.AddWithValue("@Id", ID);

                cmd.CommandType = CommandType.Text;

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

        }


        protected void GridViewEmployee_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {

            //get the ID of the selected row

            string id = ((Label)GridViewEmployee.Rows[e.RowIndex].Cells[0].FindControl("LabelSupervisorID")).Text;

            DeleteRecord(id); //call the method for delete



            BindGridView(); // Rebind GridView to reflect changes made

        }


        protected void ShowAllFunction(object sender, EventArgs e)
        {
            dropdownSearchList.ClearSelection();
            searchDepartment.Visible = false;
            SearchTextBox.Visible = false;
            BindGridView();
        }


        protected void search_Click(object sender, EventArgs e)
        {
            dropdownSearchList.DataBind();
            string cmd = dropdownSearchList.SelectedValue.ToString();
            string str = SearchTextBox.Text;
            string strDept = searchDepartment.SelectedValue.ToString();
            searchBTN.Attributes.Clear();
            if (!SearchTextBox.Text.Contains("'"))
            {
                DataTable dt = new DataTable();

                SqlConnection connection = new SqlConnection(GetConnectionString());

                if (cmd != "Select One")

                    if (str != "" || strDept != "")
                    {

                        try
                        {
                            string sqlStatement;
                            connection.Open();

                            if (cmd != "Department")
                                sqlStatement = "SELECT Supervisor.SupervisorID as SID,FirstName,LastName,deptName from [Supervisor],[Department],[DeptSupervisor]  Where Supervisor.SupervisorID=DeptSupervisor.SupervisorID AND Department.DeptID=DeptSupervisor.DeptID AND Supervisor." + cmd + " like '" + str + "%'";
                            else
                                sqlStatement = "SELECT Supervisor.SupervisorID as SID,FirstName,LastName,deptName from [Supervisor],[Department],[DeptSupervisor]  Where Supervisor.SupervisorID=DeptSupervisor.SupervisorID AND Department.DeptID=DeptSupervisor.DeptID AND Department.deptName ='" + strDept + "'";

                            SqlCommand sqlCmd = new SqlCommand(sqlStatement, connection);

                            SqlDataAdapter sqlDa = new SqlDataAdapter(sqlCmd);

                            sqlDa.Fill(dt);

                            if (dt.Rows.Count > 0)
                            {

                                GridViewEmployee.DataSource = dt;

                                GridViewEmployee.DataBind();
                            }
                        }

                        catch (System.Data.SqlClient.SqlException ex)
                        {

                            string msg = "Fetch Error:";

                            msg += ex.Message;

                            throw new Exception(msg);

                        }

                        finally
                        {

                            connection.Close();

                        }
                  }
            }
            else
            {
                searchBTN.Attributes.Add("onClick", "javascript:alert('Please enter valid characters in the text field');");
            }

        }

        protected void DropDownChange(object sender, EventArgs e)
        {
            if (dropdownSearchList.SelectedValue == "Department")
            {
                searchDepartment.Visible = true;
                SearchTextBox.Visible = false;

            }
            else
            {
                searchDepartment.Visible = false;
                if (dropdownSearchList.SelectedValue == "Select One")
                {
                    SearchTextBox.Visible = false;
                }
                else
                {
                    SearchTextBox.Visible = true;
                    SearchTextBox.Focus();
                    SearchTextBox.Text = "";
                }
            }
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
    }
}