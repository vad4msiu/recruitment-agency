// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery-ui
//= require jquery-ujs
//= require bootstrap/dist/js/bootstrap.min.js
//= require bootstrap-datepicker/dist/js/bootstrap-datepicker.min.js
//= require tag-it/js/tag-it.min.js
//= require_tree .

$(document).ready(function() {
  $(".form-skills").tagit({
    fieldName: $(".form-skills").data("namespace") + "[skill_titles][]",
    autocomplete: { source: "/api/skills/search.json" }
  });
});