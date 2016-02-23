package com.webbfontaine.training

class WorkPlace {

	Date startDate
	Date endDate
	boolean current
	Company company
	Country country

	static embedded = ['company', 'country']

	static belongsTo = [workbook: WorkBook]

	static constraints = {
		endDate (blank: true, nullable: true)
	}
}

class Company {

	String name
	String code

}

class Country {

	String name
	String code

}
