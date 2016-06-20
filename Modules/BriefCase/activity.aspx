<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="activity.aspx.cs" Inherits="StudentOrientation.Modules.BriefCase.activity" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<script type="text/javascript" language="javascript">
    $(function () {
        $("#tabs").tabs({ fx: { opacity: 'toggle' }, selected: $("#selectedIndex").val() });
        $("#tabs").tabs('option', 'disabled', [2]);

    });
</script>
<%if (ModuleCompleted("BriefCase") == 11)
  {%>
<script type="text/javascript" language="javascript">
    $("#tabs").tabs('option', 'selected', 1);
</script>
<%} %>
<body>
    <div id="tabs">
        <ul>
            <li><a href="#tabs1" id="tab1" runat="server">BriefCase</a></li>
            <li><a href="#tabs2" id="tab2" runat="server">Conclusion</a></li>
        </ul>
        <form id="form1" runat="server">
        <div id="tabs1" style="text-align: center" runat="server">
            <asp:PlaceHolder ID="FlashInsert" runat="server">
                <%-- <object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=10,0,0,0"
            width="150" height="650" id="photoGallery" align="left">
            <param name="allowScriptAccess" value="sameDomain" />
            <param name="allowFullScreen" value="false" />
            <param name="movie" value="flash/BriefcaseFinal.swf" />
            <param name="quality" value="high" />
                      
            <param name="wmode" value="transparent">
            <embed src="flash/BriefcaseFinal.swf" quality="high" bgcolor="#cdcccc" width="950" height="650"
                name="BriefcaseFinal" align="middle" allowscriptaccess="sameDomain" allowfullscreen="false"
                type="application/x-shockwave-flash" pluginspage="http://www.adobe.com/go/getflashplayer" />
        </object>--%>
            </asp:PlaceHolder>
        </div>
        <div id="tabs2" style="text-align: center" runat="server">
            <script type="text/javascript">
                jwplayer("videoContainer").setup({
                    flashplayer: "jwplayer/player.swf",
                    file: "flash/Ending.flv",
                    autostart: true,
                    width: 640,
                    height: 360,
                    skin: "jwplayer/skins/glow.zip"
                });
            </script>
            <div id="videoContainer">
                Loading the player...</div>
            <br />
        </div>
        </form>
    </div>
</body>
</html>
