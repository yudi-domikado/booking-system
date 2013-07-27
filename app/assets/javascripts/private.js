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
//= require private/vendor/bootstrap-colorpicker
//= require private/vendor/parsley.min
//= require private/vendor/formToWizard

//= require private/vendor/bootstrap.min
//= require private/vendor/bootstrap-editable.min
//= require private/thekamarel.min

//= require wiselinks
//= require_self

$(document).ready(function(){
	window.wiselinks = new Wiselinks($('body'), {html4: false} );
})

