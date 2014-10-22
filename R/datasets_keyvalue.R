
################################################################################
#                                                                              #
# Purpose:       Documentation for data sets used for key2value                #
#                                                                              #
# Author:        Erik Bülow                                                    #
# Contact:       erik.bulow@rccvast.se                                         #
# Client:        Erik Bülow                                                    #
#                                                                              #
# Code created:  2014-08-15                                                    #
# Last updated:  2014-09-02                                                    #
# Source:        /Users/erikbulow/Documents/R-kod/rcc                          #
#                                                                              #
# Comment:       The data sets themselves are constructed elsewhere!           #
#                                                                              #
################################################################################




################################################################################
#                                                                              #
#                            General documentation                             #
#                                                                              #
################################################################################



#' Key-value datasets for code translation
#'
#' Dictionary files to translate key codes to value in plain text (or reverse).
#'
#' Each file has two columns, "key" and "value". The key is a unique (mostly) numeric code
#' and the key is a character string description.
#' The data sets can be divided into four categories:
#' \itemize{
#'  \item Geographic codes: \link{region}, \link{lan}, \link{kommun} and \link{forsamling}
#'  \item Administrative codes: \link{sjukhus}, \link{klinik} and \link{patologiavdelning}
#'  \item Diagnose codes: \link{t_rtr}, \link{n_rtr}, \link{m_rtr}, \link{figo},
#'  \link{tnmgrund}, \link{sida}, \link{icd7}, \link{icd9}, \link{icd10}, \link{icdo}, \link{icdo3},
#'   \link{snomed}, \link{snomed3} and \link{pad}
#'  \item Other codes: \link{kon}
#' }
#' The intention of these data files is to be used by the \link{decode} and \link{code} functions.
#'
#'
#' @docType data
#' @keywords datasets
#' @name key_value_data
#' @family key_value_data
#' @seealso \link{decode}, \link{keyvalue}
NULL





################################################################################
#                                                                              #
#                              Geographical codes                              #
#                                                                              #
################################################################################


#' Regional code
#'
#' Key-value codes for the Swedish healthcare regions (1-6).
#'
#' @docType data
#' @keywords datasets
#' @name region
#' @family key_value_data
NULL




#' Lan code (county code)
#'
#' Key-value codes for the Swedish counties (lan).
#' Two first digits in the LKF code.
#' Be aware of the spelling ("lan")!
#'
#' @docType data
#' @keywords datasets
#' @name lan
#' @family key_value_data
NULL



#' Geographical healthcare areas
#'
#' Key-value codes for health care areas.
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
#' @seealso separate_kungalv kungalv2Storgoteborg
#' @family key_value_data
NULL


#' Kommun code (municipality code)
#'
#' Key-value codes for the Swedish municipalities (kommuner).
#' First four digits in the LKF code.
#' Data from 2014-08-12.
#'
#' @docType data
#' @keywords datasets
#' @name kommun
#' @family key_value_data
#' @references \url{http://www.scb.se/sv_/Hitta-statistik/Regional-statistik-och-kartor/Regionala-indelningar/Lan-och-kommuner/}
NULL



#' Forsamling code (parish code)
#'
#' Key-value codes for the Swedish parisches (forsamlingar).
#' All six digits in the LKF code.
#' Data from 2014-08-12.
#' Be aware of the spelling ("forsamling").
#'
#' @docType data
#' @keywords datasets
#' @name forsamling
#' @family key_value_data
#' @references \url{http://www.scb.se/sv_/Hitta-statistik/Regional-statistik-och-kartor/Regionala-indelningar/Lan-och-kommuner/}
NULL





################################################################################
#                                                                              #
#                             Administrative codes                             #
#                                                                              #
################################################################################


#' Hospital codes
#'
#' Key-value codes for Swedish hospitals and some primary health care units.
#'
#' Data from Rockan. Note that this is an old version of the classification!
#' See the reference link below for the new version.
#' The old version should be used of historical reasons.
#' One difference is for example that the Sahlgrenska university hospital is one hospital
#' in the new version of the classification but the Swedish regional cancer centers
#' still classify it as three different hospitals.
#' Note also that primary health care units did recieve their own codes until 1992 (?)
#' but not later!
#'
#' @docType data
#' @keywords datasets
#' @name sjukhus
#' @family key_value_data
#' @references \url{http://www.socialstyrelsen.se/klassificeringochkoder/andrakodverk/sjukhuskoder}
NULL


#' Clinic codes
#'
#' Key-value codes for the Swedish clinic types.
#' Data mainly from url below (taken from the PDF).
#' Some extra codes are added from Rockan (290, 291, 292, 446, 921 and 999 for unknown).
#'
#' @docType data
#' @keywords datasets
#' @name klinik
#' @family key_value_data
#' @references \url{http://www.socialstyrelsen.se/klassificeringochkoder/andrakodverk/sjukhuskoder}
#' \url{http://www.socialstyrelsen.se/klassificeringochkoder/andrakodverk/sjukhuskoder/Documents/Verksamhetskodslista2006.pdf}
NULL




