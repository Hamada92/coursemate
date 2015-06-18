$(document).ready(ready)
$(document).on('page:load', ready)

function ready() {

  if ($("#category_select").val() == "Program Related") 
    $("#tag_input").attr("placeholder", "Enter a program... eg. Electrical Engineering");
  else if ($("#category_select").val() == "University Related") 
    $("#tag_input").hide();

  $("#category_select").change(function () {
    if (this.value == "University Related") {
      $("#tag_input").hide();
      $("#tag_input").val("General");
    }
    else {
      $("#tag_input").show();
      if (this.value == "Course Related") {
        $("#tag_input").val("");
        $("#tag_input").attr("placeholder", "Enter a course name... eg. MATH 101");
      }
      else if (this.value == "Program Related") {
        $("#tag_input").val("");
        $("#tag_input").attr("placeholder", "Enter a program... eg. Electrical Engineering");
      }
    }
  });

  $("#question_body").summernote();

   $("#question_body").keyup(function() {
    $(".question_preview").html($("#question_body").val());
  });

  $(".question-card").click(function() {
    window.location.href = "/questions/" + this.id;
  });

  $(".stop-bubble").click(function(event) {
    event.stopImmediatePropagation();
  });


}


