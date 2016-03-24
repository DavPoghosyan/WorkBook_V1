package com.webbfontaine.training

class WorkBook {

    String firstName
    String lastName
    String email
    String passportNumber
    Date dateOfBirth

    static transients = ['fullName','age']

    static hasMany = [workplaces: WorkPlace]

    static constraints = {
	    firstName(size: 3..25)
	    lastName(size: 3..25)
        email(email: true, unique: true)
        passportNumber(unique: true, matches: '^[A-Z]{2}[0-9]{7}')
        age(min: 18, max: 65)
    }

    String getFullName(){
        "$firstName ${lastName}"
    }

    int getAge(){
        new Date().minus(dateOfBirth)/365.25
    }

	String toString() {
        fullName
	}


}
