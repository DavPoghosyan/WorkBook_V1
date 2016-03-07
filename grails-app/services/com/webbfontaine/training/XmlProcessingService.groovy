package com.webbfontaine.training

import grails.converters.XML

class XmlProcessingService {

    static transactional = false

    static  scope = 'session'
    static proxy = true

    def xmlObject

	void exportToXML(domainInstance) {
		def fileWriter = new FileWriter("${domainInstance}.xml")
		XML.use("shortDeep")
        def xmlConverter = domainInstance as XML
		xmlConverter.render(fileWriter)
		fileWriter.close()
	}

	def importFromXML(flyFile){
        def dirForUploads = new File('uploads')
        dirForUploads.mkdir()
        File xmlOnServer = new File(dirForUploads,"template_${new Date().timeString}.xml")
        flyFile.transferTo(xmlOnServer)
        try {
            xmlObject = new XmlSlurper().parse(xmlOnServer)
            xmlObject
        }catch (any){
            'xml is not valid'
        }
	}

}
