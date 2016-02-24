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
		Date endDate = workPlaceInstance.endDate ?: startDate.plus(1)
		//WorkPlace workPlace = WorkPlace.findByWorkBookIdAndStartDateBetweenOrEndDateBetween(workPlaceInstance.workbookId,startDate,endDate,startDate,endDate)
		def workPlaces = WorkPlace.executeQuery("FROM WorkPlace \n" +
                "where workbook_id = :workbook and \n" +
                "(start_date BETWEEN :startDate AND :endDate or\n" +
                "end_date BETWEEN :startDate AND :endDate )" +
                "or (:startDate BETWEEN start_date AND end_date\n" +
                "or :endDate BETWEEN start_date AND end_date)",
                [workbook:  workPlaceInstance.workbookId, startDate: startDate, endDate: endDate])
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
        if (workPlace.endDate == null) {
            if(!workPlace.current) {
                return [false, 'current']
            }
        } else {
            if(workPlace.endDate.before(workPlace.startDate)) {
                return [false, 'endDate']
            }
            if(workPlace.current)
                return [false, 'current']
        }
        if (!isAvailableDates(workPlace)){
            return [false, 'range']
        }
        return [true, '']
    }

/*    def validation =  { WorkPlace workPlace, String errorField ->
        Date now = new Date();
        if (workPlace.startDate.after(new Date())) {
            errorField = 'startDate'
        }

    }*/

}
