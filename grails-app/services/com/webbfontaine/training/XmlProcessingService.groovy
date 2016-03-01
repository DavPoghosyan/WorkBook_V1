package com.webbfontaine.training

import grails.converters.XML
import groovy.xml.MarkupBuilder

class XmlProcessingService {

	void exportToXML(def domainInstance) {
		XML.use('deep')
		def fileWriter = new FileWriter("a.xml")
		def xmlConverter = domainInstance as XML
		xmlConverter.render(fileWriter)
		fileWriter.close()
	}

	def importFromXML(def flyFile){
        def homeDir = new File(System.getProperty("user.home")) //user home e.g /home/username for unix
        File xmlOnServer = new File(homeDir,"some.xml")
        flyFile.transferTo(xmlOnServer)
		def xmlObject = new XmlSlurper().parse(xmlOnServer)
        xmlObject
	}


}
