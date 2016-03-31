/**
 * Created by davit on 3/18/16.
 */
$().ready(function () {

    var now = new Date()
    var options =$('#startDate_month option')
    var optionsDays =$('#startDate_day option')

    var select = $('#startDate_month');
    var currentMonth = now.getMonth();
    $('option:gt('+ currentMonth + ')',select).remove();



    $('#workPlace').validate({
        rules: {
            workbook:{
                required: true,
            },
            company:{
                required: true
            },
            country: {
                required: true
            },
            startDate_month: {
                max : now.getMonth()+1
            },
            startDate_day: {
                max : now.getDate()
            },
            endDate_month: {
                max : now.getMonth()+1
            },
            endDate_day: {
                max : now.getDate()
            }
        }
    });


    $('#startDate_year, #startDate_month').change(function() {

        isLeap = new Date($('#startDate_year').val(), 1, 29).getMonth() == 1
        if($("#startDate_month").val() == 2) {
            $('option:gt(27)',$('#startDate_day')).remove();

            if(isLeap == true) {
                $('#startDate_day').append(optionsDays.get(28));
               // $('option:gt(28)',$('#startDate_day')).remove();
            }
        } else {
            /*alert(new Date($('#startDate_year').val(), $('#startDate_month').val(), 31).getMonth())
            alert($('#startDate_month').val())*/
            var month = parseInt($('#startDate_month').val())
            alert(month)

          // var isLongMonth = new Date($('#startDate_year').val(), $('#startDate_month').val(), 31).getMonth()-1 == month
           $('#startDate_day').append(optionsDays);
            alert(month%2 == 0)
            if(month < 8 && month%2 == 0 ) {
                $('option:gt(29)',$('#startDate_day')).remove();
            }
            if(month > 8 && month%2 != 0) {
                $('option:gt(29)', $('#startDate_day')).remove();
            }
           } /*else if(month%2 != 0) {
               $('option:gt(29)',$('#startDate_day')).remove();
           }*/


        if($("#startDate_year").val() < now.getFullYear()) {
            $('#startDate_month').append(options);
        } else {
            $('option:gt('+ currentMonth + ')',select).remove();
        }
        if($("#startDate_year").val() < now.getFullYear() || $("#startDate_month").val() < now.getMonth()+1) {
            $( "#startDate_month" ).rules( "remove");
            $( "#startDate_day" ).rules( "remove");
        } else {
            $("#startDate_month").rules("add", {max: now.getMonth() + 1});
            $("#startDate_day").rules("add", {max: now.getDate()});
        }
    });
    $('#endDate_year, #endDate_month, #endDate_day').change(function() {
        if($("#endDate_year").val() < now.getFullYear() || $("#endDate_month").val() < now.getMonth()+1) {
            $( "#endDate_month" ).rules( "remove");
            $( "#wndDate_day" ).rules( "remove");
        } else {
            $("#endDate_month").rules("add", {max: now.getMonth()+1});
            $( "#endDate_day" ).rules( "add", {max: now.getDate()});
        }
    });


});

