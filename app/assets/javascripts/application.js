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
//= require summernote
//= require twitter/typeahead

$(document).ready(ready)
$(document).on('page:load', ready)

function ready() {

  var substringMatcher = function(strs) {
    return function findMatches(q, cb) {
      var matches, substringRegex;
   
      // an array that will be populated with substring matches
      matches = [];
   
      // regex used to determine if a string contains the substring `q`
      substrRegex = new RegExp(q, 'i');
   
      // iterate through the pool of strings and for any string that
      // contains the substring `q`, add it to the `matches` array
      $.each(strs, function(i, str) {
        if (substrRegex.test(str)) {
          matches.push(str);
        }
      });
   
      cb(matches);
    };
  };

  var course_tags = substringMatcher($('.typeahead').data('autocomplete-course'));
  var program_tags = substringMatcher($('.typeahead').data('autocomplete-program'));

  if ($("#category_select").val() == "Course Related") {
    var tags = course_tags;
  }
  else if ($("#category_select").val() == "Program Related") {
    $("#tag_input").attr("placeholder", "Enter a program... eg. Electrical Engineering");
    var tags = program_tags;
  }
  else if ($("#category_select").val() == "University Related")
    $("#tag_input").hide();

  $("#category_select").change(function () {
    if (this.value == "University Related") {
      $(".typeahead").typeahead("destroy");
      $("#tag_input").hide();
      $("#tag_input").val("General");
    }
    else {
      $("#tag_input").show();
      if (this.value == "Course Related") {
        $("#tag_input").val("");
        $("#tag_input").attr("placeholder", "Enter a course name... eg. MATH 101");
        $(".typeahead").typeahead("destroy");
        $('.typeahead').typeahead({
          hint: true,
          highlight: true,
          minLength: 1
        },
        {
          name: 'tags',
          source: course_tags
        });
      }
      else if (this.value == "Program Related") {
        $("#tag_input").val("");
        $("#tag_input").attr("placeholder", "Enter a program... eg. Electrical Engineering");
        $(".typeahead").typeahead("destroy");
        $('.typeahead').typeahead({
          hint: true,
          highlight: true,
          minLength: 1
        },
        {
          name: 'tags',
          source: program_tags
        });
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
   
  $('.typeahead').typeahead({
    hint: true,
    highlight: true,
    minLength: 1
  },
  {
    name: 'tags',
    source: tags
  });

  $("#change_password").click(function(){
    $("#change_password_fields").slideToggle();
  });

}









