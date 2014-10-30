

#' @export
as.keyvalue.default <- function(x, ...){
    
    stopifnot(is.atomic(x))
    
    if (is.null(names(x)) || sum(names(x) != "") != length(x)){
        stop("All elements of vector 'x' must be named!")
    }
    
    x <- data.frame(key = x, value = names(x), row.names = NULL)
    as.keyvalue(x)
}
