<%@ page import="com.webbfontaine.training.*" %>
<div class="fieldcontain ${hasErrors(bean: workPlaceInstance, field: 'workbook', 'error')} required">
    <label for="workbook">
        <g:message code="workPlace.workbook.label" default="Workbook" />
        <span class="required-indicator">*</span>
    </label>
    <g:select id="workbook" name="workbook.id"
              from="${WorkBook.list()}" optionKey="id"
              value="${workPlaceInstance?.workbook?.id}" class="many-to-one"
              onchange="greetName(this.value)"
    />
</div>
<div class="fieldcontain ${hasErrors(bean: workPlaceInstance, field: 'companyCode', 'error')} required">
    <label for="companyCode">
        <g:message code="workPlace.companyName.label" default="Company Code" />
        <span class="required-indicator">*</span>
    </label>
    <g:select id="companyCode" name="companyCode" from="${Company.list()}" optionKey="code"
              value="companyCode"
              onchange= "companyChanged(this.value);"/>
</div>
<div class="fieldcontain ${hasErrors(bean: workPlaceInstance, field: 'countryCode', 'error')} required">
    <label for="countryCode">
        <g:message code="workPlace.countryCode.label" default="Country Code" />
        <span class="required-indicator">*</span>
    </label>
    <g:select id="countryCode"  name="countryCode"
              from="${Country.listOrderByName()}" optionKey="code"
              value="countryCode"
              onchange="countryCode(this.value);"/>
</div>
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
    <g:datePicker name="endDate" precision="day"  value="${workPlaceInstance?.endDate}"
                  default="none" noSelection="['': 'choose']"/>
</div>



