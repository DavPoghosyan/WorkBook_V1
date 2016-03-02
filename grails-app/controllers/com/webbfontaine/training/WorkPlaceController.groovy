package com.webbfontaine.training

import static org.springframework.http.HttpStatus.*

class WorkPlaceController {

	WorkPlaceService workPlaceService

	static allowedMethods = [save: 'POST', update: 'PUT', delete: 'DELETE']

	def index() {
		respond workPlaceService.listWorkPlaces()
	}

	def show(WorkPlace workPlaceInstance) {
		if (workPlaceInstance == null) {
			notFound()
			return
		}
		respond workPlaceInstance
	}

	def create() {
		respond new WorkPlace(params)
	}

	def save(WorkPlace workPlaceInstance) {
		if (workPlaceInstance == null) {
			notFound()
			return
		}
		workPlaceInstance.current = !workPlaceInstance?.endDate
		additionalValidation(workPlaceInstance)
		if (workPlaceInstance.hasErrors()) {
			respond(workPlaceInstance.errors, view: 'create',status: CONFLICT)
			return
		}
		workPlaceService.save(workPlaceInstance)
		flash.message = message(
				code: 'default.created.message',
				args:  [WorkPlace.class.simpleName, workPlaceInstance.id])
		respond(workPlaceInstance, view:'show', status: OK)
	}

	def edit(WorkPlace workPlaceInstance) {
		respond workPlaceInstance
	}

	def update(WorkPlace workPlaceInstance) {
		if (workPlaceInstance == null) {
			notFound()
			return
		}
		workPlaceInstance.current = !workPlaceInstance?.endDate
		if (!workPlaceInstance?.workbook){
			def errorCode = 'domain.not.found'
			def errorMessage = message(code: errorCode, args: [WorkBook.class.simpleName, params.workBookId])
			def invalidField = 'workbook'
			workPlaceInstance.errors.rejectValue(invalidField, errorCode, errorMessage)
		}
		additionalValidation(workPlaceInstance)
		if (workPlaceInstance.hasErrors()) {
            respond(workPlaceInstance.errors, view: 'edit', status: CONFLICT)
            workPlaceInstance.discard()
            return
		}
		workPlaceService.save(workPlaceInstance)
		flash.message = message(
				code: 'default.updated.message',
				args:  [WorkPlace.class.simpleName, workPlaceInstance.id])
		respond(workPlaceInstance, view:'show', status: OK)
	}

	def delete(WorkPlace workPlaceInstance) {
		if (workPlaceInstance == null) {
			notFound()
			return
		}
		workPlaceService.remove(workPlaceInstance)
		flash.message = message(
				code: 'default.deleted.message',
				args:  [WorkBook.class.simpleName, workPlaceInstance.id])
		redirect action:'index', method:'GET'
	}

	void notFound() {
		flash.message = message(
				code: 'default.not.found.message',
				args:  [WorkBook.class.simpleName, params.id])
		redirect action:'index', method:'GET', status: NOT_FOUND
	}

	void additionalValidation(WorkPlace workPlace) {
		boolean isValid
		def  errorCode
		(isValid, errorCode) = workPlaceService.validate(workPlace)
		if(!isValid) {
			def invalidField
			def errorMessage = message(code: errorCode)
				invalidField = errorCode.tokenize('.').first()
			if(invalidField == 'range') {
				invalidField = workPlace?.endDate ? 'endDate' : 'startDate'
				errorMessage = message(code: errorCode, args: [workPlace.startDate, workPlace.endDate])
			}
			workPlace.errors.rejectValue(invalidField, errorCode, errorMessage)
		}
	}


    def retrieveCompanyData(long id) {
		def company =  Company.get(id)
        render(template:"companyDialog", model:[company: company])
    }

    def retrieveCountryData(long id) {
        def country =  Country.get(id)
	    render(template:"countryDialog", model:[country: country])
    }

}
