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
<div id="edit-workBook" class="content scaffold-edit" role="main">
    <g:if test="${flash.message}">
        <div class="message" role="status">
            ${flash.message}
        </div>
    </g:if>
    <g:hasErrors bean="${workBookInstance}">
        <ul class="errors" role="alert">
            <g:eachError bean="${workBookInstance}" var="error">
                <li
                    <g:if test="${error in org.springframework.validation.FieldError}">
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
    <g:formRemote id="workBook" name="subForm" url="[resource:workBookInstance,controller:'workBook', action:'update']"
                  update="show-workBook">
        <fieldset class="form">
            <g:render template="form"/>
        </fieldset>
        <fieldset class="buttons register">
        <g:actionSubmitImage id="formSubmit" src="${resource(dir: 'images/icons', file: 'save-icon.png')}"
                             action="update" name="update"
                             value="${message(code: 'default.button.update.label')}"
        />
        <p class="updateTip">
            <g:message code="update.label"/>
        </p>
    </fieldset>
    </g:formRemote>
</div>