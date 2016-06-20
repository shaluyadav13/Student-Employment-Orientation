<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="activity.aspx.cs" Inherits="StudentOrientation.Modules.Offices.activity" %>

<script language="javascript" type="text/javascript" for="MyWinControl" event="onclick">
// <![CDATA[
return MyWinControl_onclick()
// ]]>
</script>
<script language="javascript" type="text/javascript" for="MyWinControl" event="onclick">
// <![CDATA[
return MyWinControl_onclick()
// ]]>
</script>
<% if (!DidComplete(MODULE_TITLE))
   { %>

   <script type="text/javascript">
       (function () { function f(a, b) { if (b) for (var c in b) if (b.hasOwnProperty(c)) a[c] = b[c]; return a } function l(a, b) { var c = []; for (var d in a) if (a.hasOwnProperty(d)) c[d] = b(a[d]); return c } function m(a, b, c) { if (e.isSupported(b.version)) a.innerHTML = e.getHTML(b, c); else if (b.expressInstall && e.isSupported([6, 65])) a.innerHTML = e.getHTML(f(b, { src: b.expressInstall }), { MMredirectURL: location.href, MMplayerType: "PlugIn", MMdoctitle: document.title }); else { if (!a.innerHTML.replace(/\s/g, "")) { a.innerHTML = "<h2>Flash version " + b.version + " or greater is required</h2><h3>" + (g[0] > 0 ? "Your version is " + g : "You have no flash plugin installed") + "</h3>" + (a.tagName == "A" ? "<p>Click here to download latest version</p>" : "<p>Download latest version from <a href='" + k + "'>here</a></p>"); if (a.tagName == "A") a.onclick = function () { location.href = k } } if (b.onFail) { var d = b.onFail.call(this); if (typeof d == "string") a.innerHTML = d } } if (i) window[b.id] = document.getElementById(b.id); f(this, { getRoot: function () { return a }, getOptions: function () { return b }, getConf: function () { return c }, getApi: function () { return a.firstChild } }) } var i = document.all, k = "http://www.adobe.com/go/getflashplayer", n = typeof jQuery == "function", o = /(\d+)[^\d]+(\d+)[^\d]*(\d*)/, j = { width: "100%", height: "100%", id: "_" + ("" + Math.random()).slice(9), allowfullscreen: true, allowscriptaccess: "always", quality: "high", version: [3, 0], onFail: null, expressInstall: null, w3c: false, cachebusting: false }; window.attachEvent && window.attachEvent("onbeforeunload", function () { __flash_unloadHandler = function () { }; __flash_savedUnloadHandler = function () { } }); window.flashembed = function (a, b, c) { if (typeof a == "string") a = document.getElementById(a.replace("#", "")); if (a) { if (typeof b == "string") b = { src: b }; return new m(a, f(f({}, j), b), c) } }; var e = f(window.flashembed, { conf: j, getVersion: function () { var a, b; try { b = navigator.plugins["Shockwave Flash"].description.slice(16) } catch (c) { try { b = (a = new ActiveXObject("ShockwaveFlash.ShockwaveFlash.7")) && a.GetVariable("$version") } catch (d) { try { b = (a = new ActiveXObject("ShockwaveFlash.ShockwaveFlash.6")) && a.GetVariable("$version") } catch (h) { } } } return (b = o.exec(b)) ? [b[1], b[3]] : [0, 0] }, asString: function (a) { if (a === null || a === undefined) return null; var b = typeof a; if (b == "object" && a.push) b = "array"; switch (b) { case "string": a = a.replace(new RegExp('(["\\\\])', "g"), "\\$1"); a = a.replace(/^\s?(\d+\.?\d+)%/, "$1pct"); return '"' + a + '"'; case "array": return "[" + l(a, function (d) { return e.asString(d) }).join(",") + "]"; case "function": return '"function()"'; case "object": b = []; for (var c in a) a.hasOwnProperty(c) && b.push('"' + c + '":' + e.asString(a[c])); return "{" + b.join(",") + "}" } return String(a).replace(/\s/g, " ").replace(/\'/g, '"') }, getHTML: function (a, b) { a = f({}, a); var c = '<object width="' + a.width + '" height="' + a.height + '" id="' + a.id + '" name="' + a.id + '"'; if (a.cachebusting) a.src += (a.src.indexOf("?") != -1 ? "&" : "?") + Math.random(); c += a.w3c || !i ? ' data="' + a.src + '" type="application/x-shockwave-flash"' : ' classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"'; c += ">"; if (a.w3c || i) c += '<param name="movie" value="' + a.src + '" />'; a.width = a.height = a.id = a.w3c = a.src = null; a.onFail = a.version = a.expressInstall = null; for (var d in a) if (a[d]) c += '<param name="' + d + '" value="' + a[d] + '" />'; a = ""; if (b) { for (var h in b) if (b[h]) { d = b[h]; a += h + "=" + (/function|object/.test(typeof d) ? e.asString(d) : d) + "&" } a = a.slice(0, -1); c += '<param name="flashvars" value=\'' + a + "' />" } c += "</object>"; return c }, isSupported: function (a) { return g[0] > a[0] || g[0] == a[0] && g[1] >= a[1] } }), g = e.getVersion(); if (n) { jQuery.tools = jQuery.tools || { version: "1.2.4" }; jQuery.tools.flashembed = { conf: j }; jQuery.fn.flashembed = function (a, b) { return this.each(function () { $(this).data("flashembed", flashembed(this, a, b)) }) } } })();  </script>
<script type="text/javascript">
    function openWindow(url) {
        window.open(url, '', 'scrollbars=yes,menubar=no,height=600,width=800,resizable=yes,toolbar=no,location=no,status=no');
    }
</script>
<script type="text/javascript" language="javascript">
    $(document).ready(function () {
        $.ajaxSetup({ cache: false });
        $("#FlashInsert1").hide();
        $("#submitButton").hide();
        $("#additionalResourcesOffices").dialog({ autoOpen: false, title: 'Resources', minWidth: 500, show: 'fade', hide: 'fade' });
        $("#Officestranscript").dialog({ autoOpen: false, title: 'Video Transcript', minWidht: 500, width: 500, height: 500, show: 'fade', hide: 'fade' });
        $("#ModuleStatusComplete_Offices").dialog({ autoOpen: false, title: 'Submit Report', minWidth: 500, show: 'fade', hide: 'fade' });
        $("#ModuleStatusIncomplete_Offices").dialog({ autoOpen: false, title: 'Submit Report', minWidth: 500, show: 'fade', hide: 'fade' });

        //On click code for displaying the resources transcript
        $(document).ready(function () {
            $("#additionalResourcesButton").click(function () {
                $("#additionalResourcesOffices").dialog("open");
            });

            $("#Officetranscripts").click(function () {
                $("#Officestranscript").dialog("open");
            });
        });

        $("input:button").button();
        $("input:submit").button();
        $("input:submit").click(function () {
            updateProgress();
            $.get('Modules/progress.aspx', function (data) {
                progress = jQuery.parseJSON(data);
                completedModules = 0;
                moduleCount = 0;
                /* the following block of code could be moved to
                the deferred action collection class as member functions.
                Who wants to do that? Anyone? */
                for (var title in progress) {
                    if (progress.hasOwnProperty(title)) {
                        if (progress[title].moduleCompleted) {
                            completedModules++;
                        }
                        moduleCount++;
                    }
                }
                changeProgress((completedModules / moduleCount) * 100);

                /*-----*/
                //                alert(progress["Events"].moduleCompleted);
                if (progress["Offices"].moduleCompleted) {
                    $("#ModuleStatusComplete_Offices").dialog("open");
                } else {
                    $("#ModuleStatusIncomplete_Offices").dialog("open");
                }
            });
            $("#module").hide("slow").empty();

        });

    });
    
</script>
<script type="text/javascript">
    $(document).bind("touchmove", function (event) {
        event.preventDefault();
    });
</script>
<script type="text/javascript">

    function SendMessageToWinControl() {
        var winCtrl = document.getElementById("MyWinControl");
    }        

</script>
<script type="text/javascript">
#FlashInsert1{
}
</script>
<script type="text/javascript">
    $(function () {
        $("#tabs").tabs({ fx: { opacity: 'toggle' }, selected: $("#selectedIndex").val() });
    });
