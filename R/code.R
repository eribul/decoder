
#' @rdname decoder
#' @export
code <- function(y, keyvalue){
    
    if (is.character(keyvalue)){
        keyvalue <- get(keyvalue)
    }
    
    ## If there is a no 1:1 relation between key and value,
    ## the process continues just if the particular translation can be done safely!
    if (!is.keyvalue11(keyvalue)){
        dangerous_values <- summary(keyvalue)$nonunique$value
        not11 <- y %in% dangerous_values
        if (any(not11)){
            print(summary(keyvalue)$nonunique[dangerous_values %in% y, ])
            stop("Values above have a non 1:1 relation to their key. A safe coding can not be made for this variable!")
        }
    }
    
    names(keyvalue) <- rev(names(keyvalue))
    decode(y, keyvalue)
}
