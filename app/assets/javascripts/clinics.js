$(document).ready(function(){
  $('#create').click(function(){
    validateForm();
  });
  $('.error-clinic').delay(1000).fadeOut();

function validateForm(){

  var name = $('#nameInput').val();

  if (name == ""){
    $('#nameInput').after('Please enter a name')
  }
}

});
