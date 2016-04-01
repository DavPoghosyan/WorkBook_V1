/**
 * Created by davit on 3/18/16.
 */
$().ready(function () {
    $('#workPlace').validate({
		errorClass: 'clientSideError',
        rules: {
            workbook:{
                required: true,
            },
            company:{
                required: true
            },
            country: {
                required: true,
            },
	        startDate_year: {
		        required: true,
                fullDate: true
	        }
        }
    });

    $.validator.addMethod("fullDate", function () {
        return sdMonthSelector.val() != '' && sdDaySelector.val() != ''
    },"inCompleteDate");

    $("#workPlace").mouseout(function(){
        if($('.clientSideError').is(':visible')) {
            $(".register").hide()
        } else {
            $(".register").show()
        }

    });
    $('.register').mouseover(function(){
        $('#workPlace').valid()
    })

	var now = new Date()
	var sdMonthOptions =$('#startDate_month option')
	var sdDayOptions =$('#startDate_day option')

	var sdYearSelector = $('#startDate_year')
	var sdMonthSelector = $("#startDate_month")
	var sdDaySelector = $('#startDate_day')
	var curMonth =  now.getMonth()+1
	var curDay = now.getDate()
	$('option:gt('+ curMonth + ')',sdMonthSelector).remove();
	//$('option:gt('+ curDay + ')',sdDaySelector).remove();

	var edMonthOptions =$('#endDate_month option')
	var edDayOptions =$('#endDate_day option')

	var edYearSelector = $('#endDate_year')
	var edMonthSelector = $("#endDate_month")
	var edDaySelector = $('#endDate_day')
	$('option:gt('+ curMonth + ')',edMonthSelector).remove();

	var sdSkip =false
	var enSkip =false

    $('#startDate_year').change(function() {
	    $.monthsPickerNormalization(sdYearSelector,sdMonthSelector,sdMonthOptions,sdSkip)
	    $.daysPickerNormalization(sdYearSelector,sdMonthSelector,sdDaySelector,sdDayOptions)
    });
	$('#startDate_month').change(function() {
	$.daysPickerNormalization(sdYearSelector,sdMonthSelector,sdDaySelector,sdDayOptions)
	})
	$('#endDate_year').change(function() {
		$.monthsPickerNormalization(edYearSelector,edMonthSelector,edMonthOptions,enSkip)
		$.daysPickerNormalization(edYearSelector,edMonthSelector,edDaySelector,edDayOptions)

	});
	$('#endDate_month').change(function() {
		$.daysPickerNormalization(edYearSelector,edMonthSelector,edDaySelector,edDayOptions)

	})


});



