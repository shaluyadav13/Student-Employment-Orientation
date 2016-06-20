<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="activity.aspx.cs" Inherits="StudentOrientation.Modules.StudentsAboutSE.activity" %>

<script type="text/javascript">
    $(function () {
        $("#tabs").tabs({ fx: { opacity: 'toggle' }, selected: $("#selectedIndex").val() });
    });
</script>
<div id="tabs" style="width:800px; height:500px;">
    <ul>
        <li><a href="#tabs-1">Students talk about Student Employement</a></li>
        <li><a href="#tabs-2">Supervisors talk about Student Employment</a></li>
    </ul>
    <div id="tabs-1" style="text-align: center">
        <div id="videoContainer">
            Loading the player...
        </div>
        <script type="text/javascript">
            jwplayer("videoContainer").setup({
                flashplayer: "jwplayer/player.swf",
                file: "flash/StudentsTalkSE.flv",//"http://cite.nwmissouri.edu/SE_Orientation/Flash/StudentsTalkSE.flv",
                width: 640,
                height: 360,
                skin: "jwplayer/skins/glow.zip",
                events: {
                    onComplete: function (event) {
                        $("#tabs").tabs('option', 'selected', 1)
                    }
                }
            });
        </script>
    </div>
    <div id="tabs-2" align="center">
    <div id="videoContainer1">
            Loading the player...
        </div>
        <script type="text/javascript">
            jwplayer("videoContainer1").setup({
                flashplayer: "jwplayer/player.swf",
                file: "flash/SupervisorsTalkSE.flv", //"http://cite3.nwmissouri.edu/SE_Orientation/Flash/SupervisorsTalkSE.flv",
                width: 640,
                height: 360,
                skin: "jwplayer/skins/glow.zip",
                events: {
                    onComplete: function (event) {
                        $("#tabs").tabs('option', 'selected', 0)
                    }
                }
            });
        </script>
    </div>
</div>
