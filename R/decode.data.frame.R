#' @export
#' @rdname decoder

decode.data.frame <- function(x, ...){
    
    if (!missing(...)){
        warning("Additional arguments to decode.data.frame ignored!")
    }
    
    cols_to_change <- x[, names(x) %in% ALL_STANDARD_VAR_NAMES$key, drop = FALSE]
    cols_to_change_names <- paste0(names(cols_to_change), "_Beskrivning")
    
    if (length(cols_to_change) == 0 || identical(cols_to_change, character(0))){
        warning("No column names recognised as standard_var_names for any keyvalue object. No decoding made!")
        return(x)
    } else{
        for (i in seq_along(cols_to_change)){
            kv <- decode(names(cols_to_change)[i], "ALL_STANDARD_VAR_NAMES")
            x[[cols_to_change_names[i]]] <- decode(cols_to_change[[i]], kv)
        }
        message("New decoded columns added: ", paste(cols_to_change_names, collapse = ", ") )
        return(x)
    }
}
