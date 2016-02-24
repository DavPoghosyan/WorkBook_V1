
<%@ page import="com.webbfontaine.training.WorkPlace" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'workPlace.label', default: 'WorkPlace')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>

	<body>

		<a href="#show-workPlace" class="skip" tabindex="-1">
			<g:message code="default.link.skip.label" default="Skip to content&hellip;"/>
		</a>
		<div class="nav" role="navigation">
			<ul>
				<li>
                    <a class="home" href="${createLink(uri: '/')}">
                        <g:message code="default.home.label"/>
                    </a>
                </li>
				<li>
                    <g:link class="list" action="index">
                        <g:message code="default.list.label" args="[entityName]" />
                    </g:link>
                </li>
				<li>
                    <g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" />
                    </g:link>
                </li>
			</ul>
		</div>
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
                <g:if test="${workPlaceInstance?.countryCode}">
                    <li class="fieldcontain">
                        <span id="countryCode-label" class="property-label">
                            <g:message code="workplace.countryCode.label" default="Country Code"/>
                        </span>
                        <span class="property-value" aria-labelledby="countryCode-label">
                            <g:fieldValue bean="${workPlaceInstance}" field="countryCode"/>
                        </span>
                    </li>
                </g:if>
                <g:if test="${workPlaceInstance?.companyCode}">
                    <li class="fieldcontain">
                        <span id="companyCode-label" class="property-label">
                            <g:message code="workplace.companyCode.label" default="Company Code"/>
                        </span>
                        <span class="property-value" aria-labelledby="lastName-label">
                            <g:fieldValue bean="${workPlaceInstance}" field="companyCode"/>
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
				<g:if test="${workPlaceInstance?.current}">
				    <li class="fieldcontain">
                        <span id="current-label" class="property-label">
                            <g:message code="workPlace.current.label" default="Current" />
                        </span>
                        <span class="property-value" aria-labelledby="current-label">
                            <g:formatBoolean boolean="${workPlaceInstance?.current}" />
                        </span>
				    </li>
				</g:if>
                <g:if test="${workPlaceInstance?.endDate}">
                    <li class="fieldcontain">
                        <span id="endDate-label" class="property-label">
                            <g:message code="workPlace.endDate.label" default="End Date" />
                        </span>
                        <span class="property-value" aria-labelledby="endDate-label">
                            <g:formatDate format="yyyy-MM-dd" date="${workPlaceInstance?.endDate}" />
                        </span>
                    </li>
                </g:if>
			</ol>
			<g:form url="[resource:workPlaceInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${workPlaceInstance}">
                        <g:message code="default.button.edit.label" default="Edit" />
                    </g:link>
					<g:actionSubmit class="delete" action="delete"
                                    value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                                    onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"
                    />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
