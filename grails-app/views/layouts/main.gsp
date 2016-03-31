<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<title>
			<g:layoutTitle default="WorkBook"/>
		</title>
		%{--<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="shortcut icon" href="${assetPath(src: 'favicon.ico')}" type="image/x-icon">
		<link rel="apple-touch-icon" href="${assetPath(src: 'apple-touch-icon.png')}">
		<link rel="apple-touch-icon" sizes="114x114" href="${assetPath(src: 'apple-touch-icon-retina.png')}">--}%
  		<asset:stylesheet src="application.css"/>
		<asset:javascript src="application.js"/>
	    <g:javascript src="main.js"/>
        <g:javascript library="jquery"/>
        <g:javascript library="jquery-ui"/>
		<g:layoutHead/>
	</head>
	<body>
		<g:link class="logo" href="${createLink(uri: 'workbook/list')}">
			<asset:image src="logo.png" alt="WorkBook"/>
			<h1 class="about"><g:message code="main.about"/></h1>
		</g:link>
        <locale:selector/>
        <g:link class="log-out" controller="logout" action="">
			<asset:image src="skin/log-out-icon.png" alt="WorkBook"/>
            <p class="text">
                <g:message code="log.out.label" class="text"/>
            </p>
        </g:link>
		<g:layoutBody/>
		<div class="footer" role="contentinfo">
            <g:link uri="http://www.webbfontaine.com/" target="_blank">
                <g:message code="footer.copyright.company"/>
                </g:link>
            <g:message code="footer.training.label"/>
            <g:link uri="https://www.linkedin.com/in/davit-poghosyan-37556ab4" target="_blank">
                <g:message code="footer.copyright.developer"/>
            </g:link>
        </div>
		%{--<div id="spinner" class="spinner"><g:message code="log.out.label" default="Loading&hellip;"/></div>--}%
	</body>
</html>
