<%@ page import="com.webbfontaine.training.WorkPlace" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'workPlace.label')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="nav" role="navigation">
			<ul>
				<li>
                    <a class="home" href="${createLink(uri: '/')}">
                        <g:message code="default.home.label"/>
                    </a>
                </li>
				<li>
                    <g:link class="list" action="list">
                        <g:message code="default.list.label" args="[entityName]" />
                    </g:link>
                </li>
                <sec:ifAllGranted roles="ROLE_ADMIN">
                    <li>
                        <g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" />
                        </g:link>
                    </li>
                </sec:ifAllGranted>
			</ul>
		</div>
		<div id="show-workPlace" class="content scaffold-show" role="main">
			<h1>
				<g:message code="default.show.label" args="[entityName]" />
			</h1>
			<g:if test="${flash.message}">
			    <div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list workPlace">

                <g:if test="${workPlaceInstance?.workbook}">
                    <li class="fieldcontain">
                        <span id="workbook-label" class="property-label">
                            <g:message code="workBook.fullName.label"/>
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
                            <g:message code="workPlace.company.label"/>
                        </span>
                        <span class="property-value" aria-labelledby="lastName-label">
                            <g:fieldValue bean="${workPlaceInstance.company}" field="name"/>
                        </span>
                    </li>
                </g:if>
                <g:if test="${workPlaceInstance?.country}">
                    <li class="fieldcontain">
                        <span id="countryCode-label" class="property-label">
                            <g:message code="workPlace.country.label"/>
                        </span>
                        <span class="property-value" aria-labelledby="countryCode-label">
                            <g:fieldValue bean="${workPlaceInstance.country}" field="name"/>
                        </span>
                    </li>
                </g:if>
                <g:if test="${workPlaceInstance?.startDate}">
                    <li class="fieldcontain">
                        <span id="startDate-label" class="property-label">
                            <g:message code="workPlace.startDate.label"/>
                        </span>
                        <span class="property-value" aria-labelledby="startDate-label">
                            <g:formatDate format="yyyy-MM-dd" date="${workPlaceInstance?.startDate}" />
                        </span>
                    </li>
                </g:if>
                <li class="fieldcontain">
                    <span id="endDate-label" class="property-label">
                        <g:message code="workPlace.endDate.label"/>
                    </span>
                    <span class="property-value" aria-labelledby="endDate-label">
                         <g:if test="${workPlaceInstance?.endDate}">
                            <g:formatDate format="yyyy-MM-dd" date="${workPlaceInstance?.endDate}" />
                         </g:if>
                        <g:else>
                            <g:message code="workPlace.current.true.label"/>
                        </g:else>
                    </span>
                </li>
                <g:if test="${workPlaceInstance?.registeredAt}">
                    <li class="fieldcontain">
                        <span id="registeredAt-label" class="property-label">
                            <g:message code="instance.registered.label"/>
                        </span>
                        <span class="property-value" aria-labelledby="registeredAt-label">
                            <g:formatDate format="yyyy-MM-dd hh:mm:ss" date="${workBookInstance?.registeredAt}"/>
                        </span>
                    </li>
                </g:if>
                <g:if test="${workPlaceInstance?.lastUpdatedAt}">
                    <li class="fieldcontain">
                        <span id="lastUpdatedAt-label" class="property-label">
                            <g:message code="instance.lastUpdatedAt.label"/>
                        </span>
                        <span class="property-value" aria-labelledby="lastUpdatedAt-label">
                            <g:formatDate format="yyyy-MM-dd hh:mm:ss" date="${workBookInstance?.lastUpdatedAt}"/>
                        </span>
                    </li>
                </g:if>
			</ol>
            <sec:ifAllGranted roles="ROLE_ADMIN">
                <fieldset class="buttons">
                    <g:form url="[resource:workPlaceInstance, action:'delete']" method="DELETE" class="delete">
                        <g:actionSubmitImage src="${resource(dir: 'images/icons', file: 'delete-icon.png')}" action="delete"
                                             value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                                             onclick="return confirm('${message(code: 'default.button.delete.confirm.message')}');"/>
                        <p class="deleteTip">
                            <g:message code="default.button.delete.label"/>
                        </p>
                    </g:form>
                    <g:link class="edit" action="edit" resource="${workPlaceInstance}">
                        <g:img dir="images/icons" file="edit-icon.png"/>
                        <p class="editTip">
                            <g:message code="default.button.edit.label"/>
                        </p>
                    </g:link>
                </fieldset>
            </sec:ifAllGranted>
		</div>
	</body>
</html>
