function loadTutorial(module) {
    
    $.ajax({
        url: ("Modules/" + module + "/activity.aspx"),
        cache: false,
        success: function (html) {
            $("#module").hide("slow")
                        .empty()
                        .append("<div id=\"close\"/>")
                        .append(html)
                        .fadeIn("slow");

            $('#close').click(function (e) {
                //Need to perform a check to see if closing is enabled. Rigged a bit on the intoduction thing. SORRY CODE GODS.
                $("#module").fadeOut("slow");
                $(".modal").fadeOut("slow");
            });

        },
        failure: function (html) {
            $("#module").append("Sorry! The module couldn't load for some reason.");
        }
    });
}

$(document).ready(function () {
    $("#module").toggle();
    $("#Students").click(function () {
        loadTutorial("StudentsAboutSE");
    });
});