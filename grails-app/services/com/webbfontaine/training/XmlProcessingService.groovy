package com.webbfontaine.training

import grails.converters.XML
import groovy.xml.MarkupBuilder

class XmlProcessingService {

	void exportToXML(def domainInstance) {
		XML.use('deep')
		def fileWriter = new FileWriter("${domainInstance.workbook} ${domainInstance.id}.xml")
		def xmlConverter = domainInstance as XML
		xmlConverter.render(fileWriter)
		fileWriter.close()
	}

	void importFromXML(){
		def xmlFile = new File("testXML.xml")
		def workplace = new XmlSlurper().parse(xmlFile)
		WorkPlace wp
		println workplace.childNodes()*.name()
		workplace.children().
		workplace.each() {p ->
			wp = new WorkPlace(p.attributes())
		}
		wp.save()
	}


}
