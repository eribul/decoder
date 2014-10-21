
kv_names <- c("key", "value")

##################################### Län ######################################

lan <- read.csv2("data_other_sources/lan.csv")
lan$Län <- stringr::str_trim(lan$Län)
lan <- subset(lan, select = c("Kod", "Län"))
names(lan) <- kv_names
lan$key <- stringr::str_pad(lan$key, 2, pad = "0")
lan <- as.keyvalue11(lan, standard_var_names = "LAN_VALUE")




#################################### Kommun ####################################

# http://www.scb.se/Grupp/Hitta_statistik/Regional%20statistik/Indelningar/_Dokument/knkopplingar.xls
kommun <- read.delim("data_other_sources/kommun.tab")
names(kommun) <- kv_names
kommun <- subset(kommun, !is.na(key)) 
kommun$key <- stringr::str_pad(kommun$key, 4, pad = "0")
kommun <- as.keyvalue11(kommun)





################################## Församling ##################################

# Data hämtad från
# http://www.scb.se/Grupp/Hitta_statistik/Regional%20statistik/Indelningar/_Dokument/lkf2015.pdf
forsamling <- read.delim("data_other_sources/lkf.csv")
forsamling$Församling <- as.character(stringr::str_pad(forsamling$Församling, 6, pad = "0"))
forsamling <- subset(forsamling, select = c("Församling", "Församlingsnamn"))
names(forsamling) <- kv_names
forsamling <- as.keyvalue(forsamling, standard_var_names = c("a_lkf", "hemfr", "hemnu", "hemdia", "lkf", "LKF_VALUE"))
comment(forsamling) <- "Data from http://www.scb.se/Grupp/Hitta_statistik/Regional%20statistik/Indelningar/_Dokument/lkf2015.pdf"



################################### Kliniker ####################################
klinik <- rbind(klinik, klinik_extra_rockan)
klinik$key <- stringr::str_pad(klinik$key, 3, pad = "0")
klinik <- as.keyvalue11(klinik, standard_var_names = c("ankli"))



############################## Patologiavdelning ###############################

# Vi har koder både från Rockan och Sos.
# http://www.socialstyrelsen.se/SiteCollectionDocuments/sosfs-2006-15-bilaga-5.pdf
patologiavdelningar_sos_2006 <- read.delim("data_other_sources/patologavdelningar_sos_2006.tab", dec=",")
patologiavdelning$key <- as.numeric(patologiavdelning$key)

# Lägg till de koder som finns i Rockan-data men inte från SoS
patologiavdelning <- rbind(subset(patologiavdelning, !(key %in% patologiavdelningar_sos_2006$key)),
                          patologiavdelningar_sos_2006
                          )
patologiavdelning <- subset(patologiavdelning, !is.na(key)) 

patologiavdelning$key <- stringr::str_pad(patologiavdelning$key, 3, pad = "0")
patologiavdelning <- as.keyvalue11(patologiavdelning, standard_var_names = "pat")





#################################### ICD-10 ####################################
icd10 <- gdata::read.xls("~/Documents/R-kod/Rockan-koder/icd-koder-2014-klassifikationer-och-koder.xls",
                         sheet = "KSH97_KOD", fileEncoding = "latin1", stringsAsFactors=FALSE)
names(icd10) <- c("key", "value")
icd10 <- as.keyvalue(icd10)





