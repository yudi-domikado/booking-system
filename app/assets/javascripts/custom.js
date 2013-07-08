$(document).ready(function() {

  $('.timepick').timepicker({
    'scrollDefaultNow': true,
    'minTime': '1:00am',
    'maxTime': '12:00am',
    'step': 15
  });

  $(".dp-icon").datepicker({
    dateFormat: 'dd/mm/yy',
    autoclose: true
  });

  $('.close').click(function() {
    $('.alert').fadeOut('medium');
  });

});