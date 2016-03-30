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
        <div id="show-workBook" class="content scaffold-create" role="main">
            <g:render template="createTemp"/>
        </div>
        <g:if test="${workPlacesCount}">
            <div class="message" id="perm-message" role="status">
                <g:message code="import.workplaces.label" args="${workPlacesCount}"/>
                <g:each in="${1..workPlacesCount}" var="i" >
                    <g:remoteLink class="showSub" controller="workPlace" action="createFromImport" update="sub"  params="[id:i]">
                        WorkPlace:${i}</g:remoteLink>
                </g:each>
            </div>
        </g:if>
        <div class="closeSub" hidden>
            <g:img dir="images/icons" file="close-cross-icon.png" />
            <p class="closeTip">
                <g:message code="close.label"/>
            </p>
        </div>
        <div id="sub" class="content sub" role="sub">
        </div>
	</body>
</html>
