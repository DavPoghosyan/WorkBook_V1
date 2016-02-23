package com.webbfontaine.training

import static org.springframework.http.HttpStatus.*

class WorkPlaceController {

	WorkPlaceService workPlaceService

	static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

	def index() {
		respond workPlaceService.listWorkPlaces()
	}

	def show(WorkPlace workPlaceInstance) {
		respond workPlaceInstance
	}

	def create() {
		respond new WorkPlace(params)
	}

	def save(WorkPlace workPlaceInstance) {
        println params
		if (workPlaceInstance == null) {
			notFound()
			return
		}
        boolean isValid
        String  invalidField
        (isValid, invalidField) = workPlaceService.Validate(workPlaceInstance)
        if(!isValid) {
            //String errorMessage = message(code: "custom.invalid.$invalidField", args: workPlaceInstance."${invalidField}")
            workPlaceInstance.errors.rejectValue(invalidField,"$invalidField is invalid")
        }
		if (workPlaceInstance.hasErrors()) {
            println workPlaceInstance.errors
			respond(workPlaceInstance.errors, view: 'create',status: CONFLICT)
			return
		}
		workPlaceService.save(workPlaceInstance)
		request.withFormat {
			form multipartForm {
				flash.message = message(code: 'default.created.message', args: [message(code: 'workPlace.label', default: 'WorkPlace'), workPlaceInstance.id])
				redirect workPlaceInstance
			}
			'*' { respond workPlaceInstance, [status: CREATED] }
		}
	}

	def edit(WorkPlace workPlaceInstance) {
		respond workPlaceInstance
	}

	def update(WorkPlace workPlaceInstance) {
		if (workPlaceInstance == null) {
			notFound()
			return
		}
        boolean isValid
        String  invalidField
        (isValid, invalidField) = workPlaceService.Validate(workPlaceInstance)
        if(!isValid) {
            //String errorMessage = message(code: "custom.invalid.$invalidField", args: workPlaceInstance."${invalidField}")
            workPlaceInstance.errors.rejectValue(invalidField,"$invalidField is invalid")
        }
		if (workPlaceInstance.hasErrors()) {
			println workPlaceInstance.errors
            respond(workPlaceInstance.errors, view: 'edit', status: CONFLICT)
            workPlaceInstance.discard()
            println workPlaceInstance
            return
		}

		workPlaceService.save(workPlaceInstance)
		request.withFormat {
			form multipartForm {
				flash.message = message(code: 'default.updated.message', args: [message(code: 'WorkPlace.label', default: 'WorkPlace'), workPlaceInstance.id])
				redirect workPlaceInstance
			}
			'*' { respond workPlaceInstance, [status: OK] }
		}
	}

	def delete(WorkPlace workPlaceInstance) {

		if (workPlaceInstance == null) {
			notFound()
			return
		}

		workPlaceService.remove(workPlaceInstance)

		request.withFormat {
			form multipartForm {
				flash.message = message(code: 'default.deleted.message', args: [message(code: 'WorkPlace.label', default: 'WorkPlace'), workPlaceInstance.id])
				redirect action: "index", method: "GET"
			}
			'*' { render status: NO_CONTENT }
		}
	}

	protected void notFound() {
		request.withFormat {
			form multipartForm {
				flash.message = message(code: 'default.not.found.message', args: [message(code: 'workPlace.label', default: 'WorkPlace'), params.id])
				redirect action: "index", method: "GET"
			}
			'*' { render status: NOT_FOUND }
		}
	}
}
