<link rel="stylesheet" href="${resource(dir: 'css', file: 'dialog.css')}" type="text/css">
<div id="company-info" title="${message(code: 'company.info.label')}">
    <li class="fieldcontain">
        <span id="company-name-label" class="property-label">
            <g:message code="name.label"/>
        </span>
        <span class="property-value" aria-labelledby="company-name-label">
            <g:fieldValue bean="${company}" field="name"/>
        </span>
    </li>
    <li class="fieldcontain">
        <span id="company-description-label" class="property-label">
            <g:message code="description.label"/>
        </span>
        <span class="property-value" aria-labelledby="company-description-label">
            <g:fieldValue bean="${company}" field="description"/>
        </span>
    </li>
</div>
