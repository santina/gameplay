#' Documentation
#'
#' Checks if the nhl server is available for query
#'
#' This functions return TRUE if the connection is good.
#'
#' @return boolean to indicate if connection to `http://live.nhle.com/` server is good
#' @note If it's false, it means either the internet connection is not available or
#' the NHL server is down... though not likely cuz they can't afford that downtime!
#' (remember to pay your internet bill)



checkNHLConnection <- function() {
	tryCatch({RCurl::getURL("http://live.nhle.com/"); TRUE},
					 error = function(err) FALSE)
}
