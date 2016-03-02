package com.webbfontaine.training

import grails.converters.XML

class XmlProcessingService {

    static transactional = false

    static  scope = 'session'
    static proxy = true

    def xmlObject

	void exportToXML(def domainInstance) {
		XML.use('deep')
		def fileWriter = new FileWriter("${domainInstance}.xml")
		def xmlConverter = domainInstance as XML
		xmlConverter.render(fileWriter)
		fileWriter.close()
	}

	def importFromXML(def flyFile){
        def dirForUploads = new File('uploads') //user home e.g /home/username for unix
        dirForUploads.mkdir()
        File xmlOnServer = new File(dirForUploads,"template_${new Date().timeString}.xml")
        flyFile.transferTo(xmlOnServer)
		xmlObject = new XmlSlurper().parse(xmlOnServer)
        xmlObject
	}


}
