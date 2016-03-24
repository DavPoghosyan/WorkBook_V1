<g:javascript src="slider.js"/>
<%@ page import="com.webbfontaine.training.WorkBook" %>
<a class="slider" href="#">hide</a>
<div id="show-workBook">
    <g:if test="${flash.message}">
        <div class="message">
            ${flash.message}
        </div>
    </g:if>
    <g:if test="${id}">
        <g:set var="workBookDbInstance" value="${WorkBook.get(id)}" />
    </g:if>
    <h1>
        <g:message code="show.workBook.current"/>
    </h1>
    <ol class="property-list workBook">
        <g:if test="${workBookDbInstance?.lastName}">
            <li class="fieldcontain">
                <span id="firstName-label" class="property-label">
                    <g:message code="workBook.firstName.label"/>
                </span>
                <span class="property-value" aria-labelledby="firstName-label">
                    <g:fieldValue bean="${workBookDbInstance}" field="firstName"/>
                </span>
            </li>
        </g:if>
        <g:if test="${workBookDbInstance?.email}">
            <li class="fieldcontain">
                <span id="lastName-label" class="property-label">
                    <g:message code="workBook.lastName.label"/>
                </span>
                <span class="property-value" aria-labelledby="lastName-label">
                    <g:fieldValue bean="${workBookDbInstance}" field="lastName"/>
                </span>
            </li>
        </g:if>
        <g:if test="${workBookDbInstance?.passportNumber}">
            <li class="fieldcontain">
                <span id="pasportNumber-label" class="property-label">
                    <g:message code="workBook.passportNumber.label"/>
                </span>
                <span class="property-value" aria-labelledby="passportNumber-label">
                    <g:fieldValue bean="${workBookDbInstance}" field="passportNumber"/>
                </span>
            </li>
        </g:if>
        <g:if test="${workBookDbInstance?.firstName}">
            <li class="fieldcontain">
                <span id="email-label" class="property-label">
                    <g:message code="workBook.email.label"/>
                </span>
                <span class="property-value" aria-labelledby="email-label">
                    <g:fieldValue bean="${workBookDbInstance}" field="email"/>
                </span>
            </li>
        </g:if>
        <g:if test="${workBookDbInstance?.dateOfBirth}">
            <li class="fieldcontain">
                <span id="dateOfBirth-label" class="property-label">
                    <g:message code="workBook.dateOfBirth.label"/>
                </span>
                <span class="property-value" aria-labelledby="dateOfBirth-label">
                    <g:formatDate format="yyyy-MM-dd" date="${workBookDbInstance?.dateOfBirth}"/>
                </span>
            </li>
        </g:if>
        <g:if test="${workBookDbInstance?.age}">
            <li class="fieldcontain">
                <span id="age-label" class="property-label">
                    <g:message code="workBook.age.label"/>
                </span>
                <span class="property-value" aria-labelledby="age-label">
                    <g:fieldValue bean="${workBookDbInstance}" field="age"/>
                </span>
            </li>
        </g:if>
        <g:if test="${flag}">
            <g:if test="${workBookDbInstance?.workplaces}">
                <li class="fieldcontain">
                    <span id="workplaces-label" class="property-label">
                        <g:message code="workBook.workplaces.label"/>
                    </span>
                    <g:each in="${workBookDbInstance.workplaces}" var="workplace">
                        <span class="property-value" aria-labelledby="workplaces-label">
                            <g:link controller="workPlace" action="show" id="${workplace.id}">
                                ${workplace}
                            </g:link>
                        </span>
                    </g:each>
                </li>
            </g:if>
            <li class="fieldcontain">
                <span id="exports-label" class="property-label">
                    <g:message code="show.export.label"/>
                </span>
                <span class="property-value">
                    <g:jasperReport delimiter=" "
                                    jasper="workBook" format="PDF" name="">
                        <input type="hidden" name="id" value="${id}"/>
                        <g:link controller="xmlProcessing" action="exportAsXML" resource="${workBookInstance}">
                            <img src="${resource(dir:'images/icons', file:'xml-icon.gif')}" title="XML" />
                        </g:link>
                    </g:jasperReport>
                </span>
            </li>
        </g:if>
    </ol>
</div>