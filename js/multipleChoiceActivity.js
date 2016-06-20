// Thinking of deprecating of this method infavor of formQuestionArrayWithjQueryObject
// for maintainance reasons
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

function formQuestionArrayWithjQueryObject(jqArray) {
    var questionArray = new Array();
    jqArray.each(function (index, element) {
        var question = Object();
        var questionOptions = Array();

        question.Text = $(element).find(".questionText").text();


        $(element).find("input.options").each(function (index_radio, element_opt) {
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