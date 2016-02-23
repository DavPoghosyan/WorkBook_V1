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
		additionalValidate(workPlaceInstance)
		if (workPlaceInstance.hasErrors()) {
            println workPlaceInstance.errors
			respond(workPlaceInstance.errors, view: 'create',status: CONFLICT)
			return
		}
		workPlaceService.save(workPlaceInstance)
		flash.message = message(
				code: 'default.updated.message',
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
		additionalValidate(workPlaceInstance)
		if (workPlaceInstance.hasErrors()) {
			println workPlaceInstance.errors
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

	void additionalValidate(WorkPlace workPlace) {
		boolean isValid
		def  invalidField
		(isValid, invalidField) = workPlaceService.Validate(workPlace)
		if(!isValid) {
			def errorCode
			def errorMessage
			switch (invalidField) {
				case 'current':
					errorCode =  'custom.invalid.current'
					errorMessage = message(code: errorCode)
					break
				case 'startDate':
					errorCode = 'custom.invalid.startDate'
					errorMessage = message(code: errorCode)
					break
				case 'endDate':
					errorCode = 'custom.invalid.endDate'
					errorMessage = message(code: errorCode)
					break
				case 'range':
					errorCode = 'custom.invalid.range'
					errorMessage = message(code: errorCode, args: [workPlace.startDate, workPlace.endDate])
					invalidField = 'endDate'
					break
				default: break
			}
			workPlace.errors.rejectValue(invalidField, errorCode, errorMessage)
		}
	}
}
