// Place your Spring DSL code here
import com.webbfontaine.training.WorkBook
import org.springframework.aop.scope.ScopedProxyFactoryBean
import org.codehaus.groovy.grails.web.mime.MimeType
import grails.rest.render.xml.XmlRenderer

beans = {
    xmlProcessingServiceProxy(ScopedProxyFactoryBean) {
        targetBeanName = 'xmlProcessingService'
        proxyTargetClass = true
    }

    // Register XML renderer for WorkBook resource.
    workBookcustomXmlParserRenderer(XmlRenderer, WorkBook) {
        mimeTypes = [new MimeType('application/vnd.com.webbfontaine.training.customXmlParser+xml', 'customXmlParser')]
        namedConfiguration = 'customXmlParser'
    }
}
