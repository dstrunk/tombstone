$(function() {
  $('#aura_form_start_date').datepicker({
    dateFormat: 'mm-dd-yy',
    defaultDate: "+1w",
    changeMonth: true,
    onClose: function( selectedDate ) {
      $("#aura_form_end_date").datepicker( "option", "minDate", selectedDate );
    }
  });
  $('#aura_form_end_date').datepicker({
    dateFormat: 'mm-dd-yy',
    defaultDate: "+1w",
    changeMonth: true,
    onClose: function( selectedDate ) {
      $("#aura_form_start_date").datepicker( "option", "maxDate", selectedDate );
    }
  });
});
