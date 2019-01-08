# Make package

# Make sure it works with latest packages on CRAN
update.packages(ask = FALSE)

# Update README
# knitr::knit("README.Rmd")

# Checks
devtools::spell_check(, FALSE)
goodpractice::goodpractice(checks = setdiff(goodpractice::all_checks(), "covr"))
covr::report(covr::package_coverage())
devtools::check()
rhub::check_for_cran()
devtools::check_win_devel()
devtools::check_win_oldrelease()
devtools::check_win_release()

# Rebuild website
pkgdown::build_site()

devtools::release()
