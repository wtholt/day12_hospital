$(document).ready(function(){
  $('#create1').click(function(){
    validateForm();
  });

  $('.error-drug').delay(1000).fadeOut();


function validateForm(){

  var name = $('#nameInput').val();

  if (name == ""){
    $('#nameInput').after('Please enter a name')
  }
}

});
