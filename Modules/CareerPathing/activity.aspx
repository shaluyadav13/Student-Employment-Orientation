<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="activity.aspx.cs" Inherits="StudentOrientation.Modules.careerPathing.activity" %>

<% if (!DidComplete(MODULE_TITLE))
   { %>
<!-- Syntax highlighting  will be inaccurate for locations of javascript -->
<script type="text/javascript" language="javascript" src="../../js/multipleChoiceActivity.js"></script>
<script language="javascript" type="text/javascript" src="../../js/multipageActivity.js"> </script>
<script type="text/javascript">
    function openWindow(url) {
        window.open(url, '', 'scrollbars=yes,menubar=no,height=600,width=800,resizable=yes,toolbar=no,location=no,status=no');
    }
</script>
<script type="text/javascript" language="javascript">
    $(document).ready(function () {
        $.ajaxSetup({ cache: false });
        $("#additionalResourcesCareerpathing").dialog({ autoOpen: false, title: 'Resources', minWidth: 500, show: 'fade', hide: 'fade', closeOnEscape: true });
        $("#CareerPathing").dialog({ autoOpen: false, title: 'Video Transcript', minWidht: 500, width: 500, height: 500, show: 'fade', hide: 'fade', closeOnEscape: true });
        $("#ModuleStatusComplete_CareerPathing").dialog({ autoOpen: false, title: 'Submit Report', minWidth: 500, show: 'fade', hide: 'fade' });
        $("#ModuleStatusIncomplete_CareerPathing").dialog({ autoOpen: false, title: 'Submit Report', minWidth: 500, show: 'fade', hide: 'fade' });

        $(document).ready(function () {
            $.ajaxSetup({ cache: false });
            $("#additionalResourcesButton").click(function () {
                $("#additionalResourcesCareerpathing").dialog("open");
            });

            $("#Careertranscripts").click(function () {
                $("#CareerPathing").dialog("open");
            });
        });
        $("input:button").button();
        $("input:submit").button();
        $("input:submit").click(function () {
            var questionArray = Array();

            questionArray = formQuestionArray("#questions");

            $.post("Modules/CareerPathing/submit.aspx", { "questions": questionArray }, function (nill)
             {
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
                    if (progress["Career Pathing"].moduleCompleted) {
                        $("#ModuleStatusComplete_CareerPathing").dialog("open");
                    } else {
                        $("#ModuleStatusIncomplete_CareerPathing").dialog("open");
                    }
                });
            });
            $("#module").hide("slow").empty();
        });
    });
</script>
<script type="text/javascript">
    function formQuestionArray(rootElement) {
        var questionArray = new Array();
        $(rootElement).children(".question").each(function (index, element) {
            var question = Object();
            var questionOptions = Array();

            question.Text = $(element).find(".questionText").text();

            $(element).find("input.options").each(function (index_opt, element_opt) {
                var questionOption = Object();

                questionOption.Key = $(element_opt).val();
                questionOption.Val = $(element_opt).attr("checked");
                questionOptions.push(questionOption);
            });

            question.Options = questionOptions;
            questionArray.push(question);
        });
        return questionArray;
    }
</script>
<script type="text/javascript" language="javascript">
    $(function () {
        $("#tabs").tabs({ fx: { opacity: 'toggle' }, selected: $("#selectedIndex").val() });
    });
