<%@ page import="com.webbfontaine.training.WorkBook" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'workBook.label', default: 'WorkBook')}"/>
		<title>
		    <g:message code="default.show.label" args="[entityName]"/>
        </title>
	</head>
	<body>
		<a href="#show-workBook" class="skip" tabindex="-1">
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
                        <g:message code="default.list.label" args="[entityName]"/>
                    </g:link>
                </li>
				<li>
                    <g:link class="create" action="create">
                        <g:message code="default.new.label" args="[entityName]"/>
                    </g:link>
                </li>
			</ul>
		</div>
		<div id="show-workBook" class="content scaffold-show" role="main">
			<h1>
				<g:message code="default.show.label" args="[entityName]"/>
			</h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">
                    ${flash.message}
                </div>
			</g:if>
			<ol class="property-list workBook">
				<g:if test="${workBookInstance?.lastName}">
                    <li class="fieldcontain">
                        <span id="lastName-label" class="property-label">
                            <g:message code="workBook.lastName.label" default="Last Name"/>
                        </span>
                        <span class="property-value" aria-labelledby="lastName-label">
                            <g:fieldValue bean="${workBookInstance}" field="lastName"/>
                        </span>
                    </li>
                </g:if>
				<g:if test="${workBookInstance?.email}">
                    <li class="fieldcontain">
                        <span id="firstName-label" class="property-label">
                            <g:message code="workBook.firstName.label" default="First Name"/>
                        </span>
                        <span class="property-value" aria-labelledby="firstName-label">
                            <g:fieldValue bean="${workBookInstance}" field="firstName"/>
                        </span>
                    </li>
                </g:if>
                <g:if test="${workBookInstance?.passportNumber}">
                    <li class="fieldcontain">
                        <span id="pasportNumber-label" class="property-label">
                            <g:message code="workBook.pasportNumber.label" default="Paspport Number"/>
                        </span>
                        <span class="property-value" aria-labelledby="passportNumber-label">
                            <g:fieldValue bean="${workBookInstance}" field="passportNumber"/>
                        </span>
                    </li>
                </g:if>
                <g:if test="${workBookInstance?.firstName}">
                    <li class="fieldcontain">
                        <span id="email-label" class="property-label">
                            <g:message code="workBook.email.label" default="Email"/>
                        </span>
                        <span class="property-value" aria-labelledby="email-label">
                            <g:fieldValue bean="${workBookInstance}" field="email"/>
                        </span>
                    </li>
                </g:if>
				<g:if test="${workBookInstance?.age}">
				    <li class="fieldcontain">
					    <span id="age-label" class="property-label">
                            <g:message code="workBook.age.label" default="Age"/>
                        </span>
						<span class="property-value" aria-labelledby="age-label">
                            <g:fieldValue bean="${workBookInstance}" field="age"/>
                        </span>
				    </li>
				</g:if>
				<g:if test="${workBookInstance?.dateOfBirth}">
                    <li class="fieldcontain">
                        <span id="dateOfBirth-label" class="property-label">
                            <g:message code="workBook.dateOfBirth.label" default="Date Of Birth"/>
                        </span>
                        <span class="property-value" aria-labelledby="dateOfBirth-label">
                            <g:formatDate format="yyyy-MM-dd" date="${workBookInstance?.dateOfBirth}"/>
                        </span>
                    </li>
				</g:if>
				<g:if test="${workBookInstance?.workplaces}">
                    <li class="fieldcontain">
                        <span id="workplaces-label" class="property-label">
                            <g:message code="workBook.workplaces.label" default="Workplaces"/>
                        </span>
                        <g:each in="${workBookInstance.workplaces}" var="w">
                            <span class="property-value" aria-labelledby="workplaces-label">
                                <g:link controller="workPlace" action="show" id="${w.id}">
                                    ${w.company.name + " " + w.country.code}
                                </g:link>
                            </span>
                        </g:each>
                    </li>
                </g:if>
			</ol>
			<g:form url="[resource:workBookInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${workBookInstance}">
                        <g:message code="default.button.edit.label" default="Edit"/>
                    </g:link>
					<g:actionSubmit class="delete" action="delete"
                                    value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                                    onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
