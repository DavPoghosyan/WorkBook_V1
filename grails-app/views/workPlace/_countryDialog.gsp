<link rel="stylesheet" href="${resource(dir: 'css', file: 'dialog.css')}" type="text/css">
<div id="country-info" title="Additional Information About Country Please Check and Confirm">
    <li class="fieldcontain">
        <span id="country-name-label" class="property-label">
            <g:message code="country.name.label" default="Name:"/>
        </span>
        <span class="property-value" aria-labelledby="country-name-label">
            <g:fieldValue bean="${country}" field="name"/>
        </span>
    </li>
	<li class="fieldcontain">
		<span id="country-description-label" class="property-label">
			<g:message code="country.language.label" default="Description:"/>
		</span>
		<span class="property-value" aria-labelledby="country-description-label">
			<g:fieldValue bean="${country}" field="description"/>
		</span>
	</li>
</div>
