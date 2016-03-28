<%@ page import="com.webbfontaine.training.WorkPlace" %>
<g:set var="entityName" value="${message(code: 'workPlace.label')}" />
<g:javascript>
    if($('.message').is(':visible')) {
        <g:remoteFunction controller='workBook' action='showTemp'
                          update='show-workBook' params="['id': workBookId ?: workPlace.workbookId]"/>
    }
</g:javascript>
<div id="show-workPlace" class="content" role="main">
	<g:if test="${flash.message}">
		<div class="message" role="status">${flash.message}</div>
	</g:if>
	<g:if test="${workPlace}">
	    <h1>
	        <g:message code="default.show.label" args="[entityName]" />
	    </h1>
	    <ol class="property-list workPlace" >
	        <g:if test="${workPlace?.company}">
	            <li class="fieldcontain">
	                <span id="companyCode-label" class="property-label">
	                    <g:message code="workPlace.company.label"/>
	                </span>
	                <span class="property-value" aria-labelledby="lastName-label">
	                    <g:fieldValue bean="${workPlace.company}" field="name"/>
	                </span>
	            </li>
	        </g:if>
	        <g:if test="${workPlace?.country}">
	            <li class="fieldcontain">
	                <span id="countryCode-label" class="property-label">
	                    <g:message code="workPlace.country.label"/>
	                </span>
	                <span class="property-value" aria-labelledby="countryCode-label">
	                    <g:fieldValue bean="${workPlace.country}" field="name"/>
	                </span>
	            </li>
	        </g:if>
	        <g:if test="${workPlace?.startDate}">
	            <li class="fieldcontain">
	                <span id="startDate-label" class="property-label">
	                    <g:message code="workPlace.startDate.label"/>
	                </span>
	                <span class="property-value" aria-labelledby="startDate-label">
	                    <g:formatDate format="yyyy-MM-dd" date="${workPlace?.startDate}" />
	                </span>
	            </li>
	        </g:if>
	        <li class="fieldcontain">
	            <span id="endDate-label" class="property-label">
	                <g:message code="workPlace.endDate.label"/>
	            </span>
	            <span class="property-value" aria-labelledby="endDate-label">
	                <g:if test="${workPlace?.endDate}">
	                    <g:formatDate format="yyyy-MM-dd" date="${workPlace?.endDate}" />
	                </g:if>
	                <g:else>
	                    <i><g:message code="workPlace.current.true.label"/></i>
	                </g:else>
	            </span>
	        </li>
	        <g:if test="${workPlace?.registeredAt}">
	            <li class="fieldcontain">
	                <span id="registeredAt-label" class="property-label">
	                    <g:message code="instance.registered.label"/>
	                </span>
	                <span class="property-value" aria-labelledby="registeredAt-label">
	                    <g:formatDate format="yyyy-MM-dd hh:mm:ss" date="${workPlace?.registeredAt}"/>
	                </span>
	            </li>
	        </g:if>
	        <g:if test="${workPlace?.lastUpdatedAt}">
	            <li class="fieldcontain">
	                <span id="lastUpdatedAt-label" class="property-label">
	                    <g:message code="instance.lastUpdatedAt.label"/>
	                </span>
	                <span class="property-value" aria-labelledby="lastUpdatedAt-label">
	                    <g:formatDate format="yyyy-MM-dd hh:mm:ss" date="${workPlace?.lastUpdatedAt}"/>
	                </span>
	            </li>
	        </g:if>
        </ol>
	    <sec:ifAllGranted roles="ROLE_ADMIN">
		    <fieldset class="buttons">
			    <g:formRemote  name="delete" update="sub"
                               url="[resource:workPlace, action:'delete']" controller="workPlace" method="DELETE" class="delete">
				    <g:actionSubmitImage src="${resource(dir: 'images/icons', file: 'delete-icon.png')}" action="delete"
				                         value="${message(code: 'default.button.delete.label', default: 'Delete')}"
				                         onclick="return confirm('${message(code: 'default.button.delete.confirm.message')}');"/>
				    <p class="deleteTip">
					    <g:message code="default.button.delete.label"/>
				    </p>
			    </g:formRemote>
			    <g:remoteLink class="edit" controller="workPlace" action="edit" update="sub" resource="${workPlace}">
				    <g:img dir="images/icons" file="edit-icon.png"/>
				    <p class="editTip">
					    <g:message code="default.button.edit.label"/>
				    </p>
			    </g:remoteLink>
                %{--<g:remoteLink id="c" controller="workBook" action="showTemp" update="show-workBook" params="['id': workPlace?.workbook?.id]">
                    ${message(code: 'default.add.label', args: [message(code: 'workPlace.label')])}
                </g:remoteLink>--}%
		    </fieldset>
	    </sec:ifAllGranted>
	</g:if>
</div>