#' @export
#' @rdname decoder

decode.data.frame <- function(x, ...){
    
    if (!missing(...)){
        warning("Additional arguments to decode.data.frame ignored!")
    }
    
    # Are there any variables to decode?
    nms <- names(x)
    vars_to_decode <- intersect(nms, 
              c(ALL_STANDARD_VAR_NAMES$key, 
                tolower(ALL_STANDARD_VAR_NAMES$key), 
                toupper(ALL_STANDARD_VAR_NAMES$key)))
    # ... if not, returned unchanged
    if (identical(character(0), vars_to_decode)){
        message("No variables decoded!")
        return(x)
    }
    
    # If x has variables named "_Beskrivning/_Värde" and no "_beskrivning/_värde", "_Beskrivning" is used
    # otherwise "_beskrivning
    
    beskrivning <- 
        if (
            (any(grepl("_Beskrivning", nms)) || any(grepl("_V\u00E4rde", nms))) && 
            (!any(grepl("_beskrivning", nms)) || !any(grepl("_v\u00E4rde", nms)))
            ){
            "_Beskrivning"
        } else{
            "_beskrivning"
        }
    
    cols_to_change <- x[, vars_to_decode, drop = FALSE]
    cols_to_change_names <- paste0(names(cols_to_change), beskrivning)
    already_beskrivning  <- dplyr::intersect(tolower(cols_to_change_names), 
                                            tolower(nms))
    cols_to_change_names <- dplyr::setdiff(cols_to_change_names, already_beskrivning)
    cols_to_change <- cols_to_change[, vars_to_decode, drop = FALSE]
    
    if (length(cols_to_change) == 0 || identical(cols_to_change, character(0))){
        warning("No column names recognised as standard_var_names for any keyvalue object. No decoding made!")
        return(x)
    } else{
        kv <- as.character(decode(tolower(names(cols_to_change)), "ALL_STANDARD_VAR_NAMES"))
        if (!identical(cols_to_change_names, character(0))){
            for (i in seq_along(cols_to_change)){
                    tryCatch(x[[cols_to_change_names[i]]] <- decode(cols_to_change[[i]], kv[i]),
                             warning = function(msg){
                                warning(paste("column", 
                                  names(cols_to_change)[i], substring(msg, 18)), call. = FALSE)
                             }
                    )
            }
        }
        
        if (!identical(cols_to_change_names, character(0))){
            message("\nNew decoded columns added: \n* ", 
                    paste(cols_to_change_names, collapse = "\n* ") )
    
        } 
        if (!identical(already_beskrivning, character(0))){
                message("\n\nVariable(s) ", paste(already_beskrivning, collapse = ", "),
                    " seems to be already decoded and therefore left unchanged.")
        }
            return(x)
    }
}
