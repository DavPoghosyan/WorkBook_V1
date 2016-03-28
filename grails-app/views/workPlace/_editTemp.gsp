<div id="edit-workPlace" class="content scaffold-edit" role="main">
    <h1>
        <g:message code="update.from.xml"/>
    </h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">
            ${flash.message}
        </div>
    </g:if>
    <g:hasErrors bean="${workPlaceInstance}">
        <ul class="errors" role="alert">
            <g:eachError bean="${workPlaceInstance}" var="error">
                <li
                    <g:if test="${error in org.springframework.validation.FieldError}">
                        data-field-id="${error.field}"
                    </g:if>>
                    <g:message error="${error}"/>
                </li>
            </g:eachError>
        </ul>
    </g:hasErrors>
    <g:formRemote name="subForm" url="[resource:workPlaceInstance,controller:'workPlace', action:'remoteSave']"
                  update="sub" method="POST">
        <fieldset class="form">
            <g:render template="form"/>
        </fieldset>
        <fieldset class="buttons">
            <g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label')}" />
        </fieldset>
    </g:formRemote>
</div>