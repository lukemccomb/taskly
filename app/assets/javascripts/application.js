//= require jquery
//= require jquery_ujs
//= require_tree .

$(document).ready(function() {
//signature hello world
  console.log('Smells like updog in here');
//hiding tasks
  $('.task').hide();
//showing & hiding tasks
  $('.arrow').on('click', function() {
    var mom = $(this).parents('.task-list');
    $('.task').hide();
    $('.arrow').removeClass('arrow_rotate');
    var curr_task = mom.find('.task');
    if (curr_task.not(':visible')) {
     curr_task.slideDown();
     mom.find('.arrow').toggleClass('arrow_rotate');
    } else if (curr_task.is(':visible')) {
      curr_task.slideUp();
      mom.find('.arrow').toggleClass('arrow_rotate');
    }
  });
});
