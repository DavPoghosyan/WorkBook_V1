/**
 * Created by davit on 3/15/16.
 */
$(document).ready(function(){
    var hide = 'hide'
    var show = 'show'
    $(".slider").click(function(){
        $("#show-workBook").slideToggle("fast")
        $(this).text(function(i, v){
            return v === hide ? show : hide
        })
    })
})