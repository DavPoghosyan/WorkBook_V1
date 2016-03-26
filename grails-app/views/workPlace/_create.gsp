<%@ page import="am.webbfontaine.training.rimm.Country; am.webbfontaine.training.rimm.Company; com.webbfontaine.training.*" %>
%{--<g:javascript src="workPlaceValidation.js"/>--}%
<link rel="stylesheet" href="${resource(dir: 'css', file: 'validation.css')}" type="text/css">
<g:set var="entityName" value="${message(code: 'workPlace.label')}"/>
<g:set var="today" value="${new Date()}"/>
<g:set var="minYear" value="${today[Calendar.YEAR]-100}"/>
<g:set var="maxYear" value="${today[Calendar.YEAR]}"/>
<g:set var="entityName" value="${message(code: 'workPlace.label')}" />
<g:javascript src="libs/jquery.validate.js"/>
<g:javascript src="workPlaceFormValidation.js"/>
<script src="http://code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
<g:javascript src="workPlaceFormActions.js"/>
<g:javascript>
	function retrieveCompanyData(id) {
		if(id){
		    createDialogCompany()
            <g:remoteFunction controller='workPlace' action='retrieveCompanyData'
                                      update='company-info' params="'id='+id"/>
	    }
    }
    function retrieveCountryData(id) {
        if(id){
            createDialogCountry()
            <g:remoteFunction controller='workPlace' action='retrieveCountryData'
                              update='country-info' params="'id='+id"/>
        }
    }
</g:javascript>
<h1>
	<g:message code="registration.form.label" args="[entityName]"/>
</h1>
<g:hasErrors bean="${workPlace}">
    <ul class="errors" role="alert">
        <g:eachError bean="${workPlace}" var="error">
            <li <g:if test="${error in org.springframework.validation.FieldError}">
                data-field-id="${error.field}"
            </g:if>>
                <g:message error="${error}"/>
            </li>
        </g:eachError>
    </ul>
</g:hasErrors>
<g:formRemote id="workPlace" name="subForm" url="[resource:workPlace, controller:'workPlace', action:'save']" update="sub">
        <fieldset class="form">
            <div class="fieldcontain ${hasErrors(bean: workPlace, field: 'workbook', 'error')} required" hidden>
                <label for="workBook">
                    <g:message code="workBook.fullName.label"/>
                    <span class="required-indicator">*</span>
                </label>
                <g:field id="workBook" name="workbook.id" type="number" value="${workPlace?.workbook?.id}"/>
            </div>
            <div class="fieldcontain ${hasErrors(bean: workPlace, field: 'company', 'error')} required">
                <label for="company">
                    <g:message code="workPlace.company.code"/>
                    <span class="required-indicator">*</span>
                </label>
                <g:select id="company" name="company.id"
                          from="${Company.listOrderByCode()}"
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
                          from="${Country.listOrderByCode()}"
                          optionKey="id" optionValue="code" class="many-to-one required"
                          value="${workPlace?.country?.id}"
                          noSelection="['':'- Choose Country Code -']"
                          onchange="retrieveCountryData(this.value);"
                />
            </div>
            <div class="fieldcontain ${hasErrors(bean: workPlace, field: 'startDate', 'error')} required">
                <label for="startDate">
                    <g:message code="workPlace.startDate.label"/>
                    <span class="required-indicator">*</span>
                </label>
                <g:datePicker name="startDate" precision="day" class="startDate"
                              value="${workPlace?.startDate}" years="${maxYear..minYear}"/>
            </div>
            <div class="addElement">
                <a id="current" class="addEndDate" href="#"> + Add End Date</a>
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
       before="return validateSearchForm()"
        />

        <p class="registerTip">
            <g:message code="register.label"/>
        </p>
    </fieldset>
</g:formRemote>
<fieldset class="countryDialog" hidden>
    <g:render template="countryDialog"/>
</fieldset>
<fieldset class="companyDialog" hidden>
    <g:render template="companyDialog"/>
</fieldset>
