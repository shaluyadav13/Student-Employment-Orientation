<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="activity.aspx.cs" Inherits="StudentOrientation.Modules.policies.activity" %>

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
        $("#additionalResourcesPolicies").dialog({ autoOpen: false, title: 'Resources', minWidth: 500, show: 'fade', hide: 'fade' });
        $("#Policiestranscript").dialog({ autoOpen: false, title: 'Video Transcript', minWidht: 500, width: 500, height: 500, show: 'fade', hide: 'fade' });
        $("#ModuleStatusComplete_Policies").dialog({ autoOpen: false, title: 'Submit Report', minWidth: 500, show: 'fade', hide: 'fade' });
        $("#ModuleStatusIncomplete_Policies").dialog({ autoOpen: false, title: 'Submit Report', minWidth: 500, show: 'fade', hide: 'fade' });

        $(document).ready(function () {
            $("#additionalResourcesButton").click(function () {
                $("#additionalResourcesPolicies").dialog("open");
            });

            $("#Policytranscripts").click(function () {
                $("#Policiestranscript").dialog("open");
            });
        });

        $("input:button").button();
        $("input:submit").button();
        $("input:submit").click(function () {
            var questionArray = Array();
            questionArray = formQuestionArray("#questions");

            $.post("Modules/Policies/submit.aspx", { "questions": questionArray }, function (nill) 
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
                    if (progress["Policies and Procedures"].moduleCompleted) {

                        $("#ModuleStatusComplete_Policies").dialog("open");


                    } else {

                        $("#ModuleStatusIncomplete_Policies").dialog("open");

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
                file: "flash/Policies.flv", //"http://cite.nwmissouri.edu/SE_Orientation/Flash/Policies.flv",
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
        <div id="questions" style="overflow: auto; width: 100%; max-height: 450px">
            <% for (int i = 0; i < questions.Count; i++)
               {
                   var question = questions[i];
            %>
            <div class="question">
                <div class="questionText" id="TextSize">
                    <%= question.Text %></div>
                <br />
                <% if (!question.isMultiAnswer() && !question.isOrderedQuestion())
                   { %>
                <% foreach (var optionKey in question.OptionAnswer.Keys)
                   { %>
                <div class="optionsContainer" >
                    <input class="options" name="questions_<%=i %>" type="radio" value="<%= optionKey %>"/><%= optionKey%>
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
        <%--<div id="questions" style="overflow: auto; width: 100%; max-height: 450px">
            <% for (int i = 0; i < questions.Count; i++)
               { %>
            <% var question = questions[i]; %>
            <div class="pol_page" style="overflow: auto">
                <input type="hidden" value="<%= videos[i] %>" />
                <div class="question">
                    <span class="questionText">
                        <%= question.Text %></span>
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
                        <input class="options" name="questions_<%=i %>" type="checkbox" value="<%= optionKey %>" /><%= optionKey%>
                        <br />
                    </div>
                    <% } %>
                    <% } %>
                </div>
            </div>
            <% } %>
        </div>--%>
    </div>
    <div id="ModuleStatusComplete_Policies">
        <div class="conversions">
            You successfully completed the module</div>
    </div>
    <div id="ModuleStatusIncomplete_Policies">
        <div class="conversions">
            You have not successfully completed the module. Please retake the module</div>
    </div>
    <div id="additionalResourcesPolicies">
        <div class="conversions">
            <table>
                <tr>
                    <td>
                        <a href="javascript:openWindow('http://www.nwmissouri.edu/hr/student/PDF/Student_Employment_Handbook2012.pdf')">
                            Northwest Student Employment Handbook</a> <br />
                        <a href="javascript:openWindow('http://www.nwmissouri.edu/studentaffairs/PDF/studenthandbook.pdf')">Northwest Student Handbook </a>
                    </td>
                </tr>
            </table>
        </div>
        <a href="#" id="Policytranscripts" >Video Transcript</a>
    </div>
    <div id="Policiestranscript">
        <strong>Kelsi:</strong><p>
            As in all employment, Student Employment has its own policies and procedures. These
            policies and procedures define the program and provide consistency on how the program
            operates. It is critical that student employees become aware of all policies and
            procedures. This module will cover the main policies and procedures. The student
            employment handbook, which can be found on-line, covers everything in detail. Let’s
            start with employment eligibility.</p>
        <strong>Jordan:</strong><p>
            Eligibility to work is based on a student’s enrollment status. Policies and procedures
            apply to both undergraduate and graduate students, excluding graduate assistants.</p>
        <p>
            A student must be enrolled in a minimum of six credit hours during any trimester
            to be eligible for employment. If enrollment falls below six credit hours, employment
            will be discontinued.</p>
        <strong>Kelsi:</strong><p>
            Summer enrollment requirements are the same. A student employee shall be enrolled
            in a minimum of six credit hours during the summer trimester regardless of the session(s)
            of enrollment.</p>
        <strong>Jordan:</strong><p>
            A student is eligible to work during the University intersession providing registration
            is complete for a minimum of six credit hours for the next trimester of coursework.
            If pre-registration is not complete, a letter of intent to enroll from the student
            shall be delivered to Student Employment.</p>
        <strong>Kelsi:</strong><p>
            Students may work with five or fewer credit hours only when it is their last trimester
            of coursework. In this case written notification must be given to Student Employment
            prior to the beginning of the trimester.</p>
        <strong>Kelsi:</strong><p>
            Now let’s look at hour limitations. A student employee may work up to 20 hours per
            week during the fall and spring trimesters. It is a maximum of 20 hours regardless
            of the number of positions that a student holds in the Student Employment Program.
            ARAMARK and off campus positions not affiliated with the Student Employment Program
            are not considered for the 20 hour a week limit unless the employee is an international
            student.</p>
        <strong>Jordan:</strong><p>
            A student may work up to 20 hours a week during the summer trimester session they
            are enrolled and up to 40 hours a week during the summer trimester sessions they
            are not enrolled if they have been enrolled in a total of six credit hours in any
            session of the summer trimester. A student may also work up to 40 hours a week or
            the equivalent of an eight-hour workday during official University breaks. At no
            time shall a student be allowed to work over 40 hours per week.</p>
        <strong>Kelsi:</strong><p>
            According to the U.S. Department of Homeland Security, U.S. Immigration and Customs
            Enforcement, international students are limited to a maximum of 20 hours per week
            during the fall and spring trimester and a maximum of 40 hours per week during the
            summer trimester sessions they are not enrolled and during official University breaks,
            regardless of the number of employers.</p>
        <p>
            A student employee is not allowed to work during scheduled class time.</p>
        <strong>Jordan:</strong><p>
            Each department or office may have additional policies. Work with your supervisor
            for full understanding of policies and procedures specific in your position.</p>
        <strong>Kelsi:</strong><p>
            Your schedule of work hours will vary depending which office or department you work
            for. Listen as a few supervisors explain how schedules work in their area.</p>
          <strong>Travis Stokes:</strong><p>  
          We understand that they are a student employee so they are a student first and so we 
          work around their class schedules.
          </p>
          <strong>Stacy Stokes:</strong><p>
            Our students work 8 to 5, Monday through Friday so we always have someone
             here in the office to answer the phones and cover the front counter. 
              We set our schedule well in advance at the beginning of each trimester and
               it is set for the semester.
          </p>
          <strong>Glenn Morrow:</strong><p>
          We are open several hours during the day.  We have to have someone at the library services 
          desk each of those hours and so it takes quite a bit of scheduling to accommodate that. 
          </p>
          <strong>Danny Smith:</strong><p>
          Student employees are allowed to work 20 hours a week or up to 20.
          </p>
          <strong>Jackie Loghry:</strong><p>
          We allow them to set their own schedule as long as it’s when we’re open which is Monday through Friday, eight to five. 
           They work ten hours each week in minimum two hour blocks a minimum of three days a week.
          </p>
          <strong>Linda Standerford:</strong><p>
          Once I tell them how many hours they are going to work per week then 
          I let them decide what hours they intend to work between the hours of eight to five, 
          Monday through Friday.
          </p>
          <strong>Travis Stokes:</strong>
          <p>
           Yes. I do allow flexible schedules.
          </p><strong>Linda Standerford:</strong><p>
          Yes.  We work with them.  If they’ve got a week that they’ve got a lot of tests or maybe they’ve got a huge project
           we absolutely work with them.
          </p><strong>Glenn Morrow:</strong><p>We do in some areas of the library.  
          Just as an example in the periodicals area we can allow some flexible schedules there.
          The majority of the areas, we can accommodate people except at the library services desk 
          and we need someone there each hour as I’ve stated, so the flexibility is not so much there.
          That doesn’t mean they don’t have the option of switching out hours and trading hours but
          the desk has to be covered.</p>
         <strong>Linda Standerford:</strong><p>Since our student employees are part time employees
           and generally they only work a few hours at a time, no, there is no need for a break.</p>
          <strong>Stacey Stokes:</strong><p>
          We don’t have any scheduled breaks figured into the day but if someone were to need to go across the hall
          to the rest room, to get a snack, we will work with them on that but we don’t schedule that into the day.
         </p>
         <strong>Kelsi: </strong><p>
         In summary, schedules are determined by the immediate supervisor and the student employee. 
          Flexible schedules are offered to help accommodate students and their academic success. 
           Any abuse of flexible scheduling may result in a discussion with the student employee.  
         </p><strong>Jordan:</strong><p>A student shall be given a meal break if they are scheduled to work 
         for an increment of eight hours or greater.  Additional breaks shall be discussed with the supervisor.
         Remember, no breaks are paid.</p>
         <strong>Kelsi:</strong><p>
          The university requires regular attendance and punctuality.  
         </p>
         <strong>Linda Standerford:</strong><p> 
         We definitely expect good attendance and punctuality.  That’s very important to the services
          we offer. So we do have a process in place if there is an employee that has issues with punctuality
           or tardiness. 
         </p><strong>Jackie Loghry:</strong><p>
         We expect the students to work the 10 hours a week that they identify that they will be in the 
         office so if they need to vary from those hours the policy is to contact the direct supervisor
         </p>
         <strong>Stacey Stokes:</strong><p>
         When you are arriving to work you need to be here on time making certain that we have the 
         front counter and the phone covered all times.
         </p>
         <strong>Travis Stokes:</strong><p>
         We do expect our students to show up on time as a lot of our job is out in the field and if 
         they tell us that they are going to be here at eight o’clock and they don’t show up until eight fifteen then
          we have just stood around waiting for them for fifteen minutes.
         </p>
         <strong>Linda Standerford:</strong><p>
         If they need to be absent from their position I would expect them to let me know as soon as 
         they can.  If they are sick, obviously those are kind of last minute situations, but whenever 
         possible we expect a notice as soon as we can get one.
         </p>
         <strong>Jackie Loghry:</strong><p>
         They can call, email or text.
         </p>
         <strong>Stacy Stokes:</strong><p>
         As soon as possible.  Most advance notice that we can get is what we would prefer.
         </p>
         <strong>Travis Stokes:</strong><p>
         If it’s a planned thing we would like at least a week’s notice for them.
         </p>
         <strong>Glenn Morrow:</strong><p>
         We expect someone to be here and if they can’t be here and it’s something that is preplanned 
         then we need to know in advance.
         </p>
         <strong>Danny Smith:</strong><p>
         The best way to answer that is be responsible
         </p>
         <strong>Kelsi: </strong><p>
         If prior communication is not feasible, communication shall be made as soon as possible.
         Excessive tardiness or absences may result in termination.      
         </p>
         <strong>Jordan:</strong><p>
         Now, we are going to address the University’s dress code policies.
         </p>
         <strong>Linda Standerford:</strong><p>
         We expect our student employees to dress like students.  That is completely acceptable as 
         long as there is nothing too revealing, low cut, high cut or anything offensive.
         </p>
         <strong>Jackie Loghry:</strong><p>
         There are a few events where we dress up.  We also have staff apparel. 
          We have a staff polo and a staff fleece.  When we have an event we dress in our uniforms.
         </p>
         <strong>Stacey Stokes:</strong><p>
         We do direct them on what to wear.  We don’t allow casual clothing in the office.  
         There are no T-shirts, there’s no screen printing on any of the shirts that are worn in
          the office.  We do not expect them to dress up every day but to look nice, to look 
          presentable, a step above casual.
         </p>
         <strong>Danny Smith:</strong><p>
         We do supply the students with five work T-shirts, a pair of safety glasses, and a pair 
         of gloves.
         </p>
         <strong>Travis Stokes:</strong><p>
         We have an environmental services T-shirt that they all wear.  And then, of course,
          our nifty name badge here.
         </p>
         <strong>Kathy Howell: </strong><p>
         Whatever they’re wearing to class.  We do say no hats.  We ask them not to wear hats.
         </p>
         <strong>Jordan:</strong><p>   
         In summary, attire shall be discussed with your supervisor.  However, the University does 
         request that students dress appropriately for their position.
         </p>
         <strong>Kelsi:</strong><p>
         Now let’s look at student employment transportation policies.
         </p>
         <strong>Monica McCollough:
         </strong><p>
         We have two student positions which we require drivers. The first is our student ticket writer 
         position.  We have a more unique position with our safe rides employees and what these students
          do is drive throughout town and it’s similar to a taxi service.
         </p><strong>Danny Smith:</strong><p>
         Our student employees will drive anything; mostly our utility vehicles and mowers.
           On occasion they will be required to drive a pickup and trailer, anything that deals with 
           our day to day activities.
         </p>
         <strong>Cindy Capps:</strong><p>
         It’s important for us to get around to every department on campus to deliver mail. 
          We go to some buildings twice a day with the heavier mail volume. We make sure we hit every
           department.
         </p><strong>
         Monica McCollugh:
         </strong><p>
         The first step is that within the student’s job description we need to clearly state that
          driving is a requirement for this position and so that’s the first step that it has to be 
          a U.S. state issued driver’s license.  The other thing is that we require all of our students 
          to be mindful of the rules of the road. We really train our students to be
         superstars, be mindful of everything while they are out on the road and to know that they 
         are in the public’s eye at that point. We train on the specific vehicles that the
         student will drive; certain vans.  One of those vans is going to be a handicap accessible 
          van.  Some departments require students to drive a 15 passenger van and that’s rented
         through the university.  Those vans do require a special certification called 15 Passenger
          Van Certification.  Once they have completed that training they are proficient in how to 
         maneuver such a large vehicle and they are good to go.
         </p>
         <strong>Kelsi: </strong><p>
         In summary, transportation may be an expectation for some student employment positions. 
         Student employees may be authorized to operate University vehicles within the city limits
         of Maryville to field study sites and University property within Nodaway County for the
         purpose of conducting university business provided they have a valid and appropriate
         driver’s license for the vehicle that they are operating and that they agree to drive 
         the vehicle in a safe and prudent manner.  Driver’s license requirements are in addition
         to any requirements, standards, suspensions or operating restrictions imposed by
         Missouri Law.  Drivers are also required to have a valid driver’s license in their
         possession at all times. Students expected to operate a fifteen passenger vehicle must
         complete a training session with the environmental services department prior to 
         operating the vehicle.  
         </p>
         <strong>Jordan:</strong><p>
         Now, let’s look at an array of additional campus policies.
         </p>
         <strong>
         Kelsi:
         </strong><p>
         Student employees shall refer to the Northwest Student Handbook for details on policies and procedures for nondiscrimination and 
         expected behavioral conduct in reference to: 
         Americans with Disability Act
         Consensual Amorous Relationships
         Alcohol and Drug Policy
          Sexual Harassment 
          Now we want to take a moment to discuss each of these issues.
         </p><strong>
         Jordan:
         </strong><p>
         The federal Americans with Disability Act provides a clear and comprehensive national mandate 
         for the elimination of discrimination against individuals with disabilities. 
         The law addresses employment, public service transportation, public accommodations and
          telecommunications. The individuals covered include persons who have a physical or mental 
          condition substantially impairing “major life activities”. 
         </p>
         <strong> Kelsi:  </strong><p>
         Consensual Amorous Relationships 
         </p>
         <strong>Jordan:</strong><p>
         Supervisors and student employees should be aware that consensual 
         (i.e., both parties have consented) romantic and/or sexual amorous
          relationships with subordinate employees have the potential for adverse consequences. 
          Even when both parties have consented to a relationship, there may be serious concerns 
          about the conflicts of interest and unfair treatment of others. 
         </p><strong>Kelsi:</strong><p>
         Alcohol and Drug Policy 
         </p>
         <strong>Jordan:</strong><p>
         Reporting to work under the influence of alcohol, illegal and/or controlled substances
          or the consumption of these products may result in immediate termination by the supervisor. 
         </p>
         <strong>Kelsi:</strong><p>
         Sexual Harassment 
         </p>
         <strong>Jordan:</strong><p>
         Any unwelcome attention of a sexual nature may be sexual harassment if it creates an
         intimidating, hostile or offensive environment or if it interferes with educational
          or work performance. Sexual harassment can be verbal, nonverbal, physical or written
         (including email). Sexual harassment is a violation of state and federal law as well 
         as Northwest policy. If you feel you have been sexually harassed, report the problem to
         the Equal Employment Opportunity (EEO) Officer at 562-1128.
         </p>
         <strong>Kelsi:</strong><p>
         Contact the Athletics Department for information regarding the Employment of a 
         Student Athlete and NCAA Regulation.
         </p>
    </div>
</div>
<% }
   else
   { %>
This activity is completed.
<% } %>