$(document).ready(function(){
  
  $('#create').click(function(){
    validateForm();
  });
  $('.error').delay(1000).fadeOut();

function validateForm(){

  var firstName = $('#firstNameInput').val();
  var lastName = $('#lastNameInput').val();

  if (firstName == ""){
    $('#firstNameInput').after('Please enter a first name')
  }
  if (lastName == ""){
    $('#lastNameInput').after('Please enter a last name')
  }
}
  

});