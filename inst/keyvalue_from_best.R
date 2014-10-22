
##########################################################################################
#                                                                                        #
# Read in all datasets from best, make them keyvalue objects and assign them to the      #
# global workspace.                                                                      #
#                                                                                        #
##########################################################################################

best2keyvalue <- function () {
  for (x in dir("best/")){
      file_name <- paste0("best/", x)
      obj_name <- gsub(".tab", "", x)
      obj <- read.delim(file_name, stringsAsFactors = FALSE)
      names(obj) <- c("key", "value")
      obj$key <- stringr::str_trim(obj$key)
      obj <- as.keyvalue(obj)
      assign(obj_name, obj, envir = globalenv())
  }
  rm(best2keyvalue, envir = globalenv())

}

best2keyvalue()


################################# Add standard_var_names #################################

attr(hemort,   "standard_var_names")  <-  c("a_lkf", "hemfr", "hemnu", "hemdia", "lkf", "LKF_VALUE")
attr(sjukhus,  "standard_var_names")  <- "anlas"
attr(m_rtr,    "standard_var_names")  <- "cam"
attr(n_rtr,    "standard_var_names")  <- "can"
attr(t_rtr,    "standard_var_names")  <- "cat"
attr(figo,     "standard_var_names")  <- "figo"
attr(icd7,     "standard_var_names")  <- "icd7"
attr(icd9,     "standard_var_names")  <- "icd9"
attr(icdo,     "standard_var_names")  <- "icdo"
attr(icdo3,    "standard_var_names")  <- "icdo3"
attr(sida,     "standard_var_names")  <- "sida"
attr(tnmgrund, "standard_var_names")  <- "tnmgrund"
attr(pad,      "standard_var_names")  <- "PAD"
attr(snomed,   "standard_var_names")  <- "snomed"
attr(snomed3,  "standard_var_names")  <- "snomed3"
