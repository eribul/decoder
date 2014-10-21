

################################################################################
#                                                                              #
# Purpose:       Class and method for keyvaluem1                            #
#                                                                              #
# Author:        Erik Bülow                                                    #
# Contact:       erik.bulow@rccvast.se                                         #
# Client:        Erik Bülow                                                    #
#                                                                              #
# Code created:  2014-09-10                                                    #
# Last updated:  2014-09-10                                                    #
# Source:        /Users/erikbulow/Documents/R-kod/rcc                          #
#                                                                              #
# Comment:       Concepts for decode and group                                 #
#                                                                              #
################################################################################



#' Create a keyvaluem1-element.
#'
#' The keyvaluem1 class relies on the same concept as the \link{keyvalue} and \link{keyvalue11} classes.
#' Difference is that the keyvaluem1 class handles decoding and grouping. There is an expected m:1-relation
#' between the key and the value. The underlaying object is therefore a list and not a data.frame.
#'
#' \code{x} should be a list with the following properties:
#' \itemize{
#'    \item{All names of the list elements should be unique.}
#'    \item{All elements of the list should be named.}
#'    \item{All keys should be unique (a key should only be mappad to one value).}
#'    \item{All elements of the list should be atomic vectors.}
#' }
#'
#' @param x a \code{list} with certain properties (described in the details section).
#' @param  standard_var_names is an optional character vector with standard names of variables that
#' might be used for the decoding
#' @return The function returns an object of class \code{keyvaluem1} (and \code{list} but not
#' \link{keyvalue} or \link{keyvalue11}.
#' @export
#' @name keyvaluem1
#' @family key_value_data
#' @seealso \link{as.keyvalue} and {as.keyvalue11}
#' @examples
#'
#' ex <- list(
#'          fruit  = c("banana", "orange", "kiwi"),
#'          car    = c("SAAB", "Volvo", "taxi", "truck"),
#'          animal = c("elefant")
#' )
#' as.keyvaluem1(ex)
#' is.keyvaluem1(ex)
#' class(ex)
#' as.keyvaluem1(ex, "favorite_thing")
#'
#' \donttest{
#' # An invalid list (non unique names; not because of silly classification)
#' ex2 <- list(
#'          fruit  = c("banana", "orange", "kiwi"),
#'          car    = c("SAAB", "Volvo", "taxi", "truck"),
#'          animal = c("elefant"),
#'          fruit  = c("President_Obama")
#' )
#' as.keyvaluem1(ex2)
#'
#' # An invalid list (non unique keys; kiwi appear twice)
#' ex3 <- list(
#'          fruit  = c("banana", "orange", "kiwi"),
#'          car    = c("SAAB", "Volvo", "taxi", "truck"),
#'          animal = c("elefant", "kiwi")
#' )
#' as.keyvaluem1(ex3)
#' }

as.keyvaluem1 <- function(x, standard_var_names = NULL){
    UseMethod("as.keyvaluem1")
}

#' @export
as.keyvaluem1.default <- function(x, ...){
    stop("Only object of class list can be coerced to keyvaluem1!")
}

#' @export
as.keyvaluem1.list <- function(x, standard_var_names = NULL, ...){

    # Tests
    if ("" %in% names(x)){
        stop("All elements of x must be named (values must be given for all keys)!")
    } else if (!identical(unique(names(x)), names(x))){
        stop("All list element names must be unique!")
    } else if (anyDuplicated(unlist(x)) > 0){
        stop("Some key(s) have duplicates! A key should only be mapped to one value (be found in one element of the list)")
    } else if (!all(sapply(x, is.atomic))){
        stop("All elements of the list should be atomic!")
    }

    class(x) <- c("keyvaluem1", "list")
    if (!is.null(standard_var_names)){
        attr(x, "standard_var_names") <- standard_var_names
    }
    x

}



#' @rdname keyvaluem1
#' @export
is.keyvaluem1 <- function(x){
    inherits(x, "keyvaluem1")
}
