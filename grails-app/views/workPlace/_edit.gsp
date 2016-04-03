<%@ page import="org.springframework.web.servlet.support.RequestContextUtils; am.webbfontaine.training.rimm.Country; am.webbfontaine.training.rimm.Company; com.webbfontaine.training.*" %>
%{--<g:javascript src="workPlaceValidation.js"/>--}%
<link rel="stylesheet" href="${resource(dir: 'css', file: 'validation.css')}" type="text/css">
<g:set var="entityName" value="${message(code: 'workPlace.label')}"/>
<g:set var="today" value="${new Date()}"/>
<g:set var="minYear" value="${today[Calendar.YEAR]-100}"/>
<g:set var="maxYear" value="${today[Calendar.YEAR]}"/>
<g:javascript src="localisation/messages-${RequestContextUtils.getLocale(request).getLanguage()}.js"/>
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
<h1>
    <g:message code="edit.label" args="[entityName]"/>
</h1>
<g:render template="form"/>
<fieldset class="countryDialog" hidden>
    <g:render template="countryDialog"/>
</fieldset>
<fieldset class="companyDialog" hidden>
    <g:render template="companyDialog"/>
</fieldset>
