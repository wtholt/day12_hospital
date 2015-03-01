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

$(document).on('click', '.check-patient', function(){
  console.log('hello');
  var clinic_id = $(this).attr('clinic_id');
  var patient_id = $(this).attr('patient_id');
  $.ajax({
    type: 'PATCH',
    url: '/clinics/' + clinic_id + '/patients/' + patient_id + '/check_patient',
    dataType: 'script',
  })
})

$(document).on('click', '.examine-patient', function(){
  console.log('hello');
  var clinic_id = $(this).attr("clinic_id");
  var patient_id = $(this).attr("patient_id");
  $.ajax({
    type: 'PATCH',
    url: '/clinics/' + clinic_id + '/patients/' + patient_id + '/examine_patient',
    dataType: 'script',
  })
})

$(document).on('click', '.operate-patient', function(){
  console.log('hello');
  var clinic_id = $(this).attr("clinic_id");
  var patient_id = $(this).attr("patient_id");
  $.ajax({
    type: 'PATCH',
    url: '/clinics/' + clinic_id + '/patients/' + patient_id + '/operate_patient',
    dataType: 'script',
  })
})

$(document).on('click', '.leave-patient', function(){
  console.log('hello');
  var clinic_id = $(this).attr("clinic_id");
  var patient_id = $(this).attr("patient_id");
  $.ajax({
    type: 'PATCH',
    url: '/clinics/' + clinic_id + '/patients/' + patient_id + '/leave_patient',
    dataType: 'script',
  })
})

$(document).on('click', '.pay-patient', function(){
  console.log('hello');
  var clinic_id = $(this).attr('clinic_id');
  var patient_id = $(this).attr('patient_id');
  $.ajax({
    type: 'PATCH',
    url: '/clinics/' + clinic_id + '/patients/' + patient_id + '/pay_patient',
    dataType: 'script',
  })
})

$(document).on('click', '.submit-search', function() {
  console.log('hi')
  var clinic_id = $(this).attr('clinic_id');
  var search = $(".search-patient").val()
  $.ajax({
    type: "GET",
    url: '/clinics/' + clinic_id + '/patients/' + 'search',
    dataType: 'script',
    data: {q: search}
  })
});
