package com.webbfontaine.training

class WorkPlace {

	Date startDate
	Date endDate
	boolean current
    String companyCode
    String countryCode


    static Company retrieveCompany(String code) {
        Company.findByCode(code)
    }

    static Country retrieveCountry(String code) {
        Country.findByCode(code)
    }

	static belongsTo = [workbook: WorkBook]

	static constraints = {
		endDate (blank: true, nullable: true)
        companyCode (
                validator: {
                    if(!retrieveCompany(it)) {
                        return false
                    }
                }
        )
        countryCode (
                validator: {
                    if(retrieveCountry(it) == null) {
                        return false
                    }
                }
        )

	}
}
