<%@ page import="com.webbfontaine.training.*" %>
<g:javascript>
	function retrieveCompanyData(id) {
		if(id){
			createDialogCompany()
			<g:remoteFunction controller='workPlace' action='retrieveCompanyData'
                               update='company-info' params="'id='+id"/>
		}
	}
	function retrieveCountryData(id) {
		if(id){
			createDialogCountry()
			<g:remoteFunction controller='workPlace' action='retrieveCountryData'
                          update='country-info' params="'id='+id"/>
		}
	}
</g:javascript>
<div class="fieldcontain ${hasErrors(bean: workPlaceInstance, field: 'workbook', 'error')} required">
    <label for="workbook">
        <g:message code="workPlace.workbook.label" default="Workbook" />
        <span class="required-indicator">*</span>
    </label>
    <g:select id="workbook" name="workbook.id"
              from="${WorkBook.list()}" optionKey="id"
              noSelection="['':'- Choose WorkBook Owner -']"
              value="${workPlaceInstance?.workbook?.id}" class="many-to-one"
    />
</div>
<div class="fieldcontain ${hasErrors(bean: workPlaceInstance, field: 'company', 'error')} required">
   <label for="company">
        <g:message code="workPlace.company.code"/>
        <span class="required-indicator">*</span>
    </label>
    <g:select id="company" name="company.id" from="${Company.listOrderByCode()}"
              optionKey="id" optionValue="code"
              value="${workPlaceInstance?.company?.id}" class="many-to-one"
              noSelection="['':'- Choose Company Code -']"
              onchange="retrieveCompanyData(this.value);"
    />
</div>
<div class="fieldcontain ${hasErrors(bean: workPlaceInstance, field: 'country', 'error')} required">
    <label for="country">
        <g:message code="workPlace.country.code"/>
        <span class="required-indicator">*</span>
    </label>
    <g:select id="country"  name="country.id"
              from="${Country.listOrderByCode()}"
              optionKey="id" optionValue="code" class="many-to-one"
              value="${workPlaceInstance?.country?.id}"
              noSelection="['':'- Choose Country Code -']"
              onchange="retrieveCountryData(this.value);"
    />
</div>
<div class="fieldcontain ${hasErrors(bean: workPlaceInstance, field: 'startDate', 'error')} required">
    <label for="startDate">
        <g:message code="workPlace.startDate.label" default="Start Date" />
        <span class="required-indicator">*</span>
    </label>
    <g:datePicker name="startDate" precision="day"  value="${workPlaceInstance?.startDate}"  />
</div>
<div class="addElement">
    <a id="current" class="addEndDate" href="#"> + Add End Date</a>
</div>
<div id="endDate" class="fieldcontain ${hasErrors(bean: workPlaceInstance, field: 'endDate', 'error')} ">
    <label for="endDate">
        <g:message code="workPlace.endDate.label" default="End Date" />
    </label>
    <g:datePicker name="endDate" precision="day"  value="${workPlaceInstance?.endDate}"
                      default="none" noSelection="['': '']"/>
</div>
<fieldset class="countryDialog">
	<g:render template="countryDialog"/>
</fieldset>
<fieldset class="companyDialog">
	<g:render template="companyDialog"/>
</fieldset>
