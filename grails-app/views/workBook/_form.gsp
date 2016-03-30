<%@ page import="org.springframework.web.servlet.support.RequestContextUtils; com.webbfontaine.training.WorkBook" %>
<link rel="stylesheet" href="${resource(dir: 'css', file: 'validation.css')}" type="text/css">
<link rel="stylesheet" href="${resource(dir: 'css', file: 'jquery-ui.css')}" type="text/css">
<g:javascript src="libs/jquery.validate.js"/>
<g:javascript src="libs/jquery.localisation.js"/>
<g:javascript src="localisation/messages-${RequestContextUtils.getLocale(request).getLanguage()}.js"/>
<g:javascript src="workBookFormValidation.js"/>
<g:javascript src="ageCalculate.js"/>
%{--<g:javascript src="libs/jquery-ui.js"/>
<g:javascript>
	$( "#datepicker" ).datepicker({
		inline: true
	});
</g:javascript>--}%
<g:set var="today" value="${new Date()}"/>
<g:set var="minYear" value="${today[Calendar.YEAR]-65}"/>
<g:set var="maxYear" value="${today[Calendar.YEAR]-18}"/>
<div class="fieldcontain ${hasErrors(bean: workBookInstance, field: 'firstName', 'error')} required">
	<label for="firstName">
		<g:message code="workBook.firstName.label"/>
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="firstName" maxlength="25" required="" value="${workBookInstance?.firstName}"/>
</div>
<div class="fieldcontain ${hasErrors(bean: workBookInstance, field: 'lastName', 'error')} required">
	<label for="lastName">
		<g:message code="workBook.lastName.label"/>
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="lastName" maxlength="25" required="" value="${workBookInstance?.lastName}"/>
</div>
<div class="fieldcontain ${hasErrors(bean: workBookInstance, field: 'email', 'error')} required">
	<label for="email">
		<g:message code="workBook.email.label"/>
		<span class="required-indicator">*</span>
	</label>
	<g:textField type="email" name="email" required="" value="${workBookInstance?.email}"/>
</div>
<div class="fieldcontain ${hasErrors(bean: workBookInstance, field: 'passportNumber', 'error')} required">
	<label for="passportNumber">
		<g:message code="workBook.passportNumber.label"/>
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="passportNumber" maxlength="9" required="" value="${workBookInstance?.passportNumber}"/>
</div>
<div class="fieldcontain ${hasErrors(bean: workBookInstance, field: 'dateOfBirth', 'error')} required">
	<label for="dateOfBirth">
		<g:message code="workBook.dateOfBirth.label"/>
		<span class="required-indicator">*</span>
	</label>
    <g:datePicker class="dateOfBirth" name="dateOfBirth" precision="day"
                  value="${workBookInstance?.dateOfBirth}" years="${maxYear..minYear}"
    />
	%{--<g:textField id="datepicker" name="dateOfBirth" />--}%
</div>
<g:if test="${workBookInstance?.workPlaces}">
    <div class="fieldcontain ${hasErrors(bean: workBookInstance, field: 'workPlaces', 'error')}">
        <label id="workplaces-label">
            <g:message code="workBook.workPlaces.label"/>
        </label>
        <g:each in="${workBookInstance.workPlaces}" var="workplace">
            <g:remoteLink class="showSub" controller="workPlace" action="edit" update="sub" id="${workplace.id}">
                ${workplace}
            </g:remoteLink>
        </g:each>
    </div>
</g:if>
