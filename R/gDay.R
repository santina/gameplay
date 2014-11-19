#' Documentation
#'
#' Is it the game day of your favorite team?
#'
#' This function will tell you which channel to watch if your team is playing,
#' otherwise it tells you to wait for a few more days
#'
#' Now here's the input
#'
#' @param team The name of your team or the city of the team.
#' @return string Name of the channel to watch. Return "information not available for this date"
#' if the NHL server cannot provide information for the given date.
#' Returns "not available" if the team is #' not playing on the current day,
#' "undecided or not available" if the team is playing but the channel name
#' is not specified on NHL
#' @note case in \code{team} is ignored it will check for Canucks because this package
#' was written by someone in Vancouver
#'
#' @export
#' @examples
#' gday() # check for "Canucks"


#source("checkDate.R")
#source("checkNHLConnection.R")
gday <- function(date = Sys.Date(), team="canucks") {

	# check date, throw erros and stop the function if it's not correct
	checkDate(date)


	if(!checkNHLConnection()){
		stop("Cannot connect to NHL server :(  Try checking your internet, too.")
	}


	url <- paste0("http://live.nhle.com/GameData/GCScoreboard/", date, ".jsonp")
    #"http://live.nhle.com/GameData/GCScoreboard/2014-11-10.jsonp"
  good <- grepl(team, RCurl::getURL(url), ignore.case=TRUE) # relies on RCurl package

	unavailable <- grepl("404 Not Found", RCurl::getURL(url))

	if(unavailable){
		channel <- "information not available for this date"
	}
  else if(!good){
  	channel <- "not playing"
  }
  else{

  	raw <- RCurl::getURL(url)
  	# this parsing code was taken from the homework instruction page
  	json <- gsub('([a-zA-Z_0-9\\.]*\\()|(\\);?$)', "", raw, perl = TRUE)

  	# for whatever reason the server doesn't return any info
  	# or changes its JSON format

  	data <- jsonlite::fromJSON(json)$games
  	tryCatch({
  		data <- jsonlite::fromJSON(json)$games
  		},
  	error = function(e) {
  		message("It seems like nhl doesn't have the information for today")
  		stop()
  		}
  	)

  	result <- with(data,
  								 data.frame(home = paste(htn, htcommon),
  								 					 away = paste(atn, atcommon),
  								 					 channel = canationalbroadcasts)
  	)

  	index_home <- grep(team, result$home, ignore.case = TRUE)
  	index_away <- grep(team, result$away, ignore.case = TRUE)

  	channel  <- as.character()
  	if(!identical(index_home, integer(0))){ # if it returns a valid index
  		channel <- as.character(result[index_home, ]$channel)
  	}
  	else if(!identical(index_away, integer(0))){
  		channel <- as.character(result[index_away, ]$channel)
  	}
  }
	if (nchar(channel) == 0){
		channel  <- "undecided or not available"
	}

	channel
}

