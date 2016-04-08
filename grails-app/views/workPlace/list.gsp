
<%@ page import="com.webbfontaine.training.WorkPlace" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'workPlace.label', default: 'WorkPlace')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="nav" role="navigation">
            <ul>
                <li>
                    <g:link class="list" controller="workBook" action="list">
                        <g:img dir="images/icons" file="home-icon.png"/>
                        <p class="listTip">
                            <g:message code="workBooks.list"/>
                        </p>
                    </g:link>
                </li>
                <sec:ifAllGranted roles="ROLE_ADMIN">
                    <li>
                        <g:link class="create" action="create">
                            <g:img dir="images/icons" file="add-icon.png"/>
                            <p class="createTip">
                                <g:message code="add.new.label"/>
                            </p>
                        </g:link>
                    </li>
                </sec:ifAllGranted>
            </ul>
		</div>
		<div id="list-workPlace" class="content scaffold-list" role="main">
			<h2>
                <g:message code="default.list.label" args="[entityName]" />
            </h2>
			<g:if test="${flash.message}">
				<div class="message" role="status">
                    ${flash.message}
                </div>
			</g:if>
			<table>
			    <thead>
					<tr>
                        <g:sortableColumn property="workbook"
                                          title="${message(code: 'workBook.fullName.label',)}"/>
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
				    <g:each in="${workPlaceInstanceList}" status="i" var="workPlaceInstance">
					    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                            <td>
                                <g:link action="show" id="${workPlaceInstance.id}">
                                    ${fieldValue(bean: workPlaceInstance, field: "workbook")}
                                </g:link>
                            </td>
                            <td>
                                ${fieldValue(bean: workPlaceInstance, field: "company")}
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
			<div class="pagination">
				<g:paginate total="${workPlaceInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
