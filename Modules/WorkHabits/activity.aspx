<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="activity.aspx.cs" Inherits="StudentOrientation.Modules.WorkHabits.activity" %>

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
<script src="../../js/jquery-1.4.4.js" type="text/javascript"></script>
<script src="../../js/jquery-1.3.2.min.js" type="text/javascript"></script>
<script type="text/javascript">
    (function () { function f(a, b) { if (b) for (var c in b) if (b.hasOwnProperty(c)) a[c] = b[c]; return a } function l(a, b) { var c = []; for (var d in a) if (a.hasOwnProperty(d)) c[d] = b(a[d]); return c } function m(a, b, c) { if (e.isSupported(b.version)) a.innerHTML = e.getHTML(b, c); else if (b.expressInstall && e.isSupported([6, 65])) a.innerHTML = e.getHTML(f(b, { src: b.expressInstall }), { MMredirectURL: location.href, MMplayerType: "PlugIn", MMdoctitle: document.title }); else { if (!a.innerHTML.replace(/\s/g, "")) { a.innerHTML = "<h2>Flash version " + b.version + " or greater is required</h2><h3>" + (g[0] > 0 ? "Your version is " + g : "You have no flash plugin installed") + "</h3>" + (a.tagName == "A" ? "<p>Click here to download latest version</p>" : "<p>Download latest version from <a href='" + k + "'>here</a></p>"); if (a.tagName == "A") a.onclick = function () { location.href = k } } if (b.onFail) { var d = b.onFail.call(this); if (typeof d == "string") a.innerHTML = d } } if (i) window[b.id] = document.getElementById(b.id); f(this, { getRoot: function () { return a }, getOptions: function () { return b }, getConf: function () { return c }, getApi: function () { return a.firstChild } }) } var i = document.all, k = "http://www.adobe.com/go/getflashplayer", n = typeof jQuery == "function", o = /(\d+)[^\d]+(\d+)[^\d]*(\d*)/, j = { width: "100%", height: "100%", id: "_" + ("" + Math.random()).slice(9), allowfullscreen: true, allowscriptaccess: "always", quality: "high", version: [3, 0], onFail: null, expressInstall: null, w3c: false, cachebusting: false }; window.attachEvent && window.attachEvent("onbeforeunload", function () { __flash_unloadHandler = function () { }; __flash_savedUnloadHandler = function () { } }); window.flashembed = function (a, b, c) { if (typeof a == "string") a = document.getElementById(a.replace("#", "")); if (a) { if (typeof b == "string") b = { src: b }; return new m(a, f(f({}, j), b), c) } }; var e = f(window.flashembed, { conf: j, getVersion: function () { var a, b; try { b = navigator.plugins["Shockwave Flash"].description.slice(16) } catch (c) { try { b = (a = new ActiveXObject("ShockwaveFlash.ShockwaveFlash.7")) && a.GetVariable("$version") } catch (d) { try { b = (a = new ActiveXObject("ShockwaveFlash.ShockwaveFlash.6")) && a.GetVariable("$version") } catch (h) { } } } return (b = o.exec(b)) ? [b[1], b[3]] : [0, 0] }, asString: function (a) { if (a === null || a === undefined) return null; var b = typeof a; if (b == "object" && a.push) b = "array"; switch (b) { case "string": a = a.replace(new RegExp('(["\\\\])', "g"), "\\$1"); a = a.replace(/^\s?(\d+\.?\d+)%/, "$1pct"); return '"' + a + '"'; case "array": return "[" + l(a, function (d) { return e.asString(d) }).join(",") + "]"; case "function": return '"function()"'; case "object": b = []; for (var c in a) a.hasOwnProperty(c) && b.push('"' + c + '":' + e.asString(a[c])); return "{" + b.join(",") + "}" } return String(a).replace(/\s/g, " ").replace(/\'/g, '"') }, getHTML: function (a, b) { a = f({}, a); var c = '<object width="' + a.width + '" height="' + a.height + '" id="' + a.id + '" name="' + a.id + '"'; if (a.cachebusting) a.src += (a.src.indexOf("?") != -1 ? "&" : "?") + Math.random(); c += a.w3c || !i ? ' data="' + a.src + '" type="application/x-shockwave-flash"' : ' classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"'; c += ">"; if (a.w3c || i) c += '<param name="movie" value="' + a.src + '" />'; a.width = a.height = a.id = a.w3c = a.src = null; a.onFail = a.version = a.expressInstall = null; for (var d in a) if (a[d]) c += '<param name="' + d + '" value="' + a[d] + '" />'; a = ""; if (b) { for (var h in b) if (b[h]) { d = b[h]; a += h + "=" + (/function|object/.test(typeof d) ? e.asString(d) : d) + "&" } a = a.slice(0, -1); c += '<param name="flashvars" value=\'' + a + "' />" } c += "</object>"; return c }, isSupported: function (a) { return g[0] > a[0] || g[0] == a[0] && g[1] >= a[1] } }), g = e.getVersion(); if (n) { jQuery.tools = jQuery.tools || { version: "1.2.4" }; jQuery.tools.flashembed = { conf: j }; jQuery.fn.flashembed = function (a, b) { return this.each(function () { $(this).data("flashembed", flashembed(this, a, b)) }) } } })();  </script>
