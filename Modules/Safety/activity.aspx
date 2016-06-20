<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="activity.aspx.cs" Inherits="StudentOrientation.Modules.Safety.activity" %>

<% if (!DidComplete(MODULE_TITLE))
   { %>
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
        $("#additionalResourcesSafety").dialog({ autoOpen: false, title: 'Resources', minWidth: 500, show: 'fade', hide: 'fade', closeOnEscape: true });
        $("#Safety").dialog({ autoOpen: false, title: 'Video Transcript', minWidht: 500, width: 500, height: 500, show: 'fade', hide: 'fade', closeOnEscape: true });
        $("#ModuleStatusComplete_Safety").dialog({ autoOpen: false, title: 'Submit Report', minWidth: 500, show: 'fade', hide: 'fade' });
        $("#ModuleStatusIncomplete_Safety").dialog({ autoOpen: false, title: 'Submit Report', minWidth: 500, show: 'fade', hide: 'fade' });

        $(document).ready(function () {
            $.ajaxSetup({ cache: false });
            $("#additionalResourcesButton").click(function () {
                $("#additionalResourcesSafety").dialog("open");
            });

            $("#Safetytranscripts").click(function () {
                $("#Safety").dialog("open");
            });
        });
        $("input:button").button();
        $("input:submit").button();
        $("input:submit").click(function () {
            var questionArray = Array();

            questionArray = formQuestionArray("#questions");

            $.post("Modules/Safety/submit.aspx", { "questions": questionArray }, function (nill) 
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
                    if (progress["Safety"].moduleCompleted) {
                        $("#ModuleStatusComplete_Safety").dialog("open");
                    } else {
                        $("#ModuleStatusIncomplete_Safety").dialog("open");
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
                file: "flash/RunHideFight_small.flv",
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
    <div id="ModuleStatusComplete_Safety">
        <div class="conversions">
            You have successfully completed the module</div>
    </div>
    <div id="ModuleStatusIncomplete_Safety">
        <div class="conversions">
            You have not successfully completed the module. Please retake the module</div>
    </div>
    <div id="additionalResourcesSafety">
        <div class="conversions">
            <table>
                <tr>
                    <td>
                       <%-- <a href="javascript:openWindow('http://www.nwmissouri.edu/hr/student/aboutSafety.htm')">
                            Career Pathing Program </a>
                        <br />
                        <a href="javascript:openWindow('http://www.nwmissouri.edu/hr/student/trainingopps.htm')">
                            Training opportunities </a>--%>
                    </td>
                </tr>
            </table>
        </div>
        <a href="#" id="Safetytranscripts">Video Transcript</a>
    </div>
    <div id="Safety">
        <strong>Run. Hide. Fight. Surviving an Active Shooter Event</strong>
        
        <p>It may feel like just another
        day on campus. But occasionally, life feels more like an action movie than reality.
        The authorities are working hard to protect you, and to protect our university community.
        But sometimes bad people do bad things. Their motivations are different. The warning
        signs may vary, but the devastating effects are the same. Unfortunately, you need
        to be prepared for the worst. If you are to ever find yourself in the middle of
        a hostile intruder event, your survival may depend on whether or not you have a
        plan. The plan doesn’t have to be complicated. 
        
        <p>There are three things you can do
        to make a difference. Run. Hide. Fight.</p>
        
        ( Student: There’s a shooter in Valk! )
        
        First and foremost, if you can get out safely – get out. If it is safe to do so,
        always try and escape or evacuate, even when others insist on staying. Remember
        what’s important – you, not your stuff. Leave your belongings behind and try to
        find a way to get out safely. Encourage others to leave with you, but don’t let
        them slow you down with indecision. Trying to get yourself out of harm’s way needs
        to be your number one priority. Once you are in an area of safety, try to prevent
        others from walking into the danger zone and call University Police. If you can’t
        get out safely, you need to find a place to hide. Act quickly and quietly. Try to
        secure your hiding place the best you can. Turn out lights, and if possible, remember
        to lock doors. Silence your ringer to vibration mode on your cell phone. If you
        can’t find a safe room or closet, try to conceal yourself behind large objects that
        may protect you. Do your best to remain quiet and calm.
        
        <b>(Professor giving a lesson)</b>
        As a last resort, if your life is at risk, whether you’re alone or working together
        as a group – FIGHT. Act with aggression. Improvise weapons. Overwhelm them. (Plan
        is being devised by professor). Commit to taking the intruder down no matter what.
        Your life depends on it. Try to be aware of your environment, and always have an
        exit plan. Know that in an incident like this, victims are generally chosen randomly.
        The event is unpredictable, and may evolve quickly. The first responders on the
        scene are not there to evacuate or attend to the injured. They are well trained
        and are there to stop the intruder. Your actions can make a difference for your
        safety and survival. Be aware and be prepared. If you ever find yourself faced with
        a hostile intruder, there are three key things you need to remember to survive:
        <b>Run. Hide. Fight.</b></p>
    </div>
</div>
<% }
   else
   { %>
This activity is completed.
<% } %>
