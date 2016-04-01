<%@ page import="org.springframework.web.servlet.support.RequestContextUtils; com.webbfontaine.training.WorkBook" %>
<g:set var="today" value="${new Date()}"/>
<g:set var="minYear" value="${today[Calendar.YEAR]-99}"/>
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
                  default="none" noSelection="['': '']"
                  value="${workBookInstance?.dateOfBirth}" years="${maxYear..minYear}"
    />
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
