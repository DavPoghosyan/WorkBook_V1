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

    }

    def destroy = {
    }
}
