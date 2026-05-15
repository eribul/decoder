# This script is run to make all keyvalue objects and store them into a
# sysdata.rda file in the R directory.

library(decoder)
library(dplyr)
rm(list = ls())

# keyvalue objects can be made in three different ways, from tab-data copied
# from Rockan/best, from other data sources or 'on the run' from an R-script.

## Order of the files matter!
source("data-raw/keyvalue_from_best.R", encoding = "UTF-8")
source("data-raw/keyvalue_from_other_sources.R", encoding = "UTF-8")
source("data-raw/keyvalue_from_script.R", encoding = "UTF-8")
rm(kv_names)


# Chance encoding to UTF-8 -----------------------------------------------

for (kv_name in ls()) {
  kv_obj <- get(kv_name)
  if (is.character(kv_obj$key)) {
    kv_obj$key <- enc2utf8(kv_obj$key)
  }
  if (is.character(kv_obj$value)) {
    kv_obj$value <- enc2utf8(kv_obj$value)
  }
  assign(kv_name, kv_obj)
}

rm(kv_name, kv_obj)


# Save all objects to sysdata.rda ----------------------------------------

file.remove(file.path("data", dir("data")))
args <- Vectorize(as.name)(ls())
args$overwrite <- TRUE
do.call(usethis::use_data, args)


# Create a keyvalue object with all standard names used for all keyvalues ----

ls <- ls()
x <- lapply(ls, function(i) attr(get(i), "standard_var_names"))
names(x) <- ls
x <- Filter(Negate(is.null), x)

ALL_STANDARD_VAR_NAMES <- decoder:::internal_as.keyvalue.list(x)
usethis::use_data(ALL_STANDARD_VAR_NAMES, internal = TRUE, overwrite = TRUE)
rm(list = ls())
