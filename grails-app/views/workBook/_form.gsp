<%@ page import="com.webbfontaine.training.WorkBook" %>
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
	<g:field type="email" name="email" required="" value="${workBookInstance?.email}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: workBookInstance, field: 'passportNumber', 'error')} required">
        <label for="passportNumber">
            <g:message code="workBook.passportNumber.label"/>
            <span class="required-indicator">*</span>
        </label>
    <g:textField name="passportNumber" required="" value="${workBookInstance?.passportNumber}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: workBookInstance, field: 'dateOfBirth', 'error')} required">
	<label for="dateOfBirth">
		<g:message code="workBook.dateOfBirth.label"/>
		<span class="required-indicator">*</span>
	</label>
    <g:datePicker name="dateOfBirth" precision="day"  value="${workBookInstance?.dateOfBirth}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: workBookInstance, field: 'age', 'error')}">
    <label for="age">
        <g:message code="workBook.age.label"/>
    </label>
    <g:select name="age" from="${18..65}" value="${workBookInstance?.age}"/>
</div>

