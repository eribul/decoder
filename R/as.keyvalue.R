#' Coerce to a keyvalue object
#'
#' Functions to check if an object is a keyvalue object, or coerce it if possible.
#' 
#' @name keyvalue
#' @param x a data.frame with a unique \code{key} and a (not necessarly unique) \code{value} column.
#' @param standard_var_names a character vector with standard names for variables decoded with this key-values.
#'
#' @return 
#' \code{as.keyvalue} returns a data.frame with additional class \code{keyvalue} that fullfills the requirements
#' for a \code{keyvalue} object and with the \code{key} column as character. It also has two extra attributes
#' \code{standard_var_names} as described above and \code{keyvalue11} which is \code{TRUE} for keyvalue objects
#' with a 1:1 relation between its keys and values (otherwise FALSE).
#' 
#' @export
#' @seealso \link{as.keyvalue.list}, \link{key_value_data}, \link{decode}, \link{summary.keyvalue}, \link{key_and_value}
#' @examples
#' snomed <- decoder:::snomed
#' snomed2 <- as.keyvalue(snomed)
#' is.keyvalue(snomed2)
#' summary(snomed2)

as.keyvalue <- function(x, standard_var_names = NULL){
    UseMethod("as.keyvalue")
}
