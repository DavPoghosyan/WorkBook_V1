<script src="http://code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
<g:javascript src="formActions.js"/>
<div id="create-workPlace" class="content scaffold-edit" role="main">
    <h1>
        <g:message code="create.from.xml"/>
    </h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">
            ${flash.message}
        </div>
    </g:if>
<g:hasErrors bean="${workPlaceInstance}">
    <ul class="errors" role="alert">
        <g:eachError bean="${workPlaceInstance}" var="error">
            <li <g:if test="${error in org.springframework.validation.FieldError}">
                data-field-id="${error.field}"
            </g:if>>
                <g:message error="${error}"/>
            </li>
        </g:eachError>
    </ul>
</g:hasErrors>
<g:formRemote name="subForm" url="[resource:workPlaceInstance, controller:'workPlace', action:'remoteSave']" update="sub-content">
    <fieldset class="form">
        <g:render template="form"/>
    </fieldset>
    <fieldset class="buttons">
        <g:submitButton name="create" class="save"
                        value="${message(code: 'default.button.create.label', default: 'Create')}" />
    </fieldset>
</g:formRemote>