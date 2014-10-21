
#' @name keyvalue11
#' @rdname keyvalue
NULL

#' @rdname keyvalue
#' @export
as.keyvalue11 <- function (x, standard_var_names = NULL){
    UseMethod("as.keyvalue11")
}

#' @export
as.keyvalue.default11 <- function(x, ...){
    stop(gettextf("cannot coerce class \"%s\" to a keyvalue object", deparse(class(x))), domain = NA)
}

#' @export
as.keyvalue11.data.frame <- function(x, ...){
    as.keyvalue(x, ...) %>% as.keyvalue11(...) %>% return()
}

#' @export
as.keyvalue11.keyvalue <- function(x, ...){

    # See if the value satisfies the same constraints as a key object would
    if (inherits(try(as.key(x$value), silent = TRUE), "try-error")){
        stop("All values must be unique!")
    } else{
        x$value  <- as.key(x$value)
        class(x) <- c("keyvalue11", "keyvalue", "data.frame")
        x
    }
}


#' @rdname keyvalue
#' @export
is.keyvalue11 <- function(x){
    inherits(x, "keyvalue11")
}







