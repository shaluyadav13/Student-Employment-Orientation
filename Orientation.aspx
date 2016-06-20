<%@ Page Title="" Language="C#" AutoEventWireup="true" CodeBehind="Orientation.aspx.cs"
    Inherits="StudentOrientation.Orientation" %>

<html>
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=9" />
    <title>Student Orientation</title>
    <link rel="stylesheet" href="js/jquery.jgrowl.css" type="text/css" />
    <link rel="stylesheet" href="Layout/CSS/ui-darkness/jquery-ui-1.8.10.custom.css"
        type="text/css" />
    <link href="Layout/CSS/orientation.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="Layout/CSS/master.css" type="text/css" />
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script type="text/javascript">
        window.history.forward(1);
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            $.ajaxSetup({ cache: false });
        });
    </script>
    <style>
        #DeptName {
            border-radius: 5px;
        }

        #btnToOrientation {
            background-color: #F7941D;
            padding: 4px;
            font-size: 17px;
            border: none;
            color: white;
        }

        #editDept_lbl {
            background-color: #F7941D;
            padding: 4px;
            font-size: 17px;
            border: none;
            color: white;
        }
    </style>
</head>
<body id="bg">
    <form id="form1" runat="server">
        <div id="header" style="width: 100%; top: -10px">
            <img style="z-index: 999; float: left" src="img/NWLogoWhite.png" />
            <h3>Student Employee Orientation
                <asp:Button ID="logoutBTN" runat="server" Style="float: right" OnClick="logoutBTN_Click" />
            </h3>
        </div>
        <div id="page" runat="server" style="width: 100%; height: 100%">
            <!--TEMP MAP CODE -->
            <br />
            <br />
            <br />
            <br />
            <br />
            <br />
            <div class="row">
                <div class="col-sm-4"></div>
                <div class="col-sm-4" style="width: 500px;">
                    <div class="well-lg">
                        <h1 style="height: 10px; text-align: center; color: black">Welcome
                            <% Response.Write(Session["Name"]); %></h1>
                    </div>
                </div>
                <div class="col-sm-4"></div>
            </div>
            <div class="row" style="display: block; margin-left: auto; margin-right: auto; position: relative; top: 30px">
                <div class="col-sm-4"></div>
                <div class="col-sm-4" style="/*background-color: #006848*/height: 400px; width: 500px; border: 2px solid black;">
                    <div class="row">
                        <div class="col-sm-1"></div>
                        <div class="col-sm-10">
                            <br />
                            <br />
                            <br />
                            <h4 style="color: grey">Select or edit the department you were hired by from the dropdown box below. If you don't know please ask your supervisor.</h4>

                            <br />
                            <br />
                            <asp:TextBox ID="DeptName" runat="server" Width="200px" Enabled="False"></asp:TextBox><br />
                            <br />
                            <asp:Button ID="editDept_lbl" runat="server" Text="Select Or Edit Department" OnClick="Dropdownshow" />
                            <asp:DropDownList ID="DeptList1" runat="server" Width="400px" AutoPostBack="true"
                                OnTextChanged="SelectedDept" Visible="false">
                            </asp:DropDownList>
                            <br />
                            <br />
                            <asp:Button runat="server" ID="btnToOrientation" Text="Start Orientation" OnClick="btnToOrientation_Click" />
                        </div>
                    </div>
                </div>

                <div class="col-sm-4"></div>
            </div>
            <br />
            <br />
        </div>

        <!-- End Page Div -->
        <div id="footer" style="width: 100%; height: 80px">
            <p id="copyright" style="text-align: center">
                &#169; 2010 Northwest Missouri State University. All rights reserved.
            </p>
        </div>
        <script src="jwplayer/jwplayer.js" type="text/javascript"></script>
    </form>
</body>
</html>
