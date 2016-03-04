<g:javascript>
    $(".message").click(function(){
        $("#show-workBook").hide("fast")
    })
</g:javascript>
<%@ page import="com.webbfontaine.training.WorkBook" %>
<div id="show-workBook" class="content scaffold-show" role="main">
    <g:if test="${id}">
        <g:set var="workBookDbInstance" value="${WorkBook.get(id)}" />
        <h1>
            <g:message code="show.workbook.label" default="Current"/>
        </h1>
    </g:if>
    <g:if test="${flash.message}">
        <div class="message" role="status">
            <h2>${flash.message}</h2>
        </div>
    </g:if>
    <ol class="property-list workBook">
        <g:if test="${workBookDbInstance?.lastName}">
            <li class="fieldcontain">
                <span id="lastName-label" class="property-label">
                    <g:message code="workBook.lastName.label" default="Last Name"/>
                </span>
                <span class="property-value" aria-labelledby="lastName-label">
                    <g:fieldValue bean="${workBookDbInstance}" field="lastName"/>
                </span>
            </li>
        </g:if>
        <g:if test="${workBookDbInstance?.email}">
            <li class="fieldcontain">
                <span id="firstName-label" class="property-label">
                    <g:message code="workBook.firstName.label" default="First Name"/>
                </span>
                <span class="property-value" aria-labelledby="firstName-label">
                    <g:fieldValue bean="${workBookDbInstance}" field="firstName"/>
                </span>
            </li>
        </g:if>
        <g:if test="${workBookDbInstance?.passportNumber}">
            <li class="fieldcontain">
                <span id="pasportNumber-label" class="property-label">
                    <g:message code="workBook.pasportNumber.label" default="Paspport No"/>
                </span>
                <span class="property-value" aria-labelledby="passportNumber-label">
                    <g:fieldValue bean="${workBookDbInstance}" field="passportNumber"/>
                </span>
            </li>
        </g:if>
        <g:if test="${workBookDbInstance?.firstName}">
            <li class="fieldcontain">
                <span id="email-label" class="property-label">
                    <g:message code="workBook.email.label" default="Email"/>
                </span>
                <span class="property-value" aria-labelledby="email-label">
                    <g:fieldValue bean="${workBookDbInstance}" field="email"/>
                </span>
            </li>
        </g:if>
        <g:if test="${workBookDbInstance?.age}">
            <li class="fieldcontain">
                <span id="age-label" class="property-label">
                    <g:message code="workBook.age.label" default="Age"/>
                </span>
                <span class="property-value" aria-labelledby="age-label">
                    <g:fieldValue bean="${workBookDbInstance}" field="age"/>
                </span>
            </li>
        </g:if>
        <g:if test="${workBookDbInstance?.dateOfBirth}">
            <li class="fieldcontain">
                <span id="dateOfBirth-label" class="property-label">
                    <g:message code="workBook.dateOfBirth.label" default="Date Of Birth"/>
                </span>
                <span class="property-value" aria-labelledby="dateOfBirth-label">
                    <g:formatDate format="yyyy-MM-dd" date="${workBookDbInstance?.dateOfBirth}"/>
                </span>
            </li>
        </g:if>
        <g:if test="${workBookDbInstance?.workplaces}">
            <li class="fieldcontain">
                <span id="workplaces-label" class="property-label">
                    <g:message code="workBook.workplaces.label" default="Workplaces"/>
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
    </ol>
</div>


        <g:if test="${workPlacesCount}">
            <div class="message"  role="status">
            <g:message code="import.workplaces.label" default="Found ${workPlacesCount} WorkPlaces info from XML connected this workbook check and add them or use just as templates:"/>
            <g:each in="${1..workPlacesCount}" var="i" >
                <g:message code="import.workplaces.label" default="WorkPlace:"/>
                <g:remoteLink controller="workPlace" action="createFromImport" update="sub-content"  params="[id:i]">${i}</g:remoteLink>
            </g:each>
        </g:if>
        </div>



