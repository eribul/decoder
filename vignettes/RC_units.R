## ------------------------------------------------------------------------
df <- 
  data.frame(
    sjukhus          = c("51012", "53011", "53013", "52011", "50070"),
    something        = sample(letters, 5),
    something_else   = sample(LETTERS, 5),
    stringsAsFactors = FALSE
  )
knitr::kable(df)

## ------------------------------------------------------------------------
# Vi använder också dplyr för data managemant
suppressPackageStartupMessages(library(dplyr))
library(decoder)

df %>% 
  mutate(
    rc_sjukhus     = decode(sjukhus, "rc_sjukhus"),
    rc_forvaltning = decode(sjukhus, "rc_forvaltning")
  ) %>% 
  knitr::kable()

## ------------------------------------------------------------------------
df %>% 
  mutate(
    rc_sjukhus_kod      = decode(sjukhus, "rc_sjukhus"),
    rc_forvaltning_kod  = decode(sjukhus, "rc_forvaltning"),
    rc_sjukhus_namn     = decode(sjukhus, "rc_sjukhus", "rc_sjukhus_namn"),
    rc_forvaltning_namn = decode(sjukhus, "rc_forvaltning", "rc_forvaltning_namn")
  ) %>% 
  knitr::kable()

## ---- eval = FALSE-------------------------------------------------------
#  df %>%
#    mutate(
#      rc_sjukhus_kod      = decode(sjukhus, "rc_sjukhus"),
#      rc_forvaltning_kod  = decode(sjukhus, "rc_forvaltning"),
#      rc_sjukhus_namn     = decode(rc_sjukhus_kod, "rc_sjukhus_code2klartext"),
#      rc_forvaltning_namn = decode(rc_forvaltning_kod, "rc_forvaltning_code2klartext")
#    )

## ------------------------------------------------------------------------
decode(decode(df$sjukhus, "rc_sjukhus"), "rc_sjukhus_code2klartext")

## ------------------------------------------------------------------------
sjukhusnamn <- 
  data_frame(
    rcc_sjukhus_kod = decoder:::rc_sjukhus$key,
    rcc_sjukhus_namn = decode(rcc_sjukhus_kod, "sjukhus"),
    rc_sjukhus_namn = decode(rcc_sjukhus_kod, "rc_sjukhus", "rc_sjukhus_namn")
  ) 

knitr::kable(sjukhusnamn)

