<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TestPage.aspx.cs" Inherits="StudentOrientation.TestPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script> 
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:TextBox runat="server" CssClass="lblIn"></asp:TextBox>
            <button type="button" id="sendData" >Send Data</button>

        </div>
    </form>
    <script>
        $("#sendData").click(function () {
            var id = $(".lblIn").val();
            alert(id);
            $.ajax({
                type: "POST",
                url: "TestPage.aspx/SendData",
                contentType: "application/json; charset=utf-8",
                data: '{"requestNo":"' + id + '"}',
                dataType: "json",
                success: function (data) { alert(data.d) },
                error: function (data) { alert("failed") }
            });
        });
    </script>
</body>
</html>
