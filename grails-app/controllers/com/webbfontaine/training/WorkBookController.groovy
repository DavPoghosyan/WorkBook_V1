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
        if(!xmlFile.exists()){
            flash.message = 'internal server error export unavailble , please try a bit late'
            respond(workBook, view:'show', status: INTERNAL_SERVER_ERROR)
            return
        }
        response.with {
            setContentType('application/xml')
            setHeader('Content-Disposition', "Attachment;Filename=\"${xmlFile.name}\"")
            outputStream << xmlFile.bytes
        }
    }

    def uploadXmlFile() {
        def flyFile = request?.getFile('flyFile')
        if(flyFile.empty){
	        flash.error = 'file not chosen'
            respond(flash.error, view:'create', status: CONFLICT)
            return
        }
	    def fileExtension = flyFile.originalFilename.substring(flyFile.originalFilename.lastIndexOf('.')+1)
	    if(fileExtension != 'xml') {
		    flash.error = 'fileupload.upload.unauthorizedExtension'
		    respond(flash.error, view:'create', status: CONFLICT)
		    return
	    }
        def xmlObject = xmlProcessingServiceProxy.importFromXML(flyFile)//*** alternative way using HTTPSession session object ... session['xmlObject'] = xmlObject ***//
        if(String.isCase(xmlObject)){
            flash.error = xmlObject
            respond(flash.error, view:'create', status: CONFLICT)
            return
        }
        int workPlacesCount = xmlObject?.workplaces.children().size()
        WorkBook workBook = workBookService.xmlToDomain(xmlObject)
        render (view: 'xmlImportViews/importView',
                model:[
                        workBookInstance: workBook,
                        id: xmlObject.@id?.text(),
                        workPlacesCount: workPlacesCount,
                ])
    }

    def createFromImport(){
        def xmlObject = xmlProcessingServiceProxy.xmlObject
        WorkBook workBook = workBookService.xmlToDomain(xmlObject)
        render(template:'xmlImportViews/createTemp', model: [workBookInstance:  workBook])
    }

    def remoteSave(WorkBook workBook) {
        if (workBook == null) {
            notFound()
            return
        }
        additionalValidation(workBook)
        if (workBook.hasErrors()) {
            println workBook.errors
            render (template:'xmlImportViews/createTemp', model:[workBookInstance: workBook])
            return
        }
        workBookService.save(workBook)
        flash.message = message(
                code: 'default.created.message',
                args:  [WorkBook.class.simpleName, workBook.id])
        render(template: 'xmlImportViews/showTemp', model:[workBookDbInstance: workBook], status: OK)
    }

    def remoteUpdate(WorkBook workBook) {
        if (workBook == null) {
            notFound()
            return
        }
        additionalValidation(workBook)
        if (workBook.hasErrors()) {
            render (template: 'xmlImportViews/editTemp', model:[workBookInstance: workBook])
            workBook.workplaces*.discard()
            workBook.discard()
            return
        }
        workBookService.save(workBook)
        flash.message = message(
                code: 'default.updated.message',
                args:  [WorkBook.class.simpleName, workBook.id])
        render(template: 'xmlImportViews/showTemp', model:[workBookDbInstance: workBook, flag: false])
    }

	def updateFromImport(){
		def xmlObject = xmlProcessingServiceProxy.xmlObject
		WorkBook workBook = workBookService.xmlToDomain(xmlObject)
        render (template: 'xmlImportViews/editTemp', model:[workBookInstance: workBook, flag: true])
	}

}
