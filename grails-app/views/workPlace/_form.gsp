<%@ page import="rimm.Country; rimm.Company; com.webbfontaine.training.WorkBook" %>
<g:javascript>
    $(".find").change(function(){
    alert($(this).val())
        var numbers = [1, 2, 3, 4, 5];
        var option = '';
        var a=$(this).val()
        for (var i=0; i<5   ; i++){
            option += '<option value="'+ numbers[i] + '">' +   "${rimm.Country.where {code =~ '$a%'}.projections { distinct 'code' }.list()[0]}" + '</option>';
        }
        alert( "${rimm.Country.where {code =~ '" + $(this).val()+ "%'}.projections { distinct 'code' }.list()[0]}")

        $('#company').append(option)
    })

</g:javascript>
<g:formRemote id="workPlace" name="subForm" url="[resource:workPlace, controller:'workPlace', action:'save']" update="sub">
    <fieldset class="form">
        <div class="fieldcontain ${hasErrors(bean: workPlace, field: 'workbook', 'error')} required">
            <label for="workBook">
                <g:message code="workBook.fullName.label"/>
                <span class="required-indicator">*</span>
            </label>
            %{--<g:field id="workBook" name="workbook.id" type="number" value="${workPlace?.workbook?.id}"/>--}%
            <g:select id="workbook" name="workbook.id"
                      from="${com.webbfontaine.training.WorkBook.list()}" optionKey="id"
                      noSelection="['':'- Choose WorkBook Owner -']"
                      value="${workPlace?.workbook?.id}" class="many-to-one required"
            />
        </div>
        <div class="fieldcontain ${hasErrors(bean: workPlace, field: 'company', 'error')} required">
            <label for="company">
                <g:message code="workPlace.company.code"/>
                <span class="required-indicator">*</span>
            </label>
            <input class="find"/>
            <g:select id="company" name="company.id"
                      from="${rimm.Company.findAll{code =~ 'D%'}}"
                      optionKey="id" optionValue="code"
                      value="${workPlace?.company?.id}" class="many-to-one required"
                      noSelection="['':'- Choose Company Code -']"
                      onchange="retrieveCompanyData(this.value);"
            />
        </div>
        <div class="fieldcontain ${hasErrors(bean: workPlace, field: 'country', 'error')} required">
            <label for="country">
                <g:message code="workPlace.country.code"/>
                <span class="required-indicator">*</span>
            </label>
            <g:select id="country"  name="country.id"
                      from="${rimm.Country.where {code =~ 'P%'}.projections { distinct 'code' }.list()}"
                      class="many-to-one required"
                      value="${workPlace?.country?.id}"
                      noSelection="['':'- Choose Country Code -']"
                      onchange="retrieveCountryData(this.value);"
            />
        </div>
        <div class="fieldcontain ${hasErrors(bean: workPlace, field: 'startDate', 'er   ror')} required">
            <label for="startDate">
                <g:message code="workPlace.startDate.label"/>
                <span class="required-indicator">*</span>
            </label>
            <g:datePicker name="startDate" precision="day" class="startDate"
                          value="${workPlace?.startDate}" years="${maxYear..minYear}"/>
        </div>
        <div class="addElement">
            <a id="current" class="addEndDate" href="#">
                <g:message code="workPlace.add.endDate.label"/>
            </a>
        </div>
        <div id="endDate" class="fieldcontain ${hasErrors(bean: workPlace, field: 'endDate', 'error')}">
            <label for="endDate">
                <g:message code="workPlace.endDate.label"/>
            </label>
            <g:datePicker name="endDate" precision="day"  value="${workPlace?.endDate}"
                          default="none" noSelection="['': '']" years="${maxYear..minYear}"/>
        </div>
        <img src="${resource(dir:'images/icons', file:'ok-icon.png')}"/>
    </fieldset>
    <fieldset class="buttons register">
        <g:actionSubmitImage id="formSubmit" src="${resource(dir: 'images/icons', file: 'save-icon.png')}"
                             action="save" name="register"
                             value="${message(code: 'default.button.create.label')}"
        />

        <p class="registerTip">
            <g:message code="register.label"/>
        </p>
    </fieldset>
</g:formRemote>