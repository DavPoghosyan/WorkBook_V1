<g:set var="entityName" value="${message(code: 'workBook.label')}"/>
<div id="edit-workBook" class="content scaffold-edit" role="main">
    <h1>
        <g:message code="edit.label" args="[entityName]"/>
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