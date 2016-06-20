<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="activity.aspx.cs" Inherits="StudentOrientation.Modules.Events.activity" %>

<% if (!DidComplete(MODULE_TITLE))
   { %>
<script type="text/javascript" language="javascript" src="../../js/multipleChoiceActivity.js"></script>
<script type="text/javascript" language="javascript">
    $(document).ready(function () {
        $.ajaxSetup({ cache: false });
        $("#additionalResourcesEvents").dialog({ autoOpen: false, title: 'Resources', minWidth: 500, show: 'fade', hide: 'fade' });
        $("#Eventstranscript").dialog({ autoOpen: false, title: 'Video Transcript', minWidht: 500, width: 500, height: 500, show: 'fade', hide: 'fade' });
        $("#ModuleStatusComplete_Events").dialog({ autoOpen: false, title: 'Submit Report', minWidth: 500, show: 'fade', hide: 'fade' });
        $("#ModuleStatusIncomplete_Events").dialog({ autoOpen: false, title: 'Submit Report', minWidth: 500, show: 'fade', hide: 'fade' });

        $(document).ready(function () {
            $("#additionalResourcesButton").click(function () {
                $("#additionalResourcesEvents").dialog("open");
            });

            $("#Evetranscripts").click(function () {
                $("#Eventstranscript").dialog("open");
            });
        });
        $(function () {
            $("#tabs").tabs({ fx: { opacity: 'toggle' }, selected: $("#selectedIndex").val() });
        });
        $("input:submit").button();
        $("input:button").button();
        $("input:submit").click(function () {

            var questionArray = Array();
            questionArray = formQuestionArray("#questions");

            $.post("Modules/Events/submit.aspx", { "questions": questionArray }, function (nill)
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
                    //alert(progress["Events"].moduleCompleted);
                    if (progress["Events"].moduleCompleted) {
                        $("#ModuleStatusComplete_Events").dialog("open");
                    } else {
                        $("#ModuleStatusIncomplete_Events").dialog("open");
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
<script type="text/javascript">
    function openWindow(url) {
        window.open(url, '', 'scrollbars=yes,menubar=no,height=600,width=800,resizable=yes,toolbar=no,location=no,status=no');
    }
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
                file: "flash/events.flv",
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
        <div>
            Visit the Student Employment Events Calendar @
        </div>
        <a href="javascript:openWindow('http://www.nwmissouri.edu/hr/student/calendar.htm')">
            Student Employment Calendar</a>
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
</div>
<div id="additionalResourcesEvents">
    <div class="conversions">
        <table>
            <tr>
                <td>
                    <a href="javascript:openWindow('http://www.nwmissouri.edu/hr/student/calendar.htm')">
                        Student Employment Calendar</a>
                </td>
            </tr>
        </table>
    </div>
    <a href="#" id="Evetranscripts">Video Transcript</a>
</div>
<div id="ModuleStatusComplete_Events">
    <div class="conversions">
        You successfully completed the module</div>
</div>
<div id="ModuleStatusIncomplete_Events">
    <div class="conversions">
        You have not successfully completed the module. Please retake the module
    </div>
</div>
<div id="Eventstranscript">
    <strong>Jordan:</strong><p>
        We are in the Student Union, on 3rd floor at the entrance of the Ballroom. Many
        of the special events for Student Employment take place here in the Ballroom.</p>
    <strong>Kelsi:</strong><p>
        There are many student employment events throughout the year for all student employees.
        The Career Pathing Program offers fall and spring personal and professional development
        sessions. Many take place here in the ballroom. Check out the Career Pathing module
        for more information about Career Pathing Program and its training events.</p>
    <strong>Jordan:</strong><p>
        Another event is the Student Employee Satisfaction Survey. Student employees are
        encouraged to express their satisfaction with the student employment program through
        a student employee satisfaction survey. It is an annual survey for all student employees
        conducted in the fall trimester. Feedback from the survey is used as actionable
        data to provide improvements to the student employment experience.</p>
    <strong>Kelsi:</strong><p>
        National Student Employment Week is an annual recognition event held in the spring
        to acknowledge the contributions of student employees to the University community.<br />
        Nominated student employees are acknowledged at a recognition ceremony held at Northwest.</p>
    <strong>Jordan:</strong><p>
        Student employees are notified of the event by their Student Employment Supervisor
        and the Office of Human Resources Management. The awards listed are presented annually
        during the event.<br />
        Eligible students are undergraduate or graduate student employees (not Resident
        Advisors, Graduate Assistants, or Graduate Teaching Assistants) who have been or
        will be employed for a minimum of six months between June and May of the current
        fiscal year.</p>
    <strong>Kelsi:</strong><p>
        Nomination forms are distributed annually to student employment supervisors for
        the student employee awards and to the student employees for the Supervisor of the
        Year Award, and then submitted to the Office of Human Resources Management. The
        nominations are evaluated by parties who did not nominate a student, team or supervisor
        in the respective category.</p>
    <strong>Jordan:</strong><p>
        The Northwest Student Employee of the Year nomination is forwarded to the Midwest
        Association of Student Employment Administrators (MASEA) for consideration of state,
        regional and national awards. Many Northwest Student Employees of the Year have
        also captured the State of Missouri honor.</p>
</div>
<% }
   else
   { %>
This activity is completed.
<% } %>