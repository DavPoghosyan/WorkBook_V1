/**
 * Created by davit on 3/29/16.
 */
$().ready(function() {
    function scrollToAnchor(aid) {
        var aTag = $("#sub")
        $('html,body').animate({scrollTop: aTag.offset().top}, 'slow');
    }

    $("#addWorkPlace").click(function () {
        scrollToAnchor('sub');
    });
});