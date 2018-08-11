/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

//make jquery available in the global namespace, necessary to write js in the views.
window.$ = window.jQuery = require("jquery");

import 'bootstrap';
import initiateEditor from './pagedown';
import setDatepicker from './datepicker';
import setCourseAutocomplete from './tag_autocomplete';
import userEdit from './user_edit';
import userCourse from './user_course'

import Rails from 'rails-ujs';
import LocalTime from "local-time"

Rails.start();
LocalTime.start()

$(document).ready(ready)

function ready(){
  initiateEditor();
  setDatepicker();
  setCourseAutocomplete();
  userEdit();
  userCourse();

  $('[data-toggle="tooltip"]').tooltip();
  $('[data-toggle="popover"]').popover();
  
};

