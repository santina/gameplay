#' Documentation
#'
#' Checks the input date if it's proper format.
#'
#' This functions return TRUE if the date for format, otherwise error messages
#'
#' @param date The string we wish to check if it's a proper date format
#' @return boolean to indicate if date is in the format of YYYY-MM-DD
# @note When \code{date} is ignored it will return FALSE



checkDate  <- function(date = Sys.Date()){

	dateArray <- strsplit(as.character(date), "-")

	# first check if the length is sensible
	year <- nchar(dateArray[[1]][1])
	month <- nchar(dateArray[[1]][2])
	day <- nchar(dateArray[[1]][3])
	good  <- year == 4 & month == 2 & day == 2

	if(good == FALSE) {
		stop("Try again with the date format YYYY-MM-DD")
	}

	# check if inputs are all numbers
	yearNumber  <- suppressWarnings(!is.na(as.numeric(dateArray[[1]][1])))
	monthNumber <- suppressWarnings(!is.na(as.numeric(dateArray[[1]][2])))
	dayNumber <- suppressWarnings(!is.na(as.numeric(dateArray[[1]][3])))
	good = yearNumber&monthNumber&dayNumber

	if(good == FALSE){
		stop("Please try again with date format YYYY-MM-DD with all numbers")
	}

	good
}