<script type="text/javascript" language="javascript">
    $("#FlashInsert").hide();
    $(document).ready(function () 
    {
        $.ajaxSetup({ cache: false });

        $("#FlashInsert").hide();
        $("#submitButton").hide();
        $("#additionalResourcesWorkHabits").dialog({ autoOpen: false, title: 'Resources', minWidth: 500, show: 'fade', hide: 'fade' });
        $("#WorkHabitstranscript").dialog({ autoOpen: false, title: 'Video Transcript', minWidth: 500, width: 500, height: 500, show: 'fade', hide: 'fade' });
        $("#ModuleStatusComplete").dialog({ autoOpen: false, title: 'Submit Report', minWidth: 500, show: 'fade', hide: 'fade' });
        $("#ModuleStatusComplete1").dialog({ autoOpen: false, title: 'Submit Report', minWidth: 500, show: 'fade', hide: 'fade' });
        
        //Code for opening the transcripts while vedio playing
        $(document).ready(function () {
            $("#Worktranscripts").click(function () {
                $("#WorkHabitstranscript").dialog("open");
            });
            $("#instruction").click(function () {
                $("#instructions").dialog("open");
            });
        });

        $("#additionalResourcesButton").click(function () {
            $("#additionalResourcesWorkHabits").dialog("open");
        });
        $(function () {
            $("#sortable").sortable({
                placeholder: "ui-state-highlight",
                containment: "#boundBox",
                tolerance: "intersect",
                axis: 'y',
                update: function (event, ui) {
                    $('#sortable > li:even').animate({ backgroundColor: "#6b6bd4" }, 1000);
                    $('#sortable > li:odd').animate({ backgroundColor: "#7f7fe5" }, 1000);
                },
                change: function (event, ui) {
                    $(ui.item).fadeTo(200, 0.8);
                }
            });
            $("#sortable").disableSelection();
        });
        $('#sortable > li:even').css("background-color", "#6b6bd4");
        $('#sortable > li:odd').css("background-color", "#7f7fe5");

        $("input:submit").button();
        $("input:button").button();
        $("input:submit").click(function ()
         {
            var array = $("#sortable").sortable("toArray");
            $("#module").fadeOut("slow").empty();
            $(".modal").fadeOut("slow");
            updateProgress();
            $.get('Modules/progress.aspx', function (data)
            {
                progress = jQuery.parseJSON(data);
                completedModules = 0;
                moduleCount = 0;
                /* the following block of code could be moved to
                the deferred action collection class as member functions.
                Who wants to do that? Anyone? */
                for (var title in progress)
                 {
                     if (progress.hasOwnProperty(title)) 
                    {
                        if (progress[title].moduleCompleted) 
                        {
                            completedModules++;
                        }
                        moduleCount++;
                    }
                }
                changeProgress((completedModules / moduleCount) * 100);

                /*-----*/
                // alert(progress["Events"].moduleCompleted);
                if (progress["Work Habits and Attitudes"].moduleCompleted) 
                {
                    $("#ModuleStatusComplete").dialog("open");
                }
                else
                {
                    //progress["Work Habits and Attitudes"].moduleCompleted;
                    $("#ModuleStatusComplete1").dialog("open");
                    //completedModules++;
                    //moduleCount++;
                    //changeProgress((completedModules / moduleCount) * 100);
                }
            });
        });
    });
