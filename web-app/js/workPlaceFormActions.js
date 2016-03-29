	/*
** Created by davit on 2/25/16.
*/
$().ready(function(){
	var removeEndDateTxt = ' - Remove End Date'
	var addEndDateTxt = ' + Add End Date'
	if($("#endDate_day").val() == ''){
		$("#endDate").hide()
	} else {
		$(".addEndDate").text(removeEndDateTxt)
	}
	$(".addEndDate").click(function(){
		$("#endDate_day").val('').removeClass("invalid").addClass("valid");
		$("#endDate_month").val('').removeClass("invalid").addClass("valid");
		$("#endDate_year").val('').removeClass("invalid").addClass("valid");
		$("#endDate").slideToggle("fast")
		$(this).text(function(i, v){
			return v === addEndDateTxt ? removeEndDateTxt : addEndDateTxt
		})
	})
	$("#endDate_day").change(function() {
		$("checkBox").prop('checked', true)
	})

    $("body").mouseout(function(){
        if($('.clientSideError').is(':visible')) {
            $(".register").hide()
        } else {
            $(".register").show()
        }

    });

   /* $('#formSubmit').on('show', function() {
        alert('#foo is now visible');
        $("#formSubmit").hide()
    });

    $('.error').on('hide', function() {
        alert('#foo is hidden');
        $("#formSubmit").show()
    });*/

})
function createDialogCompany() {
	$( "#company-info").dialog({
		modal: true,
		width: '300',
		height:'150' ,
		buttons: [
			{
				text: "Confirm",
				click: function() { $(this).dialog("close"); }
			},
			{
				text: "Cancel",
				click: function() {
					$(this).dialog("close");
					$("#company").val('')
				}
			}
		]
	})
}
function createDialogCountry() {
    $( "#country-info").dialog({
        modal: true,
        width: '300',
        height:'150' ,
        buttons: [
            {
                text: "Confirm",
                click: function() { $(this).dialog("close"); }
            },
            {
                text: "Cancel",
                click: function() {
                    $(this).dialog("close");
                    $("#country").val('')
                }
            }
        ]
    })
}

(function ($) {
    $.each(['show', 'hide'], function (i, ev) {
        var el = $.fn[ev];
        $.fn[ev] = function () {
            this.trigger(ev);
            return el.apply(this, arguments);
        };
    });
})(jQuery);


