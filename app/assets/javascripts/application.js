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
//= require nested_form
//= require chosen.jquery.min
//= require jquery.cookie
//= require google-maps
//= require bootstrap-editable
//= require angular
//= require angular-ui-bootstrap
//= require angular-ui-bootstrap-tpls
//= require angular-google-maps
//= require_directory ./angular
//= require_directory ./angular/services
//= require_directory ./angular/controllers
//= require_tree .

$(document).ready(function() {
  $(".select-city").chosen({allow_single_deselect: true});

  $('#username').editable();
  $('#email').editable();
});
