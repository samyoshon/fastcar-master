jQuery(function() {
  var states;
  $('#proposal_car_model_id').parent().hide();
  states = $('#proposal_car_model_id').html();

  return $('#proposal_car_make_id').change(function() {
    var country, escaped_country, options;
    country = $('#proposal_car_make_id :selected').text();
    escaped_country = country.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1');
    options = $(states).filter('optgroup[label="' + escaped_country + '"]').html();
    if (options) {
      $('#proposal_car_model_id').html(options);
      return $('#proposal_car_model_id').parent().show();
    } else {
      $('#proposal_car_model_id').empty();
      return $('#proposal_car_model_id').parent().hide();
    }
  });

});