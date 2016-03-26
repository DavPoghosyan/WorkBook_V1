package com.webbfontaine.training

import am.webbfontaine.training.rimm.Company
import am.webbfontaine.training.rimm.Country
import org.springframework.security.access.annotation.Secured

import static org.springframework.http.HttpStatus.*

class WorkPlaceController {

	WorkPlaceService workPlaceService
    def xmlProcessingServiceProxy

	static allowedMethods = [save: 'POST', update: 'PUT', delete: 'DELETE']

	@Secured(['ROLE_USER','ROLE_ADMIN'])
	def index(Integer max) {
		params.max = max ?: 10
		respond WorkPlace.list(params), model: [workPlaceInstanceCount: WorkPlace.count()]
	}

	@Secured(['ROLE_USER','ROLE_ADMIN'])
	def show(WorkPlace workPlace) {
		if (workPlace == null) {
			notFound()
			return
		}
		render(template: 'showTemp', model:[workPlace: workPlace], status: OK)
	}

	@Secured(['ROLE_ADMIN'])
	def create() {
		println params
        WorkPlace workPlace = new WorkPlace(params)
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
        render(template: 'showTemp', model:[workPlace: workPlace], status: OK)
	}

	@Secured(['ROLE_ADMIN'])
	def edit(WorkPlace workPlace) {
		render(template:'create', model:[workPlace: workPlace], status: OK)
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
		//additionalValidation(workPlace)
		if (workPlace.hasErrors()) {
            respond(workPlace.errors, view: 'edit', status: CONFLICT)
            workPlace.discard()
            return
		}
		workPlaceService.save(workPlace)
		flash.message = message(
				code: 'default.updated.message',
				args:  [WorkPlace.class.simpleName, workPlace.id])
		respond(workPlace, view:'show', status: OK)
	}

	@Secured(['ROLE_ADMIN'])
	def delete(WorkPlace workPlaceInstance) {
		if (workPlaceInstance == null) {
			notFound()
			return
		}
		workPlaceService.remove(workPlaceInstance)
		flash.message = message(
				code: 'default.deleted.message',
				args:  [WorkBook.class.simpleName, workPlaceInstance.id])
		render flash.message
	}

	@Secured(['ROLE_ADMIN'])
    def createFromImport(){
        def xmlObject = xmlProcessingServiceProxy.xmlObject
        int i = params.id.toInteger() - 1
        WorkPlace workPlace = workPlaceService.xmlToDomain(xmlObject, i)
        render(template:'createTemp', model: [workPlaceInstance:  workPlace])
    }

	@Secured(['ROLE_ADMIN'])
    def remoteSave(WorkPlace workPlace) {
        if (workPlace == null) {
            notFound()
            return
        }
       // additionalValidation(workPlace)
        if (workPlace.hasErrors()) {
            render (template:'create', model:[workPlace: workPlace])
            return
        }
        workPlaceService.save(workPlace)
        flash.message = message(
                code: 'default.created.message',
                args:  [WorkPlace.class.simpleName, workPlace.id])
        render(template: 'showTemp', model:[workPlaceInstance: workPlace], status: OK)
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
		redirect action:'index', method:'GET', status: NOT_FOUND
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
