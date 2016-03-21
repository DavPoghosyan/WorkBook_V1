/**
 * Created by davit on 3/18/16.
 */
$().ready(function () {
    
    var now = new Date()
    $('#wp').validate({
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
    $('#startDate_year, #startDate_month, #startDate_day').change(function() {
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
