<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="activity.aspx.cs" Inherits="Sortable.Sortable" %>

<link rel="stylesheet" href="Modules/introduction/introduction.css" />
<% if (!DidComplete(MODULE_TITLE))
   { %>
<script type="text/javascript" language="javascript">
    $(document).ready(function () {
        $.ajaxSetup({ cache: false });
        $("#additionalResourcesIntro").dialog({ autoOpen: false, cache: false, title: 'Resources', minWidth: 500, show: 'fade', hide: 'fade' });
        $("#Introductiontranscript").dialog({ autoOpen: false, title: 'Video Transcript', minWidth: 500, width: 500, height: 500, show: 'fade', hide: 'fade' });

        $(document).ready(function () {
            $("#Introtranscripts").click(function () {
                $("#Introductiontranscript").dialog("open");
            });
        });

        $("#additionalResoucesButton").click(function () {
            $("#additionalResourcesIntro").dialog("open");
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
        $("input:submit").click(function () {
            var array = $("#sortable").sortable("toArray");
            $.post("Modules/Introduction/submit.aspx", { response: array.toString() });
            updateProgress();
            $(".modal").fadeOut("slow");
            $("#module").hide("slow")
                        .empty();
        });
    });
</script>
<script type="text/javascript">
    $(function () {
        $("#tabs").tabs({
            fx: { opacity: 'toggle' },
            selected: $("#selectedIndex").val()
        });
        /*
        if there are bugs with this, it means the http request hasn't yet resolved.
        if the http request doesn't resolve in time, you need to write a function to
        defer the execution of anything that depends on progress until after the $.load, 
        deferredLoad(var callbackFunction){
        $.load(blah, function()
        callbackFunction();
        }
        ^- something like that.
        */

        //doesn't work! EEP. maybe this bit doesn't call update status?
        if (!progress["Introduction"].tutorialCompleted) {
            $("#tabs").tabs('option', 'disabled', [1]);
        }

    });

</script>
</head>
<div id="tabs" class="ui-tabs-hide">
    <ul id="selectedTabs">
        <li><a href="#tabs-1">Lesson</a></li>
        <li><a href="#tabs-2">Activity<div id="unlocked" />
        </a></li>
    </ul>
    <div id="tabs-1" style="text-align: center;">
        <script type="text/javascript">
            jwplayer("videoContainer").setup({
                flashplayer: "jwplayer/player.swf",
                file: "flash/Introduction.flv", //"http://cite.nwmissouri.edu/SE_Orientation/Flash/introduction.flv",
                width: 640,
                height: 360,
                skin: "jwplayer/skins/glow.zip",
                events: {
                    onComplete: function (event) {
                        $("#tabs").tabs('option', 'disabled', []) //enable all tabs.
                        $("#tabs").tabs('option', 'selected', 1) //go to the activity tab
                        //Inform the server that the student has finished watching the video.
                        $('#locked').attr('id', '#unlocked');
                    }
                }
            });
        </script>
        <div id="videoContainer">
            Loading the player...</div>
        <br />
        <input id="additionalResoucesButton" type="button" value="Resources" />
    </div>
    <div id="tabs-2">
        <p>
            <div class="question">
                <span class="questionText">
                    <%= question.Text%></span>
                <% if (question.isOrderedQuestion())
                   { %>
                <input class="questionType" type="hidden" value="singleAnswer" />
                <div id="boundBox">
                    <table>
                        <tr>
                            <td>
                                <!--Need to use tables because IE is uncooperative. Shocking! -->
                                <div id="scale">
                                    <em>Most Important</em>
                                    <img src="img/orderScale.png" alt="" />
                                    <em>Least Important</em>
                                </div>
                            </td>
                            <td>
                                <br />
                                <ul id="sortable" class="queue">
                                    <% //for(var optionKey in question.OptionAnswer.Keys)
                       for (int i = 0; i < question.OptionAnswer.Keys.Count; i++)
                       { %>
                                    <li id="<%=i%>" class="ui-state-default">
                                        <%= question.OptionAnswer.Keys.ElementAt(i)%></li>
                                    <% } %>
                                </ul>
                                <br />
                            </td>
                        </tr>
                    </table>
                </div>
                <div id="additionalResourcesIntro">
                    <div class="conversions">
                        <table>
                            <tr>
                                <td>
                                    <img src="img/Paula.png" alt="Paula" />
                                </td>
                                <td>
                                    <strong>Paula McLain</strong>
                                    <br />
                                    Student Employment Coordinator
                                    <br />
                                    Administration Building 125
                                    <br />
                                    660-562-1140
                                    <br />
                                    pmclain@nwmissouri.edu
                                    <br />
                                </td>
                            </tr>
                        </table>
                        <hr />
                        <a href="#" id="Introtranscripts" >Video Transcript</a>
                    </div>
                </div>
                <div id="Introductiontranscript">
                    <strong>Kelsi:</strong> Hi! I am Kelsi Franklin and I work as a Student Support
                    Services Mentor here on campus.
                    <br />
                    <strong>Jordan:</strong> Hi! I am Jordan McCrady and I work as a Student Ambassador
                    here on campus.
                    <br />
                    <strong>Kelsi:</strong> We welcome you to the Northwest Student Employment Program
                    Online Orientation.
                    <br />
                    <strong>Jordan:</strong> All new Northwest student employees are required to complete
                    the on-line orientation when starting work on campus. They also are required to
                    visit the Office of Human Resource Management, 125 Administration Building, to complete
                    an I-9 employment eligibility form, W-4 tax forms, among other required paperwork.
                    This office is located in the Administration Building, room 125, right across from
                    the Student Services Desk and is also where the Student Employment office is housed.
                    Paula McLain is the coordinator of Student Employment. If you have any questions
                    regarding this orientation, please contact Paula by phone, email, or by personally
                    visiting the office.
                    <br />
                    <br />
                    <strong>Kelsi:</strong> The purpose of this orientation is to acquaint you with
                    the many aspects of student employment, including expectations and opportunities
                    that come with being a student employee.
                    <br />
                    <br />
                    <strong>Jordan:</strong> The orientation process is easy. Behind us is a virtual
                    map of icons to explore. Each of the icons represents an important component of
                    the Student Employment program. Roll over the icon to see the module’s description.
                    Click the icon to enter the module.
                    <br />
                    <br />
                    <strong>Kelsi:</strong> There are two parts to each module: first, the information
                    about the topic and second, an activity. The activity must be successfully completed
                    to confirm your knowledge of the topic. Some modules will have resource links to
                    give access to related documents and websites. The menu on the left side is used
                    to track your progress. Seventy-five percent of the points are needed to pass the
                    activity within each module. Successfully complete the module activity and receive
                    an ‘achievement’ in the virtual briefcase. Repeat module activities as necessary
                    to achieve success. Once the briefcase is full of ‘achievements’, you will have
                    completed the online orientation.
                    <br />
                    <br />
                    <strong>Jordan:</strong> Student employees are compensated for the time required
                    to complete the orientation. If you are doing the orientation for your new position
                    on campus, before you begin, make sure you log into this application. Also make
                    sure you report the time it takes to complete this orientation.
                    <br />
                    <br />
                    <strong>Kelsi:</strong> As working as a Student Support Services Mentor these last
                    couple of years, I realize how much I truly enjoy helping other people. Before taking
                    on this job, I didn’t really realize what I wanted to do with my future career goals,
                    but now, after working with about 20 students each semester working through different
                    personal and academic issues, I realize I really have a passion for helping others
                    and I want to become a high school guidance counselor.
                    <br />
                    <strong>Jordan:</strong> My position as a Student Ambassador has benefited me in
                    countless ways. First off, it allowed me to learn more about our university and
                    the resources we have to offer to our students. Secondly it has enhanced my communications
                    skills and allowed me to meet with a variety of different family from a lot of different
                    backgrounds. The skills I have learned with this position are definitely are skills
                    I can apply to future professional positions.
                    <br />
                    <br />
                    <strong>Kelsi:</strong> At Northwest, we recognize Student Employment as an important
                    aspect in enhancing career development, while earning money. It can assist you with
                    the transition between the education you receive and your future career.
                    <br />
                    <br />
                    <strong>Jordan:</strong> There are many reasons why Student Employment enhances
                    the college experience. It provides you with the opportunity to:
                    <br />
                    <strong>Kelsi:</strong>
                    <br />
                    1. Network with faculty, staff and students
                    <br />
                    2. Work in a professional environment
                    <br />
                    3. Link into the campus community
                    <br />
                    4. Work in an environment that promotes academic success
                    <br />
                    <strong>Jordan:</strong>
                    <br />
                    1. Remain on campus to work
                    <br />
                    2. Enhance time management skills
                    <br />
                    3. Feel responsible and valued
                    <br />
                    4. Gain experience and training that will enhance future career
                </div>
            </div>
            <%} %>
            <input type="submit" value="Submit" style="position: relative; top: -50px" />
    </div>
    <% }
   else
   { %>
    This activity is completed.
    <% } %></p>
    <script>
        /* //Not quite working right ;(
        $(document).ready(function () {
        $("#tabs-2").click(function() {
        $("#scale > img").attr("width", "25");
        $("#scale > img").attr("height", $("ul#sortable").height());
        });
        */
    </script>
</div>
