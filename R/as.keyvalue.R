




#' Coerce to a keyvalue object
#'
#' Functions to check if an object is a keyvalue object, or coerce it if possible.
#' @name keyvalue
#' @param x a data.frame with a unique \code{key} and a (not necessarly unique) \code{value} column.
#' @param standard_var_names a character vector with standard names for variables decoded with this key-values.
#' @return \code{as.keyvalue} returns a data.frame with additional class \code{keyvalue} that fullfills the requirements
#' for a \code{keyvalue} object and with the \code{key} column as character. It also has an extra attribute
#' \code{standard_var_names} as described above. \code{as.keyvalue11} is similair but with the extra cindition that
#' also the value column contains unique values.
#' @export
#' @seealso \link{keyvaluem1}, \link{key_value_data}, \link{decode}, \link{summary.keyvalue}, \link{key_and_value}
#' @examples
#' snomed <- rcc:::snomed
#' snomed2 <- as.keyvalue(snomed)
#' is.keyvalue(snomed2)
#' summary(snomed2)
#' \donttest{
#' as.keyvalue11(snomed)
#' }
as.keyvalue <- function(x, standard_var_names = NULL){
    UseMethod("as.keyvalue")
}


#' @export
as.keyvalue.default <- function(x, ...){
    stop(gettextf("cannot coerce class \"%s\" to a keyvalue object", deparse(class(x))), domain = NA)
}

#' @export
as.keyvalue.data.frame <- function(x, standard_var_names = NULL){
    
    if (ncol(x) != 2 | !all((c("key", "value") %in% names(x)))){
        stop("A keyvalue object must have exactly two columns: 'key' and 'value'!")
    }
    
    x <- x[order(x$key),]
    
    x$value <- as.value(x$value)
    x$key   <- as.key(x$key)
    
    class(x) <- c("keyvalue", "data.frame")
    attr(x, "standard_var_names") <- standard_var_names
    x
}


#' @export
as.keyvalue.keyvaluem1 <- function(x, ...){
    
    x <- data.frame(
        key = unlist(x),
        value = rep(names(x), sapply(x, length)),
        row.names = NULL
    )
    as.keyvalue(x, ...)
}



#' @rdname keyvalue
#' @export
is.keyvalue <- function(x){
    inherits(x, "keyvalue")
}


#' Object summary for keyvalue objects
#'
#' Objects of type \code{keyvalue11} are summarised as data.frames with an additional display of possible
#' \code{standard_var_names}. Objects of type \code{keyvalue} also gives a list of non 1:1 key-value pairs.
#' @param object a keyvalue object
#' @param ... ignored
#' @return A list with three elements: a summmary of the underlying data.frame,
#' the standard_var_names and possibly a data.frame with all non 1:1 relations.
#' @export
#' @seealso \link{keyvalue}
summary.keyvalue <- function(object, ...){
    # writeLines("\n Summary from the underlaying data.frame object:\n")
    data.frame.summary <- summary.data.frame(object)
    
    # writeLines("\n standard_var_names: \n")
    standard_var_names <- object$standard_var_names
    
    if (!is.keyvalue11(object)){
        # writeLines("\n\nThe following entries in the keyvalue-object are not 1:1!\n")
        nonunique <- object[object$value %in% unlist(dimnames(table(object$value)[table(object$value) > 1])), ] %>% arrange_(~value)
    }
    
    list(data.frame.summary = data.frame.summary,
         standard_var_names = standard_var_names,
         nonunique = nonunique)
}
