
##########################################################################################
#                                                                                        #
# This script is run to make all kayvalue objects and store them into a sysdata.rda      #
# file in the R directory.                                                               #
#                                                                                        #
##########################################################################################

rm(list = ls())
currentwd <- getwd()
setwd("~/Documents/R-kod/decoder/inst")



##########################################################################################
#                                                                                        #
# keyvalue objects can be made in three different ways, from tab-data copied from        #
# Rockan/best, from other data sources or 'on the run' from an R-script.                 #
#                                                                                        #
##########################################################################################

## Order of the files matter!
source("keyvalue_from_best.R")
source("keyvalue_from_other_sources.R")
source("keyvalue_from_script.R")


############################ Save all objects to sysdata.rda #############################

rm(kv_names)
save(list = ls(), file = "../R/sysdata.rda")

setwd(currentwd)
