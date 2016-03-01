package com.webbfontaine.training

import static org.springframework.http.HttpStatus.*

class WorkBookController {

    WorkBookService workBookService
    XmlProcessingService xmlProcessingService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

	//@Secured(['permitAll'])
    def index() {
        respond workBookService.listWorkBooks()
    }

	//@Secured(['permitAll'])
    def show(WorkBook workBookInstance) {
	    if (workBookInstance == null) {
		    notFound()
		    return
	    }
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
	    additionalValidation(workBookInstance)
        if (workBookInstance.hasErrors()) {
            respond(workBookInstance.errors, view:'create', status: CONFLICT)
            return
        }
        workBookService.save(workBookInstance)
        flash.message = message(
                code: 'default.created.message',
                args:  [WorkBook.class.simpleName, workBookInstance.id])
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
	    additionalValidation(workBookInstance)
        if (workBookInstance.hasErrors()) {
            respond(workBookInstance.errors, view:'edit', Status: CONFLICT)
            workBookInstance.workplaces*.discard()
            workBookInstance.discard()
            return
        }
        workBookService.save(workBookInstance)
        flash.message = message(
                code: 'default.updated.message',
                args:  [WorkBook.class.simpleName, workBookInstance.id])
        respond(workBookInstance, view:'show', status: OK)
    }

	//@Secured(['ROLE_ADMIN'])
    def delete(WorkBook workBookInstance) {
        if (workBookInstance == null) {
            notFound()
            return
        }
        workBookService.remove(workBookInstance)
	    flash.message = message(
			    code: 'default.deleted.message',
			    args:  [WorkBook.class.simpleName, workBookInstance.id])
	    redirect action:"index", method:"GET"
    }

    void notFound() {
	    flash.message = message(
			    code: 'default.not.found.message',
			    args:  [WorkBook.class.simpleName, params.id])
	    redirect action:"index", method:"GET", status: NOT_FOUND
    }

	void additionalValidation(WorkBook workBook) {
		boolean isValidAge
		def customErrorField
		(isValidAge, customErrorField) = workBookService.isValidBirthDateAndAge(workBook)
		if (!isValidAge) {
			def customErrorCode = customErrorField == "age" ?  'age.invalid.property' : 'birthDate.invalid.property'
			def errorMessage = message(code: customErrorCode, args: customErrorField)
			workBook.errors.rejectValue(customErrorField, customErrorCode, errorMessage)
		}
	}

    def exportAsXML(WorkBook workBook){
        xmlProcessingService.exportToXML(workBook)
        def xmlFile = new File("a.xml")
        response.with {
            setContentType('application/xml')
            setHeader('Content-Disposition', "Attachment;Filename=\"${xmlFile.name}\"")
            outputStream << xmlFile.bytes
        }
    }

    def importFromXML() {
        def flyFile = request.getFile('myFile')
        def xmlObject = xmlProcessingService.importFromXML(flyFile)
        println xmlObject.age
        String dateOfBirth =  xmlObject.dateOfBirth.text() - ~/\b\w{3}\b/
        WorkBook workBookInstance = new WorkBook()
        workBookInstance.dateOfBirth = Date.parse('yyyy-MM-dd',dateOfBirth.trim())
        workBookInstance.age = xmlObject.age.toInteger()
        workBookInstance.firstName = xmlObject.firstName.text()
        workBookInstance.lastName = xmlObject.lastName.text()
        workBookInstance.email = xmlObject.email.text()
        workBookInstance.passportNumber = xmlObject.passportNumber.text()
        workBookInstance.id = 1l
        println workBookInstance
        render(template:"form", model:[workBookInstance: workBookInstance])
        println workBookInstance
    }

}
