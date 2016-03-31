/**
 * Created by davit on 3/18/16.
 */
$().ready(function () {
    /*$( "#datepicker" ).datepicker({
        inline: true
    });*/

    $('#workBook').validate({
        errorClass: 'clientSideError',
        rules: {
            firstName:{
                minlength: 3
            },
            lastName:{
                minlength: 3
            },
            email: {
                email: true
            },
            passportNumber: {
                passportNumberRegExp: true
            },
	        dateOfBirth_month: {
		        required : true
	        },
	        dateOfBirth_day: {
		        required : true
	        },
            dateOfBirth_year: {
                required : true
            }
        },
    });

	var now = new Date()
	var bdMonthOptions =$('#dateOfBirth_month option')
	var bdDayOptions =$('#dateOfBirth_day option')

	var bdYearSelector = $('#dateOfBirth_year')
	var bdMonthSelector = $("#dateOfBirth_month")
	var bdDaySelector = $('#dateOfBirth_day')
	var curMonth =  now.getMonth()+1
	var curDay = now.getDate()
	$('option:gt('+ curMonth + ')',bdMonthSelector).remove();
	/*$('option:gt('+ curDay + ')',bdDaySelector).remove();*/

	var bdSkip = false

    $.validator.addMethod("passportNumberRegExp", function (value) {
        return  /^[A-Z]{2}[0-9]{7}/.test(value);
    },passportNumberInvalidMessage);

	$('#dateOfBirth_year').change(function() {
		$.monthsPickerNormalization(bdYearSelector,bdMonthSelector,bdMonthOptions,bdSkip)
		$.daysPickerNormalization(bdYearSelector,bdMonthSelector,bdDaySelector,bdDayOptions)
	});
	$('#dateOfBirth_month').change(function() {
		$.daysPickerNormalization(bdYearSelector,bdMonthSelector,bdDaySelector,bdDayOptions)
	})

});