</script>
<div id="tabs">
    <ul id="selectedTabs">
        <li><a href="#tabs-1">Lesson</a></li>
        <li><a href="#tabs-2">Activity</a></li>
    </ul>
    <div id="tabs-1" style="text-align: center">
        <script type="text/javascript">
            jwplayer("videoContainer").setup({
                flashplayer: "jwplayer/player.swf",
                file: "flash/CareerPathing.flv",
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
        <div id="videoContainer">
            Loading the player...</div>
        <br />
        <input id="additionalResourcesButton" type="button" value="Resources" />
    </div>
    <div id="tabs-2">
        <p>
            <div id="questions">
                <% for (int i = 0; i < questions.Count; i++)
                   {
                       var question = questions[i];
                %>
                <div class="question">
                    <div class="questionText">
                        <%= question.Text %></div>
                    <br />
                    <% if (!question.isMultiAnswer() && !question.isOrderedQuestion())
                       { %>
                    <% foreach (var optionKey in question.OptionAnswer.Keys)
                       { %>
                    <div class="optionsContainer">
                        <input class="options" name="questions_<%=i %>" type="radio" value="<%= optionKey %>" /><%= optionKey%>
                        <br />
                    </div>
                    <% } %>
                    <% }
                       else if (question.isMultiAnswer())
                       { %>
                    <% foreach (var optionKey in question.OptionAnswer.Keys)
                       { %>
                    <div class="optionsContainer">
                        <input class="options" name="questions_<%=i %>" type="checkbox" value="<%= optionKey %>" />
                        <%= optionKey%>
                        <br />
                    </div>
                    <% } %>
                    <% } %>
                </div>
                <% } %>
                <input type="submit" value="Submit" />
            </div>
    </div>
    <div id="ModuleStatusComplete_CareerPathing">
        <div class="conversions">
            You have successfully completed the module</div>
    </div>
    <div id="ModuleStatusIncomplete_CareerPathing">
        <div class="conversions">
            You have not successfully completed the module. Please retake the module</div>
    </div>
    <div id="additionalResourcesCareerpathing">
        <div class="conversions">
            <table>
                <tr>
                    <td>
                        <a href="javascript:openWindow('http://www.nwmissouri.edu/hr/student/aboutcareerpathing.htm')">
                            Career Pathing Program </a>
                        <br />
                        <a href="javascript:openWindow('http://www.nwmissouri.edu/hr/student/trainingopps.htm')">
                            Training opportunities </a>
                    </td>
                </tr>
            </table>
        </div>
        <a href="#" id="Careertranscripts">Video Transcript</a>
    </div>
    <div id="CareerPathing">
        <strong>Kelsi:</strong><p>
            The Career Pathing Program is a voluntary program for all student employees hired
            in an hourly wage position. Stipend, scholar and outlying wage rate positions do
            not qualify for the program.</p>
        <p>
            The Career Pathing Program:
            <li>Creates annual opportunities for pay advancement within the Student Employment Program.</li>
            <li>provides an opportunity to participate in structured personal and professional development
                sessions while being paid.</li>
            <li>Encourages continual feedback for personal and professional development through
                annual performance-based evaluations</li>
            <li>Promotes increased student employee responsibility</li>
            <li>Promotes experience and training based compensation</li></p>
        <p>
            The advancement in the wage rate is transferable and applicable to all eligible
            positions a student holds within the Student Employment Program. Students may continue
            to advance through the program throughout their student employment experience.</p>
        <p>
            Annual opportunities for pay advancement ($.25 per hour increase) within the Student
            Employment Program include the following levels:<br />
            Level I: Student Employee – Starting Salary<br />
            Level II: Student Assistant – Increase of $0.25<br />
            Level III: Student Associate – Increase of $0.25<br />
            Level IV: Student Manager – Increase of $0.25</p>
        <strong>Jordan:</strong><p>
            There are 3 main criteria for a student employee to advance in the Career Pathing
            Program by:
            <ol type="1">
                <li>Completing a consecutive fall and spring trimester of service within the same department
                    (credit is granted for a full trimester if a student begins employment later in
                    the trimester but still completes three training sessions for that trimester).</li>
                <li>Attending a minimum of three personal and professional development sessions offered
                    per trimester (students are paid for their time in attendance). Each session may
                    last approximately 45 to 90 minutes based on the topic and/or presenter.<br />
                    And a student employee can register for the personal and professional development
                    opportunities on-line each trimester. (Not in video – Student employees may NOT
                    skip class to attend a Career Pathing Program, but they may attend during regular
                    work hours if prior approval is received from the supervisor.) </li>
                <li>Participating in a satisfactory performance evaluation completed by their student
                    employment supervisor. Participation in the program is determined by completion
                    of the program requirements.</li>
            </ol>
        </p>
        <strong>Kelsi:</strong><p>
            Through a couple simple steps a student has the chance to earn money, increase knowledge
            and enhance personally and professionally.</p>
    </div>
</div>
<% }
   else
   { %>
This activity is completed.
<% } %>