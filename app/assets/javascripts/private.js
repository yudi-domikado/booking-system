//= require private/vendor/jquery-1.9.1.min
//= require jquery_ujs

//= require private/vendor/bootstrap-slider
//= require private/vendor/jquery.sparkline.min
//= require private/vendor/wysihtml5-0.3.0_rc2.min
//= require private/vendor/bootstrap-wysihtml5-0.0.2.min
//= require private/vendor/bootstrap-tags
//= require private/vendor/jquery.tablesorter.min
//= require private/vendor/jquery.tablesorter.widgets.min
//= require private/vendor/jquery.tablesorter.pager.min
//= require private/vendor/raphael.2.1.0.min
//= require private/vendor/jquery.animate-shadow-min
//= require private/vendor/bootstrap-multiselect
//= require private/vendor/bootstrap-datepicker
//= require jquery.timepicker
//= require private/vendor/bootstrap-colorpicker
//= require private/vendor/parsley.min
//= require private/vendor/formToWizard

//= require private/vendor/bootstrap.min
//= require private/vendor/bootstrap-editable.min
//= require private/thekamarel.min
//= require cocoon
//= require override_gon

//= require wiselinks
//= require_self

$(document).ready(function(){
	window.wiselinks = new Wiselinks($('body'), {html4: false} );
	var prepare_date_and_time_fields = function(){
    $('.timepick').timepicker({
      'scrollDefaultNow': true,
      'minTime': '1:00am',
      'maxTime': '12:00am',
      'step': 15
    });

    $(".datepick").datepicker({
      format: 'yyyy-mm-dd',
      autoclose: true,
      startDate: "0d",
      weekStart: 1
    });
  }
  
  var remove_container = function() {
    var container = $(this).parents("tr").last();
    var parent = $(this).parent();
    record_id = "#" + $(parent).find("input[type=hidden]").attr("id").replace("_destroy","id")
    $(container).slideUp("slow");

    if($(record_id).length < 1){
      $(container).remove();
    }
  };

  $('a.remove_fields').bind('click', remove_container);

  $('tbody.room_items').bind('cocoon:after-insert', function(e, insertedItem) {
    $(insertedItem).find('a.remove_fields').bind('click', remove_container);
    prepare_date_and_time_fields();
  });

  prepare_date_and_time_fields();

  if($('#pendingRoomContent').length){
    gon.watch('pending_rooms', {interval: 10000, url: '/private/pending-rooms', type: "GET", cache: true}, function(xhr){
      if(xhr.responseText != gon.pending_rooms && xhr.responseText.length){
        gon.pending_rooms = xhr.responseText;
        $('#pendingRoomContent .sidebarContent').html(String(gon.pending_rooms));
      }
    });
    gon.watch('total_pending_rooms', {interval: 10000, url: '/private/total-pending-rooms', type: "GET", cache: true}, function(xhr){
      if(xhr.responseText != gon.total_pending_rooms && xhr.responseText.length){
        gon.total_pending_rooms = xhr.responseText;
        $('.total_pending_room').html(String(gon.total_pending_rooms));
      }
    });
  }
  
})

