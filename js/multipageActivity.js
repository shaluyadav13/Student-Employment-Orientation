function multiPage_init(content) 
{
    var firstPage = $(content).children().first();
    $(content + " > *").addClass("hiddenPage");
    firstPage.removeClass("hiddenPage").addClass("visiblePage");

    grabVideoPage(firstPage);

    $("#previousButton").button({ disabled: true });
	$("#nextButton").button();
	$("input:submit").button({ disabled: true });
	$("#nextButton").click(function(){ turnNextPage(content); });
	$("#previousButton").click(function() { turnPreviousPage(content); });
}

function turnNextPage(content)
{
	var nextPage = $(content).children(".visiblePage").next();
	var hasNextNextPage = $(content).children(".visiblePage").next().next().length > 0;
	var hasPreviousPage = $(content).children(".visiblePage").next().prev().length > 0; 
	$(content).children(".visiblePage").removeClass("visiblePage").addClass("hiddenPage");
	nextPage.addClass("visiblePage");

	grabVideoPage(nextPage);
	
	if(!hasNextNextPage) {
	    $("#nextButton").button("option", "disabled", true);
	    $("input:submit").button("option", "disabled", false);
	}
	
	if (hasPreviousPage) {
		$("#previousButton").button("option", "disabled", false);
    }  
}

function turnPreviousPage(content)
{
	var previousPage = $(content).children(".visiblePage").prev();
	var hasPreviousPreviousPage = $(content).children(".visiblePage").prev().prev().length > 0;
	var hasNextPage = $(content).children(".visiblePage").prev().next().length > 0;
	
	$(content).children(".visiblePage").removeClass("visiblePage").addClass("hiddenPage");
	previousPage.addClass("visiblePage");

	grabVideoPage(previousPage);
	
	if(!hasPreviousPreviousPage) {
		$("#previousButton").button("option", "disabled", true);
	}
	
	if(hasNextPage) {
		$("#nextButton").button("option","disabled", false);
	}	
}

function grabVideoPage(page) {
    if (page.children("input:hidden").length != 0) {
        $.ajax({
            url: $("input:hidden").val(),
            cache: false,
            success: function (html) {
                page.children(".video").empty().prepend(html)
            },
            failure: function (html) {
                $("#module").append("The video couldn't load for some reason. Sorry :(");
            }
        });
    }
}