

##########################################################################################
#                                                                                        #
# code is more complicated than decode since we can not be sure that a 1:1 translation   #
# can be done. We therefore need several methods to handle different situations          #
#                                                                                        #
##########################################################################################

#' @rdname decoder
#' @export
code <- function(y, keyvalue){
    keyvalue <- get(keyvalue)
    code_internal(keyvalue, y)
}

# Switch order of arguments from "code"
# It's probably more convinient to call the function as in code.
# Reordering them makes it possible however to use S3-methods depending on the keyvalue class
code_internal <- function(keyvalue, y){
    UseMethod("code_internal")
}

code_internal.keyvalue11 <- function(keyvalue, y){
    names(keyvalue) <- rev(names(keyvalue))
    decode(y, keyvalue)
}

code_internal.keyvalue <- function(keyvalue, y){

    dangerous_values <- summary(keyvalue)$nonunique$value
    not11 <- y %in% dangerous_values
    if (any(not11)){
        print(summary(keyvalue)$nonunique[dangerous_values %in% y, ])
        stop("Values above have a non 1:1 relation to their key. A safe coding can not be made for this variable!")
    }
    NextMethod()
}

code_internal.default <- function(keyvalue, y){
    stop("Not possible to code for keyvalue-object of class ", class(keyvalue))
}
