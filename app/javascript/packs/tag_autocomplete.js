import 'typeahead.js'

export default function setCourseAutocomplete(){
  var course_tags = substringMatcher($('.typeahead').data('autocomplete-course'));  
  set_typeahead(course_tags);

  $("#university_select").change(function () {
    //get the new list of tags for this particular university
    $.ajax({
      method: 'GET',
      url: '/course_auto_completes',
      dataType: 'json',
      data: { domain: this.value },
      success: function(data){
        course_tags = substringMatcher(data);
        set_typeahead(course_tags);
      }
    });
  });

}

var substringMatcher = function(strs) {
  return function findMatches(q, cb) {
    var matches, substrRegex;
 
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

function set_typeahead(source){
  $(".typeahead").typeahead("destroy");
  $('.typeahead').typeahead({
    hint: true,
    highlight: true,
    minLength: 1
  },
  {
    name: 'tags',
    source: source
  });
};