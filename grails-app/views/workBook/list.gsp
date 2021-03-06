<%@ page import="com.webbfontaine.training.WorkBook" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'workBook.label')}"/>
		<title>
			<g:message code="default.list.label" args="[entityName]"/>
        </title>
		<g:set var="lang" value="${session.'org.springframework.web.servlet.i18n.SessionLocaleResolver.LOCALE'}"/>
	</head>
	<body>
	<div class="nav" role="navigation">
		<ul>
            <li>
                <g:link class="list" controller="workPlace" action="list">
                    <g:img dir="images/icons" file="workplaces-list-icon.png"/>
                    <p class="listTip">
                        <g:message code="workPlaces.list"/>
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
		<div id="list-workBook" class="content scaffold-list" role="main">
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
                        <g:sortableColumn property="lastName"
                                          title="${message(code: 'workBook.fullName.label')}"/>
                        <g:sortableColumn property="passportNumber"
                                          title="${message(code: 'workBook.passportNumber.label')}"/>
                        <g:sortableColumn property="email"
                                          title="${message(code: 'workBook.email.label')}"/>
						<g:sortableColumn property="dateOfBirth"
                                          title="${message(code: 'workBook.age.label')}"/>
						<g:sortableColumn property="dateOfBirth"
                                          title="${message(code: 'workBook.dateOfBirth.label')}"/>
                        <g:sortableColumn property="registeredAt"
                                          title="${message(code: 'instance.registeredAt.label')}"/>
                        <g:sortableColumn property="lastUpdatedAt"
                                          title="${message(code: 'instance.lastUpdatedAt.label')}"/>
					</tr>
                </thead>
				<tbody>
				    <g:each in="${workBookInstanceList}" status="i" var="workBookInstance">
					    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
						    <td class="refToDetails">
                                <g:link action="show" id="${workBookInstance.id}">
                                    ${fieldValue(bean: workBookInstance, field: "fullName")}
									<p class="title">
                                        <g:img dir="images/icons" file="details_icon.png"/>
									</p>
                                </g:link>
                            </td>
                            <td>${fieldValue(bean: workBookInstance, field: "passportNumber")}</td>
                            <td>${fieldValue(bean: workBookInstance, field: "email")}</td>
                            <td>${fieldValue(bean: workBookInstance, field: "age")}</td>
                            <td><g:formatDate format="yyyy-MM-dd" date="${workBookInstance.dateOfBirth}" /></td>
                            <td><g:formatDate format="yyyy-MM-dd hh:mm" date="${workBookInstance.registeredAt}" /></td>
                            <td><g:formatDate format="yyyy-MM-dd hh:mm" date="${workBookInstance.lastUpdatedAt}" /></td>

					    </tr>
				    </g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${workBookInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>