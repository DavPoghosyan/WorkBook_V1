/**
 * Created by davit on 3/29/16.
 */
$().ready(function() {

    $('.closeSub').click(function () {
        $(this).hide()
        $('#sub').hide()
    })

    $('.showSub').click(function () {
        $('.closeSub').show()
        var aTag = $('#sub')
        aTag.show()
        $('html,body').animate({scrollTop: aTag.offset().top}, 'slow');
    })
});