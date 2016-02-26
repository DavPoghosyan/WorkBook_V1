/*
** Created by davit on 2/25/16.
*/
function createDialog(code) {
    $( "#"+code).dialog({
        modal: true,
        width: 'auto',
        height:'auto' ,
        buttons: [
            {
                text: "Confirm",
                click: function() { $(this).dialog("close"); }
            },
            {
                text: "Cancel",
                click: function() {
                    $(this).dialog("close");
                    $("#"+code+"Code").val('')
                }
            }
        ]
    })
}