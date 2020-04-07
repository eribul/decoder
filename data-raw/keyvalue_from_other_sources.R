kv_names <- c("key", "value")

##################################### Län ######################################

lan <-
  read.csv2(
    "data-raw/data_other_sources/lan.csv", 
    stringsAsFactors = FALSE, 
    fileEncoding = "UTF-8"
  )

lan$Län    <- trimws(lan$Län)
lan        <- subset(lan, select = c("Kod", "Län"))
names(lan) <- kv_names
lan$key    <- decoder:::pad0(lan$key, 2)

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
  read.delim(
    "data-raw/data_other_sources/kommun.tab", 
    stringsAsFactors = FALSE, 
    fileEncoding = "UTF-8"
  )

names(kommun) <- kv_names
kommun        <- subset(kommun, !is.na(key))
kommun$key    <- decoder:::pad0(kommun$key, 4)

kommun <-
  as.keyvalue(
    kommun,
    standard_var_names = 
      c("a_lkf", "hemfr", "hemnu", "hemdia", "lkf", "lkf_value")
  )


#################################### HSN ####################################

# Baseras på ett dokument i et mail från Erik H som jag sedan kompletterat med kommunkoder
hsn <- readxl::read_excel(
  "data-raw/data_other_sources/HSN2015.xlsx",
  sheet = "Organisation",
  skip = 4
)
hsn <- hsn[, c("key", "value")]
hsn <- unique(hsn)
hsn <- as.keyvalue(hsn)



################################## Församling ##################################

# Data hämtad från
# http://www.scb.se/Grupp/Hitta_statistik/Regional%20statistik/Indelningar/_Dokument/lkf2015.pdf
forsamling <-
  read.delim(
    "data-raw/data_other_sources/lkf.csv", 
    stringsAsFactors = FALSE,
    fileEncoding = "UTF-8"
  )

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
klinik <- 
  read.delim(
    "data-raw/best/klinik.tab", 
    stringsAsFactors = FALSE,
    fileEncoding = "UTF-8"
  )
klinik_extra_rockan <- read.delim("data-raw/best/klinik_extra_rockan.tab")
klinik              <- rbind(klinik, klinik_extra_rockan)
klinik$key          <- decoder:::pad0(klinik$key, 3)
klinik              <- unique(klinik)
klinik              <- as.keyvalue(klinik, standard_var_names = c("ankli"))



############################## Patologiavdelning ###############################

# Vi har koder både från Rockan och Sos.
# http://www.socialstyrelsen.se/SiteCollectionDocuments/sosfs-2006-15-bilaga-5.pdf
patologiavdelningar_sos_2006 <-
  read.delim(
    "data-raw/data_other_sources/patologavdelningar_sos_2006.tab",
    dec = ",",
    stringsAsFactors = FALSE,
    fileEncoding = "UTF-8"
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



# ICD-9-CM Disease -------------------------------------------------------------
# File from https://www.cms.gov/Medicare/Coding/ICD9ProviderDiagnosticCodes/codes
# version 32
icd9cmd <- readxl::read_excel("data-raw/data_other_sources/CMS32_DESC_LONG_SHORT_DX.xlsx") %>% 
  dplyr::select(key = 1, value = 3) %>% 
  as.keyvalue()

# ICD-9-CM Procedure -------------------------------------------------------------
icd9cmp <- readxl::read_excel("data-raw/data_other_sources/CMS32_DESC_LONG_SHORT_SG.xlsx") %>% 
  dplyr::select(key = 1, value = 3) %>% 
  as.keyvalue()


#################################### ICD-10 ####################################
icd10se1 <- 
  readxl::read_excel(
    "data-raw/data_other_sources/icd10se-inkl-andringar-2020.xlsx",
    sheet = "ICD10SE_KOD" # All codes except chapter 20
  ) %>% 
  dplyr::select(key = Kod, value = Kodtext)

icd10se2 <- 
  readxl::read_excel(
    "data-raw/data_other_sources/icd10se-inkl-andringar-2020.xlsx",
    sheet = "ICD10SE_K20" # Codes from chapter 20
  ) %>% 
  dplyr::select(key = Kod, value = Kodtext)

icd10 <- 
  dplyr::bind_rows(icd10se1, icd10se2) %>% 
  as.keyvalue()

rm(icd10se1, icd10se2)


####################################### ICD7_grov #######################################

x <-
  read.delim(
    "data-raw/data_other_sources/icd7_grov_from_SoS.tab", 
    sep = " ",
    fileEncoding = "UTF-8",
    stringsAsFactors = FALSE
  )
icd7_grov <- as.keyvalue(x)




####################################### ICDO3_grov #######################################

x <-
  read.delim(
    "data-raw/data_other_sources/icdo3_fran_manual.tab", 
    header = FALSE,
    stringsAsFactors = FALSE,
    fileEncoding = "UTF-8",
  )
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


################################## sjukhus_rc ##################################

rc <- 
  read.csv2(
    "data-raw/data_other_sources/organisationslista_rc.tab", 
    stringsAsFactors = FALSE,
    fileEncoding = "UTF-8",
  )

sjukhus_rc <- 
  rc %>% 
    dplyr::select(
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

incaorg <- 
  readr::read_delim(
    "data-raw/data_other_sources/N58 Organisationsenheter i INCA 2.txt", 
    ";", 
    escape_double = FALSE, 
    trim_ws = TRUE
  )
  
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
# download.file("http://www.socialstyrelsen.se/SiteCollectionDocuments/patientregistret-sjukhus-klinikkoder-oppen-vard-2014.xls", "data_other_sources/sos_par_sjukhus_oppen.xls")

oppen <- 
  readxl::read_excel(
    "data-raw/data_other_sources/sos_par_sjukhus_oppen.xls", 
    "Öppenvård", 
    range = "B3:C2058",
    col_names = c("key", "value"),
    col_types = c("numeric", "text")
  ) %>% 
  na.omit()

sluten <- 
  readxl::read_excel(
    "data-raw/data_other_sources/sos_par_sjukhus_sluten.xls", 
    "Slutenvård", 
    range = "B3:C979",
    col_names = c("key", "value"),
    col_types = c("numeric", "text")
  ) %>% 
  na.omit()

sjukhus_par <- 
  oppen %>% 
  bind_rows(sluten) %>% 
  filter(
    key != value,
  ) %>% 
  distinct(key, .keep_all = TRUE) %>% 
  arrange(key) %>% 
  as.keyvalue()

rm(oppen, sluten)
