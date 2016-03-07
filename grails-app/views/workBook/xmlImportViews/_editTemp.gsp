<div id="edit-workBook" class="content scaffold-edit" role="main">
    <h1>
        <g:message code="update.from.xml"/>
    </h1>
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
    <g:formRemote name="subForm" url="[resource:workBookInstance,controller:'workBook', action:'remoteUpdate']"
                  update="main-content">
        <fieldset class="form">
            <g:render template="form"/>
        </fieldset>
        <fieldset class="buttons">
            <g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label')}" />
        </fieldset>
    </g:formRemote>
</div>