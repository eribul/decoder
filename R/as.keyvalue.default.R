

#' @export
as.keyvalue.default <- function(x, ...){
    stop(gettextf("cannot coerce class \"%s\" to a keyvalue object", deparse(class(x))), domain = NA)
}
