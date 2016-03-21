package workbook

import org.springframework.web.servlet.support.RequestContextUtils;
import groovy.xml.MarkupBuilder;

class LocaleTagLib {
    static namespace = 'locale'

    def locales = [Locale.ENGLISH, Locale.GERMAN]

    /**
     * Renders a locale selector.
     * Adds the class <code>active</code> to the list-element of the current language.
     */
    def selector = {
        def requestLocale = RequestContextUtils.getLocale(request)

        MarkupBuilder mb = new MarkupBuilder(out)
        mb.ol('id': 'locale-selector') {
            locales.each { Locale locale ->
                def attrs = ['type': 'radio','name': 'lang', 'checked': true,'disabled':true]
                if(requestLocale.language != locale.language) attrs.remove('checked')
                li(attrs) {
                    mb.yield(
                            link(controller: controllerName, action: actionName, params: params + [lang: locale.language],
                                    {locale.getLanguage() }).toString(),
                            false
                    )
                }
            }
        }
    }
}