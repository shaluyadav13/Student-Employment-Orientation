<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="activity.aspx.cs" Inherits="StudentOrientation.Modules.confidentiality.activity" %>

<% if (!DidComplete(MODULE_TITLE))
   
   { %>
<style type="text/css">
   
</style>
<script language="javascript" type="text/javascript">
    $(document).ready(function () {
        $.ajaxSetup({ cache: false });
        $("#additionalResourcesConfidentiality").dialog({ autoOpen: false, title: 'Resources', minWidth: 500, show: 'fade', hide: 'fade' });
        $("#ConfidentialityTranscript").dialog({ autoOpen: false, title: 'Video Transcript', minWidht: 500, width: 500, height: 500, show: 'fade', hide: 'fade' });
        $("#ModuleStatusComplete_confidentiality").dialog({ autoOpen: false, title: 'Submit Report', minWidth: 500, show: 'fade', hide: 'fade' });
        $("#ModuleStatusIncomplete_confidentiality").dialog({ autoOpen: false, title: 'Submit Report', minWidth: 500, show: 'fade', hide: 'fade' });

        $(document).ready(function ()
         {
             $("#additionalResourcesButton").click(function ()
             {
                $("#additionalResourcesConfidentiality").dialog("open");
            });

            $("#Confidentialtranscripts").click(function () 
            {
                $("#ConfidentialityTranscript").dialog("open");
            });
        });

        $("#dialog").dialog({ autoOpen: false, title: "Confidentiality Agreement", buttons:
          { 'OK': function () {
              $(this).dialog('close');
              return true;
                 }
          }

        });
        $("#tabs").tabs({ fx: { opacity: 'toggle' }, selected: $("#selectedIndex").val() });
        $("input:button").button();
        $("input:submit").button();
        $("input:submit").click(function () {
            $("#question").children("input:radio").each(function (index, element) {
                if ($(element).val() == "No" && $(element).attr("checked") == true) {
                    $("#ModuleStatusIncomplete_confidentiality").dialog("open");
                    $("#module").hide("slow").empty();
                    return false;
                }
                else if ($(element).val() == "Yes" && $(element).attr("checked") == true) {
                    $.post("Modules/confidentiality/submit.aspx");
                    $("#module").hide("slow").empty();
                    return true;
                }
            });

            updateProgress();
            $.get('Modules/progress.aspx', function (data) {
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


                if (progress["Confidentiality"].moduleCompleted) {
                    $("#ModuleStatusComplete_confidentiality").dialog("open");
                } else {
                    $("#ModuleStatusIncomplete_confidentiality").dialog("open");
                }
            });
        });
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
                file: "flash/Confidentiality.flv",
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
        <div >
            <img src="img/contract.png" alt="" />
        </div>
        <div id="question">
            <p>
                Did you complete the Family Education Rights and Privacy Act Confidentiality Statement?
            </p>
            <input type="radio" name="taskComplete" value="Yes"  />
            Yes
            <br />
            <input type="radio" name="taskComplete" value="No" />
            No
            <br />
        </div>
        <input type="submit" value="Submit" />
    </div>
    <div id="ModuleStatusComplete_confidentiality">
        <div class="conversions">
            You have successfully completed the module
        </div>
    </div>
    <div id="ModuleStatusIncomplete_confidentiality">
        <div class="conversions">
             Sorry! you have not completed this activity. Please fill out the Family Education
            Rights and Privacy Act Confidentiality Statement "FERPA" at the Office of Human Resources
            when you get a chance and come back to complete the activity!
        </div>
    </div>
    <div id="additionalResourcesConfidentiality">
        <div class="conversions">
            <table>
                <tr>
                    <td>
                        
                    </td>
                </tr>
            </table>
        </div>
        <a href="#" id="Confidentialtranscripts">Video Transcript</a>
    </div>
    <div id="ConfidentialityTranscript">
        <strong>Kelsi:</strong><p>
            Here we are in Office of Human Resources. As a new student employee, you are required
            to review and sign a confidentiality statement. The confidentiality statement is
            completed during the time initial employment verification and authorization paperwork
            is completed.</p>
        <strong>Jordan:</strong><p>
            Confidentiality is important for all jobs on campus and is mandated by federal law.
            The Family Educational Rights and Privacy Act of 1974, as amended, is a federal
            law which provides that college and universities will maintain the confidentiality
            of student education records. Basically, the law says that no one outside the institution
            shall have access to your education records nor will the institution disclose any
            information from those records without your written consent. There are exceptions,
            of course, so certain personnel within the institution may see your records, including
            persons in an emergency in order to protect the health or safety of students or
            other persons.</p>
        <strong>Kelsi:</strong><p>
            If you are a student employee of the University, you may have access to confidential
            records. Their confidentiality, use, and release are governed by FERPA. In general,
            all student information must be treated as confidential. Any questions about information
            released should be referred to your supervisor.</p>
        <p>
            Now let’s look at some scenarios where confidentiality goes beyond student records.
            Each office or department will have their specific confidentiality policies.</p>
        <hr style="outline-style: dashed; line-height: 10px" />
        <p>
        </p>
        <strong>At the Wellness Center a student employee, a receptionist, answers the phone.</strong><p>
        </p>
        <strong>Student Employee:</strong><p>
            Good morning and thank you for calling the University Wellness Center. This is Ashleigh,
            how may I help you?</p>
        <strong>Parent:</strong><p>
            Hello, my name is Jennifer Smith and I am calling in regards to my son Luke Smith.
            I received a bill from Northwest recently and there was a $80 charge from the Wellness
            Center. I need to speak with someone to figure out what the charges are for and
            why this wasn’t paid by our insurance.</p>
        <strong>Student Employee:</strong><p>
            I understand, let me look and see if we have a copy of your son’s insurance on file.
            (Pause). It appears that we do not have your son’s insurance information on file.
            If you could either fax a copy of both sides of the card or have him bring a copy
            of his insurance card to the Wellness Center we will keep that on file for him.</p>
        <strong>Parent:</strong><p>
            I appreciate your assistance; however, I would still like to know what the charges
            are for.</p>
        <strong>Student Employee:</strong><p>
            I apologize for the inconvenience; however, If there are billing concerns, I would
            suggest that your son contact our office.</p>
        <strong>Parent:</strong><p>
            The insurance is in my name and I pay the bills for my son to attend Northwest.
            Is there someone else that I can talk to?</p>
        <strong>Student Employee:</strong><p>
            Would you please hold while I transfer you to my supervisor?</p>
        <strong>Parent:</strong><p>
            Yes, thank you.</p>
        <strong>Supervisor:</strong><p>
            Thank you for holding, this is Kelley, How may I assist you?</p>
        <strong>Parent:</strong><p>
            This is extremely frustrating, The insurance is in my name and I pay the bills for
            my son to attend Northwest I don’t understand why you won’t tell me why he has been
            charged.</p>
        <strong>Supervisor:</strong><p>
            I apologize for the frustration you are experiencing, however, HIPAA guidelines
            restrict us from communicating to anyone other than the patient regarding their
            visit or bill without their written consent. It is our responsibility to protect
            your son’s health information and our office from civil penalties. Please have your
            son call us to discuss his billing and/or signing an authorization to discuss his
            encounter with you.</p>
        <strong>Parent:</strong><p>
            I will just have him call you.</p>
        <hr style="outline-style: dashed; line-height: 10px" />
        <p>
        </p>
        <strong>University Police Department - Confidentiality –</strong>
        <p>
            The end of a study group session. Group leader says: ‘So let’s all meet next week
            at this same time’. The group disperses except for two.</p>
        <strong>Friend:</strong><p>
            Hey Conner! How’s it going? Did you get your assignment finished for tomorrow? Hey
            by the way- you work for University Police right? What happened last night? There
            were cop cars outside my building and an ambulance at 4am!?</p>
        <strong>University Police student employee:</strong><p>
            Yes, I work there but I had to sign a confidentiality agreement. That means I can’t
            talk about anything that happens at work outside of work.</p>
        <strong>Friend:</strong><p>
            Oh, I don’t need to know the details, I just heard that someone was seriously hurt
            and wanted to make sure that they were ok.</p>
        <strong>Unviersity Police student employee:</strong><p>
            That’s cool, I understand. I can always talk to my supervisor to find out if everyone
            was ok.</p>
        <strong>Jordan:</strong><p>
            If you have any questions regarding the confidentiality in your new position, make
            sure to ask your supervisor for clarification. Or if you have questions about the
            confidentiality statement you signed, contact the Office of Human Resources Management.</p>
    </div>
   
    <div id="dialog">
    Sorry! you have not completed this activity. Please fill out the Family Education
    Rights and Privacy Act Confidentiality Statement "FERPA" at the Office of Human Resources
    when you get a chance and come back to complete the activity!
    </div>
</div>

<% }
   else
   { %>
This activity is completed.
<% } %>