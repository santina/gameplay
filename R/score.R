#' Documentation
#'
#' Gives a summary of the scores from all teams playing on the given date.
#' Default date is that of the current day.
#'
#' This functions return a data.frame of the scores of all home teams and away teams,
#' as available on live.nhle.com.
#'
#' @param date The scores of the date you want to search for. format: YYYY-MM-DD
#' @param team The team of your interest. If it's playing as indicated by gday(),
#' the function will return the score information of both the team and its rival team.
#' @return data.frame If connection to live.nhle.com is successful and
#' that the date is the right format
#' @note When \code{date} is ignored it will check for \code{Sys.Date()},
#' and if \code{team} is ignored, the function will return all the teams playing on
#' the given day.
#' The function also throw errors when date format is not proper or
#' information are not avaiable for certain date.
#' \code{team} can be either the name of the team or the city names
#' @export
#' @examples
#' score()
#' score(date = "2014-11-17")
#' score(team = "kings")
#' score(date = "2014-11-17", team = "kings")


score <- function(date = Sys.Date(), team = NULL) {
	source("checkDate.R")
	source("checkNHLConnection.R")
	checkDate(date)
	if(!checkNHLConnection()){
		stop("Cannot connect to NHL server :(  Try checking your internet, too.")
	}

	url  <- paste0('http://live.nhle.com/GameData/GCScoreboard/',
								 date, '.jsonp')

	raw <- RCurl::getURL(url)
	# this parsing code was taken from the homework instruction page
	json <- gsub('([a-zA-Z_0-9\\.]*\\()|(\\);?$)', "", raw, perl = TRUE)

		tryCatch({
			data <- jsonlite::fromJSON(json)$games
		},
		error = function(e) {
			message("It seems like nhl doesn't have the information for that date...")
			stop()
			}
		)

	result <- with(data,
			 data.frame(home = paste(htn, htcommon),
			 					 away = paste(atn, atcommon),
			 					 home_score = hts,
			 					 away_score = ats))
	if (!identical(team, NULL)){
		if(gday(team) == TRUE){
			# search for both home and away columns in the data frame.
			index_home <- grep(team, result$home, ignore.case = TRUE)
			index_away <- grep(team, result$away, ignore.case = TRUE)

			if(!identical(index_home, integer(0))){ # if it returns a valid index
					result <- result[index_home, ]
			}
			else if(!identical(index_away, integer(0))){
				result <- result[index_away, ]
			}

			if (nrow(result) == 1){
				if(result$home_score == "")#if no score yet
					print("Team is playing but the scores aren't available yet")
			}

		}
		else{
			print("The team isn't playing today")
		}
	}
	result

}
