//= require jquery
//= require jquery_ujs
//= require_tree .

$(document).ready(function() {
//signature hello world
  console.log('Smells like updog in here');
//Declaring global var
//login form
  $('.arrow').on('click', function() {
    var mom = $(this).parents('.task-list');
    mom.find('.task').toggle();
  });
});
