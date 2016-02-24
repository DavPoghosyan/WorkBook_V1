package com.webbfontaine.training

import org.springframework.transaction.annotation.Transactional

class WorkPlaceService {

	@Transactional(readOnly = true)
	def listWorkPlaces(){
		WorkPlace.list()
	}

	@Transactional
	def save(WorkPlace workPlace) {
		workPlace.save(flush: true)
	}

	@Transactional
	def remove(WorkPlace workPlace) {
		workPlace.delete(flush: true)
	}

    @Transactional(readOnly = true)
	boolean isAvailableDates(def workPlaceInstance) {
		Date startDate = workPlaceInstance.startDate
		Date endDate = workPlaceInstance.endDate ?: startDate.plus(57*365)
	    def c = WorkPlace.createCriteria()
	    def workPlaces = c.list {
		    and {
			    eq('workbook.id', workPlaceInstance.workbookId)
			    gt('endDate', startDate)
			    lt('startDate', endDate)
		    }
	    }
        workPlaces.remove(workPlaceInstance)
		if(!workPlaces.isEmpty()) {
			return false
		}
		return true
	}

    def Validate(WorkPlace workPlace) {
        if (workPlace.startDate.after(new Date())) {
            return [false, 'startDate']
        }
        if (workPlace.endDate == null && !workPlace.current) {
	        return [false, 'current']
        }
        if (!isAvailableDates(workPlace)){
            return [false, 'range']
        }
        return [true, '']
    }

}
