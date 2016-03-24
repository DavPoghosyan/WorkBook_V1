<%@ page import="com.webbfontaine.training.WorkPlace" %>
<g:set var="entityName" value="${message(code: 'workPlace.label')}" />
%{--<div id="show-workPlace" class="content scaffold-show" role="main">
    <g:if test="${id}">
        <g:set var="workPlace" value="${WorkPlace.get(id)}" />
        <h1>
            <g:message code="show.workPlace.label" default="Current"/>
        </h1>
    </g:if>--}%
<div id="show-workPlace" class="content" role="main">
    <h1>
        <g:message code="default.show.label" args="[entityName]" />
    </h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <ol class="property-list workPlace">
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
    </ol>
	    <sec:ifAllGranted roles="ROLE_ADMIN">
		    <fieldset class="buttons">
			    <g:form url="[resource:workPlaceInstance, action:'delete']" method="DELETE" class="delete">
				    <g:actionSubmitImage src="${resource(dir: 'images/icons', file: 'delete-icon.png')}" action="delete"
				                         value="${message(code: 'default.button.delete.label', default: 'Delete')}"
				                         onclick="return confirm('${message(code: 'default.button.delete.confirm.message')}');"/>
				    <p class="deleteTip">
					    <g:message code="default.button.delete.label"/>
				    </p>
			    </g:form>
			    <g:link class="edit" action="edit" resource="${workPlaceInstance}">
				    <g:img dir="images/icons" file="edit-icon.png"/>
				    <p class="editTip">
					    <g:message code="default.button.edit.label"/>
				    </p>
			    </g:link>
		    </fieldset>
	    </sec:ifAllGranted>
</div>