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

  function change_header_color(){
    var data_color = $(".banner-image").find("[data-color]");
    if(data_color.length){
      $("#header").css("background",data_color.attr("data-color"));
    }else{
      $("#header").css("background","#dc4f4f");
    }
  }
  
  if($('#current_meeting').length){
    gon.watch('current_meeting', {interval: 9000, url: window.location.pathname, type: "GET", cache: true}, function(xhr){
      if(xhr.responseText != gon.current_meeting && xhr.responseText.length){
        gon.current_meeting = xhr.responseText;
        $('#current_meeting').html(String(gon.current_meeting));
      }
      change_header_color();
    });
  }
  
  if($('#wrapper-schedule').length){
    gon.watch('next_meetings', {interval: 10000, url: window.location.pathname, type: "GET", cache: true}, function(xhr){
      if(xhr.responseText != gon.next_meetings){
        gon.next_meetings = xhr.responseText;
        $('#wrapper-schedule').html(String(gon.next_meetings));
      }
    });
  }

  change_header_color();
  
}); 