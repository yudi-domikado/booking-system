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

//= require jquery
//= require jquery.min
//= require jquery.1.9.min
//= require_self
//= require jquery-ui.min
//= require active_admin
//= require bootstrap
//= require head
//= require mobile
//= require scripts
//= require jquery.timepicker


$(document).ready(function() {
	$('.timepick').timepicker({
		'scrollDefaultNow': true,
		'minTime': '1:00am',
		'maxTime': '12:00am',
		'step': 15
	});

	$('#check_in_date').datepicker({
	    dateFormat: 'dd/mm/yy'
	});

	$('.close').click(function() {
		$('.alert').fadeOut('medium');
	});
});