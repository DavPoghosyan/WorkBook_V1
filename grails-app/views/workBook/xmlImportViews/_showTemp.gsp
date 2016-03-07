<g:javascript>
   /* $(".cl").click(function(){
        $("#show-workBook").slideToggle("fast")
    })*/
    var hide = '- hide'
    var show = '+ show'
    $(".cl").click(function(){
	    $("#show-workBook").slideToggle("fast")
	    $(this).text(function(i, v){
		    return v === hide ? show : hide
	    })
    })
</g:javascript>
<%@ page import="com.webbfontaine.training.WorkBook" %>
<g:if test="${flash.message}">
	<div class="message" role="status">
		${flash.message}
	</div>
    <div class="cl">
        - hide
    </div>
</g:if>
<div id="show-workBook" class="content scaffold-show" role="main">
    <g:if test="${id}">
        <g:set var="workBookDbInstance" value="${WorkBook.get(id)}" />
        <h1>
            <g:message code="show.workBook.current"/>
        </h1>
    </g:if>
    <ol class="property-list workBook">
        <g:if test="${workBookDbInstance?.lastName}">
            <li class="fieldcontain">
                <span id="firstName-label" class="property-label">
                    <g:message code="workBook.firstName.label"/>
                </span>
                <span class="property-value" aria-labelledby="firstName-label">
                    <g:fieldValue bean="${workBookDbInstance}" field="firstName"/>
                </span>
            </li>
        </g:if>
        <g:if test="${workBookDbInstance?.email}">
            <li class="fieldcontain">
                <span id="lastName-label" class="property-label">
                    <g:message code="workBook.lastName.label"/>
                </span>
                <span class="property-value" aria-labelledby="lastName-label">
                    <g:fieldValue bean="${workBookDbInstance}" field="lastName"/>
                </span>
            </li>
        </g:if>
        <g:if test="${workBookDbInstance?.passportNumber}">
            <li class="fieldcontain">
                <span id="pasportNumber-label" class="property-label">
                    <g:message code="workBook.passportNumber.label"/>
                </span>
                <span class="property-value" aria-labelledby="passportNumber-label">
                    <g:fieldValue bean="${workBookDbInstance}" field="passportNumber"/>
                </span>
            </li>
        </g:if>
        <g:if test="${workBookDbInstance?.firstName}">
            <li class="fieldcontain">
                <span id="email-label" class="property-label">
                    <g:message code="workBook.email.label"/>
                </span>
                <span class="property-value" aria-labelledby="email-label">
                    <g:fieldValue bean="${workBookDbInstance}" field="email"/>
                </span>
            </li>
        </g:if>
        <g:if test="${workBookDbInstance?.age}">
            <li class="fieldcontain">
                <span id="age-label" class="property-label">
                    <g:message code="workBook.age.label"/>
                </span>
                <span class="property-value" aria-labelledby="age-label">
                    <g:fieldValue bean="${workBookDbInstance}" field="age"/>
                </span>
            </li>
        </g:if>
        <g:if test="${workBookDbInstance?.dateOfBirth}">
            <li class="fieldcontain">
                <span id="dateOfBirth-label" class="property-label">
                    <g:message code="workBook.dateOfBirth.label"/>
                </span>
                <span class="property-value" aria-labelledby="dateOfBirth-label">
                    <g:formatDate format="yyyy-MM-dd" date="${workBookDbInstance?.dateOfBirth}"/>
                </span>
            </li>
        </g:if>
        <g:if test="${workBookDbInstance?.workplaces}">
            <li class="fieldcontain">
                <span id="workplaces-label" class="property-label">
                    <g:message code="workBook.workplaces.label"/>
                </span>
                <g:each in="${workBookDbInstance.workplaces}" var="workplace">
                    <span class="property-value" aria-labelledby="workplaces-label">
                        <g:link controller="workPlace" action="show" id="${workplace.id}">
                            ${workplace}
                        </g:link>
                    </span>
                </g:each>
            </li>
        </g:if>
    </ol>
</div>