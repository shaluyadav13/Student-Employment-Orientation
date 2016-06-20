var modules = ["introduction", "workHabits", "fedWorkStudy",
                "policies", "workersComp", "compensation",
                "confidentiality", "careerPathing", "events",
                "offices"];
var accordionIndex = [0, 1, 2, 3, 4, 5, 6, 7, 8];
var activeModule = 1;
var progress = "none";

function deferredActionCollection() {
    this.funcs = new Array();
    this.add = add;
    this.execute = execute;

    function add(f) {
        var fcall = f;
        if (typeof f != "function") {
            fcall = new Function(f);
        }
        this.funcs[this.funcs.length] = fcall;
    }

    function execute() {
        for (var i = 0; i < this.funcs.length; i++) {
            this.funcs[i](); // Call the function
        }
    }
}

var afterProgressIsKnown = new deferredActionCollection();

function updateProgress() {
    
    $.get('Modules/progress.aspx', function (data) {
        progress = jQuery.parseJSON(data);
        completedModules = 0;
        moduleCount = 0;
        /* the following block of code could be moved toimage6
        the deferred action collection class as member functions.
        Who wants to do that? Anyone? */
        for (var title in progress) {
            if (progress.hasOwnProperty(title)) 
            {
                if (progress[title].moduleCompleted)
                 {
                    completedModules++;
                }
                moduleCount++;
            }
        }
        if (!progress["Introduction"].moduleCompleted) {
            $(".modal").show();
            $("#module").toggle();
            loadTutorial("Introduction");
        }
        changeProgress((completedModules / moduleCount) * 100);
        if (completedModules == moduleCount) {
            loadTutorial("BriefCase");
        }
        /*-----*/
        afterProgressIsKnown.execute();

    });
}
function alert(msg) {
    $('<div>', {
        id: 'alert',
        text: msg,
        title: 'Alert'
    }).appendTo('body');

    $("#alert").dialog({
        close: function (event, ui) { $("#alert").remove(); }
    });
}

function changeProgress(val) {
    $("#progressbar").progressbar("value", val);
}

$(function () {
    $.get('Modules/progress.aspx', function (data) {
        $("#progressbar").progressbar({
            value: 0
        });
        updateProgress();
    });

});

//function getStudentProgress() {

//}
if (!Array.prototype.indexOf) {
    Array.prototype.indexOf = function (elt /*, from*/) {
        var len = this.length;

        var from = Number(arguments[1]) || 0;
        from = (from < 0)
         ? Math.ceil(from)
         : Math.floor(from);
        if (from < 0)
            from += len;

        for (; from < len; from++) {
            if (from in this &&
          this[from] === elt)
                return from;
        }
        return -1;
    };
}

