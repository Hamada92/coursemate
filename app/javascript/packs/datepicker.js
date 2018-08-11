import moment from 'moment'
import datetimepicker from 'eonasdan-bootstrap-datetimepicker'

export default function set_datepicker(){
  $('.datepicker').datetimepicker({
    format: 'MMMM Do YYYY, h:mm a',
    minDate: moment()
  });
}
