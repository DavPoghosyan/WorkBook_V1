package com.webbfontaine.training

class WorkPlace {

	Date startDate
	Date endDate
	boolean current
    String companyCode
    String countryCode

	static belongsTo = [workbook: WorkBook]

	static constraints = {
		endDate (blank: true, nullable: true,
				validator: { val, obj ->
					val?.after(obj.startDate)
				}
        )
        companyCode (
                validator: {
                    if (Company.findByCode(it) == null) {
                        return false
                    }
                }
        )
        countryCode (
                validator: {
                    if (Country.findByCode(it) == null) {
                        return false
                    }
                }
        )

	}
}
