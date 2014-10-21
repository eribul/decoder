

#' Keyvaluem1 objects for decoding and grouping
#'
#' Dictionary objects to decode and group key codes to values in plain text.
#'
#' \code{keyvalue1} objects have similair purpose as \link{keyvalue} and \link{keyvalue11} objects.
#' They are used for decoding coded values into plain text. The difference is that keyvaluem1 objects
#' have an m:1 relation between its key and its value, hence the keys are also grouped
#' simultainasly as they are decoded.
#' The intention of the \code{keyvaluem1} objects is to be used by \link{decode} (bot not by \link{code}).
#'
#' @docType data
#' @keywords datasets
#' @name keyvaluem1_data
#' @family key_value_data
#' @seealso \link{decode}, \link{keyvalue}
NULL




#' Geographical healthcare areas
#'
#' An object of class \code{keyvaluem1} (\link{keyvaluem1_data}).
#'
#' \itemize{
#'      \item{Key: the first four digits from the LKF-code}
#'      \item{Value: A geographical area (sub area of county/lan) with special interest}
#' }
#'
#' The object currently only applies to the Western healthcare region
#' \itemize{
#'      \item{Storgoteborg}
#'      \item{Fyrbodal}
#'      \item{Sodra_Alvsborg}
#'      \item{Skaraborg}
#'      \item{Norra_Halland}
#' }
#' Updates for other regions needs to be requested (please do!).
#'
#' @section Kungalv:
#'  Kungalv is an independent area by default. There are situations when Kungalv should be dealt with as an
#'  independent healthcare region or as a part of Storgoteborg. See section "extra_functions" in \link{decode}
#'  to handle this.
#'
#' @docType data
#' @keywords datasets
#' @name sjukvardsomrade
#' @seealso keyvaluem1_data separate_kungalv kungalv2Storgoteborg
#' @family key_value_data
NULL
