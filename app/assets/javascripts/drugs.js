$(document).ready(function(){
  $('#create1').click(function(){
    validateForm();
  });

function validateForm(){

  var name = $('#nameInput').val();

  if (name == ""){
    $('#nameInput').after('Please enter a name')
  }
}

});
