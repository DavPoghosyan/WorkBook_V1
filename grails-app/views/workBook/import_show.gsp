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
    <div>
        <li class="fieldcontain">
            <span id="import-workbook-label" class="property-label">
                <g:message code="import.workbook.label" default="Found WorkBook Info For:"/>
            </span>
            <span class="property-value" aria-labelledby="import-workbook-label">
                <g:if test="${id}">
                    <g:remoteLink action="updateFromImport" update="mainContent"
                    >${workBookOwner}</g:remoteLink>
                    already exists want to update it?
                </g:if>
                <g:else>
                    <g:remoteLink action="createFromImport" update="mainContent"
                    >${workBookOwner}</g:remoteLink>
                </g:else>
            </span>
        </li>
	    <div id="mainContent" style='float: right; width: 80%; min-height: 500px; background-color: #c0ffc0;'>
		    <p>This is the main content</p>
	    </div>
        <li class="fieldcontain">
            <span id="import-workplaces-label" class="property-label">
                <g:message code="import.workplaces.label" default="Found WorkPlaces:"/>
            </span>
            <span class="property-value" aria-labelledby="import-workplaces-label">
                ${workPlacesCount}
            </span>
        </li>
		</div>
	</body>
</html>
