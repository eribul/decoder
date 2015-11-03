

# Try to transform x in order to fit the key from keyvalue
format_as_key <- function(x, keyvalue, name_x = "x", name_keyvalue = "keyvalue"){
    
    ## Get the keyvalue object if specified by character name
    if (is.character(keyvalue)) {
        keyvalue <- get(keyvalue)
    }
    
    # initiate warning message
    msg <- ""
    
    has_blank    <- function(y) any(grepl("[[:blank:]]", y), na.rm = TRUE)
    has_punct    <- function(y) any(grepl("[[:punct:]]", y), na.rm = TRUE)
    has_capitals <- function(y) any(grepl("[[:upper:]]", y), na.rm = TRUE)
    has_anylow   <- function(y) any(grepl("[[:lower:]]", y), na.rm = TRUE)
    start_0      <- function(y) any(substr(as.character(y), 1, 1) == 0, na.rm = TRUE) 
    
    # Trim spaces 
    if (has_blank(x)) {
        x <- stringr::str_trim(x)
        msg <- "Spaces are removed from beginning and end."
    }
    
    # If x starts with zero but the key does not, zeroes are removed
    # This applies even if x is still character (and is therefore not an ifelse statement)
    if (start_0(x) & !start_0(keyvalue$key)) {
        msg <- paste(msg, "Leading 0:s are ignored.")
    }
    while (start_0(x) & !start_0(keyvalue$key)) {
        x <- ifelse(substr(x, 1, 1) == "0", # If leading 0 ...
                    substring(x, 2),        # ... remove the 0 ...
                    x)                      # ... otherwise leave unchanged
    }
    
    # If key starts with 0 but x does not, pad with zeros!
    # Only applies if all codes have the same length and x is shorter than this length
    key_length <- stringr::str_length(keyvalue$key)[1]
    if (!start_0(x) && 
        start_0(keyvalue$key) && 
        do.call(all.equal, as.list(na.omit(stringr::str_length(keyvalue$key)))) && 
        key_length > min(stringr::str_length(x), na.rm = TRUE)) {
            x <- stringr::str_pad(x, key_length, pad = "0")
    msg <- paste(msg, "Leading 0:s are introduced for short characters.")
    }
    
    
    # If x has punctuations but the key has not, punctuations are removed from x
    if (has_punct(x) & !has_punct(keyvalue$key)) {
        x <- stringr::str_replace_all(x, "[[:punct:]]", "")
        msg <- paste(msg, "Punctuations are removed")
    }
    
    # If key has no capitals, all letters in x are made lowercase
    if (has_capitals(x) && has_anylow(keyvalue$key)  && !has_capitals(keyvalue$key)) {
        x <- tolower(x)
        msg <- paste(msg, "Capitals are changed to lower case.")
        
        
    # If key has no lowercase, all letters in x are made upper case
    } else if (has_anylow(x) && has_capitals(keyvalue$key) && !has_anylow(keyvalue$key)) {
        x <- toupper(x)
        msg <- paste(msg, "Lower case are changed to upper case.")
    }
    
    # If the key is shorter than x, x is substringed
    key_length <- max(stringr::str_length(keyvalue$key), na.rm = TRUE)
    if (max(stringr::str_length(x), na.rm = TRUE) > key_length) {
        x <- substr(x, 1, key_length)
        msg <- paste(msg, "Only the first", key_length, "characters are used.")
    }
    
    ## Print warning if any changes made
    if (msg != "") {
        warning(name_x, " has been transformed to match the code for ", name_keyvalue, 
                ": ", msg)
    }
    
    list(x = x, keyvalue = keyvalue)
}
