// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require bootstrap-datepicker
//= require bootstrap-datetimepicker
//= require_tree .
$(document).ready(function() {
    $("[data-behaviour~='datetimepicker1']").datetimepicker({
    pickDate: true,            // disables the date picker
    pickTime: true             // disables de time picker
    });

    $("[data-behaviour~='datepicker']").datepicker({
        format: 'yyyy-mm-dd'
    });


    var date = new Date();
    var d = date.getDate();
    var m = date.getMonth();
    var y = date.getFullYear();

    $('#calendar').fullCalendar({
      editable: true,        
      header: {
              left: 'prev,next today',
              center: 'title',
              right: 'month,agendaWeek,agendaDay'
          },
          defaultView: 'agendaWeek',
          height: 500,
          slotMinutes: 15,
          minTime: 7,
          maxTime: 22,
          firstHour: 8,
          
          loading: function(bool){
              if (bool) 
                  $('#loading').show();
              else 
                  $('#loading').hide();
          },

          selectable: true,
          selectHelper: true,

          // a future calendar might have many sources.        
          eventSources: [{
              url: '/events',
              color: 'red',
              textColor: 'black',
              ignoreTimezone: false
          }],
          
          timeFormat: 'h:mm t{ - h:mm t} ',
          dragOpacity: "0.5",
          
          select: function(start, end, allDay) {
              window.location.replace("/events/new"+"?start="+start);
          },

          //http://arshaw.com/fullcalendar/docs/event_ui/eventDrop/
          eventDrop: function(event, dayDelta, minuteDelta, allDay, revertFunc){
              updateEvent(event);
          },

          // http://arshaw.com/fullcalendar/docs/event_ui/eventResize/
          eventResize: function(event, dayDelta, minuteDelta, revertFunc){
              updateEvent(event);
          },

          // http://arshaw.com/fullcalendar/docs/mouse/eventClick/
          eventClick: function(event, jsEvent, view){
              window.location.replace("/events/"+event.id+"/edit");
          },
    });


  function updateEvent(the_event) {
    $.ajax({
      type: 'put',
      url: "/events/" + the_event.id,
      headers: {
        'X-Transaction': 'put',
        'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
      },
      data: 
      { 
        event: { title: the_event.title,
                 starts_at: "" + the_event.start,
                 ends_at: "" + the_event.end,
                 description: the_event.description
           }
      },
      complete:  function (reponse) { }
    });
  };

  function addEvent(the_event) {
    $.ajax({
      type: 'post',
      url: "/events/",
      headers: {
        'X-Transaction': 'POST',
        'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
      },
      data: 
      { 
        event: { title: the_event.title,
                 starts_at: "" + the_event.start,
                 ends_at: "" + the_event.end,
                 description: the_event.description
           }
      },
      complete: function (reponse) { }
    });

  };
});