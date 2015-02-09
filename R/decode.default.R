

#' @export
#' @rdname decoder
decode.default <- function(x, keyvalue, extra_functions = NULL, exact = FALSE, ...){
    
    if (!is.atomic(x)){
        stop("decode only works for atomic vectors or data.frames!")
    } else if (all(is.na(x))){
        return(x)
    }
    
    if (is.character(keyvalue)){
        keyvalue <- get(keyvalue)
    } 
    
    if (!is.keyvalue(keyvalue)){
        keyvalue <- tryCatch(as.keyvalue(keyvalue), 
                             error = function(x) stop("'keyvalue' is neither a keyvalue object, nor an object that can be easily coerced to such! See '?as.keyvalue'"))
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