#' Patology department codes
#'
#' Key-value codes for the Swedish "laboratories".
#' Data is combined from two sources.
#' \enumerate{
#'  \item The official list from SOFS 2006:15 (see url below). This is the primary source for codes
#'  appearing in both sources.
#'  \item Extra codes are also added from the old Rockan registry for historical reasons.
#' }
#' @docType data
#' @keywords datasets
#' @name patologiavdelning
#' @family key_value_data
#' @references \url{http://www.socialstyrelsen.se/SiteCollectionDocuments/sosfs-2006-15-bilaga-5.pdf}
NULL


################################################################################
#                                                                              #
#                              Diagnostics codes                               #
#                                                                              #
################################################################################


#' M-stadium
#'
#' Key-value codes for M-stadium (sep-03).
#' Data from Rockan (Rocen).
#'
#' @docType data
#' @keywords datasets
#' @name m_rtr
#' @family key_value_data
NULL

#' N-stadium
#'
#' Key-value codes for N-stadium (sep-03).
#' Data from Rockan (Rocen).
#'
#' @docType data
#' @keywords datasets
#' @name n_rtr
#' @family key_value_data
NULL

#' T-stadium
#'
#' Key-value codes for T-stadium (sep 2003).
#' Data from Rockan (Rocen).
#'
#' @docType data
#' @keywords datasets
#' @name t_rtr
#' @family key_value_data
NULL

#' FIGO-stadium
#'
#' Key-value codes for FIGO-stadium (Tumorutbredning enl FIGO, sep 2003).
#' Data from Rockan (Rocen).
#'
#' @docType data
#' @keywords datasets
#' @name figo
#' @family key_value_data
NULL

#' ICD-7
#'
#' Key-value codes for ICD-7.
#' Data from Rockan (Rocen).
#'
#' @docType data
#' @keywords datasets
#' @name icd7
#' @family key_value_data
NULL

#' ICD-9
#'
#' Key-value codes for ICD-9.
#' Data from Rockan (Rocen).
#'
#' @docType data
#' @keywords datasets
#' @name icd9
#' @family key_value_data
NULL

#' ICD-O
#'
#' Key-value codes for ICD-O.
#' Data from Rockan (Rocen).
#'
#' @docType data
#' @keywords datasets
#' @name icdo
#' @family key_value_data
NULL

#' ICD-O3
#'
#' Key-value codes for ICD-O3.
#' Data from Rockan (Rocen).
#'
#' @docType data
#' @keywords datasets
#' @name icdo3
#' @family key_value_data
NULL

#' Sida
#'
#' Key-value codes for sida (Sida, 1 = Hoger, 2 = Vanster, 9 = Okant).
#' Data from Rockan (Rocen).
#'
#' @docType data
#' @keywords datasets
#' @name sida
#' @family key_value_data
NULL

#' Grund till TNM (patologisk/klinisk)
#'
#' Key-value codes for TNM-grund (Grund till TNM, 1=patologisk, 2=klinisk).
#' Data from Rockan (Rocen).
#'
#' @docType data
#' @keywords datasets
#' @name tnmgrund
#' @family key_value_data
NULL

#' ICD-10 code
#'
#' Key-value codes for ICD-10-SE (Swedish version).
#' Includes all ICD-10-codes (not only the C- and D-codes).
#' Data from Socialstyrelsen.
#' Note that key codes are given without dots, i e C569, not C56.9.
#'
#' @docType data
#' @keywords datasets
#' @name icd10
#' @family key_value_data
#' @references \url{http://www.socialstyrelsen.se/klassificeringochkoder/laddaner/kodtextfiler#1}
NULL


#' Snomed code
#'
#' Key-value codes for Snomed. Data from Rockan 2012-10-05.
#' Note tht this variable is the same as \code{snomed} from Rockan.
#' It should not be confused with the later version \code{snomed3}!
#'
#' @docType data
#' @keywords datasets
#' @name snomed
#' @family key_value_data
NULL



#' Snomed 3
#'
#' Key-value codes for Snomed3 (fr 2005).
#' Data from Rockan (Rocen).
#'
#' @docType data
#' @keywords datasets
#' @name snomed3
#' @family key_value_data
NULL



#' PAD (C24) code
#'
#' Key-value codes for PAD (C24) Data from Rockan 2012-09-18.
#'
#' @docType data
#' @keywords datasets
#' @name pad
#' @family key_value_data
NULL



################################################################################
#                                                                              #
#                                 Other codes                                  #
#                                                                              #
################################################################################




#' Gender code (kon)
#'
#' Key-value codes for gender (1 = man (Male) and 2 = Kvinna (female)).
#' Be aware of the spelling ("kon")!
#'
#' @docType data
#' @keywords datasets
#' @name kon
#' @family key_value_data
NULL
