

##########################################################################################
#                                                                                        #
# This script is run to make all kayvalue objects and store them into a sysdata.rda      #
# file in the R directory.                                                               #
#                                                                                        #
##########################################################################################

library(decoder)
library(dplyr)
rm(list = ls())


##########################################################################################
#                                                                                        #
# keyvalue objects can be made in three different ways, from tab-data copied from        #
# Rockan/best, from other data sources or 'on the run' from an R-script.                 #
#                                                                                        #
##########################################################################################

## Order of the files matter!
source("data-raw/keyvalue_from_best.R")
source("data-raw/keyvalue_from_other_sources.R")
source("data-raw/keyvalue_from_script.R")
rm(kv_names)


######## Create a keyvalue object with all standard names used for all keyvalues #########
ls       <- ls()
x        <- lapply(ls, function(i) attr(get(i), "standard_var_names"))
names(x) <- ls
x        <- Filter(Negate(is.null), x)

ALL_STANDARD_VAR_NAMES <- decoder:::internal_as.keyvalue.list(x)

################################ Chance encoding to UTF-8 ################################
for (kv_name in ls) {
  print(kv_name)
  kv_obj       <- get(kv_name)
  kv_obj$key   <- iconv(kv_obj$key, to = "UTF-8")
  kv_obj$value <- iconv(kv_obj$value, to = "UTF-8")
  assign(kv_name, kv_obj)
}


############################ Save all objects to sysdata.rda #############################

rm(kv_name, x)


args <- Vectorize(as.name)(ls())
args$internal  <-  TRUE
args$overwrite <- TRUE
do.call(devtools::use_data, args)

rm(list = ls())
