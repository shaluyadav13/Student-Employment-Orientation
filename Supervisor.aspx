<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Supervisor.aspx.cs" Inherits="StudentOrientation.Supervisor" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Student Employee Orientation - Supervisor</title>
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
    <script type="text/javascript" language="javascript">
        $(document).ready(function () {
            $("#accordion").accordion({
                collapsible: true,                
                autoHeight:false,
                active: false
            });
        });
    </script>
    <script type="text/javascript">
        $("#logoutBTN").click(function () {
            window.history.forward(1);
        });
        
    </script>
    <style type="text/css">
        #map
        {
            width: 953px;
        }
        
        .style3
        {
            width: 65px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div id="header" style="width:98%;">
        <table id="progress" style="width: 100%; top: 0px">
            <tr>
                <td class="style3">
                    <img style="z-index: 999" src="img/NWLogoWhite.png" />
                </td>
                <td style="text-align: left">
                    <h3>
                        Student Employee Orientation
                    </h3>
                </td>
                <td align="right">
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
    </tr> </table> </div>
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <div id="page">
        <table>
            <tr>
                <td class="style1">
                    <div class="infobox leftNav">
                        <div class="menu">
                            <div id="accordion" runat="server">
                                <h3>
                                    <a href="#">Introduction</a></h3>
                                <div class="navInfo">
                                    <ol>
                                        <li id="introductionLesson" class="available">Lesson - Welcome to Employee Orientation!</li>
                                        <li id="introductionActivity" class="available"><a>Activity - Opinion Survey</a></li>
                                    </ol>
                                </div>
                                <h3>
                                    <a id="work" href="">Work Habits and Attitudes</a></h3>
                                <div class="navInfo">
                                    <ol>
                                        <li class="available"><a id="workHabits">Lesson - Work Habits</a></li>
                                        <li class="available">Activity - Unimplemented</li>
                                    </ol>
                                </div>
                                <h3>
                                    <a href="">Federal Work Study</a></h3>
                                <div class="navInfo">
                                    <ol>
                                        <li class="available">Lesson - Federal Work Study and You</li>
                                        <li class="locked"><a id="fedWorkStudyActivity">Activity - Take Assessment</a></li>
                                    </ol>
                                </div>
                                <h3>
                                    <a href="">Policies and Procedures</a></h3>
                                <div class="navInfo">
                                    <ol>
                                        <li><a id="policiesActivity">Take Assessment</a></li>
                                    </ol>
                                </div>
                                <h3>
                                    <a href="#">Worker's Compensation</a></h3>
                                <div class="navInfo">
                                    <ol>
                                        <li><a id="workmansCompActivity">Take Assessment</a></li>
                                    </ol>
                                </div>
                                <h3>
                                    <a href="#">Compensation</a></h3>
                                <div class="navInfo">
                                    <ol>
                                        <li><a id="compensationActivity">Take Assessment</a></li>
                                    </ol>
                                </div>
                                <h3>
                                    <a href="#">Confidentiality</a></h3>
                                <div class="navInfo">
                                    <ol>
                                        <li><a id="confidentialityActivity">Take Assessment</a></li>
                                    </ol>
                                </div>
                                <h3>
                                    <a href="#">Career Pathing</a></h3>
                                <div class="navInfo">
                                    <ol>
                                        <li><a id="careerPathingActivity">Take Assessment</a></li>
                                    </ol>
                                </div>
                                <h3>
                                    <a href="#">Events</a></h3>
                                <div class="navInfo">
                                    <ol>
                                        <li class="available"><a id="eventsLink">Lesson -Events</a></li>
                                        <li class="available">Activity - Unimplemented</li>
                                    </ol>
                                </div>
                                <h3>
                                    <a href="#">Offices</a></h3>
                                <div class="navInfo">
                                    <ol>
                                        <li class="available"><a id="officesLink">Lesson - Offices</a></li>
                                        <li class="available">Activity - Unimplemented</li>
                                    </ol>
                                </div>
                            </div>
                        </div>
                    </div>
                </td>
    </div>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#map').flash({
                src: 'flash/map.swf',
                width: 640,
                height: 480,
                wmode: "transparent"
            });
        }); 
    </script>
    <td>
        <div id="map">
            <div style="position: absolute; top: 166px; left: 8px; height: 571px; width: 993px;
                opacity: 0.9; filter: alpha(opacity=40); background-color: Black; border: 5px solid DarkOliveGreen;
                border-radius: 16px;" align="center">
                <div style="height: 629px">
                    &nbsp;
                    <script type="text/javascript">
                        $(document).ready(function () {
                            $('#buttons').flash({
                                src: 'flash/SupervisorPage.swf',
                                width: 640,
                                height: 480,
                                wmode: "transparent"
                            });
                        }); 
                    </script>
                    <div style="position: absolute; top: 25px; left: 233px; width: 461px; height: 158px;"
                        id="buttons">

                        
                        <%-- <input type=button onClick="parent.location='Scores.aspx'" value='Log' 
                    style="height: 82px; width: 140px; margin-left: 0px; background-color:Orange; ">
            <input type=button onClick="parent.location='Orientation.aspx'" value='Orientation' 
                    style="height: 81px; width: 140px">--%>
                    </div>
                </div>
            </div>
        </div>
    </td>
    </tr> </table> </table>
    </form>
</body>
</html>
