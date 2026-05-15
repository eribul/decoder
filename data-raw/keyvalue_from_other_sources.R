kv_names <- c("key", "value")


# Län ---------------------------------------------------------------------

lan <-
  read.csv2(
    "data-raw/data_other_sources/lan.csv",
    stringsAsFactors = FALSE,
    fileEncoding = "UTF-8"
  )

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


# Kommun ------------------------------------------------------------------

# http://www.scb.se/Grupp/Hitta_statistik/Regional%20statistik/Indelningar/_Dokument/knkopplingar.xls # nolint: line_length_linter
kommun <-
  read.delim(
    "data-raw/data_other_sources/kommun.tab",
    stringsAsFactors = FALSE,
    fileEncoding = "UTF-8"
  )

names(kommun) <- kv_names
kommun <- subset(kommun, !is.na(key))
kommun$key <- decoder:::pad0(kommun$key, 4)

kommun <-
  as.keyvalue(
    kommun,
    standard_var_names = c(
      "a_lkf",
      "hemfr",
      "hemnu",
      "hemdia",
      "lkf",
      "lkf_value"
    )
  )


# HSN ---------------------------------------------------------------------

# Baseras på ett dokument i et mail från Erik H som jag sedan kompletterat
# med kommunkoder.
# Har kopierat över till dat-fil pga problem med Excels encoding

hsn <-
  readr::read_table(
    "data-raw/data_other_sources/HSN2015_copied_columns.dat",
    col_types = "ic"
  ) |>
  dplyr::distinct() |>
  as.keyvalue()


# Församling --------------------------------------------------------------

# Data hämtad från
# http://www.scb.se/Grupp/Hitta_statistik/Regional%20statistik/Indelningar/_Dokument/lkf2015.pdf # nolint: line_length_linter
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
    standard_var_names = c(
      "a_lkf",
      "hemfr",
      "hemnu",
      "hemdia",
      "lkf",
      "lkf_value"
    )
  )
comment(forsamling) <-
  "Data from http://www.scb.se/Grupp/Hitta_statistik/Regional%20statistik/Indelningar/_Dokument/lkf2015.pdf" # nolint: line_length_linter


# Hemort2 -----------------------------------------------------------------

hemort2 <- as.keyvalue(rbind(lan, kommun, forsamling))


# Distrikt ----------------------------------------------------------------

# Data och beskrivning:
# https://www.scb.se/hitta-statistik/regional-statistik-och-kartor/regionala-indelningar/distrikt/ # nolint: line_length_linter
distrikt <-
  suppressMessages(
    readr::read_csv2("data-raw/data_other_sources/distrikt.dat")
  ) |>
  decoder::as.keyvalue()


# Kliniker ----------------------------------------------------------------

klinik <-
  read.delim(
    "data-raw/best/klinik.tab",
    stringsAsFactors = FALSE,
    fileEncoding = "UTF-8"
  )
klinik_extra_rockan <-
  read.delim(
    "data-raw/best/klinik_extra_rockan.tab",
    fileEncoding = "UTF-8"
  )
klinik <- rbind(klinik, klinik_extra_rockan)
klinik$key <- decoder:::pad0(klinik$key, 3)
klinik <- unique(klinik)
klinik <- as.keyvalue(klinik, standard_var_names = c("ankli"))

rm(klinik_extra_rockan)

# Patologiavdelning -------------------------------------------------------

# Vi har koder både från Rockan och Sos.
# http://www.socialstyrelsen.se/SiteCollectionDocuments/sosfs-2006-15-bilaga-5.pdf # nolint: line_length_linter
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
  rbind(
    subset(
      patologiavdelning,
      !(key %in% patologiavdelningar_sos_2006$key)
    ),
    patologiavdelningar_sos_2006
  )
patologiavdelning <- subset(patologiavdelning, !is.na(key))
patologiavdelning$key <- decoder:::pad0(patologiavdelning$key, 3)
patologiavdelning <-
  patologiavdelning[!duplicated(patologiavdelning$key), ]
patologiavdelning <-
  as.keyvalue(patologiavdelning, standard_var_names = "pat")

rm(patologiavdelningar_sos_2006)

# ICD-9-CM Disease -------------------------------------------------------------

# File from https://www.cms.gov/Medicare/Coding/ICD9ProviderDiagnosticCodes/codes # nolint: line_length_linter
# version 32
icd9cmd <- readxl::read_excel(
  "data-raw/data_other_sources/CMS32_DESC_LONG_SHORT_DX.xlsx"
) |>
  dplyr::select(key = 1, value = 3) |>
  as.keyvalue()

# ICD-9-CM Procedure -----------------------------------------------------------

icd9cmp <- readxl::read_excel(
  "data-raw/data_other_sources/CMS32_DESC_LONG_SHORT_SG.xlsx"
) |>
  dplyr::select(key = 1, value = 3) |>
  as.keyvalue()


# ICD-10 ------------------------------------------------------------------

icd10cmfile <- "data-raw/data_other_sources/valid-icd-10-list.xlsx"
if (!file.exists(icd10cmfile)) {
  download.file(
    "https://www.cms.gov/files/document/valid-icd-10-list.xlsx-0",
    icd10cmfile
  )
}
icd10cm <-
  readxl::read_excel(icd10cmfile) |>
  dplyr::select(
    key = CODE,
    value = `SHORT DESCRIPTION (VALID ICD-10 FY2026)`
  ) |>
  mutate_all(trimws) |>
  as.keyvalue()


# ICD-10-SE ------------------------------------------------------------------

