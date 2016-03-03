<%@ page import="com.webbfontaine.training.WorkBook" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'workBook.label', default: 'WorkBook')}"/>
		<title>
		    <g:message code="default.show.label" args="[entityName]"/>
        </title>
		<g:javascript library="jquery" />
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
    <g:if test="${workPlacesCount}">
        <g:message code="import.workplaces.label" default="Found WorkPlaces:"/>${workPlacesCount}
        <g:each in="${1..workPlacesCount}" var="i" >
            <g:message code="import.workplaces.label" default="Add WorkPlace:"/>
            <g:remoteLink controller="workPlace" action="createFromImport" update="main-content"  params="[id:i]">${i}</g:remoteLink>
        </g:each>
    </g:if>
        <div id="main-content">
            <g:message code="import.workbook.label" default="Found WorkBook Info For:"/>
            ${workBookInstance}
            <g:if test="${id}">
                already exists want to update it?
                <div id='current-from-store' style='float: left; width: 50%; min-height: 250px; background-color: #ffffff;'>
                    <g:render template="showTemp"/>
                </div>
                <g:remoteLink action="updateFromImport" update="mainContent">Update this one by imported XML</g:remoteLink>
                <g:remoteLink action="createFromImport" update="main-content">Use As Template</g:remoteLink>
            </g:if>
            <g:else>
                <g:remoteLink action="createFromImport" update="main-content">${workBookInstance}</g:remoteLink>
                <g:render template="createTemp"/>
            </g:else>
            <div id="mainContent">
                %{--<g:render template="remoteForm"/>--}%
            </div>
        </div>
	</body>
</html>
