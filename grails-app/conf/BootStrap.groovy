import com.webbfontaine.training.Company
import com.webbfontaine.training.Country
import com.webbfontaine.training.WorkBook

class BootStrap {

    def init = { servletContext ->
     /*   def adminRole = SecAppRole.newInstance(authority: 'ROLE_ADMIN')
	    adminRole.save(flush: true)
        def userRole = SecAppRole.newInstance(authority: 'ROLE_USER')
	    userRole.save(flush: true)

        def admin = SecAppUser.newInstance(username: 'admin', enabled: true, password: 'admin')
	    admin.save(flush: true)
	    def user = SecAppUser.newInstance(username: 'user', enabled: true, password: 'user' )
	    user.save(flush: true)

        SecAppUserSecAppRole.create(admin, adminRole)
	    SecAppUserSecAppRole.create(user, userRole)*/

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

        grails.converters.JSON.registerObjectMarshaller( com.webbfontaine.training.WorkBook ) {
            return [
                    id : it.id,
                    name: it.firstName
            ]
        }

       /* grails.converters.XML.registerObjectMarshaller(WorkBook) {workbook, converter ->
            converter.build {
                id(workbook.id)
            }
        }*/
    }

    def destroy = {
    }


}
