// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require dataTables/jquery.dataTables
//= require dataTables/bootstrap/3/jquery.dataTables.bootstrap
//= require dataTables/jquery.dataTables
//= require turbolinks
//= require underscore
//= require gmaps/google
//= require maps
//= require select2
//= require_tree .

$(document).on('ready page:load', function () {
  $('#to-do-activities').slimScroll({
    height: '600px'
  });

  $('.datatable').DataTable({
    pagingType: 'full_numbers',
    "bLengthChange": false,
    "iDisplayLength": 50,
  });

  $('.rsvp-datatable').DataTable({
    pagingType: 'full_numbers',
    "bLengthChange": false,
    "aaSorting": [[ 0, "desc" ]],
    "iDisplayLength": 50,
  });

  $(".select2").select2();

})
