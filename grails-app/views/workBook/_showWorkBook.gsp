<g:javascript src="scroll.js"/>
<g:set var="entityName" value="${message(code: 'workBook.label')}"/>
<g:if test="${flash.message?.contains(entityName)}">
    <div class="message" role="status">
        ${flash.message}
    </div>
</g:if>
<h1>
    <g:message code="default.show.label" args="[entityName]"/>
</h1>
<ol class="property-list workBook">
    <li class="fieldcontain">
        <g:if test="${workBookInstance?.fullName}">
            <span id="fullName-label" class="property-label">
                <g:message code="workBook.fullName.label"/>
            </span>
            <span class="property-value" aria-labelledby="firstName-label">
                <g:fieldValue bean="${workBookInstance}" field="fullName"/>
            </span>
        </g:if>
    </li>
    <g:if test="${workBookInstance?.email}">
        <li class="fieldcontain">
            <span id="email-label" class="property-label">
                <g:message code="workBook.email.label"/>
            </span>
            <span class="property-value" aria-labelledby="email-label">
                <g:fieldValue bean="${workBookInstance}" field="email"/>
            </span>
        </li>
    </g:if>
    <g:if test="${workBookInstance?.passportNumber}">
        <li class="fieldcontain">
            <span id="passportNumber-label" class="property-label">
                <g:message code="workBook.passportNumber.label"/>
            </span>
            <span class="property-value" aria-labelledby="passportNumber-label">
                <g:fieldValue bean="${workBookInstance}" field="passportNumber"/>
            </span>
        </li>
    </g:if>
    <g:if test="${workBookInstance?.dateOfBirth}">
        <li class="fieldcontain">
            <span id="dateOfBirth-label" class="property-label">
                <g:message code="workBook.dateOfBirth.label"/>
            </span>
            <span class="property-value" aria-labelledby="dateOfBirth-label">
                <g:formatDate format="yyyy-MM-dd" date="${workBookInstance?.dateOfBirth}"/>
            </span>
        </li>
    </g:if>
    <g:if test="${workBookInstance?.age}">
        <li class="fieldcontain">
            <span id="age-label" class="property-label">
                <g:message code="workBook.age.label"/>
            </span>
            <span class="property-value" aria-labelledby="age-label">
                <g:fieldValue bean="${workBookInstance}" field="age"/>
            </span>
        </li>
    </g:if>
    <g:if test="${workBookInstance?.workPlaces}">
        <li class="fieldcontain">
            <span id="workplaces-label" class="property-label">
                <g:message code="workBook.workPlaces.label"/>
            </span>
            <table class="workplaces-table">
                <thead>
                <tr>
                    <g:sortableColumn property="company"
                                      title="${message(code: 'workPlace.company.label',)}"/>
                    <g:sortableColumn property="country"
                                      title="${message(code: 'workPlace.country.label',)}"/>
                    <g:sortableColumn property="startDate"
                                      title="${message(code: 'workPlace.startDate.label')}"/>
                    <g:sortableColumn property="endDate"
                                      title="${message(code: 'workPlace.endDate.label')}"/>
                </tr>
                </thead>
                <tbody>
                <g:each in="${workBookInstance.workPlaces}" status="i" var="workPlaceInstance">
                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                        <td>
                            <g:remoteLink class="showSub" controller="workPlace" action="show" update="sub" id="${workPlaceInstance.id}">
                                ${fieldValue(bean: workPlaceInstance, field: "company")}
                            </g:remoteLink>
                        </td>
                        <td>
                            ${fieldValue(bean: workPlaceInstance, field: "country")}
                        </td>
                        <td>
                            <g:formatDate format="yyyy-MM-dd" date="${workPlaceInstance.startDate}" />
                        </td>
                        <td>
                            <g:if test="${workPlaceInstance?.endDate}">
                                <g:formatDate format="yyyy-MM-dd" date="${workPlaceInstance.endDate}" />
                            </g:if>
                            <g:else>
                                <g:message code="workPlace.current.true.label"/>
                            </g:else>
                        </td>
                    </tr>
                </g:each>
                </tbody>
            </table>
            %{--<div class="pagination">
                <g:paginate total="${2 ?: 0}" />
            </div>--}%
        </li>
    </g:if>
    <sec:ifAllGranted roles="ROLE_ADMIN">
        <li class="fieldcontain">
                <g:remoteLink class="showSub addWorkPlace" controller="workPlace" action="add" update="sub" params="['workbook.id': workBookInstance?.id]">
                    ${message(code: 'default.add.label', args: [message(code: 'workPlace.label')])}
                </g:remoteLink>
        </li>
    </sec:ifAllGranted>
    <g:if test="${workBookInstance?.registeredAt}">
        <li class="fieldcontain">
            <span id="registeredAt-label" class="property-label">
                <g:message code="instance.registeredAt.label"/>
                <img src="${resource(dir:'images/icons', file:'clock-icon.png')}"/>
            </span>
            <span class="property-value" aria-labelledby="registeredAt-label">
                <g:formatDate format="yyyy-MM-dd hh:mm:ss" date="${workBookInstance?.registeredAt}"/>
            </span>
        </li>
    </g:if>
    <g:if test="${workBookInstance?.lastUpdatedAt}">
        <li class="fieldcontain">
            <span id="lastUpdatedAt-label" class="property-label">
                <g:message code="instance.lastUpdatedAt.label"/>
                <img src="${resource(dir:'images/icons', file:'clock-icon.png')}"/>
            </span>
            <span class="property-value" aria-labelledby="lastUpdatedAt-label">
                <g:formatDate format="yyyy-MM-dd hh:mm:ss" date="${workBookInstance?.lastUpdatedAt}"/>
            </span>
        </li>
    </g:if>
    <li class="fieldcontain">
        <span id="exports-label" class="property-label">
            <g:message code="show.export.label"/>
        </span>
        <span class="property-value">
                <g:jasperReport delimiter=" "
                            jasper="workBook" format="PDF" name="">
                <input type="hidden" name="id" value="${workBookInstance?.id}"/>
                <input type="hidden" name="age" value="${workBookInstance?.age}"/>
                <input type="hidden" name="logo" value="./grails-app/assets/images/logo.png"/>
                <g:link controller="xmlProcessing" action="exportAsXML" resource="${workBookInstance}">
                    <g:img dir="images/icons" file="xml-icon.png" title="XML" />
                </g:link>
            </g:jasperReport>
        </span>
    </li>
</ol>
<sec:ifAllGranted roles="ROLE_ADMIN">
    <fieldset class="buttons">
        <g:form url="[resource:workBookInstance, action:'delete']" method="DELETE" class="delete">
            <g:actionSubmitImage src="${resource(dir: 'images/icons', file: 'delete-icon.png')}" action="delete"
                                 value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                                 onclick="return confirm('${message(code: 'default.button.delete.confirm.message')}');"/>
            <p class="deleteTip">
                <g:message code="default.button.delete.label"/>
            </p>
        </g:form>
        <g:remoteLink class="edit" action="edit" resource="${workBookInstance}" update="show-workBook">
            <g:img dir="images/icons" file="edit-icon.png"/>
            <p class="editTip">
                <g:message code="default.button.edit.label"/>
            </p>
        </g:remoteLink>
    </fieldset>
</sec:ifAllGranted>

