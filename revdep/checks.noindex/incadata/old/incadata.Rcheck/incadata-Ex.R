pkgname <- "incadata"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
library('incadata')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
base::assign(".old_wd", base::getwd(), pos = 'CheckExEnv')
cleanEx()
nameEx("as.Dates")
### * as.Dates

flush(stderr()); flush(stdout())

### Name: as.Dates
### Title: Converting potential date to Date vector
### Aliases: as.Dates

### ** Examples


as.Dates(c(1212121212, "20000101", "2014-10-15", 5806))

## Not run: 
##D # Note that the as.Date (as oppose to as.Dates)
##D # does not handle missing dates as empty strings
##D as.Date(c("", "2017-02-16")) # Error
##D as.Dates(c("", "2017-02-16")) # NA "2017-02-16"
## End(Not run)



cleanEx()
nameEx("documents")
### * documents

flush(stderr()); flush(stdout())

### Name: documents
### Title: Download and possibly open INCA documentation
### Aliases: documents

### ** Examples

## Not run: 
##D documents("lunga", "uppfoljning")
## End(Not run)



cleanEx()
nameEx("dplyr_methods")
### * dplyr_methods

flush(stderr()); flush(stdout())

### Name: dplyr_methods
### Title: dplyr methods for INCA data
### Aliases: dplyr_methods filter.incadata mutate.incadata arrange.incadata
###   rename.incadata select.incadata slice.incadata summarise.incadata
###   summarize.incadata group_by.incadata
### Keywords: internal

### ** Examples

x <- dplyr::slice(as.incadata(incadata::ex_data), 1:10)
class(x) # "incadata"   "tbl_df"     "tbl"        "data.frame"




cleanEx()
nameEx("ex_data")
### * ex_data

flush(stderr()); flush(stdout())

### Name: ex_data
### Title: Synthetic example data from INCA
### Aliases: ex_data
### Keywords: datasets

### ** Examples

# Inspect the data
dplyr::glimpse(ex_data)

# Coerce to incadata
as.incadata(ex_data)



cleanEx()
nameEx("find_documents")
### * find_documents

flush(stderr()); flush(stdout())

### Name: find_documents
### Title: List all documents for a register
### Aliases: find_documents

### ** Examples

## Not run: 
##D find_documents("all")
##D find_documents("peniscancer", "uppfoljning")
## End(Not run)



cleanEx()
nameEx("find_register")
### * find_register

flush(stderr()); flush(stdout())

### Name: find_register
### Title: Find register by name
### Aliases: find_register

### ** Examples

find_register("all") # "akut lymfatiskt leukemi all"
## Not run: 
##D find_register("kronisk") # More than one possible alternative
## End(Not run)



cleanEx()
nameEx("is.incalogical")
### * is.incalogical

flush(stderr()); flush(stdout())

### Name: is.incalogical
### Title: Coerce to logical if value is logical according to INCA
### Aliases: is.incalogical incalogical2logical

### ** Examples

is.incalogical(c("", "", "True", ""))  # TRUE
is.incalogical(c("", "False", "", "")) # TRUE
is.incalogical(c("", "FALSE", "", "")) # FALSE
is.incalogical(logical(2)) # will be recognised as well



cleanEx()
nameEx("lt")
### * lt

flush(stderr()); flush(stdout())

### Name: lt
### Title: Lead time from one date to another
### Aliases: lt

### ** Examples

lt("2017-02-10", "2017-02-16") # 6
lt("2017-02-16", "2017-02-10") # negative lead times ignored by default
lt("2017-02-16", "2017-02-10", TRUE) # -6



cleanEx()
nameEx("use_incadata")
### * use_incadata

flush(stderr()); flush(stdout())

### Name: use_incadata
### Title: Use incadata from file or dataframe df
### Aliases: use_incadata

### ** Examples

## Not run: 
##D # Create a csv file with example data in a temporary directory
##D fl <- tempfile("ex_data", fileext = ".csv2")
##D write.csv2(incadata::ex_data, fl)
##D 
##D # First time the file is read from csv2
##D use_incadata(fl)
##D dir(tempdir) # a cache file is saved along the original csv2-file
##D use_incadata(fl) # Next time file loaded from cache
## End(Not run)



### * <FOOTER>
###
cleanEx()
options(digits = 7L)
base::cat("Time elapsed: ", proc.time() - base::get("ptime", pos = 'CheckExEnv'),"\n")
grDevices::dev.off()
###
### Local variables: ***
### mode: outline-minor ***
### outline-regexp: "\\(> \\)?### [*]+" ***
### End: ***
quit('no')
