

##########################################################################################
#                                                                                        #
#                             Main function for the package                              #
#                                                                                        #
##########################################################################################

#' @export
#' @rdname decoder
decode <- function(x, keyvalue, extra_functions = NULL, exact = FALSE){
    
    if (is.character(keyvalue)){
        keyvalue <- get(keyvalue)
    }
    
    if (is.keyvaluem1(keyvalue)){
        keyvalue <- as.keyvalue(keyvalue)
    }
    
    ## We might try to convert x in order to better match the format of the key
    if (!exact){
        x <- format_as_key(x, keyvalue)
    }
    
    ## Translate key to value
    positions <- match(x, keyvalue$key)
    res <- keyvalue[positions, "value", drop = TRUE]
    
    ## Apply extra functions if given
    if (!is.null(extra_functions)){
        for (fun in extra_functions){
            FUN <- match.fun(fun)
            res <- FUN(res)
        }
    }
    
    res
}
