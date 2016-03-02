package com.webbfontaine.training

import org.springframework.transaction.annotation.Transactional

class WorkBookService {

    @Transactional(readOnly = true)
	def listWorkBooks(){
        WorkBook.list()
	}

	@Transactional
    void save(WorkBook workBook) {
        workBook.save(flush: true)
    }

	@Transactional
    void remove(WorkBook workBook) {
		workBook.delete(flush: true)
	}

	def isValidBirthDateAndAge(WorkBook workbook) {
        Date now = new Date()
        Date dateOfBirth = workbook.dateOfBirth
        int expectedAge = now.minus(dateOfBirth)/365.25
        if (expectedAge < 18) {
            return [false, 'dateOfBirth']
        }
        if(expectedAge != workbook.age) {
            return  [false, 'age']
        }
        return [true,'']
    }

    def xmlToDomain(def xmlObject) {
        WorkBook workBook = new WorkBook()
        String dateOfBirth =  xmlObject?.dateOfBirth.text() - ~/\b\w{3}\b/
        if(dateOfBirth){
            workBook.dateOfBirth = Date.parse('yyyy-MM-dd',dateOfBirth.trim())
        }
        workBook.age = xmlObject.age?.text() ? xmlObject.age.toInteger() : 18
        workBook.firstName = xmlObject.firstName.text() ?: "Unknown"
        workBook.lastName = xmlObject.lastName.text() ?: "Unknown"
        workBook.email = xmlObject.email.text()
        workBook.passportNumber = xmlObject.passportNumber.text()
        workBook.id =  xmlObject.@id?.text() ? xmlObject.@id.toLong() : 0
        workBook
    }

}
