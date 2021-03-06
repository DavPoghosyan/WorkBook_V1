import com.webbfontaine.training.SecRole
import com.webbfontaine.training.SecUser
import com.webbfontaine.training.SecUserSecRole
import com.webbfontaine.training.WorkBook
import grails.converters.XML
import am.webbfontaine.training.rimm.Company
import am.webbfontaine.training.rimm.Country

class BootStrap {

    def init = { servletContext ->
        XML.createNamedConfig("customXmlParser") {
                it.registerObjectMarshaller(WorkBook){WorkBook workBook, xml ->
                    xml.build {
                        firstName(workBook.firstName)
                        lastName(workBook.lastName)
                        email(workBook.email)
                        passportNumber(workBook.passportNumber)
                        age(workBook.age)
                        dateOfBirth(workBook.dateOfBirth)
                        workPlaces(workBook.workPlaces)
                    }
            }
        }

       /* def adminRole = SecRole.newInstance(authority: 'ROLE_ADMIN')
        adminRole.save(flush: true)
        def userRole = SecRole.newInstance(authority: 'ROLE_USER')
        userRole.save(flush: true)

        def admin = SecUser.newInstance(username: 'admin', enabled: true, password: 'admin')
        admin.save(flush: true)
        def user = SecUser.newInstance(username: 'user', enabled: true, password: 'user' )
        user.save(flush: true)

        SecUserSecRole.add(admin, adminRole)
        SecUserSecRole.add(user, userRole)*/

        Country country = Country.newInstance(name: 'Armenia', code: 'AM', description: 'Republic')
        country.save(flush: true)
	    Country country1 = Country.newInstance(name: 'Poland', code: 'PL', description: 'Republic')
	    country1.save(flush: true)
        Country country2 = Country.newInstance(name: 'Denmark', code: 'DK', description: 'Kingdom')
        country2.save(flush: true)

	    Company company = Company.newInstance(code: 'WBBF', name: 'Webb Fontaine', description: 'e-Government Solutions')
	    company.save(flush: true)
	    Company company1 = Company.newInstance(code: 'DC', name: 'Double Coconut', description: 'Game Boutique')
	    company1.save(flush: true)
	    Company company2 = Company.newInstance(code: 'JD_IT', name: 'JEDEN IT', description: 'Information systems integration')
	    company2.save(flush: true)
    }

    def destroy = {
    }


}
