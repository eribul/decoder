
# Test coverage

library(testthat)
library("testCoverage")

reportCoverage(sourcefiles = paste0(getwd(), "/R/", setdiff(dir("R/"), "sysdata.rda")),
               unittestdir = "tests/testthat", 
               reportfile = "inst/test_coverage/test.html",
               outputfile = "inst/test_coverage/traceOutput.txt")
