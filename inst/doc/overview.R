## ----setup, include = FALSE, cache = FALSE-------------------------------
knitr::opts_chunk$set(error = TRUE)

## ------------------------------------------------------------------------
library(gameplay)
gday(date = "2014-11-18", team = "KINGS") # returns the broadcaster name for Oilers 
gday(team = "Dubai") # return "not playing" since Dubai isn't in the NHL
gday(date = "2014-11-19") # check for Canucks, which is playing on Nov 19, 2014

## ------------------------------------------------------------------------
# detects improper length 
#gday(date = "2014-111-18") 
# detects not all date components are numbers
#score(date = "2014-No-18") 

## ------------------------------------------------------------------------
gday(date = "2022-11-18") 
score(date = "1700-11-18")

