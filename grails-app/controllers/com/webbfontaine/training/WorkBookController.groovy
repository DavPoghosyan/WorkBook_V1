package com.webbfontaine.training

import static org.springframework.http.HttpStatus.*

class WorkBookController {

    WorkBookService workBookService
    def xmlProcessingServiceProxy

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

	//@Secured(['permitAll'])
    def index() {
        respond workBookService.listWorkBooks()
    }

	//@Secured(['permitAll'])
    def show(WorkBook workBook) {
	    if (workBook == null) {
		    notFound()
		    return
	    }
        respond workBook
    }

	//@Secured(['ROLE_ADMIN'])
    def create(WorkBook workBook) {
        println params.workbook
        if(workBook){
            respond workBook
            return
        }
        respond new WorkBook(params)
    }

    //@Secured(['ROLE_ADMIN'])
    def edit(WorkBook workBook) {
        respond workBook
    }

	//@Secured(['ROLE_ADMIN'])
    def save(WorkBook workBook) {
        if (workBook == null) {
            notFound()
            return
        }
	    additionalValidation(workBook)
        if (workBook.hasErrors()) {
            respond(workBook.errors, view:'create', status: CONFLICT)
            return
        }
        workBookService.save(workBook)
        flash.message = message(
                code: 'default.created.message',
                args:  [WorkBook.class.simpleName, workBook.id])
        respond(workBook, view:'show', status: OK)
    }

	//@Secured(['ROLE_ADMIN'])
    def update(WorkBook workBook) {
        if (workBook == null) {
            notFound()
            return
        }
	    additionalValidation(workBook)
        if (workBook.hasErrors()) {
            respond(workBook.errors, view:'edit', Status: CONFLICT)
            workBook.workplaces*.discard()
            workBook.discard()
            return
        }
        workBookService.save(workBook)
        flash.message = message(
                code: 'default.updated.message',
                args:  [WorkBook.class.simpleName, workBook.id])
        respond(workBook, view:'show', status: OK)
    }

	//@Secured(['ROLE_ADMIN'])
    def delete(WorkBook workBook) {
        if (workBook == null) {
            notFound()
            return
        }
        workBookService.remove(workBook)
	    flash.message = message(
			    code: 'default.deleted.message',
			    args:  [WorkBook.class.simpleName, workBook.id])
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
			def customErrorCode = customErrorField ==
                    "age" ?  'age.invalid.property' : 'birthDate.invalid.property'
			def errorMessage = message(code: customErrorCode, args: customErrorField)
			workBook.errors.rejectValue(customErrorField, customErrorCode, errorMessage)
		}
	}

    def exportAsXML(WorkBook workBook){
        xmlProcessingServiceProxy.exportToXML(workBook)
        def xmlFile = new File("${workBook}.xml")
        response.with {
            setContentType('application/xml')
            setHeader('Content-Disposition', "Attachment;Filename=\"${xmlFile.name}\"")
            outputStream << xmlFile.bytes
        }
    }
    
    def uploadXmlFile() {
        def flyFile = request?.getFile('flyFile')
        def xmlObject = xmlProcessingServiceProxy.importFromXML(flyFile)
        //*** alternative way using HTTPSession session object ... session['xmlObject'] = xmlObject ***//
        def workPlacesCount = xmlObject?.workplaces.children().size()
        def workBookOwner = "${xmlObject.firstName.text() ?: "Unknown"}" +
                "_${xmlObject.lastName.text() ?: "Unknown"}"  //firstName_lastName
        "_${xmlObject.lastName.text() ?: "Unknown"}"  //firstName_lastName
        WorkBook workBook = workBookService.xmlToDomain(xmlObject)
        render (view: 'import_show',
                model:[
                        workBookInstance: workBook,
                        id: xmlObject.@id?.text(),
                        workPlacesCount: workPlacesCount,
                ])
    }

    def createFromImport(){
        def xmlObject = xmlProcessingServiceProxy.xmlObject
        WorkBook workBook = workBookService.xmlToDomain(xmlObject)
        render(template:'createTemp', model: [workBookInstance:  workBook])
    }


    def remoteSave(WorkBook workBook) {
        if (workBook == null) {
            notFound()
            return
        }
        additionalValidation(workBook)
        if (workBook.hasErrors()) {
            render (template:'createTemp', model:[workBookInstance: workBook])
            return
        }
        workBookService.save(workBook)
        flash.message = message(
                code: 'default.created.message',
                args:  [WorkBook.class.simpleName, workBook.id])
        render(template: 'showTemp', model:[workBookInstance: workBook], status: OK)
    }

    def remoteUpdate(WorkBook workBook) {
        if (workBook == null) {
            notFound()
            return
        }
        additionalValidation(workBook)
        if (workBook.hasErrors()) {
            render (template: 'editTemp', model:[workBookInstance: workBook])
            workBook.workplaces*.discard()
            workBook.discard()
            return
        }
        workBookService.save(workBook)
        flash.message = message(
                code: 'default.updated.message',
                args:  [WorkBook.class.simpleName, workBook.id])
        render(template: 'showTemp', model:[workBookInstance: workBook])
    }


	def updateFromImport(){
		def xmlObject = xmlProcessingServiceProxy.xmlObject
		WorkBook workBook = workBookService.xmlToDomain(xmlObject)
        render (template: 'editTemp', model:[workBookInstance: workBook])
	}

    def showTemp() {
        def xmlObject = xmlProcessingServiceProxy.xmlObject
        WorkBook workBook = WorkBook.get(xmlObject.@id.toLong())
        if (workBook == null) {
            notFound()
            return
        }
        render(template: 'showTemp', model:[workBookInstance: workBook], status: OK)
    }

}
