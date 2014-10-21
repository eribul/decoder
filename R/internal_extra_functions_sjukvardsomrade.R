
################################################################################
#                                                                              #
#                        extra_functions for keyvaluem1                        #
#                                                                              #
################################################################################

#'Extra functions to apply to decoded variables using decode
#'
#'See section "extra_functions" at the \link{decode} help page!
#'
#' @param x The decoded variable to be further processed. This argument should not be set by the user.
#' It is used only internally by the function from which it is called.
#' @name extra_functions
#' @export
kungalv2Storgoteborg <- function(x){
    x <- as.character(x)
    x[x == "Kungalv"] <- "Storgoteborg"
    as.factor(x)
}

#' @rdname extra_functions
#' @export
kungalv2Fyrbodal <- function(x){
    x <- as.character(x)
    x[x == "Kungalv"] <- "Fyrbodal"
    as.factor(x)
}

#' @rdname extra_functions
#' @export
real_names <- function(x){
    plyr::revalue(x, c(
        "Kungalv"        = "Kung\u00E4lv",
        "Norra_Halland"  = "Norra Halland",
        "Sodra_Alvsborg" = "S\u00F6dra \u00C4lvsborg",
        "Storgoteborg"   = "Storg\u00F6teborg")
    )
}
