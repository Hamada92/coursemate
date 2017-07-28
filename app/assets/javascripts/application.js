//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require jquery-fileupload/basic
//= require jquery-fileupload/jquery.fileupload-process
//= require jquery-fileupload/jquery.fileupload-validate
//= require twitter/typeahead
//= require local_time
//= require jquery.Jcrop
//= require pagedown_bootstrap
//= require exif
//= require moment
//= require bootstrap-datetimepicker

//= require_tree .

$(document).ready(ready)

function ready() {
  $('.datepicker').datetimepicker({
    format: 'MMMM Do YYYY, h:mm a',
    minDate: moment()
    
  });

  userEdit();

  setCourseAutocomplete();

  $('[data-toggle="tooltip"]').tooltip();
  $('[data-toggle="popover"]').popover();

}

function getOrientation(exifOrientation) {
  // gets orientation tag from image EXIF metadata
  var orientation = parseInt(EXIF.getTag(exifOrientation, 'Orientation'));
  switch(orientation) {
    case 2:
      return 'flip';
    case 3:
      return 'rotate-180';
    case 4:
      return 'flip-and-rotate-180';
    case 5:
      return 'flip-and-rotate-270';
    case 6:
      return 'rotate-90';
    case 7:
      return 'flip-and-rotate-90';
    case 8:
      return 'rotate-270';
  }
}
