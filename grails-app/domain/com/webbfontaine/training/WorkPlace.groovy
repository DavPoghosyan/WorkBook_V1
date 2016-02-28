package com.webbfontaine.training

class WorkPlace {

	Date startDate
	Date endDate
	boolean current
    Company company
    Country country

	static belongsTo = [workbook: WorkBook]
	
	static constraints = {
		endDate (blank: true, nullable: true,
				validator: { val, obj ->
					val?.after(obj.startDate)
				}
        )
	}

	def dateMessage = { Date date ->
		date ? date.getDateTimeString().tokenize().first() : "now"
	}

	@Override
	String toString() {
		"${this?.company?.name} (${this?.country?.code}) ${dateMessage(startDate)} to ${dateMessage(endDate)} "
	}
}