</script>
<div id="tabs">
    <ul>
        <li><a href="#tabs-1">Lesson</a></li>
        <li><a href="#tabs-2">Activity</a></li>
    </ul>
    <div id="tabs-1" style="text-align: center">
        <script type="text/javascript">
            jwplayer("videoContainer").setup({
                flashplayer: "jwplayer/player.swf",
                file: "flash/Offices.flv", //"http://cite.nwmissouri.edu/SE_Orientation/Flash/offices.flv",
                width: 640,
                height: 360,
                skin: "jwplayer/skins/glow.zip",
                events: {
                    onComplete: function (event) {
                        $("#tabs").tabs('option', 'selected', 1)
                    }
                }
            });
            function MyWinControl_onclick() {

            }

            //            function MyWinControl_onclick() {

            //            }
        </script>
        <div id="videoContainer">
            Loading the player...</div>
        <br />
        <input id="additionalResourcesButton" type="button" value="Resources" />
    </div>
    <div id="tabs-2" onclick="SendMessageToWinControl()">
        <%--<asp:placeholder runat="server" id="FlashInsert"></asp:placeholder>--%>
        <div align="center">
            <div id="FlashInsert1" runat="server">
            </div>
            <%--<div>
            <button 
            </div>--%>
            <div align="center" style="z-index: 5000">
                <br />
                <%--&nbsp;&nbsp;&nbsp;&nbsp;--%>
                <div id="instructions" style="text-align: justify" runat="server">
                    > This activity holds a map of the Administration Building.<br />
                    > Find the location of the office given in the top textbox, by clicking it on the map.<br />
                    > Switch floors as neccessary to find the correct location.<br />
                    > Submit when you are done.
                </div>
            </div>
            <input type="button" id="startgame" runat="server" value="Start Activity" />
            <script type="text/javascript">
                $("#startgame").click(function () {
                    $("#FlashInsert1").show("fast");
                    $("#startgame").hide();
                    $("#instructions").hide();
                    $("#submitButton").show("fast");
                });
            </script>
            <input style="text-align: center" class="submit" type="submit" value="Submit" id="submitButton" runat="server" />
            <div id="flash">
            </div>
        </div>
        <div id="ModuleStatusComplete_Offices">
            <div class="conversions">
                You have successfully completed the module</div>
        </div>
        <div id="ModuleStatusIncomplete_Offices">
            <div class="conversions">
                You have not successfully completed the module. Please retake the module</div>
        </div>
        <div id="additionalResourcesOffices">
            <div class="conversions">
                <a href="javascript:openWindow('http://www.nwmissouri.edu/hr/student/')">Student Employment Website
                </a>
            </div>
            <a href="#" id="Officetranscripts">Video Transcript</a>
        </div>
        <div id="Officestranscript">
            <strong>Kelsi:</strong><p>
                There are five offices that can provide assistance throughout your student employment
                experience based on your need. All of these offices are located in the Administration
                building.</p>
            <strong>Jordan:</strong><p>
                The Student Employment Program is located in the Office of Human Resources Management,
                room 125, and can be of assistance to address specific issues regarding: employment
                policies, compensation, training and recognition.</p>
            <strong>Kelsi:</strong><p>
                Office of Financial Assistance, room273, can be of assistance to address specific
                issues regarding: Federal Work-Study eligibility and awards.</p>
            <strong>Jordan:</strong><p>
                The Office of Career Services, room 130, can be of assistance to address specific
                issues regarding: interviewing skills, resume writing and future or present job
                tips.</p>
            <strong>Kelsi:</strong><p>
                The Equal Employment Opportunity (EEO) Officer, room 125, can be of assistance to
                address specific issues regarding: EEO compliance and sexual harassment.</p>
            <strong>Jordan:</strong><p>
                Another great resource is the website for the Student Employment Program. Watch
                now as Paula McLain, Coordinator of Student Employment, gives us a tour.</p>
            <strong>Paula:</strong><p>
                An overview of the Student Employment Program can best be referenced by the website.
                The Student Employment website is located at the following link:<br />
                <a href="http://www.nwmissouri.edu/hr/student">www.nwmissouri.edu/hr/student</a><br />
                The website includes information in the following areas:<br />
                “About Student Employment” – Provides general information about Student Employment:
                who can work on campus; frequently asked questions; federal work study information;
                & the most current revision of the Student Employment Handbook<br />
                “How Do I Get a Job” – Provides general information on job searching tips and referrals
                for assistance on resume writing and interviewing skills<br />
                “Job Postings” – A list of available student employment positions<br />
                “Career Pathing Program” – Information about the program and current personal and
                professional development opportunities<br />
                “Payroll” – Information for contacting the Payroll Office as well as a list of monthly
                pay dates<br />
                “Human Resources” – A direct link to the Northwest Human Resources Management website</p>
        </div>
    </div>
    <% }
   else
   { %>
    This activity is completed.
    <% } %>
