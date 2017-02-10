kv_names <- c("key", "value")

##################################### Län ######################################

lan <-
  read.csv2("data-raw/data_other_sources/lan.csv", stringsAsFactors = FALSE)
lan$Län <- trimws(lan$Län)
lan <- subset(lan, select = c("Kod", "Län"))
names(lan) <- kv_names
lan$key <- decoder:::pad0(lan$key, 2)
lan <-
  as.keyvalue(
    lan,
    standard_var_names = c(
      "lan_value",
      "a_lkf",
      "hemfr",
      "hemnu",
      "hemdia",
      "lkf",
      "lkf_value"
    )
  )

#################################### Kommun ####################################

# http://www.scb.se/Grupp/Hitta_statistik/Regional%20statistik/Indelningar/_Dokument/knkopplingar.xls
kommun <-
  read.delim("data-raw/data_other_sources/kommun.tab", stringsAsFactors = FALSE)
names(kommun) <- kv_names
kommun <- subset(kommun, !is.na(key))
kommun$key <- decoder:::pad0(kommun$key, 4)
kommun <-
  as.keyvalue(kommun,
              standard_var_names = c("a_lkf", "hemfr", "hemnu", "hemdia", "lkf", "lkf_value"))


#################################### HSN ####################################

# Baseras på ett dokument i et mail från Erik H som jag sedan kompletterat med kommunkoder
hsn <- readxl::read_excel("data-raw/data_other_sources/HSN2015.xlsx",
                          sheet = "Organisation",
                          skip = 3)
hsn <- hsn[, c("key", "value")]
hsn <- unique(hsn)
hsn <- as.keyvalue(hsn)



################################## Församling ##################################

# Data hämtad från
# http://www.scb.se/Grupp/Hitta_statistik/Regional%20statistik/Indelningar/_Dokument/lkf2015.pdf
forsamling <-
  read.delim("data-raw/data_other_sources/lkf.csv", stringsAsFactors = FALSE)
forsamling$Församling <- decoder:::pad0(forsamling$Församling, 6)
forsamling <-
  subset(forsamling, select = c("Församling", "Församlingsnamn"))
names(forsamling) <- kv_names
forsamling <-
  as.keyvalue(
    forsamling,
    standard_var_names = c("a_lkf", "hemfr", "hemnu", "hemdia", "lkf", "lkf_value")
  )
comment(forsamling) <-
  "Data from http://www.scb.se/Grupp/Hitta_statistik/Regional%20statistik/Indelningar/_Dokument/lkf2015.pdf"



##### Combined keyvalue for lan, kommun and forsamling, similair to hemort #####
hemort2 <- as.keyvalue(rbind(lan, kommun, forsamling))


################################### Distrikt ###################################

# Data och beskrivning:
# http://www.scb.se/sv_/Hitta-statistik/Regional-statistik-och-kartor/Regionala-indelningar/Distrikt/
distrikt <-
  readxl::read_excel("data-raw/data_other_sources/Distrikt-i-kodnummerordning.xlsx",
                     skip = 1)
distrikt <- distrikt[!is.na(distrikt$Distriktskod), ]
names(distrikt) <- kv_names
distrikt <- decoder::as.keyvalue(distrikt)
comment(distrikt) <-
  "Data from www.scb.se/sv_/Hitta-statistik/Regional-statistik-och-kartor/Regionala-indelningar/Distrikt/"


################################### Kliniker ####################################
klinik <- read.delim("data-raw/best/klinik.tab")
klinik_extra_rockan <- read.delim("data-raw/best/klinik_extra_rockan.tab")
klinik <- rbind(klinik, klinik_extra_rockan)
klinik$key <- decoder:::pad0(klinik$key, 3)
klinik <- unique(klinik)
klinik <- as.keyvalue(klinik, standard_var_names = c("ankli"))



############################## Patologiavdelning ###############################

# Vi har koder både från Rockan och Sos.
# http://www.socialstyrelsen.se/SiteCollectionDocuments/sosfs-2006-15-bilaga-5.pdf
patologiavdelningar_sos_2006 <-
  read.delim(
    "data-raw/data_other_sources/patologavdelningar_sos_2006.tab"
    ,
    dec = ",",
    stringsAsFactors = FALSE
  )
# patologiavdelning$key <- as.numeric(patologiavdelning$key)

# Lägg till de koder som finns i Rockan-data men inte från SoS
patologiavdelning <-
  rbind(subset(
    patologiavdelning,
    !(key %in% patologiavdelningar_sos_2006$key)
  ),
  patologiavdelningar_sos_2006)
patologiavdelning <- subset(patologiavdelning, !is.na(key))
patologiavdelning$key <- decoder:::pad0(patologiavdelning$key, 3)
patologiavdelning <-
  patologiavdelning[!duplicated(patologiavdelning$key), ]
patologiavdelning <-
  as.keyvalue(patologiavdelning, standard_var_names = "pat")





#################################### ICD-10 ####################################
# icd10 <- readxl::read_excel("data_other_sources/icd-koder-2014-klassifikationer-och-koder.xls",
#                                          sheet = "KSH97_KOD")
icd10 <- readxl::read_excel("data-raw/data_other_sources/ICD10SE-2016.xls",
                            sheet = "KSH97_KOD")
names(icd10) <- kv_names
icd10 <- as.keyvalue(icd10)


####################################### ICD7_grov #######################################

x <-
  read.delim("data-raw/data_other_sources/icd7_grov_from_SoS.tab", sep = " ")
