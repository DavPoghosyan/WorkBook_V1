/**
 * Created by davit on 3/18/16.
 */
$().ready(function () {
    $('#wb').validate({
        lang: 'fi',
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
        },
      /*  messages: {
            firstName: {
                minlength: hello
            },
        }*/
    });

    $.validator.addMethod("passportNumberRegExp", function (value, element) {
        return  /^[A-Z]{2}[0-9]{7}/.test(value);
    },passportNumberInvalidMessage);
});
