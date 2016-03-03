<%@ page import="com.webbfontaine.training.WorkPlace" %>
<div id="show-workPlace" class="content scaffold-show" role="main">
    <g:if test="${id}">
        <g:set var="workPlaceInstance" value="${WorkPlace.get(id)}" />
        <h1>
            <g:message code="show.workPlace.label" default="Current"/>
        </h1>
    </g:if>
    <g:if test="${flash.message}">
        <div class="message" role="status">
            <h2>${flash.message}</h2>
        </div>
    </g:if>
<div id="show-workPlace" class="content scaffold-show" role="main">
    <h1><g:message code="default.show.label" args="[entityName]" /></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <ol class="property-list workPlace">

        <g:if test="${workPlaceInstance?.workbook}">
            <li class="fieldcontain">
                <span id="workbook-label" class="property-label">
                    <g:message code="workPlace.workbook.label" default="Workbook Owner" />
                </span>
                <span class="property-value" aria-labelledby="workbook-label">
                    <g:link
                            controller="workBook" action="show"
                            id="${workPlaceInstance?.workbook?.id}">${workPlaceInstance?.workbook?.encodeAsHTML()}
                    </g:link>
                </span>
            </li>
        </g:if>
        <g:if test="${workPlaceInstance?.company}">
            <li class="fieldcontain">
                <span id="companyCode-label" class="property-label">
                    <g:message code="workplace.company.label" default="Company"/>
                </span>
                <span class="property-value" aria-labelledby="lastName-label">
                    <g:fieldValue bean="${workPlaceInstance.company}" field="name"/>
                </span>
            </li>
        </g:if>
        <g:if test="${workPlaceInstance?.country}">
            <li class="fieldcontain">
                <span id="countryCode-label" class="property-label">
                    <g:message code="workplace.country.label" default="Country"/>
                </span>
                <span class="property-value" aria-labelledby="countryCode-label">
                    <g:fieldValue bean="${workPlaceInstance.country}" field="name"/>
                </span>
            </li>
        </g:if>
        <g:if test="${workPlaceInstance?.startDate}">
            <li class="fieldcontain">
                <span id="startDate-label" class="property-label">
                    <g:message code="workPlace.startDate.label" default="Start Date" />
                </span>
                <span class="property-value" aria-labelledby="startDate-label">
                    <g:formatDate format="yyyy-MM-dd" date="${workPlaceInstance?.startDate}" />
                </span>
            </li>
        </g:if>
        <li class="fieldcontain">
            <span id="endDate-label" class="property-label">
                <g:message code="workPlace.endDate.label" default="End Date" />
            </span>
            <span class="property-value" aria-labelledby="endDate-label">
                <g:if test="${workPlaceInstance?.endDate}">
                    <g:formatDate format="yyyy-MM-dd" date="${workPlaceInstance?.endDate}" />
                </g:if>
                <g:else>
                    <i>Up to now</i>
                </g:else>
            </span>
        </li>
    </ol>
</div>