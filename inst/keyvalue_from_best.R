
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

hemort <- as.keyvalue(hemort, standard_var_names = c("a_lkf", "hemfr", "hemnu", "hemdia", "lkf", "LKF_VALUE"))
sjukhus <- as.keyvalue(sjukhus, standard_var_names = c("anlas"))
m_rtr <- as.keyvalue11(m_rtr, standard_var_names = "cam")
n_rtr <- as.keyvalue11(n_rtr, standard_var_names = "can")
t_rtr <- as.keyvalue11(t_rtr, standard_var_names = "cat")
figo <- as.keyvalue11(figo, standard_var_names = "figo")
icd7 <- as.keyvalue(icd7, standard_var_names = "icd7")
icd9 <- as.keyvalue11(icd9, standard_var_names = "icd9")
icdo <- as.keyvalue(icdo, standard_var_names = "icdo")
icdo3 <- as.keyvalue(icdo3, standard_var_names = "icdo3")
sida <- as.keyvalue11(sida, standard_var_names = "sida")
tnmgrund <- as.keyvalue11(tnmgrund, standard_var_names = "tnmgrund")
pad <- as.keyvalue(pad, standard_var_names = "PAD")
snomed <- as.keyvalue(snomed, standard_var_names = "snomed")
snomed3 <- as.keyvalue(snomed3, standard_var_names = "snomed3")
