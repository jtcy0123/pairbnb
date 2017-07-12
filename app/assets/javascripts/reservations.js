// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
  $( function() {
    // var array = ["2017-07-14","2017-07-15","2017-07-16"]
    // $('input').datepicker({
    //     minDate: 0,
    //     beforeShowDay: function(date){
    //         var string = jQuery.datepicker.formatDate('yy-mm-dd', date);
    //         return [ array.indexOf(string) == -1 ]
    //     }
    // });
   
    $( "#datepicker1" ).datepicker({
        dateFormat: "dd-mm-yy",
        minDate: 0, // user can checkin today
        onSelect: function (date) {
            var checkoutDate = $('#datepicker1').datepicker('getDate');
            checkoutDate.setDate(checkoutDate.getDate() + 1);
            $('#datepicker2').datepicker('setDate', checkoutDate); //by default, checkout date if next day
            $('#datepicker2').datepicker('option', 'minDate', checkoutDate);} //but user can reselect their date
    });
    $( "#datepicker2" ).datepicker({
        dateFormat: "dd-mm-yy",
        onClose: function () {
            var datepicker1 = $('#datepicker1').datepicker('getDate'); //checkin date
            var datepicker2 = $('#datepicker2').datepicker('getDate'); //checkout date
            if (datepicker2 <= datepicker1) {
                var minDate = $('#datepicker2').datepicker('option', 'minDate'); //checkin date plus 1
                $('#datepicker2').datepicker('setDate', minDate);}}
  
    });
  });