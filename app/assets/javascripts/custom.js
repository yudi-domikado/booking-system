(function($){ 
  jQuery.fn.idle = function(time)
  { 
    var o = $(this); 
    o.dequeue();
    o.queue(function()
    { 
       setTimeout(function()
       { 
          o.dequeue(); 
       }, time);
    });
  };
})(jQuery);

$(document).ready(function() {

  $('.timepick').timepicker({
    'scrollDefaultNow': true,
    'minTime': '1:00am',
    'maxTime': '12:00am',
    'step': 15
  });

  $(".dp-icon").datepicker({
    dateFormat: 'dd/mm/yy',
    autoclose: true,
    startDate: "0d",
    weekStart: 1
  });

  $('.close').click(function() {
    $('.alert').fadeOut('medium');
  });

});
