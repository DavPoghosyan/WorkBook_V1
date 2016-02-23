
<%@ page import="com.webbfontaine.training.WorkBook" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'workBook.label', default: 'WorkBook')}"/>
		<title>
			<g:message code="default.list.label" args="[entityName]"/>
        </title>
	</head>
	<body>
		<a href="#list-workBook" class="skip" tabindex="-1">
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
                        <g:message code="default.new.label" args="[entityName]"/>
                    </g:link>
                </li>
			</ul>
		</div>
		<div id="list-workBook" class="content scaffold-list" role="main">
			<h1>
                <g:message code="default.list.label" args="[entityName]"/>
            </h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">
                    ${flash.message}
                </div>
			</g:if>
			<table>
			    <thead>
					<tr>
                        <g:sortableColumn property="fullName"
                                          title="${message(code: 'workBook.fullName.label', default: 'WorkBook Owner')}"/>
                        <g:sortableColumn property="pasportNumber"
                                          title="${message(code: 'workBook.passportNumber.label', default: 'Passport Number')}"/>
                        <g:sortableColumn property="email"
                                          title="${message(code: 'workBook.email.label', default: 'Email')}"/>
						<g:sortableColumn property="age"
                                          title="${message(code: 'workBook.age.label', default: 'Age')}"/>
						<g:sortableColumn property="dateOfBirth"
                                          title="${message(code: 'workBook.dateOfBirth.label', default: 'Date Of Birth')}"/>
					</tr>
                </thead>
				<tbody>
				    <g:each in="${workBookInstanceList}" status="i" var="workBookInstance">
					    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
						    <td>
                                <g:link action="show" id="${workBookInstance.id}">
                                    ${fieldValue(bean: workBookInstance, field: "fullName")}
                                </g:link>
                            </td>
                            <td>${fieldValue(bean: workBookInstance, field: "passportNumber")}</td>
                            <td>${fieldValue(bean: workBookInstance, field: "email")}</td>
                            <td>${fieldValue(bean: workBookInstance, field: "age")}</td>
                            <td><g:formatDate format="yyyy-MM-dd" date="${workBookInstance.dateOfBirth}" /></td>
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