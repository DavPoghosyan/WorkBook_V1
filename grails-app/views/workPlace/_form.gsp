<%@ page import="com.webbfontaine.training.WorkPlace" %>

<div class="fieldcontain ${hasErrors(bean: workPlaceInstance, field: 'workbook', 'error')} required">
    <label for="workbook">
        <g:message code="workPlace.workbook.label" default="Workbook" />
        <span class="required-indicator">*</span>
    </label>
    <g:select id="workbook" name="workbook.id"
              from="${com.webbfontaine.training.WorkBook.list()}" optionKey="id"
              required="" value="${workPlaceInstance?.workbook?.id}" class="many-to-one"/>
</div>
<fieldset class="embedded">
    <legend>
        <g:message code="workPlace.company.label" default="Company"/>
    </legend>
    <div class="fieldcontain ${hasErrors(bean: workPlaceInstance, field: 'company.code', 'error')} required">
        <label for="company.code">
            <g:message code="workPlace.company.code.label" default="Code" />
            <span class="required-indicator">*</span>
        </label>
        <g:textField name="company.code" required="" value="${workPlaceInstance.company?.code}"/>
    </div>
    <div class="fieldcontain ${hasErrors(bean: workPlaceInstance, field: 'company.name', 'error')} required">
        <label for="company.name">
            <g:message code="workPlace.company.name.label" default="Name" />
            <span class="required-indicator">*</span>
        </label>
        <g:textField name="company.name" required="" value="${workPlaceInstance.company?.name}"/>
    </div>
</fieldset>
<fieldset class="embedded">
    <legend>
        <g:message code="workPlace.country.label" default="Country"/>
    </legend>
    <div class="fieldcontain ${hasErrors(bean: workPlaceInstance, field: 'country.code', 'error')} required">
        <label for="country.code">
            <g:message code="workPlace.country.code.label" default="Code" />
            <span class="required-indicator">*</span>
        </label>
        <g:textField name="country.code" required="" value="${workPlaceInstance.country?.code}"/>
    </div>
    <div class="fieldcontain ${hasErrors(bean: workPlaceInstance, field: 'country.name', 'error')} required">
        <label for="country.name">
            <g:message code="workPlace.country.name.label" default="Name" />
            <span class="required-indicator">*</span>
        </label>
        <g:textField name="country.name" required="" value="${workPlaceInstance.country?.name}"/>
    </div>
</fieldset>
<div class="fieldcontain ${hasErrors(bean: workPlaceInstance, field: 'startDate', 'error')} required">
    <label for="startDate">
        <g:message code="workPlace.startDate.label" default="Start Date" />
        <span class="required-indicator">*</span>
    </label>
    <g:datePicker name="startDate" precision="day"  value="${workPlaceInstance?.startDate}"  />
</div>
<div class="fieldcontain ${hasErrors(bean: workPlaceInstance, field: 'current', 'error')} ">
    <label for="current">
        <g:message code="workPlace.current.label" default="Current" />
    </label>
    <g:checkBox name="current" value="${workPlaceInstance?.current}" />
</div>
<div class="fieldcontain ${hasErrors(bean: workPlaceInstance, field: 'endDate', 'error')} ">
    <label for="endDate">
        <g:message code="workPlace.endDate.label" default="End Date" />
    </label>
    <g:datePicker name="endDate" precision="day"  value="${workPlaceInstance?.endDate}" default="none" noSelection="['': '']" />
</div>


