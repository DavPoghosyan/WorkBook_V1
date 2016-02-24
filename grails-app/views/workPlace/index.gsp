
<%@ page import="com.webbfontaine.training.WorkPlace" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'workPlace.label', default: 'WorkPlace')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>

	<body>
		<a href="#list-workPlace" class="skip" tabindex="-1">
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
                    <g:link class="create" action="create">
                        <g:message code="default.new.label" args="[entityName]" />
                    </g:link>
                </li>
			</ul>
		</div>
		<div id="list-workPlace" class="content scaffold-list" role="main">
			<h1>
                <g:message code="default.list.label" args="[entityName]" />
            </h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">
                    ${flash.message}
                </div>
			</g:if>
			<table>
			    <thead>
					<tr>
                        <th>
                            <g:message code="workPlace.workbook.label" default="Workbook Owner"/>
                        </th>
                        <th>
                            <g:message code="workPlace.companyCode.label" default="Company Code"/>
                        </th>
                        <th>
                            <g:message code="workPlace.countryCode.label" default="Country Code"/>
                        </th>
                        <g:sortableColumn property="startDate"
                                          title="${message(code: 'workPlace.startDate.label', default: 'Start Date')}"/>
                        <g:sortableColumn property="current"
                                          title="${message(code: 'workPlace.current.label', default: 'Current')}"/>
                        <g:sortableColumn property="endDate"
                                          title="${message(code: 'workPlace.endDate.label', default: 'End Date')}"/>
					</tr>
                </thead>
				<tbody>
				    <g:each in="${workPlaceInstanceList}" status="i" var="workPlaceInstance">
					    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                            <td>
                                <g:link action="show" id="${workPlaceInstance.id}">
                                    ${fieldValue(bean: workPlaceInstance, field: "workbook")}
                                </g:link>
                            </td>
                            <td>
                                ${fieldValue(bean: workPlaceInstance, field: "companyCode")}
                            </td>
                            <td>
                                ${fieldValue(bean: workPlaceInstance, field: "countryCode")}
                            </td>
                            <td>
                                <g:formatDate format="yyyy-MM-dd" date="${workPlaceInstance.startDate}" />
                            </td>
                            <td>
                                <g:formatBoolean boolean="${workPlaceInstance.current}" />
                            </td>
                            <td>
                                <g:formatDate format="yyyy-MM-dd" date="${workPlaceInstance.endDate}" />
                            </td>
					    </tr>
				    </g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${workPlaceInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
