<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="activity.aspx.cs" Inherits="StudentOrientation.Modules.workmansComp.acitivity" %>

<% if (!DidComplete(MODULE_TITLE))
   { %>
<script language="javascript" type="text/javascript" src="js/workersComp.js">
</script>
<style>
    .wc_questionOptions
    {
        list-style-type: none;
        margin: 0px;
        padding: 10px;
    }
    
    .wc_questionOptions li
    {
        background-color: rgb(106, 190, 167);
        margin-bottom: 3px;
        padding: 0.25em;
        cursor: pointer;
    }
    
    .wc_optionBox, .wc_answers
    {
        float: left;
        margin: 5px;
        background: lightgrey; /*background: darkgreen;*/
        position: relative;
        height: 100%;
        width: 300px;
    }
    .wc_Content
    {
        position: relative;
    }
    .footer
    {
        clear: both;
    }
</style>
<div id="tabs">
    <ul>
        <li><a href="#tabs-1">Lesson</a></li>
        <li><a href="#tabs-2">Activity</a></li>
    </ul>
    <div id="tabs-1" style="text-align: center">
        <script type="text/javascript">
            jwplayer("videoContainer").setup({
                flashplayer: "jwplayer/player.swf",
                file: "flash/Workers_Comp.flv", //"http://cite.nwmissouri.edu/SE_Orientation/Flash/Workers_Comp.flv",
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
        <%= question.Text %>
        <div class="wc_Content">
            <div class="wc_optionBox">
                <ul id="workmansCompOptions" class="wc_questionOptions">
                    <% for (int i = 0; i < question.OptionAnswer.Keys.Count; i++)
                       {
                           var optionKey = question.OptionAnswer.Keys.ElementAt(i);%>
                    <li id="wc_<%= i %>" class="ui-state-default">
                        <%= optionKey%></li>
                    <% } %>
                </ul>
            </div>
            <div class="wc_answers">
                <ul id="workmansCompAnswers" class="wc_questionOptions">
                </ul>
            </div>
        </div>
        <div class="footer">
            <input type="submit" value="Submit" />
        </div>
    </div>
    <div id="ModuleStatusComplete_WorkersComp">
        <div class="conversions">
            You have successfully completed the module</div>
    </div>
    <div id="ModuleStatusIncomplete_WorkersComp">
        <div class="conversions">
            You have not successfully completed the module. Please retake the module</div>
    </div>
    <div id="additionalResources">
        <div class="conversions">
            <a href="#" id="Workerstranscripts">Video Transcript</a>
        </div>
    </div>
    <div id="transcript">
        <strong>Kelsi:</strong><p>
            A student employee for Athletic Grounds department is hanging a baseball batting
            net on a windy day. A gust of wind knocks the ladder over while he was on it and
            he injures is leg in the fall. If a student employee is injured on the job follow
            the steps listed below:</p>
        <strong>Jordan:</strong><p>
            <ol style="list-style: 1">
                <li>The student employee should notify their supervisor of all work-related incidents,
                    regardless if the injured received medical attention. Supervisors should then report
                    the injury to the Office of Human Resources Management.</li>
                <li>If the student employee requires immediate medical attention call University Police
                    at 562-1254. The officer will call for an ambulance to transport the student employee
                    to St. Francis Hospital Emergency Room.</li>
                <li>If the injury does not require immediate medical attention, but medical attention
                    is needed, the student employee will need to contact the Division of Workers’ Compensation
                    to report the injury and receive authorization for treatment. Contact information
                    will be given by the Office of Human Resources Management.</li>
                <li>Medical appointments must be made by the Office of Human Resources Management to
                    insure approved physicians and facilities are used.</li>
                <li>The injured student (and supervisor) will be given workers’ compensation injury
                    reports to complete. These need to be completed as soon as possible and returned
                    to the Office of Human Resources Management.</li></ol>
        </p>
        <strong>Kelsi:</strong><p>
            Any medical attention needed for a work related injury must be administered by a
            doctor or facility covered under the Missouri Worker’s Compensation Insurance. The
            University Health Center does not see patients for workers’ compensation related
            injury or illness.</p>
    </div>
</div>
<% }
   else
   { %>
This activity is completed.
<% } %>