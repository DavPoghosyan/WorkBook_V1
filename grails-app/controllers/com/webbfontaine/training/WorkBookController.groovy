package com.webbfontaine.training

import org.springframework.security.access.annotation.Secured

import static org.springframework.http.HttpStatus.*

class WorkBookController {

    WorkBookService workBookService
    def xmlProcessingServiceProxy

  //  static allowedMethods = [remoteSave: "POST", update: "PUT", delete: "DELETE"]

	/*@Secured(['ROLE_USER','ROLE_ADMIN'])
    def index() {
        respond workBookService.listWorkBooks()
    }*/
    @Secured(['ROLE_USER','ROLE_ADMIN'])
    def index(Integer max) {
        params.max = max ?: 10
        respond WorkBook.list(params), model: [workBookInstanceCount: WorkBook.count()]
    }

	@Secured(['ROLE_USER','ROLE_ADMIN'])
    def show(WorkBook workBook) {
        println params
	    if (workBook == null) {
		    notFound()
		    return
	    }
        respond workBook
    }

    @Secured(['ROLE_USER','ROLE_ADMIN'])
    def showTemp(WorkBook workBook) {
        if (workBook == null) {
            notFound()
            return
        }
        render(template: 'showWorkBook', model:[workBookInstance: workBook], status: OK)
    }

	@Secured(['ROLE_ADMIN'])
    def create(WorkBook workBook) {
        if(workBook){
            respond workBook
            return
        }
        respond new WorkBook(params)
    }

    @Secured(['ROLE_ADMIN'])
    def edit(WorkBook workBook) {
        render (template:'editTemp', model:[workBookInstance: workBook])
    }

	@Secured(['ROLE_ADMIN'])
    def save(WorkBook workBook) {
        if (workBook == null) {
            notFound()
            return
        }
	   // additionalValidation(workBook)
        workBook.registeredAt = new Date()
        workBook.lastUpdatedAt = new Date()
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

	@Secured(['ROLE_ADMIN'])
    def update(WorkBook workBook) {
        println params
        //workBook.lock()
        if (workBook == null) {
            notFound()
            return
        }
	   // additionalValidation(workBook)
        if(workBookService.isInValidModifications(workBook)) {
            def customErrorCode =  'workBook.age.conflict.workplaces'
            def errorMessage = message(code: customErrorCode)
            workBook.errors.rejectValue('dateOfBirth', customErrorCode, errorMessage)
        }
        if (workBook.hasErrors()) {
            render (template: 'editTemp', model:[workBookInstance: workBook])
            workBook.workplaces*.discard()
            workBook.discard()
            return
        }
        workBook.lastUpdatedAt(new Date())
        workBookService.save(workBook)
        flash.message = message(
                code: 'default.updated.message',
                args:  [WorkBook.class.simpleName, workBook.id])
        render (template: 'showWorkBook', model:[workBookInstance: workBook])
    }

    @Secured(['ROLE_ADMIN'])
    def remoteUpdate(WorkBook workBook) {
        if (workBook == null) {
            notFound()
            return
        }
      //  additionalValidation(workBook)
        if(workBookService.isInValidModifications(workBook)) {
            def customErrorCode =  'workBook.age.conflict.workplaces'
            def errorMessage = message(code: customErrorCode)
            workBook.errors.rejectValue('dateOfBirth', customErrorCode, errorMessage)
        }
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
        render(template: 'showWorkBook', model:[workBookInstance: workBook])
    }

	@Secured(['ROLE_ADMIN'])
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

    @Secured(['ROLE_USER','ROLE_ADMIN'])
    def exportAsXML(WorkBook workBook){
        def xmlString = xmlProcessingServiceProxy.exportToXML(workBook)
        response.with {
            setContentType('application/xml')
            setHeader('Content-Disposition', "Attachment;Filename=\"${workBook}\"")
            outputStream << xmlString
        }
    }

    @Secured(['ROLE_ADMIN'])
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
        /*render (view: 'show',
                model:[
                        workBookInstance: workBook,
                        id: xmlObject.@id?.text(),
                        workPlacesCount: workPlacesCount,
                ])*/
        workBook.validate()
        if(workBookService.isInValidModifications(workBook)) {
            def customErrorCode =  'workBook.age.conflict.workplaces'
            def errorMessage = message(code: customErrorCode)
            workBook.errors.rejectValue('dateOfBirth', customErrorCode, errorMessage)
        }
        render(model: [workBookInstance: workBook, workPlacesCount: workPlacesCount], view:'create', status: OK)
    }

    @Secured(['ROLE_ADMIN'])
    def createFromImport(){
        def xmlObject = xmlProcessingServiceProxy.xmlObject
        WorkBook workBook = workBookService.xmlToDomain(xmlObject)
        render(template:'xmlImportViews/createTemp', model: [workBookInstance:  workBook])
    }

    @Secured(['ROLE_ADMIN'])
    def remoteSave(WorkBook workBook) {
        println workBook.errors
        if (workBook == null) {
            notFound()
            return
        }
        workBook.registeredAt = new Date()
        workBook.lastUpdatedAt = new Date()
        additionalValidation(workBook)
        if (workBook.hasErrors()) {
            println workBook.errors
            render (template:'xmlImportViews/createTemp', model:[workBookInstance: workBook])
           // render(view:'create', model: [workBookInstance:  workBook])
            return
        }
        workBookService.save(workBook)
        session['workBookId'] = workBook.id
        flash.message = message(
                code: 'default.created.message',
                args:  [WorkBook.class.simpleName, workBook.id])
        render(template: 'showWorkBook', model:[workBookInstance: workBook], status: OK)
    }

    @Secured(['ROLE_ADMIN'])
	def updateFromImport(){
		def xmlObject = xmlProcessingServiceProxy.xmlObject
		WorkBook workBook = workBookService.xmlToDomain(xmlObject)
        render (template: 'editTemp', model:[workBookInstance: workBook, flag: true])
	}

    void notFound() {
        flash.message = message(
                code: 'default.not.found.message',
                args:  [WorkBook.class.simpleName, params.id])
        redirect action:"index", method:"GET", status: NOT_FOUND
    }

    void additionalValidation(WorkBook workBook) {
        def customErrorField
        if (!workBookService.isValidBirthDate(workBook)) {
            def customErrorCode =  'workBook.age.min.invalid'
            def errorMessage = message(code: customErrorCode, args: customErrorField)
            workBook.errors.rejectValue(customErrorField, customErrorCode, errorMessage)
        }
    }

}
