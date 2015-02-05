$(document).ready(function(){
  $('ul.drug-pages > li').hide();
  $('li.paginatedrug_1').show();


$("ul.link_list > li > a").click(function() {
  console.log("hi");
  $("ul.drug-pages > li").hide()
  var medication_list = $(this).attr("drug_num")
  $("li.paginatedrug_" + medication_list).show()
})





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
