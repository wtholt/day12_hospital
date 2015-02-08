$(document).ready(function(){
  $('ul.clinic-pages > li').hide();
  $('li.paginate_1').show();
$('ul.clinic_list > li > a').click(function(){
  $('ul.clinic-pages > li').hide()
  var clinic_list = $(this).attr("clinic_num")
  $("li.paginate_" + clinic_list).show()
})



  $('#create').click(function(){
    validateForm();
  });
  $('.error-clinic').delay(1000).fadeOut();

  $('.notice').delay(1000).fadeOut()

  $('.jumbotron-clinics').hover(function() {
    $(this).css("cursor", "pointer");
    $(this).animate({
      opacity: 0.50,
    }, 'slow');
  }, function() {
    $(this).animate({
      opacity: 1,
    }, 'slow');
  });

function validateForm(){

  var name = $('#nameInput').val();

  if (name == ""){
    $('#nameInput').after('Please enter a name')
  }
}

});
