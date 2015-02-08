$(document).ready(function(){
  $('.list-group-item-index').hover(function(){
    $(this).css("cursor", "pointer");
    $(this).animate({
      opacity: 0.50,
    }, 'slow');
  }, function() {
    $(this).animate({
      opacity: 1,
    }, 'slow');
  });

  $('.jumbotron').hover(function() {
    $(this).css("cursor", "pointer");
    $(this).animate({
      opacity: 0.50,
    }, 'slow');
  }, function() {
    $(this).animate({
      opacity: 1,
    }, 'slow');
  });




});
