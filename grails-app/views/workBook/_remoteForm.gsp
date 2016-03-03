%{--<g:form url="[resource:workBookInstance, action:'save']" >
    <fieldset class="form">
        <g:render template="form"/>
    </fieldset>
    <fieldset class="buttons">
        <g:submitButton name="create" class="save"
                        value="${message(code: 'default.button.create.label', default: 'Create')}" />
    </fieldset>
</g:form>--}%
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
<g:formRemote name="subForm" url="[controller:'workBook', action:'remoteSave']" update="mainContent">
    <fieldset class="form">
        <g:render template="form"/>
    </fieldset>
    <fieldset class="buttons">
        <g:submitButton name="create" class="save"
                        value="${message(code: 'default.button.create.label', default: 'Create')}" />
    </fieldset>
</g:formRemote>