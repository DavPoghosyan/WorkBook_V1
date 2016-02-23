package com.webbfontaine.training

import org.springframework.validation.FieldError

import static org.springframework.http.HttpStatus.*


class WorkBookController {

    WorkBookService workBookService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    String customErrorField , customErrorCode
    Boolean isValidAge = true

	//@Secured(['permitAll'])
    def index() {
        respond workBookService.listWorkBooks()
    }

	//@Secured(['permitAll'])
    def show(WorkBook workBookInstance) {
        respond workBookInstance
    }

	//@Secured(['ROLE_ADMIN'])
    def create() {
        respond new WorkBook(params)
    }

	//@Secured(['ROLE_ADMIN'])
    def save(WorkBook workBookInstance) {
        if (workBookInstance == null) {
            notFound()
            return
        }
        (isValidAge, customErrorField) = workBookService.isValidBirthDateAndAge(workBookInstance)
        if (!isValidAge) {
            customErrorCode = customErrorField == "age" ?  'custom.invalid.age' : 'custom.invalid.birth.date'
            String errorMessage = message(code: customErrorCode, args: customErrorField)
            workBookInstance.errors.rejectValue(customErrorField,errorMessage)
        }
        if (workBookInstance.hasErrors()) {
            println workBookInstance.errors
            respond(workBookInstance.errors, view:'create', status: CONFLICT)
            return
        }
        workBookService.save(workBookInstance)
        flash.message = message(
                code: 'default.created.message',
                args:  [WorkBook.class.name, workBookInstance.id])
        respond(workBookInstance, view:'show', status: OK)
    }

	//@Secured(['ROLE_ADMIN'])
    def edit(WorkBook workBookInstance) {
        respond workBookInstance
    }

	//@Secured(['ROLE_ADMIN'])
    def update(WorkBook workBookInstance) {
        if (workBookInstance == null) {
            notFound()
            return
        }
        (isValidAge, customErrorField) = workBookService.isValidBirthDateAndAge(workBookInstance)
        if (!isValidAge) {
            customErrorCode = customErrorField == "age" ?  'custom.invalid.age' : 'custom.invalid.birth.date'
            String errorMessage = message(code: customErrorCode, args: customErrorField)
            workBookInstance.errors.rejectValue(customErrorField,errorMessage)
        }
        if (workBookInstance.hasErrors()) {
            println workBookInstance.errors
            respond(workBookInstance.errors, view:'edit', Status: CONFLICT)
            workBookInstance.workplaces*.discard()
            workBookInstance.discard()
            println workBookInstance
            return
        }
        workBookService.save(workBookInstance)
        flash.message = message(
                code: 'default.updated.message',
                args:  [WorkBook.class.name, workBookInstance.id])
        respond(workBookInstance, view:'show', status: OK)
    }

	//@Secured(['ROLE_ADMIN'])
    def delete(WorkBook workBookInstance) {
        if (workBookInstance == null) {
            notFound()
            return
        }
        workBookService.remove(workBookInstance)
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'WorkBook.label', default: 'WorkBook'), workBookInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'workBook.label', default: 'WorkBook'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
