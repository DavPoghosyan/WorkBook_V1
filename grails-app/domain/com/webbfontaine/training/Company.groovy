package com.webbfontaine.training

class Company {

	String code
	String name
	String description

    @Override
    String toString() {
        def strCompany = ''
        this.properties.each {
            strCompany += "${it.key} ${it.value} \n"
        }
        return strCompany
    }
}
