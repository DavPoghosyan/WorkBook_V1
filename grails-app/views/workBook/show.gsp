<%@ page import="com.webbfontaine.training.WorkBook" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="id" value="${workBookInstance?.id}"/>
        <g:set var="entityName" value="${message(code: 'workBook.label')}"/>
		<title>
		    <g:message code="default.show.label" args="[entityName]"/>
        </title>
        <g:javascript src="scroll.js"/>
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

        <div id="show-workBook" class="content" role="main">
            <g:render template="showWorkBook"/>
        </div>
		<div id="sub" class="content sub" role="sub">
		</div>
	</body>
</html>
