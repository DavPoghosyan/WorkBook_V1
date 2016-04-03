package com.webbfontaine.training

import am.webbfontaine.training.rimm.Company
import am.webbfontaine.training.rimm.Country
import org.springframework.security.access.annotation.Secured

import static org.springframework.http.HttpStatus.*

class WorkPlaceController {

	WorkPlaceService workPlaceService
    def xmlProcessingServiceProxy

	static allowedMethods = [save: 'POST', update: 'POST', delete: 'DELETE']

	@Secured(['ROLE_USER','ROLE_ADMIN'])
	def list(Integer max) {
		params.max = max ?: 10
		respond WorkPlace.list(params), model: [workPlaceInstanceCount: WorkPlace.count()]
	}

	@Secured(['ROLE_USER','ROLE_ADMIN'])
	def show(WorkPlace workPlace) {
			if (workPlace == null) {
			notFound()
			return
		}
		render(template: 'showWorkPlace', model:[workPlace: workPlace], status: OK)
	}

	@Secured(['ROLE_ADMIN'])
	def create() {
        WorkPlace workPlace = new WorkPlace(params)
        render(template:'create', model:[workPlace: workPlace], status: OK)
	}

	@Secured(['ROLE_ADMIN'])
	def createFromImport(){
		def xmlObject = xmlProcessingServiceProxy.xmlObject
		int i = params.id.toInteger() - 1
		WorkPlace workPlace = workPlaceService.xmlToDomain(xmlObject, i)
        if(session.workBookId) {
            workPlace.workbook = WorkBook.get(session.workBookId)
        }
		render(template:'create', model:[workPlace: workPlace], status: OK)
	}

	@Secured(['ROLE_ADMIN'])
	def save(WorkPlace workPlace) {
		if (workPlace == null) {
            notFound()
            return
        }
        workPlace.current = !workPlace?.endDate
        workPlace.registeredAt = new Date()
        workPlace.lastUpdatedAt = new Date()
        workPlace.workbook.lastUpdatedAt = new Date()
        additionalValidation(workPlace)
        if (workPlace.hasErrors()) {
            render (template:'create', model:[workPlace: workPlace])
            return
        }
        workPlaceService.save(workPlace)
        flash.message = message(
                code: 'default.created.message',
                args:  [WorkPlace.class.simpleName, workPlace.id])
        render(template: 'showWorkPlace', model:[workPlace: workPlace, workBookId: workPlace.workbook.id], status: OK)
	}

	@Secured(['ROLE_ADMIN'])
	def edit(WorkPlace workPlace) {
		render(template:'edit', model:[workPlace: workPlace])
	}

	@Secured(['ROLE_ADMIN'])
	def update(WorkPlace workPlace) {
		if (workPlace == null) {
			notFound()
			return
		}
        workPlace.lastUpdatedAt = new Date()
        workPlace.workbook.lastUpdatedAt = new Date()
		workPlace.current = !workPlace?.endDate
		if (!workPlace?.workbook){
			def errorCode = 'domain.not.found'
			def errorMessage = message(code: errorCode, args: [WorkBook.class.simpleName, params.workBookId])
			def invalidField = 'workbook'
			workPlace.errors.rejectValue(invalidField, errorCode, errorMessage)
		}
		additionalValidation(workPlace)
		if (workPlace.hasErrors()) {
            render (template:'edit', model:[workPlace: workPlace])
            workPlace.discard()
            return
		}
		workPlaceService.save(workPlace)
		flash.message = message(
				code: 'default.updated.message',
				args:  [WorkPlace.class.simpleName, workPlace.id])
        render(template: 'showWorkPlace', model:[workPlace: workPlace], status: OK)
	}

	@Secured(['ROLE_ADMIN'])
	def delete(WorkPlace workPlaceInstance) {
		if (workPlaceInstance == null) {
			notFound()
			return
		}
		long workBookId = workPlaceInstance.workbookId
		workPlaceService.remove(workPlaceInstance)
		flash.message = message(
				code: 'default.deleted.message',
				args:  [WorkPlace.class.simpleName, workPlaceInstance.id])
		render(template: 'showWorkPlace',model: [workBookId: workBookId], status: OK)
	}


    @Secured(['ROLE_USER','ROLE_ADMIN'])
    def retrieveCompanyData(long id) {
        def company =  Company.get(id)
        render(template:"companyDialog", model:[company: company])
    }

    @Secured(['ROLE_USER','ROLE_ADMIN'])
    def retrieveCountryData(long id) {
	    def country =  Country.get(id)
        render(template:"countryDialog", model:[country: country])
    }

	void notFound() {
		flash.message = message(
				code: 'default.not.found.message',
				args:  [WorkPlace.class.simpleName, params.id])
		redirect action:'list', method:'GET', status: NOT_FOUND
	}

	void additionalValidation(WorkPlace workPlace) {
		boolean isValid
		def  errorCode
		(isValid, errorCode) = workPlaceService.validate(workPlace)
    		if(!isValid) {
			def invalidField
			def errorMessage = message(code: errorCode)
			invalidField = errorCode.tokenize('.')[1]
			if(invalidField == 'range') {
				invalidField = workPlace?.endDate ? 'endDate' : 'startDate'
				errorMessage = message(code: errorCode, args: [workPlace.startDate, workPlace.endDate])
			}
			workPlace.errors.rejectValue(invalidField, errorCode, errorMessage)
		}
	}

}
