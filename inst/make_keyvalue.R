
##########################################################################################
#                                                                                        #
# This script is run to make all kayvalue objects and store them into a sysdata.rda      #
# file in the R directory.                                                               #
#                                                                                        #
##########################################################################################

rm(list = ls())



##########################################################################################
#                                                                                        #
# keyvalue objects can be made in three different ways, from tab-data copied from        #
# Rockan/best, from other data sources or 'on the run' from an R-script.                 #
#                                                                                        #
##########################################################################################

## Order of the files matter!
source("inst/keyvalue_from_best.R")
source("inst/keyvalue_from_other_sources.R")
source("inst/keyvalue_from_script.R")
rm(kv_names)


######## Create a keyvalue object with all standard names used for all keyvalues #########

ALL_KEYVALUE_OBJECTS <- ls()
x <- as.list(ALL_KEYVALUE_OBJECTS)
names(x) <- x
x <- lapply(x, function(x) NA)
for (i in names(x)){
    x[[i]] <- attr(get(i), "standard_var_names")
}
x$forsamling <- NULL
ALL_STANDARD_VAR_NAMES <- as.keyvalue(x)
rm(i, x)

############################ Save all objects to sysdata.rda #############################


save(list = ls(), file = "R/sysdata.rda")