# Last version from SoS; next time från E-hälsomyndigheten)
icd10se <- readr::read_tsv(
  "https://www.socialstyrelsen.se/globalassets/sharepoint-dokument/dokument-webb/klassifikationer-och-koder/icd-10-se.tsv", # nolint: line_length_linter
  col_select = c("Kod", "Titel"),
) |>
  dplyr::filter(grepl("[A-Z]", Kod), !grepl("-", Kod), !is.na(Titel)) |>
  dplyr::select(key = Kod, value = Titel) |>
  dplyr::mutate(key = gsub("\\.", "", key)) |>
  as.keyvalue()


# ICD-7 grov --------------------------------------------------------------

x <-
  read.delim(
    "data-raw/data_other_sources/icd7_grov_from_SoS.tab",
    sep = " ",
    fileEncoding = "UTF-8",
    stringsAsFactors = FALSE
  )
icd7_grov <- as.keyvalue(x)


# ICD-O3 grov -------------------------------------------------------------

x <-
  read.delim(
    "data-raw/data_other_sources/icdo3_fran_manual.tab",
    header = FALSE,
    stringsAsFactors = FALSE,
    fileEncoding = "UTF-8"
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
x <- x[!duplicated(x$key), ]
x$value[x$key == "C44"] <- "Hud (inkl melanom)"

comment(x) <-
  "Data from http://www.socialstyrelsen.se/Lists/Artikelkatalog/Attachments/19446/2014-5-12.pdf" # nolint: line_length_linter

icdo3_grov <- as.keyvalue(x)


# Koder från INCA:s organisationsregister ---------------------------------

incaorg <-
  suppressMessages(
    readr::read_delim(
      "data-raw/data_other_sources/N58 Organisationsenheter i INCA 2.txt",
      ";",
      escape_double = FALSE,
      trim_ws = TRUE,
      guess_max = 20000
    )
  )

trim0 <- function(x) gsub("^0(\\w*)$", "\\1", x)

x <-
  incaorg |>
  dplyr::filter(
    TopPosCode %in% 1:6,
    PosLevel == 2,
    UnitCode != "30199", # This code used by two units. Skip it by now
    trimws(UnitCode) != "",
    trimws(UnitName) != ""
  ) |>
  group_by(UnitCode) |>
  filter(n() == 1 | PosEnabled == "True") |>
  ungroup()

# Koder som bara skiljer sig med avseende på ev inledande nolla
problematic_keys <-
  x |>
  filter(
    startsWith(UnitCode, "0"),
    trim0(UnitCode) %in% UnitCode
  ) |>
  select(UnitCode)


sjukhus_inca <-
  x |>
  transmute(
    key = ifelse(
      UnitCode %in% problematic_keys$UnitCode,
      UnitCode,
      trim0(UnitCode)
    ),
    value = UnitName
  ) |>
  distinct(key, value, .keep_all = TRUE) |>
  as.keyvalue()

rm(incaorg, trim0, x, problematic_keys)


# Sjukhuskoder från SOS/PAR -----------------------------------------------

# download.file(
#   "http://www.socialstyrelsen.se/SiteCollectionDocuments/patientregistret-sjukhus-klinikkoder-sluten-vard-2014.xls", # nolint: line_length_linter
#   "data_other_sources/sos_par_sjukhus_sluten.xls"
# )
# download.file(
#   "http://www.socialstyrelsen.se/SiteCollectionDocuments/patientregistret-sjukhus-klinikkoder-oppen-vard-2014.xls", # nolint: line_length_linter
#   "data_other_sources/sos_par_sjukhus_oppen.xls"
# )

oppen <-
  readxl::read_excel(
    "data-raw/data_other_sources/sos_par_sjukhus_oppen.xls",
    "Öppenvård",
    range = "B3:C2058",
    col_names = c("key", "value"),
    col_types = c("text", "text")
  ) |>
  na.omit()

sluten <-
  readxl::read_excel(
    "data-raw/data_other_sources/sos_par_sjukhus_sluten.xls",
    "Slutenvård",
    range = "B3:C979",
    col_names = c("key", "value"),
    col_types = c("text", "text")
  ) |>
  na.omit()

sjukhus_par <-
  oppen |>
  bind_rows(sluten) |>
  filter(
    key != value,
  ) |>
  distinct(key, .keep_all = TRUE) |>
  arrange(key) |>
  as.keyvalue()

rm(oppen, sluten)


# Åtgärdskoder ------------------------------------------------------------

kva_path <- "data-raw/data_other_sources/kva-inkl-beskrivningstexter-2026.xlsx"
if (!file.exists(kva_path)) {
  download.file(
    "https://www.socialstyrelsen.se/globalassets/sharepoint-dokument/dokument-webb/klassifikationer-och-koder/kva-inkl-beskrivningstexter-2026.xlsx", # nolint: line_length_linter
    kva_path
  )
}

kva <-
  readxl::read_excel(
    kva_path,
    sheet = 2
  ) |>
  select(key = Kod, value = Titel) |>
  as.keyvalue()

# ATC codes ---------------------------------------------------------------
if (!file.exists("data-raw/data_other_sources/atc.zip")) {
  download.file(
    "https://nsl.mpa.se/sensl-v2.0.zip",
    "data-raw/data_other_sources/atc.zip"
  )
  unzip(
    "data-raw/data_other_sources/atc.zip",
    exdir = "data-raw/data_other_sources/atc"
  )
}

xml <- xml2::read_xml(
  "data-raw/data_other_sources/atc/codesystems\\atc-code.xml",
  encoding = "UTF-8"
)
ns <- xml2::xml_ns(xml)
concepts <- xml2::xml_find_all(xml, ".//d1:concept", ns)

atc <- tibble::tibble(
  key = xml2::xml_attr(concepts, "code"),
  value = xml2::xml_find_first(
    concepts,
    ".//d1:designation[@language='sv']",
    ns
  ) |>
    xml2::xml_text()
) |>
  as.keyvalue()

rm(xml, ns, concepts)
