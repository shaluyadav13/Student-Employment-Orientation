$(document).ready(function () {
    $.ajaxSetup({ cache: false });
    $("#transcript").dialog({ autoOpen: false, title: 'Video Transcript', minWidht: 500, width: 500, height: 500, show: 'fade', hide: 'fade' });
    $(document).ready(function () {
        $("#transcripts").lvie('click',function() {
            $("#transcript").dialog("open");
        });
    });
});