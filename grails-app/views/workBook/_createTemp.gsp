<div id="create-workBook" class="content scaffold-edit" role="main">
    <h1>
        <g:message code="remote.create.label" default="Create From XML Template"/>
    </h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">
            ${flash.message}
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
<g:formRemote name="subForm" url="[controller:'workBook', action:'remoteSave']" update="main_content">
    <fieldset class="form">
        <g:render template="form"/>
    </fieldset>
    <fieldset class="buttons">
        <g:submitButton name="create" class="save"
                        value="${message(code: 'default.button.create.label', default: 'Create')}" />
    </fieldset>
</g:formRemote>