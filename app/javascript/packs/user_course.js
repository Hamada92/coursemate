export default function userCourse() {
  $('#edit-courses-list').click(function(event) {
    event.stopPropagation()
    $('#user-course-form').toggle();
  });
}
