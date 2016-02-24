<%@ page import="com.webbfontaine.training.WorkBook" %>

<div class="fieldcontain ${hasErrors(bean: workBookInstance, field: 'firstName', 'error')} required">
	<label for="firstName">
		<g:message code="workBook.firstName.label" default="First Name"/>
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="firstName" maxlength="25" required="" value="${workBookInstance?.firstName}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: workBookInstance, field: 'lastName', 'error')} required">
	<label for="lastName">
		<g:message code="workBook.lastName.label" default="Last Name"/>
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="lastName" maxlength="25" required="" value="${workBookInstance?.lastName}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: workBookInstance, field: 'email', 'error')} required">
	<label for="email">
		<g:message code="workBook.email.label" default="Email" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="email" name="email" required="" value="${workBookInstance?.email}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: workBookInstance, field: 'passportNumber', 'error')} required">
    <label for="passportNumber">
        <g:message code="workBook.passportNumber.label" default="Passport Number"/>
        <span class="required-indicator">*</span>
    </label>
    <g:textField name="passportNumber" required="" value="${workBookInstance?.passportNumber}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: workBookInstance, field: 'dateOfBirth', 'error')} required">
	<label for="dateOfBirth">
		<g:message code="workBook.dateOfBirth.label" default="Date Of Birth" />
		<span class="required-indicator">*</span>
	</label>
    <g:datePicker name="dateOfBirth" precision="day"  value="${workBookInstance?.dateOfBirth}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: workBookInstance, field: 'age', 'error')}">
    <label for="age">
        <g:message code="workBook.age.label" default="Age" />
    </label>
    <g:select name="age" from="${18..65}" value="${workBookInstance?.age}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: workBookInstance, field: 'workplaces', 'error')} ">
	<label for="workplaces">
		<g:message code="workBook.workplaces.label" default="Workplaces"/>
	</label>
    <ul class="one-to-many">
        <g:each in="${workBookInstance?.workplaces?}" var="w">
             <li>
                 <g:link controller="workPlace" action="show" id="${w.id}">
                     ${w.companyCode + " " + w.countryCode}
                 </g:link>
             </li>
        </g:each>
        <li class="add">
            <g:link controller="workPlace" action="create" params="['workBook.id': workBookInstance?.id]">
                ${message(code: 'default.add.label', args: [message(code: 'workPlace.label', default: 'WorkPlace')])}
            </g:link>
        </li>
    </ul>
</div>

