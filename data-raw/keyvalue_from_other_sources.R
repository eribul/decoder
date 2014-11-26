
kv_names <- c("key", "value")

##################################### Län ######################################

lan <- read.csv2("data_other_sources/lan.csv", stringsAsFactors = FALSE)
lan$Län <- stringr::str_trim(lan$Län)
lan <- subset(lan, select = c("Kod", "Län"))
names(lan) <- kv_names
lan$key <- stringr::str_pad(lan$key, 2, pad = "0")
lan <- as.keyvalue(lan, standard_var_names = "lan_value")




#################################### Kommun ####################################

# http://www.scb.se/Grupp/Hitta_statistik/Regional%20statistik/Indelningar/_Dokument/knkopplingar.xls
kommun <- read.delim("data_other_sources/kommun.tab", stringsAsFactors = FALSE)
names(kommun) <- kv_names
kommun <- subset(kommun, !is.na(key)) 
kommun$key <- stringr::str_pad(kommun$key, 4, pad = "0")
kommun <- as.keyvalue(kommun)





################################## Församling ##################################

# Data hämtad från
# http://www.scb.se/Grupp/Hitta_statistik/Regional%20statistik/Indelningar/_Dokument/lkf2015.pdf
forsamling <- read.delim("data_other_sources/lkf.csv", stringsAsFactors = FALSE)
forsamling$Församling <- as.character(stringr::str_pad(forsamling$Församling, 6, pad = "0"))
forsamling <- subset(forsamling, select = c("Församling", "Församlingsnamn"))
names(forsamling) <- kv_names
forsamling <- as.keyvalue(forsamling, standard_var_names = c("a_lkf", "hemfr", "hemnu", "hemdia", "lkf", "LKF_VALUE"))
comment(forsamling) <- "Data from http://www.scb.se/Grupp/Hitta_statistik/Regional%20statistik/Indelningar/_Dokument/lkf2015.pdf"



################################### Kliniker ####################################
klinik <- rbind(klinik, klinik_extra_rockan)
klinik$key <- stringr::str_pad(klinik$key, 3, pad = "0")
klinik <- unique(klinik)
klinik <- as.keyvalue(klinik, standard_var_names = c("ankli"))



############################## Patologiavdelning ###############################

# Vi har koder både från Rockan och Sos.
# http://www.socialstyrelsen.se/SiteCollectionDocuments/sosfs-2006-15-bilaga-5.pdf
patologiavdelningar_sos_2006 <- read.delim("data_other_sources/patologavdelningar_sos_2006.tab"
                                           , dec=",", stringsAsFactors = FALSE)
# patologiavdelning$key <- as.numeric(patologiavdelning$key)

# Lägg till de koder som finns i Rockan-data men inte från SoS
patologiavdelning <- rbind(subset(patologiavdelning, !(key %in% patologiavdelningar_sos_2006$key)),
                          patologiavdelningar_sos_2006
                          )
patologiavdelning <- subset(patologiavdelning, !is.na(key)) 
patologiavdelning$key <- stringr::str_pad(patologiavdelning$key, 3, pad = "0")
patologiavdelning <- patologiavdelning[!duplicated(patologiavdelning$key),]
patologiavdelning <- as.keyvalue(patologiavdelning, standard_var_names = "pat")





#################################### ICD-10 ####################################
icd10 <- XLConnect::readWorksheetFromFile("data_other_sources/icd-koder-2014-klassifikationer-och-koder.xls",
                                          sheet = "KSH97_KOD")
names(icd10) <- kv_names
icd10 <- as.keyvalue(icd10)


####################################### ICD7_grov #######################################

x <- read.delim("data_other_sources/icd7_grov_from_SoS.tab", sep = " ")
icd7_grov <- as.keyvalue(x)




####################################### ICDO3_grov #######################################

x <- read.delim("data_other_sources/icdo3_fran_manual.tab", header = FALSE)
x <- as.character(unlist(x))
x <- gsub(".", " ", x, fixed = TRUE)
x <- substring(x, 1, nchar(x) - 3)
x <- gdata::trim(x)
x <- strsplit(x, "  ")

x <- data.frame(key = substring(x, nchar(x) - 2),
                value = substring(x, 1, nchar(x) - 4),
                stringsAsFactors = FALSE)

## Hud finns uppdelat i två poster (med och utan melanom), vi nöjer oss med en
x <- x[!duplicated(x$key), ]
x$value[x$key == "C44"] <- "Hud (inkl melanom)"

comment(x) <- "Data from http://www.socialstyrelsen.se/Lists/Artikelkatalog/Attachments/19446/2014-5-12.pdf"

icdo3_grov <- as.keyvalue(x)


