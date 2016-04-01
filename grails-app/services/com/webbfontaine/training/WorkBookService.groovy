package com.webbfontaine.training

import org.springframework.transaction.annotation.Transactional

class WorkBookService {

   @Transactional(readOnly = true)
	def listWorkBooks(int max){
        WorkBook.list(max : max)
	}

	@Transactional
    void save(WorkBook workBook) {
        workBook.save(flush: true)
    }

	@Transactional
    void remove(WorkBook workBook) {
		workBook.delete(flush: true)
	}

    @Transactional(readOnly = true)
    def isInValidModifications(WorkBook workBook) {
        Date dateOfBirth = workBook.dateOfBirth
        boolean flag
        workBook.workPlaces.any {
            flag = it.startDate.minus(dateOfBirth)/365.25 < 18
        }
        return flag

    }

    def xmlToDomain(def xmlObject) {
        WorkBook workBook = new WorkBook()
        String dateOfBirth =  xmlObject?.dateOfBirth.text() - ~/\b\w{3}\b/
        if(dateOfBirth){
            workBook.dateOfBirth = Date.parse('yyyy-MM-dd',dateOfBirth.trim())
        }
        workBook.firstName = xmlObject.firstName.text() ?: "Unknown"
        workBook.lastName = xmlObject.lastName.text() ?: "Unknown"
        workBook.email = xmlObject.email.text()
        workBook.passportNumber = xmlObject.passportNumber.text()
        workBook
    }

}
