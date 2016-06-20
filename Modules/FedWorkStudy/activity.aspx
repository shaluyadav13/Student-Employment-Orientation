<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="activity.aspx.cs" Inherits="StudentOrientation.Modules.fedWorkStudy.activity" %>

<% if (!DidComplete(MODULE_TITLE))
   { %>
<!-- Syntax highlighting  will be inaccurate for locations of javascript -->
<script language="javascript" type="text/javascript" src="../../js/multipleChoiceActivity.js"> </script>
<script language="javascript" type="text/javascript" src="../../js/multipageActivity.js"> </script>
<script type="text/javascript">
    function openWindow(url) {
        window.open(url, '', 'scrollbars=yes,menubar=no,height=600,width=800,resizable=yes,toolbar=no,location=no,status=no');
    }
</script>
<script type="text/javascript" language="javascript">
    $(document).ready(function () {
        $.ajaxSetup({ cache: false });
        $("#additionalResourcesFedStudy").dialog({ autoOpen: false, title: 'Resources', minWidth: 500, show: 'fade', hide: 'fade' });
        $("#FedWorkStudytranscript").dialog({ autoOpen: false, title: 'Video Transcript', minWidht: 500, width: 500, height: 500, show: 'fade', hide: 'fade' });
        $("#ModuleStatusComplete_FedWorkStudy").dialog({ autoOpen: false, title: 'Submit Report', minWidth: 500, show: 'fade', hide: 'fade' });
        $("#ModuleStatusIncomplete_FedWorkStudy").dialog({ autoOpen: false, title: 'Submit Report', minWidth: 500, show: 'fade', hide: 'fade' });

        $("#additionalResourcesButton").click(function () {
            $("#additionalResourcesFedStudy").dialog("open");
        });

        $("#Fedtranscripts").click(function () {
            $("#FedWorkStudytranscript").dialog("open");
        });

        $("input:button").button();
        $("input:submit").button();
        $("input:submit").click(function () {
            var questionArray = Array();
            questionArray = formQuestionArray("#questions");

            $.post("Modules/FedWorkStudy/submit.aspx", { "questions": questionArray, async: false }, function (nill)
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
                    //alert(progress["Federal Work Study"].moduleCompleted);
                    if (progress["Federal Work Study"].moduleCompleted) {
                        $("#ModuleStatusComplete_FedWorkStudy").dialog("open");
                    } else {
                        $("#ModuleStatusIncomplete_FedWorkStudy").dialog("open");
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
                file: "flash/Fin_Assistance.flv",//"http://cite.nwmissouri.edu/SE_Orientation/Flash/Fin_Assistance.flv",
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
            Loading the player...
        </div>
        <br />
        <input id="additionalResourcesButton" type="button" value="Resources" />
    </div>
    <div id="tabs-2">
        <div id="questions" style="overflow: auto; width: 100%; max-height: 450px">
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
        </div>
        <input type="submit" value="Submit" />
    </div>
    <div id="ModuleStatusComplete_FedWorkStudy">
        <div class="conversions">
            You successfully completed the module</div>
    </div>
    <div id="ModuleStatusIncomplete_FedWorkStudy">
        <div class="conversions">
            You have not successfully completed the module. Please retake the module</div>
    </div>
    <div id="additionalResourcesFedStudy">
        <div class="conversions">
            <table>
                <tr>
                    <td>
                        <a href="javascript:openWindow('http://www.nwmissouri.edu/FinAid/index.htm')">Office
                            Of Financial Assistance </a>
                        <br />
                        <a href="javascript:openWindow('http://www.nwmissouri.edu/hr/student/workstudy.htm')">
                            Federal Work Study </a>
                        <br />
                    </td>
                </tr>
            </table>
        </div>
        <a href="#" id="Fedtranscripts">Video Transcript</a>
    </div>
    <div id="FedWorkStudytranscript">
        <strong>Kelsi:</strong><p>
            Some student employees may be earning federal work study awards during their work
            experience while others are earning regular pay. To understand federal work study
            better lets watch a new student inquire about work study in the financial assistance
            office.</p>
        <strong>Staff:</strong><p>
            Hi how can I help you?</p>
        <strong>Student:</strong><p>
            I would like to work on campus. Is this where I apply for work study?</p>
        <strong>Staff:</strong><p>
            Yes, this is where you can begin the process. To be eligible for work study, a student
            needs to complete the FAFSA to determine eligibility.</p>
        <strong>Student:</strong><p>
            What is the FAFSA?</p>
        <strong>Staff:</strong><p>
            FAFSA is the Free Application for Federal Student Aid. It is the federal government's
            way of determining financial need. Work-study is awarded to the students as part
            of their financial aid package. Have you applied for financial aid by completing
            the FAFSA?</p>
        <strong>Student:</strong><p>
            I don't know....I think so.</p>
        <strong>Staff:</strong><p>
            Give me your student ID and I can check your record.</p>
        <p>
            Yes, I see that you have applied and you do have work study eligibility.</p>
        <strong>Student:</strong><p>
            So how does work study actually works? Do I get assigned a job?</p>
        <strong>Staff:</strong><p>
            NO you are not assigned a job. You will need to look for job openings and actually
            apply for a position. Once you have secured a job on campus your federal work study
            funds will be paid to you for wages earned through a paycheck. You are paid monthly
            for the actual hours you worked the previous month.</p>
        <strong>Student:</strong><p>
            So once I get a job on campus, they will pay me with the federal work study money?</p>
        <strong>Staff:</strong><p>
            That is correct. It is also important to remember federal work study eligibility
            is awarded on an annual basis. You must apply each year in order to determine your
            continued eligibility.</p>
        <strong>Student:</strong><p>
            So are all student jobs on campus work study?</p>
        <strong>Staff:</strong><p>
            No, you can work on campus without being eligible for federal work study if you
            can secure a position. Applicants for a position with work study eligibility have
            the edge over other applicants of the same qualifications.</p>
        <strong>Student:</strong><p>
            So are there any other advantages of receiving federal work study funds?</p>
        <strong>Staff:</strong><p>
            Well, yes. Although federal work study earnings are subject to state and federal
            withholding taxes, earnings are not considered income when determining eligibility
            for other federal aid programs. Meaning your earnings this year will not count against
            you next year when you reapply for financial aid.</p>
        <strong>Student:</strong><p>
            Okay, so where do I go to start looking for a campus job?</p>
        <strong>Staff:</strong><p>
            To actually find a job on campus you need to visit the Office of Human Resources
            or check out their web site for student job position openings. The student employment
            website lists the current openings.</p>
        <strong>Jordan:</strong><p>
            So if you are interested in federal work study eligibility and have not completed
            the FAFSA, you are encouraged to visit the Office of Financial Assistance.</p>
    </div>
</div>
<% }
   else
   { %>
This activity is completed.
<% } %>