$(document).ready(function () {
    $("#module").toggle();

    $("#fedWorkStudyLesson").click(function () {
        $("#selectedIndex").val("0");
        loadTutorial("fedWorkStudy");
    });
    $("#fedWorkStudyActivity").click(function () {
        $("#selectedIndex").val("1");
        loadActivity("fedWorkStudy");
    });

    $("#introductionTutorial").click(function () {
        if (progress["Introduction"].moduleCompleted) {
            //message to show....
        }
        else {
            $("#selectedIndex").val("0");
            loadActivity("Introduction");
        }

    });

    $("#introductionActivity").click(function () {
        if (progress["Introduction"].moduleCompleted) {
            //message to show....
        }
        else {
            $("#selectedIndex").val("1");
            loadActivity("Introduction");
        }
    });

    $("#workmansCompLesson").click(function () {
        $("#selectedIndex").val("0");
        loadTutorial("workersComp");
    });

    $("#workmansCompActivity").click(function () {
        $("#selectedIndex").val("1");
        $("#FlashInsert").hide();
        loadActivity("workersComp");
    });


    $("#workHabitsLesson").click(function () {
        $("#selectedIndex").val("0");
        $("#FlashInsert").hide();
        loadTutorial("workHabits");
    });

    $("#workHabitsActivity").click(function () {
        $("#selectedIndex").val("1");
        $("#FlashInsert").hide();
        loadActivity("workHabits");
    });

    $("#officesLesson").click(function () {
        $("#selectedIndex").val("0");
        loadTutorial("offices");
    });

    $("#officesActivity").click(function () {
        $("#selectedIndex").val("1");
        loadActivity("offices");
    });

    $("#eventsLesson").click(function () {
        $("#selectedIndex").val("0");
        loadTutorial("Events");
    })

    $("#eventsActivity").click(function () {
        $("#selectedIndex").val("1");
        loadActivity("Events");
    })

    $("#confidentialityLesson").click(function () {
        $("#selectedIndex").val("0");
        loadTutorial("confidentiality");
    });

    $("#confidentialityActivity").click(function () {
        $("#selectedIndex").val("1");
        loadActivity("confidentiality");
    });

    $("#careerPathingLesson").click(function () {
        $("#selectedIndex").val("0");
        loadTutorial("careerPathing");
    });

    $("#careerPathingActivity").click(function () {
        $("#selectedIndex").val("1");
        loadActivity("careerPathing");
    });

    $("#policiesLesson").click(function () {
        $("#selectedIndex").val("0");
        loadTutorial("policies");
    });

    $("#policiesActivity").click(function () {
        $("#selectedIndex").val("1");
        loadActivity("policies");
    });

    $("#compensationLesson").click(function () {
        $("#selectedIndex").val("0");
        loadTutorial("compensation");
    });

    $("#compensationActivity").click(function () {
        $("#selectedIndex").val("1");
        loadActivity("compensation");
    });

    $(".tempButton").click(function () {
        $("#accordion > h3:eq(" + this.id + ")").click();
        loadActivity(modules[this.id]);
    });

    $("#accordion").accordion({
        autoHeight: false,
        fillSpace: true
    });

    $('#close').click(function (e) {
        alert("you clicked it, lol");
        $(".modal").fadeOut("slow");
        $(this).parent().toggle("slow");
    });
    $("#briefCase").click(function () {
        loadTutorial("BriefCase");
    });
});

function loadTutorial(module) {
    $("#accordion > h3:eq(" + modules.indexOf(module) + ")").click(); //Move the accordion when they click a flash thing.
    $("#selectedIndex").val("0");
    $.ajax({
        url: ("Modules/" + module + "/activity.aspx"),
        cache: false,
        success: function (html) {
            $("#module").empty()
                        .append("<div id=\"close\"/>")
                        .append(html)
                        .fadeIn("slow");

            $('#close').click(function (e) {
                //Need to perform a check to see if closing is enabled. Rigged a bit on the intoduction thing. SORRY CODE GODS.

                if (module == "Introduction") {
                    if (progress["Introduction"].moduleCompleted) {
                        $(this).parent().fadeOut("slow")
                                        .empty();
                        $(".modal").fadeOut("slow");
                    }
                    else {
                        $.jGrowl('You must complete the introduction activity first.');
                    }
                }
                else if (module == "Work Habits and Attitudes") {
                    $(this).parent().fadeOut("slow").empty();
                    $(".modal").fadeout("slow");
                }
                else {
                    $(this).parent().fadeOut("slow")
                                    .empty();

                }
            });

        },
        failure: function (html) {
            $("#module").append("Sorry! The module couldn't load for some reason.");
        }
    });
}

function loadActivity(module) {
    updateProgress();
    $("#selectedIndex").val("1");
    $.ajax({
        url: ("Modules/" + module + "/activity.aspx"),
        cache: false,
        success: function (html) {
            $("#module").empty()
                        .append("<div id=\"close\"/>")
                        .append(html)
                        .fadeIn("slow");
            $("#tabs").tabs('option', 'selected', 1);
            $('#close').click(function (e) {
                //Need to perform a check to see if closing is enabled. Rigged a bit on the intoduction thing. SORRY CODE GODS.
                if (module == "Introduction") {
                    if (progress["Introduction"].moduleCompleted) {
                        $(this).parent().fadeOut("slow");
                        $(".modal").fadeOut("slow");
                    }
                    else {
                        $.jGrowl('You must complete the introduction activity first.');
                    }
                }
                else {
                    $(this).parent().fadeOut("slow")
                                    .empty();
                }
            });

        },
        failure: function (html) {
            $("#module").append("Sorry! The module couldn't load for some reason.");
        }

    });

}