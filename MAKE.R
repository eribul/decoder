# Make package

# Make sure it works with latest packages on CRAN
update.packages(ask = FALSE)

# Update README
# knitr::knit("README.Rmd")

source("data-raw/make_keyvalue.R")
devtools::document()

# Checks
devtools::test()
devtools::spell_check(, FALSE)
goodpractice::goodpractice(checks = setdiff(goodpractice::all_checks(), "covr"))
covr::report(covr::package_coverage())
devtools::check()
rhub::check_for_cran()
devtools::check_win_devel()
devtools::check_win_oldrelease()
devtools::check_win_release()

# Reverse dependencies
# pak::pkg_install("r-lib/revdepcheck")
revdepcheck::revdep_reset()
revdepcheck::revdep_check()

# Rebuild website
pkgdown::build_site()

# CRAN release
devtools::release()
