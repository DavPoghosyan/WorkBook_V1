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
        <div id="main_content">
            <g:message code="import.workbook.label" default="In Uploaded XML Found Personal Info For WorkBook Owner: ${workBookInstance}"/>
            <g:if test="${id}">
                <g:message code="import.owner.exists" default="Record about this workbook already exists in store, if want to update it?"/>
                <div id='current-from-store' style='float: left; width: 50%; min-height: 250px; background-color: #ffffff;'>
                    <g:render template="showTemp"/>
                </div>
                <g:remoteLink action="createFromImport" update="main_content">Use As Template</g:remoteLink>
	            <div id="mainContent">
		            <g:render template="editTemp"/>
	            </div>
            </g:if>
            <g:else>
	            <div id="m_c">
		            <g:render template="createTemp"/>
	            </div>
            </g:else>
        </div>
	<g:if test="${workPlacesCount}">
		<g:message code="import.workplaces.label" default="Found WorkPlaces:"/>${workPlacesCount}
		<g:each in="${1..workPlacesCount}" var="i" >
			<g:message code="import.workplaces.label" default="Add WorkPlace:"/>
			<g:remoteLink controller="workPlace" action="createFromImport" update="sub-content"  params="[id:i]">${i}</g:remoteLink>
		</g:each>
	</g:if>
		<div id="sub-content">
		</div>
	</body>
</html>
