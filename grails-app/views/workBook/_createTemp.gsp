<%@ page import="org.springframework.web.servlet.support.RequestContextUtils" %>
<g:javascript src="scroll.js"/>
<link rel="stylesheet" href="${resource(dir: 'css', file: 'validation.css')}" type="text/css">
<link rel="stylesheet" href="${resource(dir: 'css', file: 'jquery-ui.css')}" type="text/css">
<g:javascript src="libs/jquery.validate.js"/>
<g:javascript src="libs/jquery.localisation.js"/>
<g:javascript src="localisation/messages-${RequestContextUtils.getLocale(request).getLanguage()}.js"/>
<g:javascript src="datePickersNormalizations.js"/>
<g:javascript src="workBookFormValidation.js"/>
<g:set var="entityName" value="${message(code: 'workBook.label')}"/>
<g:if test="${flash.message}">
    <div class="message" role="status">
        ${flash.message}
    </div>
</g:if>
<g:if test="${flash.error}">
    <div class="errors" role="alert">
        <g:message error="${flash.error}"/>
    </div>
</g:if>
<g:hasErrors bean="${workBookInstance}">
    <ul class="errors" role="alert">
        <g:eachError bean="${workBookInstance}" var="error">
            <li <g:if test="${error in org.springframework.validation.FieldError}">
                data-field-id="${error.field}"
            </g:if>>
                <g:message error="${error}"/>
            </li>
        </g:eachError>
    </ul>
</g:hasErrors>
<h1>
    <g:message code="registration.form.label" args="[entityName]"/>
</h1>
<g:formRemote id="workBook" name="subForm" url="[controller:'workBook', action:'remoteSave']"
          update="show-workBook">
	<fieldset class="form">
	    <g:render template="form"/>
	</fieldset>
	<fieldset class="buttons register">
	    <g:actionSubmitImage src="${resource(dir: 'images/icons', file: 'save-icon.png')}"
	                         name="register" value="${message(code: 'default.button.create.label')}"/>
	    <p class="registerTip">
	        <g:message code="register.label"/>
	    </p>
	</fieldset>
</g:formRemote>
