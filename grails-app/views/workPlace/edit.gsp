<%@ page import="com.webbfontaine.training.WorkPlace" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'workPlace.label', default: 'WorkPlace')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
        <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
        %{-- <g:javascript src="retrieveReferenceData.js"/>--}%
        <script src="http://code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
        <script>
        function retrieveCompanyData( code) {
            <g:remoteFunction controller='workPlace' action='retrieveCompanyData'
                     update='company' params="'code='+code"/>
            $( "#company" ).dialog({
             modal: true,
             width:400,
             height:450 ,
             buttons: [
             {
             text: "Ok",
             click: function() { $(this).dialog("close"); }
             },
                 {
                     text: "Cancel",
                     click: function() {$(this).dialog("close");}
                 }
             ]
             });
        }
        function retrieveCountryData(code) {
            <g:remoteFunction controller='workPlace' action='retrieveCountryData'
                     update='country' params="'code='+code"/>
            $( "#country" ).dialog({
                modal: true,
                width:400,
                height:450 ,
                buttons: [
                    {
                        text: "Ok",
                        click: function() { $(this).dialog("close"); }
                    },
                    {
                        text: "Cancel",
                        click: function() {$(this).dialog("close");}
                    }
                ]
            });
        }
    </script>
	</head>
	<body>
    <div id="company" title="Company Info" style="display: none;">
        <g:textArea id="company" name="company" rows="1" cols="40" value="" />
    </div>
    <div id="country" title="Country Info" type="hidden" style="display: none;">
        <g:textArea id="country" name="country" rows="1" cols="40" value="" />
    </div>
		<a href="#edit-workPlace" class="skip" tabindex="-1">
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
                        <g:message code="default.list.label" args="[entityName]" />
                    </g:link>
                </li>
				<li>
                    <g:link class="create" action="create">
                        <g:message code="default.new.label" args="[entityName]" />
                    </g:link>
                </li>
			</ul>
		</div>
		<div id="edit-workPlace" class="content scaffold-edit" role="main">
			<h1>
                <g:message code="default.edit.label" args="[entityName]" />
            </h1>
			<g:if test="${flash.message}">
			    <div class="message" role="status">
                    ${flash.message}
                </div>
			</g:if>
			<g:hasErrors bean="${workPlaceInstance}">
                <ul class="errors" role="alert">
                    <g:eachError bean="${workPlaceInstance}" var="error">
                        <li
                            <g:if test="${error in org.springframework.validation.FieldError}">
                                data-field-id="${error.field}"
                            </g:if>>
                            <g:message error="${error}"/>
                        </li>
                    </g:eachError>
                </ul>
			</g:hasErrors>
			<g:form url="[resource:workPlaceInstance, action:'update']" method="PUT" >
				<g:hiddenField name="version" value="${workPlaceInstance?.version}" />
                <fieldset class="form">
                    <g:render template="form"/>
				</fieldset>
                <fieldset class="buttons">
					<g:actionSubmit class="save" action="update"
                                    value="${message(code: 'default.button.update.label', default: 'Update')}" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
