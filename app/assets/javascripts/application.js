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
//= require foundation
//= require turbolinks
//= require_tree .

$(function(){ $(document).foundation(); });

$(document).ready(ready)
$(document).on('page:load', ready)

function ready() {

  if ($("#category_select select").val() == "University Related") 
    $("#tag_input").hide();

  $("#category_select select").change(function () {
    var category = $("#category_select select").val();
    if (category == "University Related") {
      $("#tag_input").hide();
      $("#tag_input input").val("General");
    }
    else {
      $("#tag_input").show();
      if (category == "Course Related") {
        $("#tag_input input").val("");
        $("#tag_input input").attr("placeholder", "Enter a course name... eg. MATH 101");
      }
      else if (category == "Program Related") {
        $("#tag_input input").val("");
        $("#tag_input input").attr("placeholder", "Enter a program... eg. Electrical Engineering");
      }
    }
  });

}

