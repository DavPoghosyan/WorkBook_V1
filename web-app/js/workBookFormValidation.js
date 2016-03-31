/**
 * Created by davit on 3/18/16.
 */
$().ready(function () {
    /*$( "#datepicker" ).datepicker({
        inline: true
    });*/
    var now = new Date()
    $('#workBook').validate({
        errorClass: 'clientSideError',
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
            dateOfBirth_year: {
                ageValidation : true
            }
        },
    });

    $.validator.addMethod("ageValidation", function () {
        return  dateValidation();
    },invalidAge);

    $.validator.addMethod("passportNumberRegExp", function (value) {
        return  /^[A-Z]{2}[0-9]{7}/.test(value);
    },passportNumberInvalidMessage);

    $('#dateOfBirth_month').change(function() {
        $('#workBook').valid();
    });

    /*$('#endDate_year, #endDate_month, #endDate_day').change(function() {
        dateValidation($("#endDate"));
    });
*/

});

function dateValidation() {
    var now = new Date();
    var birthDay = $('#dateOfBirth_day').val();
    var birthMonth = $('#dateOfBirth_month').val();
    var birthYear = $('#dateOfBirth_year').val();
    var dateOfBirth = new Date(birthYear, birthMonth, birthDay)
    var age = Math.floor((now - dateOfBirth) / (365.25 * 24 * 60 * 60 * 1000));
    var today = now.getDate()
    var currentMonth = now.getMonth()+1
    if (birthMonth <= currentMonth && birthDay <= today) {
        age += 1
    }
    if(age < 18) {
        return false
    }
    return true
}