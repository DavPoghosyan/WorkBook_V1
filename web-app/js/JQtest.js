/**
 * Created by davit on 3/17/16.
 */
$().ready(function() {

    <!-- Real-time Validation -->
    <!-- First Name can't be less 2 chars -->
    $('#firstName').on('input', function() {
        var input = $(this);
        var firstNameLength = input.val().length;
        if (firstNameLength > 2) {
            input.removeClass("invalid").addClass("valid");
        } else {
            input.removeClass("valid").addClass("invalid");
        }
    });

    <!-- Last Name can't be less 2 chars -->
    $('#lastName').on('input', function() {
        var input = $(this);
        var firstNameLength = input.val().length;
        if(firstNameLength > 2) {
            input.removeClass("invalid").addClass("valid");
        } else {
            input.removeClass("valid").addClass("invalid");
        }
    });

    <!-- Email should match with email pattern -->
    $('#email').on('input', function() {
        var input=$(this);
        var emailPattern = /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/;
        var isEmail = emailPattern.test(input.val());
        if(isEmail) {
            input.removeClass("invalid").addClass("valid");
        } else {
            input.removeClass("valid").addClass("invalid");
        }
    });

    <!-- Passport Number should match with passport Number Pattern -->
    $('#passportNumber').on('input', function() {
        var input=$(this);
        var passportNumberPattern = /^[A-Z]{2}[0-9]{7}/;
        var isPassportNumber = passportNumberPattern.test(input.val());
        if(isPassportNumber) {
            input.removeClass("invalid").addClass("valid");
        } else {
            input.removeClass("valid").addClass("invalid");
        }
        ageCalculation()
    });

    <!-- After Form Submitted Validation-->
    submitValidation();

    $('#dateOfBirth_year, #dateOfBirth_month, #dateOfBirth_day').change(function() {
        ageCalculation();
    });



});

function ageCalculation() {
    var now = new Date();
    var birthDay = $('#dateOfBirth_day').val();
    var birthMonth = $('#dateOfBirth_month').val();
    var birthYear = $('#dateOfBirth_year').val();
    var dateOfBirth = new Date(birthYear, birthMonth, birthDay)
    var age = Math.floor((now-dateOfBirth) / (365.25 * 24 * 60 * 60 * 1000));
    var today = now.getDate()
    var tm = now.getMonth()+1
    if(birthMonth == tm &&  birthDay <= today ) {
       age += 1
   }
   $('#age').val(age);
}

function submitValidation() {

    $("#wb").submit(function(event){
        var form_data=$("#wb").serializeArray();
        var error_free=true;
        for (var input in form_data) {
            var element =$("#"+form_data[input]['name']);
            var invalid = element.hasClass("invalid");
            var error_element = $("span", element.parent());
            if (invalid) {
                error_element.removeClass("jq-error").addClass("error_show");
                error_free = false;
            } else {
                error_element.removeClass("error_show").addClass("jq-error");
            }
        }
        if (!error_free){
            event.preventDefault()
            return false
        } else {
            return true
        }
    });
}
