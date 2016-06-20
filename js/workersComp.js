$(document).ready(function () {
    $.ajaxSetup({ cache: false });
    $("#additionalResources").dialog({ autoOpen: false, title: 'Resources', minWidth: 500, show: 'fade', hide: 'fade' });
    $("#transcript").dialog({ autoOpen: false, title: 'Video Transcript', minWidht: 500, width: 500, height: 500, show: 'fade', hide: 'fade' });
    $("#ModuleStatusComplete_WorkersComp").dialog({ autoOpen: false, title: 'Resources', minWidth: 500, show: 'fade', hide: 'fade' });
    $("#ModuleStatusIncomplete_WorkersComp").dialog({ autoOpen: false, title: 'Resources', minWidth: 500, show: 'fade', hide: 'fade' });

    $(document).ready(function () {
        $("#additionalResourcesButton").click(function () {
            $("#additionalResources").dialog("open");
        });

        $("#Workerstranscripts").click(function () {
            $("#transcript").dialog("open");
        });
    });
    $("input:button").button();
    $("input:submit").button();
    $("#tabs").tabs({ fx: { opacity: 'toggle' }, selected: $("#selectedIndex").val() });

    $("#workmansCompOptions, #workmansCompAnswers").sortable({ connectWith: ".wc_questionOptions" });

    $("#workmansCompOptions, #workmansCompAnswers").disableSelection();

    // calculate height
    var heightOfChildren = $(".wc_questionOptions li").css("height");
    var numberOfChildren = $("#workmansCompOptions").children("li").length;
    var newHeight = numberOfChildren * heightOfChildren;
    $("wc_answers").css("height", newHeight);
    $("wc_optionBox").css("height", newHeight);

    $("input:submit").click(function () {
        var answers = new Array();

        $("#workmansCompAnswers").children("li").each(function (index, element) {
            answers.push($(element).text());
        });


        answers.toString = function () {
            var str = "";
            this.forEach(function (element) {
                str += element + "\0";
            });
            return str;
        }

        $.post("Modules/workersComp/submit.aspx", { "answers": answers.toString() });
        $("#module").hide("slow")
                    .empty();
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
            if (progress["Worker's Compensation"].moduleCompleted) {
                $("#ModuleStatusComplete_WorkersComp").dialog("open");
            } else {
                $("#ModuleStatusIncomplete_WorkersComp").dialog("open");
            }
        });
    });
});