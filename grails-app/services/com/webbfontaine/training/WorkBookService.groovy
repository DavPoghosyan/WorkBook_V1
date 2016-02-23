package com.webbfontaine.training

import org.springframework.transaction.annotation.Transactional

class WorkBookService {

    @Transactional(readOnly = true)
	def listWorkBooks(){
        WorkBook.list()
	}

	@Transactional
    def save(WorkBook workBook) {
        workBook.save(flush: true)
    }

	@Transactional
	def remove(WorkBook workBook) {
		workBook.delete(flush: true)
	}

	def isValidBirthDateAndAge(WorkBook workbook) {
        Date now = new Date()
        Date dateOfBirth = workbook.dateOfBirth
        int expectedAge = now.minus(dateOfBirth)/365
        if (expectedAge < 18) {
            return [false, 'dateOfBirth']
        }
        if(expectedAge != workbook.age) {
            return  [false, 'age']
        }
        return [true,'']
    }


}