</script>
<script type="text/javascript">
    $("#tabs1").click(function () 
    {
        $("#FlashInsert").hide();
    });
</script>
<script type="text/javascript">
    $("#tabs2").click(function () {
        $("#FlashInsert").hide();
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

<script type="text/javascript" language="javascript">
    $(function () {
        $("#tabs").tabs({ fx: { opacity: 'toggle' }, selected: $("#selectedIndex").val() });
    });
</script>
<div id="tabs">
    <ul>
        <li><a id="#tabs1" href="#tabs-1">Lesson</a></li>
        <li><a id="#tabs2" href="#tabs-2">Activity<div id="unlocked"></div></a></li>
    </ul>
    <div id="tabs-1" style="text-align: center">
        <script type="text/javascript">
            jwplayer("videoContainer").setup({
                flashplayer: "jwplayer/player.swf",
                file: "flash/workhabits.flv", //"http://cite.nwmissouri.edu/SE_Orientation/Flash/workhabits.flv",
                width: 640,
                height: 360,
                skin: "jwplayer/skins/glow.zip",
                events: {
                    onComplete: function (event)
                     {
                        $("#tabs").tabs('option', 'disabled', []) //enable all tabs.
                        $("#tabs").tabs('option', 'selected', 1) //go to the activity tab
                        //Inform the server that the student has finished watching the video.
                        $('#locked').attr('id', '#unlocked');
                    }
                }
            });
            function MyWinControl_onclick() {

            }

        </script>
        <div id="videoContainer">
            Loading the player...</div>
        <br />
        <input id="additionalResourcesButton" type="button" value="Resources" />
    </div>
    <div id="tabs-2">
        <div align="center">
            <%--<div id="pacman" style="z-index: 3000">
            </div>
            <script type="text/javascript">
                $(document).ready(function () {
                    $('#pacman').flash({
                        src: 'flash/Pacman.swf',
                        width: 800,
                        height: 500,
                        wmode: "transparent"
                    });
                }); 
            </script>--%>
            <%--<object classid=\"clsid:d27cdb6e-ae6d-11cf-96b8-444553540000\"" +
                               "codebase=\"http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=10,0,0,0\"" +
                               "width=\"800\"" +
                               "height=\"500\"" +
                               "align=\"middle\"" +
                               "id=\"Pacman\">" +
                               "<param name=\"allowScriptAccess\" value=\"sameDomain\" />" +
                               "<param name=\"movie\" value=\"flash/Pacman.swf\" />" +
                               "<param name=\"quality\" value=\"high\" />" +
                               "<param name=\"wmmode\" value=\"opaque\" />" +
                               "<param name=\"flashVars\" value=\"" + "UserName=" + Session["UserName"] + "\" />" +
                               "<embed src=\"flash/Pacman.swf\"" +
                               "width=\"800\"" +
                               "height=\"500\"" +
                               "autostart=\"true\"" +
                               "quality=\"high\"" +
                               "wmode=\"opaque\"" +
                               "FlashVars=\"UserName=" + Session["UserName"] + "\"" +
                               "name=\"Pacman\"" +
                               "align=\"middle\"" +
                               "allowScriptAccess=\"sameDomain\"" +
                               "type=\"application/x-shockwave-flash\"" +
                               "pluginspage=\"http://www.macromedia.com/go/getflashplayer\" />" +
                               "</object>--%>
            <div id="FlashInsert" runat="server">
            </div>
            <%--<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=10,0,0,0"
                    width="800" height="500" align="middle" id="Pacman">
                    <param name="allowScriptAccess" value="sameDomain" />
                    <param name="movie" value="falsh/Pacman.swf" />
                    <param name="quality" value="high" />
                    <param name="wmode" value="transparent" />
                    <%--<embed src="flash/Pacman.swf" width="800" height="500" autostart="true" quality="high"
                        wmode="transparent" name="Pacman" align="middle" allowscriptaccess="sameDomain"
                        type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer">
                </embed>--%>
            <%--<asp:placeholder id="FlashInsert" runat="server"></asp:placeholder>--%>
            <div align="center" style="z-index: 5000">
                <%--<input id="instruction" type="button" value="Instructions" /><br />--%>
                <br />
                <div id="instructions" style="text-align: justify" runat="server">
                   > This activity is a game of PAC MAN representing your Student Employment.<br/>
                   > Do your job by capturing the dots and the 'good behaviour' icons on the path.<br/>
                   > Capture blinking ghost and get a raise.<br/>
                   > Experience a warning, probation and termination if a ghost catches you in 'bad behaviour'.<br/>
                   > Game ends when dots are gone or you have been terminated.<br/>
                   > Any score is passing this activity.<br/><br/>
                    Instructions:
                    <h2>
                        Make sure to click somewhere on the screen</h2>
                    as the game begins, then use the arrow keys to move Pac Man around the course. Once
                    you are finished,<h2>
                        review
                    </h2>
                    the good and bad behaviors that you encountered.
                    <h2>
                        Submit
                    </h2>
                    your score to complete the module.
                </div>
            </div>
            <input type="button" id="startgame" runat="server" value="Start Game" />
            <script type="text/javascript">
                $("#startgame").click(function () {
                    $("#FlashInsert").show("fast");
                    $("#startgame").hide();
                    $("#instructions").hide();
                    $("#submitButton").show("fast");
                });
            </script>
            <div align="center">
                <input style="text-align: center" id="submitButton" class="submit" type="submit"
                    value="submit" />&nbsp;</div>
            <div id="flash">
            </div>
        </div>
        <div id="ModuleStatusComplete">
            <div class="conversions">
              You successfully completed the Module</div>
        </div>
        <div id="ModuleStatusComplete1">
            <div class="conversions">
                You have not successfully completed the module. Please retake the module</div>
        </div>
        <div id="additionalResourcesWorkHabits">
            <div class="conversions">
                <a href="#" id="Worktranscripts" >Video Transcript</a>
            </div>
        </div>
        <div id="WorkHabitstranscript">
           
            <strong>Kelsi:</strong>
            <p>
                When a student is hired, she/he becomes a member of a team or work group. This team
                or work group relies on student employees, as they are valuable part of University
                operations. There are basic fundamental attitudes and work habits that are expected
                of employees. Let's take a look at what some of the supervisors expect from their
                student employees.</p>
           <strong>Linda Standerford:</strong><p>
           Generally, all of our student employees at some point tutor.  We expect them to have A’s or B’s in the courses that they tutor.
           </p>
           <strong>Jackie Loghry:</strong><p>
           They must be at least a sophomore.  It can’t be their first year of college.  They must maintain a minimum 3.0 GPA.
           </p>
           <strong>Stacey Stokes:</strong><p>
           We’re looking for a variety of different things; one is going to be someone who is able to speak in front of a crowd, public speaking.
           </p>
           <strong>Kathy Howell:</strong><p>
           They need to have a really positive outlook.  They need to be ready to speak up and help students.
           </p>
           <strong>
           Danny Smith:
           </strong><p>
           We like to have our students come in with an athletic background; not necessarily mandatory, but it’s nice because that way they have an idea
            of how the field’s laid out, some of the rules, some of the different aspects of athletic events. 
            Another thing, they must be able to follow directions.  They must have worked either as a team or by themselves
           </p>
           <strong>Linda Standerford:</strong><p>
           As far as work habits, we expect excellent communication skills from our employees.  We also expect them to check their email daily. 
           A positive attitude is always helpful.  In our unit we’re very customer service focused and like our student employees to take the initiative whenever 
           possible.  We also talk about confidentiality and make sure that they understand the expectation the university has.  
           If we notice that they are having problems with tardiness or not showing up at all, and especially if they have not communicated with us that they 
           are not going to show up; if I’ve noticed two times, and especially if we’ve noticed three times there is a problem, to me this indicates that there is a 
           pattern.  I will speak with them and tell them that the behavior needs to change immediately.  When timesheets are due, and any other paperwork, 
           it has to be in on time.
           </p>
           <strong>Stacey Stokes:</strong><p>
           The first thing that we would go over is for them to be punctual.  We want to insure that they arrive to work at least five minutes early, that they’re in 
           place; they’re ready to go, ready to meet that customer, this is very important to us.  We ask that they call if they are running late to let us know that 
           they are on their way.  And then, if the student is ill, we ask that they call us as soon as they know.  
           Our discipline policy is a three strike policy.  If a student is late for work and doesn’t call us and they show up fifteen or twenty minutes late,
            they receive their first strike.  If it happens again, if they break another rule, if they show up wearing something they’re not supposed to wear, they 
            receive their second strike. Again, we would address a verbal and a written warning at that point.  If there’s a third strike or a third incidence, that 
            student has made the choice to no longer work in our office.  At that point we would part ways and begin looking for a new student and hope that the candidate 
            has learned from the choices that they’ve made and makes better choices in the future.
           </p>
            <strong>Jordan:</strong>
            <p>
                In summary, as a student employee you are expected:
                <ul>
                    <li style="text-indent:10%">To perform all the work assigned completely in a professional and satisfactory manner;</li>
                    <li style="text-indent:10%">To treat others courteously and with respect;</li>
                    <li style="text-indent:10%">To report to work promptly;</li>
                    <li style="text-indent:10%">To communicate with supervisors regarding tardiness or absences;</li>
                    <li style="text-indent:10%">To refrain from conducting personal business while working;</li>
                    <li style="text-indent:10%">To report hours worked accurately.</li>
                </ul>
             </p>
            <strong>Kelsi:</strong>
            <p>
                Your department, office or work unit may have additional policies, procedures and
                expectations that will be communicated and must be adhered to as a condition of
                employment.</p>
            <strong>Jordan:</strong>
            <p>
                Student employment is an at-will agreement and therefore not governed by a written
                contract or a labor union. Student employees may choose to transfer to another department
                or resign their position at any time for any reason.</p>
            <strong>Kelsi:</strong>
            <p>
                Supervisors may choose to end employment of student employees at any time for any
                reason. Serious misconduct shall result in immediate termination by the supervisor.
                Other disciplinary actions may be pursued depending upon the nature of the misconduct.</p>
            <strong>Jordan:</strong>
            <p>
                Serious misconduct shall include, but is not limited to, any of the following:
                <ul>
                <li text-indent="10px">
                    Theft of University property, theft of University personnel property
                    or theft of property of a University guest on University grounds;
                </li>
                <li text-indent="10px">
                    Immoral or illegal conduct;
                </li>
                <li text-indent="10px">
                    Physical fighting with any other person;
                </li>
                <li text-indent="10px">
                    Refusal to follow instructions of the supervisor or general insubordination;
                </li>
                <li text-indent="10px">
                    Willful destruction of property, equipment or materials;
                </li>
                <li text-indent="10px">
                    Reporting to work under the influence of alcohol, illegal and/or controlled substance or the consumption of these products;
                </li>
                <li text-indent="10px">
                    Any actions which endangers the safety of any person, including the safety of the employee;
                </li>
                <li text-indent="10px">
                    Knowingly falsifying University records; or
                </li>
                <li text-indent="10px">
                    Infraction of any University policy, procedure or regulation.
               </li>
               </ul>
                 Any of these will result to TERMINATION.
           </p>
        </div>
    </div>
<% }
   else
   { %>
This activity is completed.
<% } %>
