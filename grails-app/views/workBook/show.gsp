<%@ page import="com.webbfontaine.training.WorkBook" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'workBook.label')}"/>
		<g:set var="id" value="${workBookInstance.id}"/>
		<title>
		    <g:message code="default.show.label" args="[entityName]"/>
        </title>
	</head>
	<body>
		<div class="nav" role="navigation">
			<ul>
                <li>
                    <a class="home" href="${createLink(uri: '/')}">
                        <g:img dir="images/icons" file="home-icon.png"/>
                        <p class="homeTip">
                            <g:message code="default.home.label"/>
                        </p>
                    </a>
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
		<div id="show-workBook" class="content scaffold-show" role="main">
			<g:if test="${flash.message}">
				<div class="message" role="status">
                    ${flash.message}
                </div>
			</g:if>
			<ol class="property-list workBook">
                <g:if test="${workBookInstance?.firstName}">
                    <li class="fieldcontain">
                        <span id="firstName-label" class="property-label">
                            <g:message code="workBook.firstName.label"/>
                        </span>
                        <span class="property-value" aria-labelledby="firstName-label">
                            <g:fieldValue bean="${workBookInstance}" field="firstName"/>
                        </span>
                    </li>
                </g:if>
				<g:if test="${workBookInstance?.lastName}">
                    <li class="fieldcontain">
                        <span id="lastName-label" class="property-label">
                            <g:message code="workBook.lastName.label"/>
                        </span>
                        <span class="property-value" aria-labelledby="lastName-label">
                            <g:fieldValue bean="${workBookInstance}" field="lastName"/>
                        </span>
                    </li>
                </g:if>
                <g:if test="${workBookInstance?.passportNumber}">
                    <li class="fieldcontain">
                        <span id="passportNumber-label" class="property-label">
                            <g:message code="workBook.passportNumber.label"/>
                        </span>
                        <span class="property-value" aria-labelledby="passportNumber-label">
                            <g:fieldValue bean="${workBookInstance}" field="passportNumber"/>
                        </span>
                    </li>
                </g:if>
                <g:if test="${workBookInstance?.email}">
                    <li class="fieldcontain">
                        <span id="email-label" class="property-label">
                            <g:message code="workBook.email.label"/>
                        </span>
                        <span class="property-value" aria-labelledby="email-label">
                            <g:fieldValue bean="${workBookInstance}" field="email"/>
                        </span>
                    </li>
                </g:if>
				<g:if test="${workBookInstance?.age}">
				    <li class="fieldcontain">
					    <span id="age-label" class="property-label">
                            <g:message code="workBook.age.label"/>
                        </span>
						<span class="property-value" aria-labelledby="age-label">
                            <g:fieldValue bean="${workBookInstance}" field="age"/>
                        </span>
				    </li>
				</g:if>
				<g:if test="${workBookInstance?.dateOfBirth}">
                    <li class="fieldcontain">
                        <span id="dateOfBirth-label" class="property-label">
                            <g:message code="workBook.dateOfBirth.label"/>
                        </span>
                        <span class="property-value" aria-labelledby="dateOfBirth-label">
                            <g:formatDate format="yyyy-MM-dd" date="${workBookInstance?.dateOfBirth}"/>
                        </span>
                    </li>
				</g:if>
				<g:if test="${workBookInstance?.workplaces}">
                    <li class="fieldcontain">
                        <span id="workplaces-label" class="property-label">
                            <g:message code="workBook.workplaces.label"/>
                        </span>
                        <g:each in="${workBookInstance.workplaces}" var="workplace">
                            <span class="property-value" aria-labelledby="workplaces-label">
                                <g:link controller="workPlace" action="show" id="${workplace.id}">
                                    ${workplace}
                                </g:link>
                            </span>
                        </g:each>
                    </li>
                </g:if>
                <sec:ifAllGranted roles="ROLE_ADMIN">
                    <li class="fieldcontain">
                        <span class="property-value">
                            <g:link controller="workPlace" action="create" params="['workbook.id': workBookInstance?.id]">
                                ${message(code: 'default.add.label', args: [message(code: 'workPlace.label')])}
                            </g:link>
                        </span>
                    </li>
                </sec:ifAllGranted>
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
			</ol>
            <sec:ifAllGranted roles="ROLE_ADMIN">
                <fieldset class="buttons">
                    <g:form url="[resource:workBookInstance, action:'delete']" method="DELETE" class="delete">
                        <g:actionSubmitImage src="${resource(dir: 'images/icons', file: 'delete-icon.png')}" action="delete"
                                        value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                                        onclick="return confirm('${message(code: 'default.button.delete.confirm.message')}');"/>
                        <p class="deleteTip">
                            <g:message code="default.button.delete.label"/>
                        </p>
                    </g:form>
                    <g:link class="edit" action="edit" resource="${workBookInstance}">
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
