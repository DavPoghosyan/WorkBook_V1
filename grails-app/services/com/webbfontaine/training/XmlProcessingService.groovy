package com.webbfontaine.training

import grails.converters.XML
import org.codehaus.groovy.grails.web.converters.marshaller.xml.DomainClassMarshaller


class XmlProcessingService {

    static transactional = false

    static  scope = 'session'
    static proxy = true

    def xmlObject

	void exportToXML(domainInstance) {
		//XML.use('deep')
		def fileWriter = new FileWriter("${domainInstance}.xml")

        XML.createNamedConfig("forCustomers") {
            XML.registerObjectMarshaller(WorkBook,{workbook, conv ->
                conv.build {
                    login(workbook.firstName)
                    name(workbook.lastName)
                    workPlaces(workbook.workplaces)
                }
            })
        }
       XML.use("forCustomers")
       /* def converter = new XML(domainInstance)
        converter.registerObjectMarshaller(WorkBook, {workbook, conv ->
            conv.build {
                login(workbook.firstName)
                name(workbook.lastName)
            }
        })*/
        def xmlConverter = domainInstance as XML
		xmlConverter.render(fileWriter)
		fileWriter.close()
	}

	def importFromXML(flyFile){
        def dirForUploads = new File('uploads')
        dirForUploads.mkdir()
        File xmlOnServer = new File(dirForUploads,"template_${new Date().timeString}.xml")
        flyFile.transferTo(xmlOnServer)
        validate(xmlOnServer)
        try {
            xmlObject = new XmlSlurper().parse(xmlOnServer)
            xmlObject
        }catch (any){
            'xml is not valid'
        }
	}

	boolean validate(file) {
       /* URL schemaFile = new URL("http://java.sun.com/xml/ns/j2ee/web-app_2_4.xsd");
        Source xmlFile = new StreamSource(file)
        SchemaFactory schemaFactory = SchemaFactory
                .newInstance(XMLConstants.W3C_XML_SCHEMA_NS_URI);
        Schema schema = schemaFactory.newSchema(schemaFile);
        Validator validator = schema.newValidator();
        try {
            validator.validate(xmlFile);
            System.out.println(xmlFile.getSystemId() + " is valid");
        } catch (SAXException e) {
            System.out.println(xmlFile.getSystemId() + " is NOT valid");
            System.out.println("Reason: " + e.getLocalizedMessage());
        }*/
    }

}
