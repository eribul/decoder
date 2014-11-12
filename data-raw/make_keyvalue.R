
##########################################################################################
#                                                                                        #
# This script is run to make all kayvalue objects and store them into a sysdata.rda      #
# file in the R directory.                                                               #
#                                                                                        #
##########################################################################################

library(decoder)
rm(list = ls())
old_wd <- setwd("./data-raw")


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
rm(kv_names)


######## Create a keyvalue object with all standard names used for all keyvalues #########

ALL_KEYVALUE_OBJECTS <- ls()[ls() != "old_wd"]
x <- as.list(ALL_KEYVALUE_OBJECTS)
names(x) <- x
x <- lapply(x, function(x) NA)
for (i in names(x)){
    x[[i]] <- attr(get(i), "standard_var_names")
}
x$forsamling <- NULL
ALL_STANDARD_VAR_NAMES <- as.keyvalue(x)

############################ Save all objects to sysdata.rda #############################

setwd(old_wd)
rm(i, x, old_wd)


args <- Vectorize(as.name)(ls())
args$internal = TRUE
do.call(use_data, args)


