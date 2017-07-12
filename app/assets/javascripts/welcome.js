  $( function() {
    $( "#dp1" ).datepicker({
        dateFormat: "dd-mm-yy",
        minDate: 0, // user can checkin today
        onSelect: function (date) {
            var checkoutDate = $('#dp1').datepicker('getDate');
            checkoutDate.setDate(checkoutDate.getDate() + 1);
            $('#dp2').datepicker('setDate', checkoutDate); //by default, checkout date if next day
            $('#dp2').datepicker('option', 'minDate', checkoutDate);} //but user can reselect their date
    });
    $( "#dp2" ).datepicker({
        dateFormat: "dd-mm-yy",
        onClose: function () {
            var datepicker1 = $('#dp1').datepicker('getDate'); //checkin date
            var datepicker2 = $('#dp2').datepicker('getDate'); //checkout date
            if (datepicker2 <= datepicker1) {
                var minDate = $('#dp2').datepicker('option', 'minDate'); //checkin date plus 1
                $('#dp2').datepicker('setDate', minDate);}}
  
    });
  });