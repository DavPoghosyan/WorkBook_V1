<%@ page import="com.webbfontaine.training.WorkBook" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
        <g:set var="entityName" value="${message(code: 'workPlace.label')}"/>
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
                            <g:message code="workBooks.list"/>
                        </p>
                    </a>
                </li>
                <li>
                    <g:link class="list" controller="workPlace" action="list">
                        <g:img dir="images/icons" file="workplaces-list-icon.png"/>
                        <p class="listTip">
                            <g:message code="workPlaces.list"/>
                        </p>
                    </g:link>
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
        <div id="show-worBook"k class="content" role="main">
            <g:render template="showWorkPlace"/>
        </div>
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
