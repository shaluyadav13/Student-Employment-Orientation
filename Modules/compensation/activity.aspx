<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="activity.aspx.cs" Inherits="StudentOrientation.Modules.compensation.activity" %>

<% if (!DidComplete(MODULE_TITLE))
   { %>
<script language="javascript" type="text/javascript" src="../../js/multipleChoiceActivity.js"></script>
<script language="javascript" type="text/javascript" src="../../js/multipageActivity.js"></script>
<script type="text/javascript">
    function openWindow(url) {
        window.open(url, '', 'scrollbars=yes,menubar=no,height=600,width=800,resizable=yes,toolbar=no,location=no,status=no');
    }
 </script>
<script type="text/javascript" language="javascript">
    $(document).ready(function () {
        $.ajaxSetup({ cache: false });
        $("#additionalResourcesCompensation").dialog({ autoOpen: false, title: 'Resources', minWidth: 550, width: 500, show: 'fade', hide: 'fade' });
        $("#Compensationtranscript").dialog({ autoOpen: false, title: 'Video Transcript', minWidht: 500, width: 500, height: 500, show: 'fade', hide: 'fade' });
        $("#ModuleStatusComplete_Compensation").dialog({ autoOpen: false, title: 'Submit Report', minWidth: 500, show: 'fade', hide: 'fade' });
        $("#ModuleStatusIncomplete_Compensation").dialog({ autoOpen: false, title: 'Submit Report', minWidth: 500, show: 'fade', hide: 'fade' });

        $(document).ready(function () {
            $("#additionalResourcesButton").click(function () {
                $("#additionalResourcesCompensation").dialog("open");
            });
            $("#transcripts").click(function () {
                $("#Compensationtranscript").dialog("open");
            });

        });

        $("input:button").button();
        $("input:submit").button();
        $("input:submit").click(function () {
            var questionArray = Array();
            questionArray = formQuestionArray("#questions");
           // forSubmit = questionArray;

            $.post("Modules/Compensation/submit.aspx", { "questions": questionArray }, function (nill) 
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
                    //            alert(progress["Compensation"].moduleCompleted);
                    if (progress["Compinsation"].moduleCompleted) {
                        $("#ModuleStatusComplete_Compensation").dialog("open");
                    } else {
                        $("#ModuleStatusIncomplete_Compensation").dialog("open");
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
        $("#tabs").css({});
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
                file: "flash/Payroll.flv",
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
       <div>
       1.  Do the simulation of the Web-Time Entry process by clicking on this link below.This will open in a new window.  When finished with the simulation, close the window and proceed with #2. 
            </div>
            <div>
                <a href=" javascript:openWindow('flash/Compensation-WTE.swf')"> Student Employment Web Time Entry Simulation</a>
            </div>
            <div>
                2. Answer the questions below.
            </div> 
           
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
    </div>
        <%--<div class="question">
            November starts on a Monday this year. Clayton, a student employee in the CITE Office
            on campus. On the 1st he arrived at 10:00 and left at 3:00. On the 3rd, he arrived
            at work at 10:15 and left 12:45 to take a lunch break. He returned at 2:00 for the
            afternoon and finished for the day at 4:00. Friday he worked straight through arriving
            at 10:00 and leaving at 3:00.
            <p>
                Note: The TOTAL HRS FOR DAY of the day must be converted using the <a id="tenthsOfHourConversionChartClick">
                    tenths of hour conversion chart</a>.</p>
        </div>--%>
     <%--   <div class="timeSheetContent">
            
        </div>--%>
        <br />
        <input type="submit" value="Submit" />
    </div>
    <div id="ModuleStatusComplete_Compensation">
        <div class="conversions">
            You have successfully completed the module</div>
    </div>
    <div id="ModuleStatusIncomplete_Compensation">
        <div class="conversions">
            You have not successfully completed the module. Please retake the module</div>
    </div>
    <div id="additionalResourcesCompensation">
        <div class="conversions">
            <table>
                <tr>
                    <td>
                        Payroll Clerk Contact information:
                        <br />
                        <strong>Shannon Heitman</strong>
                        <br />
                        Administration Building 102A
                        <br />
                        660-562-1108
                        <br />
                    </td>
                </tr>
               <tr>
                <td>
                 <a href="javascript:openWindow('http://www.nwmissouri.edu/hr/PDF/BannerWebTimeEntry.pdf')">
                        WTE User guide</a>
                </td>
               </tr>
            </table>
        </div>
        <a href="#" id="transcripts" >Video Transcript</a>
    </div>
    <div id="Compensationtranscript">
        <strong>Kelsi:</strong><p>
            This is the payroll office. Shannon Heitman, the Payroll Clerk, has offered to show
            us how to record hours worked.</p>
        <strong>Jordan:</strong><p>
            Student employees are paid minimum wage or higher and are paid monthly. Rates are
            based upon the job duties and qualifications. Supervisors should inform their student
            employees of the position wage rate upon hiring. In order for a student employee
            to receive their earnings they must accurately record their working hours on a monthly
            timesheet. Let’s watch Shannon’s demo on how a student employee records their work
            time.</p>
        <strong>Shannon:</strong><p>
        To access your Web Time Entry time sheet, simply login to CatPAWS with your 919 number and PIN.
        If you do not know your PIN, please contact the Help Desk at extension 1634.  Access the Employee
        section by clicking the Employee tab or the Employee menu link.  Click the Time Sheet menu link to
        access your Web Time Entry Time Sheet Selection home page.

        Warning:  Use the navigation buttons within Web Time Entry.  Do NOT use browser navigation buttons such
        as the back arrow and do NOT double click the Web Time Entry navigation buttons.  Failure to properly navigate
        within Web Time Entry can result in time sheet errors that will need to be addressed so the employee will be paid
        timely and accurately.  

        On the Time Sheet Selection web page, select the My Choice radio button for the appropriate Title and Department
        and select the Pay Period and status in the respective drop-down box. The Title and Department should contain your
        Position Title, Position Number, and Department.  Each Pay Period has a status description and allows you to monitor
        the time sheet.  

The various status definitions are
--In Progress, you have started the time sheet, but have not submitted it for approval
--Pending, you have submitted your time sheet for approval
--Approved, the time sheet has been approved by your supervisor and sent to payroll
--Completed, the time sheet has been successfully processed through payroll
--Not Started, you have not started the time sheet process
--Returned for Correction, there is a problem with your time sheet and your supervisor returned it to you for correction
--Error, there is an error on your time sheet so you will need to record the hours you have already entered, then Restart your time sheet and re-enter your hours
-- Also, if you see this message “Time transaction already exists” on the top of the Time and Leave Reporting web page, there is an error on your time sheet, most likely caused by double clicking.  You will need to record the hours you have already entered, then Restart your time sheet and re-enter your hours 


Refer back to the Time Sheet Selection web page.  If there are multiple titles, contact your supervisor to determine the correct
one to use.  Please note, if titles and departments are missing or incorrect, contact your supervisor immediately so the issue can
be resolved with Human Resources and Payroll.  After the Title and Department and the Pay Period and Status are selected, click the
Time Sheet button.  When a new monthly time sheet is started, immediately click the Preview button and scroll to the right to validate
all scheduled days exist for the entire pay period.  

Please contact your supervisor immediately to report issues.

At the top of the Time and Leave Reporting web page, you will note some important information.  You will see your title and position number,
your department, the time sheet period and the submission deadline. Select the link on the appropriate day to enter hours.  Accurately 
enter the time in or time out to the nearest 15 minute interval (to enter your time, enter it numerically or enter the colon if you wish).
Remember to update the AM and PM to accurately reflect the shift and do NOT change the Shift value that defaults to 1.  Click Save to save
your time in or time out entry and to allow the system to calculate your hours.  If you do not click Save, your entry will be lost.  You
should enter your hours immediately following your shift.  You can add time sheet appropriate comments by clicking the Comments button. 
The comments will be viewed by your supervisor and Payroll.

<strong>Example #1</strong> (Monday, December 5th):
The student employee’s Time in is 9:00 am and Time out is 11:00 am.  
The total hours worked for the day is 2 hours.  The student employee actually worked 1 hour more than scheduled because their 10AM class 
was cancelled so the student employee should enter a comment in the system…”10AM Class was cancelled so I was able to work until 11AM”.  
Be sure to save your comment.

<strong>Example #2</strong> (Tuesday, December 6th):  
The student employee’s Time in is 9:00 am and Time out is 11:15 am indicating a total of 2 hours and 15 minutes that has been worked for
the day.  The total hours worked for the day is 2.25 hours.

<strong>Example #3</strong> (Wednesday, December 7th):  
On this particular day the student employee has received a break and then returned to work at a later time.  The student employee’s first 
Time in for the day is 9:00 am and Time out is 11:15 am.  

The student employee later returned to work for his second shift. The student employee’s second Time in for the day is 2:00 pm and Time 
out is 4:15 pm.  

The student employee has worked a total of 4 hours and 30 minutes for the day and the system accurately calculated the total number of
hours worked for the day of 4.5.  


If your shift crosses midnight, you will enter 2 shifts in the Web Time Entry time sheet on the respective days.  For example, if you work
from 10PM to 2AM, simply enter 10PM to 12AM on day one and 12AM to 2AM on day two.  

The active link for each day will either be Enter Hours or the total number of hours for the day based on times you have already saved in
the system.  You will be able to edit and update all shifts for the entire pay period until you submit your time sheet for approval.  

The total number of hours worked for the month is updated based on the daily entries.  The total number of hours is available on the Time 
and Leave Reporting web page and in the Preview format on the Summary of Reported Time web page.  The student employee must submit the time
sheet on-line by Midnight on the first business day after the end of the pay period.

After entering all hours worked for the entire pay period, preview the monthly time sheet.  ONLY AFTER you have verified the completeness
and accuracy of the entire time sheet, click Submit for Approval. 

 The system will prompt for your PIN which acts as an electronic signature certifying your time sheet.  The deadline for submission of your
 monthly time sheet is Midnight of the first business day after the end of the pay period, but you can submit your time sheet earlier after you have worked your last scheduled shift of the month.  Remember to enter and save your times and preview the monthly time sheet prior to submitting your time sheet for approval. 

After you submit your time sheet for approval, you will see a message indicating it was submitted successfully.  You can monitor the status
of your time sheet to ensure your Supervisor approves the time sheet.  Your supervisor’s deadline is Midnight of the second business day 
after the end of the pay period.

If you realize you need to make corrections to your time sheet and your supervisor has not approved your time sheet and it is prior to your
submission deadline, you can simply click Return Time and make the changes.  You must then re-submit your time sheet by clicking Submit for
Approval.  If the Return Time button is not available, contact your supervisor immediately.

This concludes our Web Time Entry instruction video.  Realize…falsifying your time sheets with inaccurate information can result in 
termination.  If you have any questions, you may refer to the Web Time Entry Users guide located on the Student Employment web page, 
click the payroll web time entry link.  You can also contact your supervisor or the Payroll Office.</p>


        <strong>Shannon:</strong><p>
            The Payroll Office receives records of time worked by each employee and ensures
            proper payment in accordance with Northwest, Internal Revenue Service, and federal
            work-study policies and laws.
            Failure by supervisors or student employees to follow proper procedures may result
            in untimely payment to students and places Northwest in jeopardy in the event of
            an external audit.</p>
        <strong>Kelsi:</strong><p>
            Student employees are paid once per month following the month the work was performed. Student employees are paid on the 25th day of the month. If the 25th is a holiday or weekend, payment is made available in advance of the regular pay date. A published list of pay dates can be found on-line. 
Student employees have two options for receiving their pay - direct deposit or U.S. Bank Accelapay Card. Direct deposit allows pay to be automatically deposited in an existing checking or savings account at any bank. To enroll in direct deposit, a voided check or official correspondence from the bank that includes the routing and account numbers must be provided. It is important to remember if there are changes with the banking account that an updated Payroll Enrollment Form must be submitted to the Payroll Office. Changes in a banking account may include: closing an account, name changes, etc.
The Accelapay card is a MasterCard prepaid debit card issued by U.S. Bank. Pay is automatically loaded to the card which can be used to make purchases anywhere MasterCard debit cards are accepted.
</p>
        <strong>Jordan:</strong><p>
            What about taxes? Are taxes taken out of my check?</p>
        <strong>Shannon:</strong><p>
            Yes and no. Let me explain:<br />
            All student employee earnings, including federal work-study, are subject to state
            and federal withholding taxes. These forms are completed in the Office of Human
            Resources Management at the same time the Form I-9 is completed.<br />
            The W-4 form communicates how to calculate taxes. Some important guidelines to remember:<br />
            When a student employee claims “exempt”, a new W-4 form must be completed at the
            beginning of a new calendar year. A new W-4 form is also required when a name change
            is completed. A W-4 form may be completed here in our office, the Payroll Office,
            in the Administration Building.</p>
        <p>
            FICA taxes are a combination of social security and Medicare taxes. Student employees,
            including international students, are exempt from FICA taxes based on Internal Revenue
            Service Codes. This exemption exists only when enrollment of a minimum of six credit
            hours per academic trimester is verified with the University Registrar. Students
            enrolled in fewer than six credit hours per academic trimester are not eligible
            for the FICA tax exemption and therefore may not be paid as a student employee.</p>
        <strong>Kelsi:</strong><p>
            Thank you for explaining everything about our paychecks!</p>
        <strong>Shannon</strong><p>
            You're Welcome.</p>
    </div>
    <%--<div id="conversionChart">
        <div class="minutesHeader">
            # OF MINUTES</div>
        <div class="tenthsHeader">
            TENTHS OF HOUR</div>
        <div class="clear">
        </div>
        <div class="conversions">
            <div class="conversionFrom">
                57-02</div>
            <hr class="separator" />
            <div class="conversionTo">
                1.0 hour</div>
            <div class="clear">
            </div>
            <div class="conversionFrom">
                03-08</div>
            <hr class="separator" />
            <div class="conversionTo">
                .1 hour</div>
            <div class="clear">
            </div>
            <div class="conversionFrom">
                09-14</div>
            <hr class="separator" />
            <div class="conversionTo">
                .2 hour</div>
            <div class="clear">
            </div>
            <div class="conversionFrom">
                15-20</div>
            <hr class="separator" />
            <div class="conversionTo">
                .3 hour</div>
            <div class="clear">
            </div>
            <div class="conversionFrom">
                21-26</div>
            <hr class="separator" />
            <div class="conversionTo">
                .4 hour</div>
            <div class="clear">
            </div>
            <div class="conversionFrom">
                27-32</div>
            <hr class="separator" />
            <div class="conversionTo">
                .5 hour</div>
            <div class="clear">
            </div>
            <div class="conversionFrom">
                33-38</div>
            <hr class="separator" />
            <div class="conversionTo">
                .6 hour</div>
            <div class="clear">
            </div>
            <div class="conversionFrom">
                39-44</div>
            <hr class="separator" />
            <div class="conversionTo">
                .7 hour</div>
            <div class="clear">
            </div>
            <div class="conversionFrom">
                45-50</div>
            <hr class="separator" />
            <div class="conversionTo">
                .8 hour</div>
            <div class="clear">
            </div>
            <div class="conversionFrom">
                51-56</div>
            <hr class="separator" />
            <div class="conversionTo">
                .9 hour</div>
            <div class="clear">
            </div>
        </div>
    </div>
</div>--%>
<% }
   else
   { %>
This activity is completed.
<% } %>
