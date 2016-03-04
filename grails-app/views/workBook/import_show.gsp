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
			<div class="message" id="perm" role="status">
            	<g:message code="import.workbook.label" default="In Uploaded XML Found Personal Info For WorkBook Owner: ${workBookInstance} Please check, before creating"/>
           	</div>
            <g:if test="${id}">
                <div class="message" id="perm" role="status">
                <g:message code="import.owner.exists" default="Record about this workbook already exists in store, if want to update it?"/>
                <g:remoteLink action="createFromImport" update="main_content">Use As Template</g:remoteLink>
                </div>
                <div id='current-from-store' style='float: left; width: 50%; min-height: 250px; background-color: #ffffff;'>
                    <g:render template="showTemp"/>
                </div>
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
    </div>
		<div id="sub-content">
		</div>
	</body>
</html>