icd7_grov <- as.keyvalue(x)




####################################### ICDO3_grov #######################################

x <-
  read.delim("data-raw/data_other_sources/icdo3_fran_manual.tab", header = FALSE)
x <- as.character(unlist(x))
x <- gsub(".", " ", x, fixed = TRUE)
x <- substring(x, 1, nchar(x) - 3)
x <- trimws(x)
x <- strsplit(x, "  ")

x <- data.frame(
  key = substring(x, nchar(x) - 2),
  value = substring(x, 1, nchar(x) - 4),
  stringsAsFactors = FALSE
)

## Hud finns uppdelat i två poster (med och utan melanom), vi nöjer oss med en
x <- x[!duplicated(x$key),]
x$value[x$key == "C44"] <- "Hud (inkl melanom)"

comment(x) <-
  "Data from http://www.socialstyrelsen.se/Lists/Artikelkatalog/Attachments/19446/2014-5-12.pdf"

icdo3_grov <- as.keyvalue(x)


if (FALSE) {
  ####################################### Sjukhus #######################################
  sjh_koder <-
    gdata::read.xls("data-raw/data-raw/data_other_sources/enhetskoder_preiminara_infor_caninca.xlsx")
  sjh_koder <- sjh_koder %>%
    #select(Leveranskod_sjukhus, Sjukhus_Enhet) %>%
    mutate(Sjukhus_Enhet = trimws(Sjukhus_Enhet)) %>%
    distinct(Leveranskod_sjukhus, Sjukhus_Enhet)
  
  # dublettkoder
  dublettkoder <- sjh_koder[sjh_koder$Leveranskod_sjukhus %in%
                              names(table(sjh_koder$Leveranskod_sjukhus)[table(sjh_koder$Leveranskod_sjukhus) >
                                                                           1]),] %>%
    arrange(Leveranskod_sjukhus)
  
  write.csv2(dublettkoder,
             "data-raw/data_other_sources/dublettlista_till_SAN.csv")
}


################################## sjukhus_rc ##################################

rc <- read.csv2("data-raw/data_other_sources/organisationslista_rc.tab", 
  stringsAsFactors = FALSE)

sjukhus_rc <- 
  rc %>% 
    select(
      key = usesjhkod,
      value = s_administration
    ) %>% 
    as.keyvalue()

forvaltning_rc <- 
  rc %>% 
  select(
    key = usesjhkod,
    value = Administration
  ) %>% 
  as.keyvalue()

# Hjälpöversättningar för kod till klartext

sjukhus_rc_code2klartext <- 
  rc %>% 
  transmute(
    key = s_administration,
    value = trimws(sjukhus)
  ) %>% 
  as.keyvalue()


forvaltning_rc_code2klartext <- 
  rc %>% 
  transmute(
    key = Administration,
    value = trimws(Förvaltning)
  ) %>%
  distinct() %>% 
  as.keyvalue()

rm(rc)
  



##################### Koder från INCA:s organisationsregister###################

incaorg <- read.csv2("data-raw/data_other_sources/N58 Organisationsenheter i INCA 2.txt", 
                     stringsAsFactors = FALSE)


trim0 <- function(x) gsub("^0(\\w*)$", "\\1", x)

x <- 
  incaorg %>% 
  filter(
    TopPosCode %in% 1:6,
    PosLevel == 2,
    UnitCode != "30199",     # This code used by two units. Skip it by now
    trimws(UnitCode) != "",
    trimws(UnitName) != ""
  ) %>% 
  group_by(UnitCode) %>% 
  filter(n() == 1 | PosEnabled == "True") %>%
  ungroup() 

# Koder som bara skiljer sig med avseende på ev inledande nolla
problematic_keys <- 
  x %>% 
    filter(
      startsWith(UnitCode, "0"),
      trim0(UnitCode) %in% UnitCode
    ) %>% 
  select(UnitCode)


sjukhus_inca <- 
  x %>% 
    transmute(
      key = ifelse(UnitCode %in% problematic_keys$UnitCode, UnitCode, 
                   trim0(UnitCode)),
      value = UnitName
    ) %>% 
    distinct(key, value, .keep_all = TRUE) %>% 
    as.keyvalue()

rm(incaorg, trim0, x, problematic_keys)



########################## Sjukhuskoder från SOS/PAR ###########################

# download.file("http://www.socialstyrelsen.se/SiteCollectionDocuments/patientregistret-sjukhus-klinikkoder-sluten-vard-2014.xls", "data_other_sources/sos_par_sjukhus_sluten.xls")
# 
# download.file("http://www.socialstyrelsen.se/SiteCollectionDocuments/patientregistret-sjukhus-klinikkoder-oppen-vard-2014.xls", "data_other_sources/sos_par_sjukhus_oppen.xls")

oppen <- readxl::read_excel("data-raw/data_other_sources/sos_par_sjukhus_oppen.xls", 
  "Öppenvård", col_names = FALSE)
sluten <- readxl::read_excel("data-raw/data_other_sources/sos_par_sjukhus_sluten.xls", 
                            "Slutenvård", col_names = FALSE)

sjukhus_par <- 
  oppen %>% 
  bind_rows(sluten) %>% 
  select(
    key = X2,
    value = X3
  ) %>% 
  filter(
    !is.na(key),
    key != value,
    !is.na(value)
  ) %>% 
  distinct(key, .keep_all = TRUE) %>% 
  arrange(key) %>% 
  as.keyvalue()

rm(oppen, sluten)
