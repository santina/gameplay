#' Documentation 
#' 
#' Is it Gameday? 
#' 
#' This function returns TRUE if your NHL team plays today 
#' and FALSE otherwise 
#' 
#' Now here's the input 
#' 
#' @param team.name The name of your team 
#' @return logical \code{TRUE} if \code{team.name} has a NHL game today 
#' \code{FALSE} otherwise 
#' @note case in \code{team.name} is ignored it will check for Canucks
#' @export 
#' @examples
#' gday("canucks")
#' gday("Bruins")


gday <- function(team.name="canucks") {
  url <- paste0("http://live.nhle.com/GameData/GCScoreboard/", Sys.Date(), ".jsonp")
    #"http://live.nhle.com/GameData/GCScoreboard/2014-11-10.jsonp"
  grepl(team.name, getURL(url), ignore.case=TRUE) # relies on RCurl package
}

