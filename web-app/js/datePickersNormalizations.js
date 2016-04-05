/**
 * Created by davit on 4/1/16.
 */

$().ready( function(){


	var now = new Date()
	var curMonth = now.getMonth()+1
	var curDay = now.getDate()
	var curYear = now.getFullYear()

	$.daysPickerNormalization = function(yearSelector, monthSelector, daySelector, dayOptions) {
		var year = yearSelector.val()
		var isLeap = new Date(year, 1, 29).getMonth() == 1
		if(yearSelector.selector.indexOf('Birth') != -1 ) {
			year = parseInt(yearSelector.val()) + 18
		}
		if(monthSelector.val() == curMonth && year == curYear) {
			$('option:gt('+ curDay + ')',daySelector).remove();
		} else {
			daySelector.append(dayOptions);
			if(monthSelector.val() == 2) {
				$('option:gt(28)',daySelector).remove();
				if(isLeap == true) {
					daySelector.append(dayOptions.get(29));
				}
			} else {
				monthSelector = parseInt(monthSelector.val())
				if(monthSelector < 8 && monthSelector%2 == 0 ) {
					$('option:gt(30)',daySelector).remove();
				}else  if(monthSelector > 8 && monthSelector%2 != 0) {
					$('option:gt(30)', daySelector).remove();
				}
			}
		}

	}

	$.monthsPickerNormalization = function(yearSelector, monthSelector, monthOptions,skip){
		var year = yearSelector.val()
		if(yearSelector.selector.indexOf('Birth') != -1 ) {
			year = parseInt(yearSelector.val()) + 18
		}
		if(year < curYear) {

			if(skip == true) {
				return
			}
			monthSelector.append(monthOptions);
			skip = true
		} else {
			skip = false
			$('option:gt('+ curMonth + ')',monthSelector).remove();
		}
	}

});