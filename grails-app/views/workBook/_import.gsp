<%--
  Created by IntelliJ IDEA.
  User: davit
  Date: 3/2/16
  Time: 7:27 AM
--%>
<div id="imported_workbook" title="Additional Information About Company Please Check and Confirm">
    <li class="fieldcontain">
        <span id="import-workbook-label" class="property-label">
            <g:message code="import.workbook.label" default="Found WorkBook Info For:"/>
        </span>
        <span class="property-value" aria-labelledby="import-workbook-label">
            <g:if test="${isWorkBookExists}">
                <g:link action="edit" id="${workBookOwner.id}">
                    ${workBookOwner}
                </g:link>
                already exists want to update it?
            </g:if>
            <g:else>
                <g:remoteLink action="createFromImport" update="success"
                              > AAA</g:remoteLink>
            </g:else>
        </span>
    </li>
    <li class="fieldcontain">
        <span id="import-workplaces-label" class="property-label">
            <g:message code="import.workplaces.label" default="Found WorkPlaces:"/>
        </span>
        <span class="property-value" aria-labelledby="import-workplaces-label">
            ${workPlacesCount}
        </span>
    </li>
</div>