<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddSupervisor.aspx.cs"
    Inherits="StudentOrientation.AddSupervisor" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Student Employee Orientation - AddSupervisor</title>
    <link rel="stylesheet" href="js/jquery.jgrowl.css" type="text/css" />
    <link rel="stylesheet" href="Layout/CSS/ui-darkness/jquery-ui-1.8.10.custom.css"
        type="text/css" />
    <link href="Layout/CSS/orientation.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="Layout/CSS/master.css" type="text/css" />
    <script src="js/jquery-1.4.4.js" type="text/javascript"></script>
    <script src="js/jquery-ui-1.8.10.js" type="text/javascript"></script>
    <script src="js/jquery.flash.js" type="text/javascript"></script>
    <script src="js/jquery.jgrowl.js" type="text/javascript"></script>
    <script src="js/Orientation.js" type="text/javascript"></script>
    <script type="text/javascript">
       
    </script>
    <style type="text/css">
        #map
        {
            width: 953px;
        }
    </style>
</head>
<body>
    <form id="form1" defaultbutton="searchBTN" runat="server">
    <div id="header" style="position: absolute; width: 98%; top: 0px; left: 7px; background-color: #024733;">
        <table id="progress" style="width: 100%">
            <tr>
                <td>
                    <img src="img/NWLogoWhite.png" />
                </td>
                <td class="style2">
                    <h3>
                        Student Employee Orientation</h3>
                </td>
                <td>
                    <div id="welcome" style="text-align: right">
                        <h4 style="height: 10px">
                            Welcome
                            <% Response.Write(Session["Name"]); %></h4>
                        <asp:Button ID="logoutBTN" runat="server" Text="logout" OnClick="logoutBTN_Click" />
                    </div>
                </td>
            </tr>
        </table>
    </div>
    <br />
    <br />
    <br />
    <br />
    <br />
    <div id="page">
        <div style="height: 595px; width: 828px; position: absolute; top: 125px; left: 278px;
            opacity: 0.9; filter: alpha(opacity=40); background-color: Black; border: 5px solid DarkOliveGreen;
            border-radius: 16px;">

            <div style="position: absolute; top: 43px; left: 23px; height: 346px; width: 563px;">
                <asp:GridView ID="GridViewEmployee" runat="server" AllowPaging="true" CellPadding="4"
                    GridLines="None" AutoGenerateColumns="False" ShowFooter="True" AllowSorting="True"
                    ForeColor="#333333" PageSize="12" Width="777px" OnRowCancelingEdit="GridViewEmployee_RowCancelingEdit"
                    OnRowEditing="GridViewEmployee_RowEditing" OnRowUpdating="GridViewEmployee_RowUpdating"
                    OnRowDeleting="GridViewEmployee_RowDeleting" OnRowDataBound="GridViewEmployee_RowDatabound"
                    OnPageIndexChanging="GridViewEmployee_PageChanging">

                    <EditRowStyle BackColor="#7C6F57" />
                    <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" HorizontalAlign="Left" />
                    <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" />
                    <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
                    <AlternatingRowStyle BackColor="White" />
                    <RowStyle HorizontalAlign="Left" />
                    <Columns>
                        <asp:TemplateField HeaderText="SupervisorID" Visible="false">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBoxEditSupervisorID" runat="server" Text='<%# Bind("SID") %>'
                                    Enabled="false" />
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="LabelSupervisorID" runat="server" Text='<%# Bind("SID") %>' />
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:TextBox ID="TextBoxSupervisorID" runat="server" Visible="false" />
                            </FooterTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="First Name">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBoxEditFirstName" runat="server" Text='<%# Bind("FirstName") %>' />
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="LabelFirstName" runat="server" Text='<%# Bind("FirstName") %>' />
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:TextBox ID="TextBoxFirstName" runat="server" />
                            </FooterTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Last Name">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBoxEditLastName" runat="server" Text='<%# Bind("LastName") %>'/>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="LabelLastName" runat="server" Text='<%# Bind("LastName") %>'/>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:TextBox ID="TextBoxLastName" runat="server" />
                            </FooterTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Department">
                            <EditItemTemplate>
                                <%-- <asp:TextBox ID="TextBoxEditDepartment" runat="server" Text='<%# Bind("deptName") %>' />--%>
                                <asp:DropDownList ID="TextBoxEditDepartment" runat="server" />
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="LabelDepartment" runat="server" Text='<%# Bind("deptName") %>' />
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:DropDownList ID="TextBoxDepartment" runat="server">
                                </asp:DropDownList>
                            </FooterTemplate>
                        </asp:TemplateField>
                        <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                    </Columns>
                    <SelectedRowStyle ForeColor="#333333" Font-Bold="True" BackColor="#C5BBAF"></SelectedRowStyle>
                    <RowStyle BackColor="#E3EAEB"></RowStyle>
                    <SortedAscendingCellStyle BackColor="#F8FAFA" />
                    <SortedAscendingHeaderStyle BackColor="#246B61" />
                    <SortedDescendingCellStyle BackColor="#D4DFE1" />
                    <SortedDescendingHeaderStyle BackColor="#15524A" />
                </asp:GridView>
                <asp:Button ID="addNewBtn" runat="server" Text="Add New" OnClick="Button1_Click" />
                <asp:Label ID="labelAlert" runat="server" />
            </div>
            <div style="position: absolute; background-color: Orange; background-position: center;
                border-top-left-radius: 10px 10px; border-bottom-right-radius: 10px 10px; border-top-right-radius: 10px 10px;
                border-bottom-left-radius: 10px 10px; top: 11px; left: 254px; width: 255px; height: 27px;
                text-align: center; vertical-align: baseline">
                <asp:Label ID="LabelOverGrid" runat="server" Text="Updating Supervisor's Details"></asp:Label>
            </div>
        </div>
        <div style="position: absolute; top: 124px; left: 10px; width: 253px; height: 595px;
            opacity: 0.9; filter: alpha(opacity=40); background-color: Black; border: 5px solid DarkOliveGreen;
            border-radius: 16px;">
            <div style="position: absolute; background-color: Orange; background-position: center;
                border-top-left-radius: 10px 10px; border-bottom-right-radius: 10px 10px; border-top-right-radius: 10px 10px;
                border-bottom-left-radius: 10px 10px; top: 16px; left: 33px; width: 193px; height: 22px;
                bottom: 485px; text-align: center; vertical-align: baseline">
                <asp:Label ID="LabelOverSearchBox" runat="server" Text="Search Supervisors"></asp:Label>
            </div>
            <div style="position: absolute; top: 59px; left: 36px; width: 210px; height: 394px;">
                <table style="height: 0px">
                    <tr>
                        <asp:DropDownList ID="dropdownSearchList" runat="server" AutoPostBack="true" OnSelectedIndexChanged="DropDownChange">
                        </asp:DropDownList>
                        <br />
                        <br />
                    </tr>
                    <tr>
                        <asp:TextBox ID="SearchTextBox" runat="server"></asp:TextBox>
                    </tr>
                    <tr>
                        <asp:DropDownList ID="searchDepartment" runat="server" Width="200" Visible="false">
                        </asp:DropDownList>
                        <br />
                        <br />
                    </tr>
                    <tr>
                        <asp:Button ID="searchBTN" runat="server" OnClick="search_Click" Text="Search" />
                        <br />
                        <br />
                        <asp:Button ID="showAllBTN" runat="server" Text="Show All" OnClick="ShowAllFunction" />
                    </tr>
                    <%--<tr>
                    <div id="content">
                        <asp:Label ID="FromLabel" Text="From:" runat="server"></asp:Label>
                        <asp:TextBox ID="startdate" class="field" runat="server"></asp:TextBox>
                        <asp:Label ID="ToLabel" Text="To:" runat="server"></asp:Label>
                        <asp:TextBox ID="enddate" class="field" runat="server"></asp:TextBox>
                    </div>
                    <asp:Button ID="SearchDate" runat="server" OnClick="Button2_Click" Text="SearchByDate" />
                </tr>--%>
                </table>
            </div>
            <div style="position: absolute; top: 474px; left: 19px; height: 32px; width: 240px;">
                <asp:Button ID="instructionsButton" runat="server" Text="Log" PostBackUrl="Scores.aspx" />
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp
                <asp:Button ID="orientationButton" runat="server" Text="Orientation" PostBackUrl="Orientation.aspx" />
            </div>
        </div>
    </form>
</body>
</html>
