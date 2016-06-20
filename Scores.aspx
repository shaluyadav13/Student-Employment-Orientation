<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Scores.aspx.cs" Inherits="StudentOrientation.Scores" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Student Employee Orientation - Scores</title>
    <style type="text/css">
    .StartDateBtnClass
    { top:-5px;
    padding: 0px;
    border-color: #FF9900;
    color: #FFF;
    width: 80px;
    height: 30px;
    background-color: #FF9900;
    font-size: medium;
    border-top-left-radius: 15px 15px;
    border-bottom-right-radius: 15px 15px;
    border-top-right-radius: 15px 15px;
    border-bottom-left-radius: 15px 15px;
        
        }
    </style>
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
   <script src="http://code.jquery.com/jquery-latest.js" type="text/javascript"></script>
   <link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="stylesheet" type="text/css"/>
   <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.5/jquery.min.js" type="text/javascript""></script>
   <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js" type="text/javascript"></script>
    <%--    <script type="text/javascript">

        $(document).ready(function () {
            $("#startDate").click(function () {

                $("#datepicker").datepicker({ mindate: new Date(), autosize: true, disableb: false, dateformat: 'dd/mm/yy',
                    onSelect: function (dateText, picker) {
                        $("#enddatepicker").hide();
                        var dateObject = $("#datepicker").datepicker("getDate");
                        var selecteddate = (dateObject.getMonth() + 1) + '/' + dateObject.getDate() + '/' + dateObject.getFullYear();
                        $("#startDate").val(selecteddate.toString());
                        $("#datepicker").hide();

                    } //end of onselect function 
                }); //End of datePicker
            }); // End of the Function 
            $("#endDate").live('click', function () {
                $("#enddatePicker").datepicker({ mindate: new Date(), autosize: true, disableb: false, dateformat: 'mm/dd/yy',
                    onSelect: function (dateText, picker) {
                        $("datepicker").hide();
                        var dateObject = $("#enddatePicker").datepicker("getDate");
                        var selecteddate = (dateObject.getMonth() + 1) + '/' + dateObject.getDate() + '/' + dateObject.getFullYear();
                        $("#endDate").val(selecteddate.toString());
                        $("#enddatePicker").hide();
                    }
                });
            }); //End of function
        }); 
    </script>--%>
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
                    <h3>Student Employee Orientation</h3>
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
    
        <asp:SqlDataSource ID="cite3" runat="server" ConnectionString="<%$ ConnectionStrings:StudentOrientationConnectionString %>"
            SelectCommand="Select  a.UserName,a.LastName,a.FirstName, d.DeptName,s.StartDate, s.EndDate,(SUM(Score*100/MaxScore)/10) as Score
                           from [Answer],[User] As a
                           LEFT JOIN [Department] As d ON d.DeptID = a.DeptID
                           LEFT JOIN [StudentEmployee] As s ON s.UserID = a.UserID
                           Where a.UserID = [Answer].UserID
                           group by a.UserName,a.LastName,a.FirstName, d.DeptName, s.StartDate, s.EndDate"></asp:SqlDataSource></div>
         <div style="height: 680px; width: 880px; position: absolute; top: 126px; left: 275px;overflow-y: auto; 
            opacity: 0.9; filter: alpha(opacity=40); background-color: Black; border: 5px solid DarkOliveGreen;            border-radius: 16px;">
           <div style="position: absolute; top: 63px; left: 33px; height: 346px; width: 563px;">
                <asp:GridView ID="DataGrid_Supervisor"  AllowPaging="True" CellPadding="4" GridLines="None"
                    AutoGenerateColumns="False" DataSourceID="cite3" runat="server" AllowSorting="True"
                    OnRowDataBound="GridView1_RowDataBound" ForeColor="#333333" PageSize="15" Width="817px" Font-Size="14px"
                     OnPageIndexChanging="GridViewScores_NextPage" OnSorting="GridViewScores_Sorting">
                   
                    <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" HorizontalAlign="Left"/>
                    <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" />
                    <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Left" />
                    <AlternatingRowStyle BackColor="White" HorizontalAlign="Left"/>
                    <RowStyle HorizontalAlign="Left" />
                    <Columns>
                        <asp:BoundField HeaderText="LastName" DataField="LastName" SortExpression="LastName" ItemStyle-HorizontalAlign="Left">
                        </asp:BoundField>
                        <asp:BoundField HeaderText="FirstName" DataField="FirstName" SortExpression="FirstName" ItemStyle-HorizontalAlign="Left">
                            
                        </asp:BoundField>
                        <asp:BoundField HeaderText="UserName" DataField="UserName" SortExpression="UserName" ItemStyle-HorizontalAlign="Left"
                            DataFormatString="{0:d}">
                           
                        </asp:BoundField>
                        <asp:BoundField HeaderText="Department" DataField="DeptName" SortExpression="DeptName" DataFormatString="{0:d}"
                            ItemStyle-Width="1000px" ItemStyle-HorizontalAlign="Center">
                            
                        </asp:BoundField>
                        <asp:BoundField HeaderText="Start-Date" DataField="StartDate" SortExpression="StartDate" DataFormatString="{0:d}"
                            ItemStyle-Width="200px" ItemStyle-HorizontalAlign="center">
                           
                        </asp:BoundField>
                        <asp:BoundField HeaderText="End-Date" DataField="EndDate" SortExpression="EndDate" DataFormatString="{0:d}"
                            ItemStyle-Width="200px" ItemStyle-HorizontalAlign="center">
                           
                        </asp:BoundField>
                       
                        <asp:TemplateField HeaderText="Score" SortExpression="Score" ItemStyle-HorizontalAlign="Right">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Score") %>'>
                                </asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("Score", "{0:d}") %>'>
                                </asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <SelectedRowStyle ForeColor="#333333" Font-Bold="True" BackColor="#C5BBAF"></SelectedRowStyle>
                    <RowStyle BackColor="#E3EAEB" HorizontalAlign="Left"></RowStyle>
                    <SortedAscendingCellStyle BackColor="#F8FAFA" />
                    <SortedAscendingHeaderStyle BackColor="#246B61" />
                    <SortedDescendingCellStyle BackColor="#D4DFE1" />
                    <SortedDescendingHeaderStyle BackColor="#15524A" />
                </asp:GridView>
               
                <asp:Button ID="exportButton" runat="server" OnClick="BtnExport_Click" Text="Export to Excel" /> &nbsp&nbsp&nbsp&nbsp&nbsp

                <asp:Button ID="deleteGuestData" runat="server" OnClick="DeleteGuestData" Text="Delete Guest Data" />

              
                   
          </div>

          <div 
                
                style="position:absolute; padding: 5px 0 0 0 ; background-color:Orange; background-position:center;  
                border-top-left-radius: 10px 10px;
                border-bottom-right-radius: 10px 10px;
                border-top-right-radius: 10px 10px;
                border-bottom-left-radius: 10px 10px; top: 20px; bottom:10px; left: 120px; width: 650px; height: 27px; text-align:center"><asp:Label ID="LabelOverGrid" runat="server"  Text="Student Employees who have completed the Online Orientation"></asp:Label></div>
        </div>
       <div style="position: absolute; top: 124px; left: 10px; width: 220px; height: 660px;
            opacity: 0.9; filter: alpha(opacity=40); background-color: Black; border: 5px solid DarkOliveGreen;
            border-radius: 16px;  padding:20px 0px 0px 30px">

            <div style="padding:5px 0 0 0 ; background-color:Orange; background-position:center;  border-top-left-radius: 10px 10px;
                    border-bottom-right-radius: 10px 10px;border-top-right-radius: 10px 10px; border-bottom-left-radius: 10px 10px; top: 15px; left: 44px; 
                    width: 193px; height: 27px; bottom: 643px; 
                    text-align:center"><asp:Label ID="LabelOverSearchBox" runat="server" Text="Search Log of Students"></asp:Label>
            </div>
           
          <div style="position: absolute; top: 59px; left: 36px; width: 210px; height: 420px;">
        <table style="width: 200px; height: auto">
            <tr>
                <td>
                    <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="true" OnSelectedIndexChanged="DropDownChange">
                    </asp:DropDownList>
                    
                </td>
            </tr>
            <tr>
                <td style="padding-top: 10px">
                    <asp:TextBox ID="SearchTextBox" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    
                    <asp:DropDownList ID="searchDepartment" runat="server" Width="200" Visible="false">
                    </asp:DropDownList>
                    
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="StartDateLbl" runat="server" Text="StartDate: " class="StartDateBtnClass"
                        Visible="false"></asp:Label>
                    <asp:TextBox ID="startDate" runat="server" Visible="false" OnTextChanged="startDate_TextChanged"
                        AutoPostBack="true"></asp:TextBox>
                    <asp:ImageButton ID="CalenderImageButton" runat="server" ImageUrl="~/img/CalenderIcon.jpg"
                        Visible="False" OnClick="Calender_Click" Width="25px" />
                    
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="EndDateLbl" runat="server" Text="EndDate: " class="StartDateBtnClass"
                        Visible="false"></asp:Label>
                    <asp:TextBox ID="endDate" runat="server" Visible="false" AutoPostBack="true"></asp:TextBox>
                    <asp:ImageButton ID="EndDateimageButton" runat="server" Visible="False" ImageUrl="~/img/CalenderIcon.jpg"
                        Width="25px" OnClick="EndDateCalender_Click" />
            <br /><br />
                </td>
            </tr>
            
            <tr>
                <td>
                    <asp:Button ID="searchBTN" runat="server" OnClick="searchBTN_Click" Text="Search" />
                    <asp:Button ID="showAllBTN" runat="server" Text="Show All" OnClick="ShowAllFunction" />
                </td>
            </tr>
        </table>
        <div style="position: absolute; top: 474px; left: 19px; height: 32px; width: 217px;">
            <asp:Button ID="orientationButton" runat="server" Text="Orientation" PostBackUrl="Orientation.aspx" />
        </div>
    </div>
            <%--<div id="datepicker" style="position:absolute; top: 242px; left: 4px;"> --%>   
           <div style="position:absolute; top: 303px; left: 29px;" >
               <asp:Calendar ID="StartDateCalender" runat="server" BackColor="White"
                BorderColor="#999999" CellPadding="4" DayNameFormat="Shortest" 
                Font-Names="Verdana" Font-Size="8pt"  ForeColor="Black" Height="180px" 
                Width="200px" Visible="false" 
                onSelectionChanged="StartDateCalender_SelectionChanged">
                  
                <DayHeaderStyle BackColor="#CCCCCC" Font-Bold="True" Font-Size="7pt" />
                <NextPrevStyle VerticalAlign="Bottom" />
                <OtherMonthDayStyle ForeColor="#808080" />
                <SelectedDayStyle BackColor="#666666" Font-Bold="True" ForeColor="White" />
                <SelectorStyle BackColor="#CCCCCC" />
                <TitleStyle BackColor="#999999" BorderColor="Black" Font-Bold="True" />
                <TodayDayStyle BackColor="#CCCCCC" ForeColor="Black" />
                <WeekendDayStyle BackColor="#FFFFCC" />
            </asp:Calendar>

            </div>
               <div style="position:absolute; top: 303px; left: 29px;" >
               <asp:Calendar ID="EndDateCalender" runat="server" BackColor="White"
                BorderColor="#999999" CellPadding="4" DayNameFormat="Shortest" 
                Font-Names="Verdana" Font-Size="8pt"  ForeColor="Black" Height="180px" 
                Width="200px" Visible="false" 
                onSelectionChanged="EndateCalender_SelectionChanged">
                  
                <DayHeaderStyle BackColor="#CCCCCC" Font-Bold="True" Font-Size="7pt" />
                <NextPrevStyle VerticalAlign="Bottom" />
                <OtherMonthDayStyle ForeColor="#808080" />
                <SelectedDayStyle BackColor="#666666" Font-Bold="True" ForeColor="White" />
                <SelectorStyle BackColor="#CCCCCC" />
                <TitleStyle BackColor="#999999" BorderColor="Black" Font-Bold="True" />
                <TodayDayStyle BackColor="#CCCCCC" ForeColor="Black" />
                <WeekendDayStyle BackColor="#FFFFCC" />
            </asp:Calendar>

            </div>
            <%--<div id="enddatePicker"style="position:absolute; top: 242px; left: 10px;" >--%>
               </div>
            
    </form>
</body>
</html>
