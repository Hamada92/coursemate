// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require jquery
//= require bootstrap-sprockets

$(function(){ $(document).foundation(); });

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

}

