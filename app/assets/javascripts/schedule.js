// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require newsticker
//= require override_gon
//= require_self

// $('.schedule_rows').vTicker({ 
//     speed: 500,
//     pause: 3000,
//     animation: 'fade',
//     mousePause: false,
//     showItems: 10,
//     parent_element: "tbody",
//     child_element: "tr"
//   });

$(document).ready(function() {
  var newDate = new Date();
  newDate.setDate(newDate.getDate());

  setInterval( function() {
    var seconds = new Date().getSeconds();
    $("#sec").html(( seconds < 10 ? "0" : "" ) + seconds);
    },1000);
    
  setInterval( function() {
    var minutes = new Date().getMinutes();
    $("#min").html(( minutes < 10 ? "0" : "" ) + minutes);
  },1000);
    
  setInterval( function() {
    var hours = new Date().getHours();
    $("#hours").html(( hours < 10 ? "0" : "" ) + hours);
  }, 1000);

  if($('#current_meeting').length > 0){
    var last_status = function(xhr, status){
      if(xhr.responseText !=  gon.current_meeting){
        gon.current_meeting = xhr.responseText;
        $('#current_meeting').html(gon.current_meeting);
      }
    }
    gon.watch('current_meeting', {interval: 10000, type: "GET", cache: true}, last_status)
  }

  if($('#next_meetings').length > 0){
    var next_statuses = function(xhr, status){
      if(xhr.responseText !=  gon.current_meeting){
        gon.next_meetings = xhr.responseText;
        $('#next_meetings').html(gon.next_meetings);
      }
    }
    gon.watch('next_meetings', {interval: 10000, type: "GET", cache: true}, next_statuses)
  }
  
}); 