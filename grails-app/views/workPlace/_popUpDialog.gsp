<link rel="stylesheet" href="${resource(dir: 'css', file: 'dialog.css')}" type="text/css">
<div id="company" title="Company Info">
    <li class="fieldcontain">
        <span id="name-label" class="property-label">
            <g:message code="company.name.label" default="Name"/>
        </span>
        <span class="property-value" aria-labelledby="name-label">
            <g:fieldValue bean="${company}" field="name"/>
        </span>
    </li>
    <li class="fieldcontain">
        <span id="description-label" class="property-label">
            <g:message code="description.name.label" default="Description"/>
        </span>
        <span class="property-value" aria-labelledby="description-label">
            <g:fieldValue bean="${company}" field="description"/>
        </span>
    </li>
</div>
<div id="country" title="Country Info" style="display: none;">
    <g:textArea id="country" name="country" rows="1" cols="40" value="" />
</div>
