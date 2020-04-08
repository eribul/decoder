## -----------------------------------------------------------------------------
library(decoder)

## ---- echo = FALSE, message=FALSE---------------------------------------------
library(decoder)
suppressPackageStartupMessages(library(dplyr))

sjukhus_all <- 
  dplyr::bind_rows(
    rockan = sjukhus,
    inca   = sjukhus_inca,
    par    = sjukhus_par,
    .id    = "source"
)

key_n_sources <- 
  sjukhus_all %>% 
  count(key, sort = TRUE)

## ---- echo = FALSE, message = FALSE-------------------------------------------
sjukhus_most <- 
  dplyr::bind_rows(
    rockan = sjukhus,
    inca   = sjukhus_inca,
    par    = sjukhus_par,
    .id    = "source"
)

key_n_sources <- 
  sjukhus_most %>% 
  count(key, sort = TRUE)
in3 <- key_n_sources %>% filter(n == 3)

sjukhus_most %>% 
  inner_join(in3) %>% 
  arrange(key) %>% 
  tidyr::spread(source, value) %>% 
  select(-n) %>% 
  knitr::kable()

## ---- echo = FALSE, message = FALSE-------------------------------------------
sjukhus %>% 
anti_join(sjukhus_inca) %>% 
  knitr::kable()


## ---- echo = FALSE, message=FALSE---------------------------------------------
sjukhus_inca %>% 
anti_join(sjukhus) %>% 
  knitr::kable()


