<%@ page import="com.webbfontaine.training.WorkBook" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'workBook.label')}"/>
		<title>
			<g:message code="registration.form.label" args="[entityName]"/>
		</title>
        <g:javascript src="uploadFormSubmit.js"/>
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
				<li>
                    <div class="import">
                        <g:render template="uploadForm"/>
                    </div>
				</li>
			</ul>
		</div>
        <g:if test="${workBookInstance?.firstName}">
            <div class="message" id="perm-message" role="status">
                <g:message code="import.workbook.label" args="${workBookInstance}"/>

                <g:if test="${workPlacesCount}">

                    <g:message code="import.workplaces.label" args="${workPlacesCount}"/>
                    <g:each in="${1..workPlacesCount}" var="i" >
                        <g:remoteLink controller="workPlace" action="createFromImport" update="sub"  params="[id:i]">
                            WorkPlace:${i}</g:remoteLink>
                    </g:each>
                </g:if>
            </div>
        </g:if>
		<div id="create-workBook" class="content scaffold-create" role="main">
			<h1>
                <g:message code="registration.form.label" args="[entityName]"/>
            </h1>
			<g:if test="${flash.message}">
			    <div class="message" role="status">
                    ${flash.message}
                </div>
			</g:if>
            <g:if test="${flash.error}">
                <div class="errors" role="alert">
	                <g:message error="${flash.error}"/>
                </div>
            </g:if>
			<g:hasErrors bean="${workBookInstance}">
                <ul class="errors" role="alert">
                    <g:eachError bean="${workBookInstance}" var="error">
                        <li <g:if test="${error in org.springframework.validation.FieldError}">
                            data-field-id="${error.field}"
                        </g:if>>
                            <g:message error="${error}"/>
                        </li>
                    </g:eachError>
                </ul>
            </g:hasErrors>
            <g:formRemote id="workBook" name="subForm" url="[controller:'workBook', action:'remoteSave']"
                          update="create-workBook">
                <fieldset class="form">
                    <g:render template="form"/>
                </fieldset>
                <fieldset class="buttons register">
                    <g:actionSubmitImage src="${resource(dir: 'images/icons', file: 'save-icon.png')}"
                                         action="save" name="register"
                                         value="${message(code: 'default.button.create.label')}"/>
                    <p class="registerTip">
                        <g:message code="register.label"/>
                    </p>
                </fieldset>
            </g:formRemote>
		</div>
    <div id="sub" class="content sub" role="sub">
    </div>
	</body>
</html>
