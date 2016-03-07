import com.webbfontaine.training.WorkBook
import grails.converters.XML

class BootStrap {

    def init = { servletContext ->

	    XML.createNamedConfig("shortDeep") {
		    XML.registerObjectMarshaller(WorkBook,{workBook, converter ->
			    converter.build {
				    id(workBook.id)
				    firstName(workBook.firstName)
				    lastName(workBook.lastName)
				    email(workBook.email)
				    passportNumber(workBook.passportNumber)
				    age(workBook.age)
				    dateOfBirth(workBook.dateOfBirth)
				    workPlaces(workBook.workplaces)
			    }
		    })
	    }
     /*   def adminRole = SecAppRole.newInstance(authority: 'ROLE_ADMIN')
	    adminRole.save(flush: true)
        def userRole = SecAppRole.newInstance(authority: 'ROLE_USER')
	    userRole.save(flush: true)

        def admin = SecAppUser.newInstance(username: 'admin', enabled: true, password: 'admin')
	    admin.save(flush: true)
	    def user = SecAppUser.newInstance(username: 'user', enabled: true, password: 'user' )
	    user.save(flush: true)

        SecAppUserSecAppRole.create(admin, adminRole)
	    SecAppUserSecAppRole.create(user, userRole)

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
*/
    }

    def destroy = {
    }


}
