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
	    /*** alternative way using HTTPSession session object ... session['xmlObject'] = xmlObject ***/
        def workPlacesCount = xmlObject?.workplaces.children().size()
	    def workBookOwner = "${xmlObject.firstName.text() ?: "Unknown"}" +
			    "_${xmlObject.lastName.text() ?: "Unknown"}"  //firstName_lastName
        render (view: 'import_show',
                model:[
                        workBookOwner: workBookOwner,
		                id: xmlObject.@id?.text(),
                        workPlacesCount: workPlacesCount,
                ])
    }

    def createFromImport(){
        def xmlObject = xmlProcessingServiceProxy.xmlObject
        WorkBook workBook = workBookService.xmlToDomain(xmlObject)
	    render(template:"form", model:[workBookInstance: workBook])
    }


	def uploading={
		println params
		fileUploader(params.uploadField)
		render params.name
		return
	}

	def fileUploader(def file){
		Random randomGenerator = new Random()
		int randomInt = randomGenerator.nextInt(1000000)
		def docName = randomInt+file?.getOriginalFilename()
		log.debug"Random no: "+randomInt

		InputStream is = file?.getInputStream()
		OutputStream os = new FileOutputStream(docName)   //file path
		log.debug"Image Size: "+file?.getSize()
		byte[] buffer = new byte[file?.getSize()]
		int bytesRead
		while ((bytesRead = is.read(buffer)) != -1) {
			os.write(buffer, 0, bytesRead)
		}
		is.close()
		os.close()
		return docName
	}

	def updateFromImport(){
		def xmlObject = xmlProcessingServiceProxy.xmlObject
		WorkBook workBook = workBookService.xmlToDomain(xmlObject)
		respond(workBook, view:'edit')
	}


}
