

# Try to transform x in order to fit the key from keyvalue
format_as_key <- function(x, keyvalue){
    
    if (is.character(keyvalue)){
        keyvalue <- get(keyvalue)
    }
    
    x_name <- deparse(substitute(x))
    keyvalue_name <- deparse(substitute(keyvalue))
    
    has_punct    <- function(y) any(grepl("[[:punct:]]", y))
    has_capitals <- function(y) any(grepl("[[:upper:]]", y))
    has_anylow   <- function(y) any(grepl("[[:lower:]]", y))
    
    # If x has punctuations but the key has not, punctuations are removed from x
    if (has_punct(x) & !has_punct(keyvalue$key)){
        x <- stringr::str_replace_all(x, "[[:punct:]]", "")
        warning(x_name, " contained punctuation. Punctuations are removed and capital letters",
                " are changed to lower case before decoding!")
    }
    
    # If key has no capitals, all letters in x are made lowercase
    if (has_capitals(x) & !has_capitals(keyvalue$key)){
        x <- tolower(x)
        warning(x_name, " contains upper case letters but the key does not. Capitals are changed to lower case!")
        
        
        # If key has no capitals, all letters in x are made lowercase
    } else if (has_anylow(x) & !has_anylow(keyvalue$key)){
        x <- toupper(x)
        warning(x_name, " contains lower case letters but the key does not. Lower case are changed to upper case!")
    }
    
    # If the key is shorter than x, x is substringed
    key_length <- max(stringr::str_length(keyvalue$key), na.rm = TRUE)
    if (max(stringr::str_length(x), na.rm = TRUE) > key_length){
        x <- substr(x, 1, key_length)
        warning("Entries in ", x_name, " have too many characters to be matched to ",
                x_name, " and is threfore substringed to match its length!")
    }
    
    x
}
