	/*
** Created by davit on 2/25/16.
*/
$().ready(function(){
    $("#locale-selector").hide()
	$(".upload_btn").change(function() {
		$("#import").click()
	})

	$("body").mouseout(function(){
		if($('.clientSideError').is(':visible')) {
			$(".register").hide()
		} else {
			$(".register").show()
		}

	});
})
