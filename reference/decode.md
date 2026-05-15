# Decode codes to plain text (and vice versa)

Translate coded values into meaningful plain text (or reversed).

## Usage

``` r
code(y, keyvalue, verbose = TRUE)

decode(x, ...)

# S3 method for class 'data.frame'
decode(x, ...)

# Default S3 method
decode(x, keyvalue, extra_functions = NULL, exact = FALSE, ...)
```

## Arguments

- y:

  value to be coded (to be matched against the `value` element) in a
  [keyvalue](https://eribul.github.io/decoder/reference/keyvalue.md)
  object.

- keyvalue:

  either a name (as character string) of a package internal
  [keyvalue](https://eribul.github.io/decoder/reference/keyvalue.md)
  object, or a user defined keyvalue object (see
  [as.keyvalue](https://eribul.github.io/decoder/reference/keyvalue.md)).

- verbose:

  (only for `code`) can be set to `FALSE` to avoid a printed message to
  the console if an error occur (`TRUE` as default).

- x:

  object to decode. Either a key vector to be matched against the `key`
  column in `keyvalue`, or a data.frame (see section
  `decode.data.frame`). object.

- ...:

  ignored

- extra_functions:

  is a list of functions (or names of functions as character vector) to
  be applied to the decoded data after decoding (see section
  "extra_functions" below).

- exact:

  Should `x` have an exact match from the key? Default is `FALSE`. When
  `FALSE`, `x` might be transformed to fit the key (punctuation might be
  removed, upper case changed to lower case or vice versa and strings
  that are too long might be substringed). (`code` only accept exact
  matches.)

## Value

- For default S3 method: A vector of the same length as `x` but with all
  cells decoded (or coded) to plain text (or code) as character.

- For S3 method for class 'data.frame': Data.frame `x` is returned,
  possibly with some extra columns (names ending in '\_Beskrivning'),
  decoded from columns with names corresponding to attribute
  `standard_var_names` for keyvalue objects listed by
  `list_keyvalues()`.

## Vignette

See the vignette for a longer introduction to the package:
[`vignette("decoder")`](https://eribul.github.io/decoder/articles/decoder.md)

## decode.data.frame

If `x` is a data.frame, all column names of `x` are matched to attribute
`standard_var_names` for all keyvalue objects in the package (see
`list_keyvalues()`). If the column name is a standard name used for a
coding, the corresponding keyvalue object is used to decode the column
and to add an extra column to `x` with its original name with suffix
`_Beskrivning`. This is done for all identified columns.

## extra_functions

The relationship between the key and the value in a keyvalue object is
either 1:1 or m:1. The mapping is straight forward for 1:1 but with m:1,
different applications might require slightly different groupings of the
keys. One solution is to have several versions of the
[keyvalue](https://eribul.github.io/decoder/reference/keyvalue.md)
object. Another (which we prefer) is to use the same
[keyvalue](https://eribul.github.io/decoder/reference/keyvalue.md)
object (if possible) but to call one or several extra function(s) to
further process the result. These functions are either built in package
functions that should be called by quoted names or user defined
functions that can be called by either quoted or unquoted names (if
available in the current environment). Note that the order of the
functions could matter since they are called in turn (the output from
the first function is passed as input to the second function etc).

Standard functions and how to use them:

To use with
[sjukvardsomrade](https://eribul.github.io/decoder/reference/sjukvardsomrade.md):

- `kungalv2Fyrbodal`:

  The default classification used in
  [sjukvardsomrade](https://eribul.github.io/decoder/reference/sjukvardsomrade.md)
  is to make Kungalv a region of its own. Use this function if Kungalv
  should be included in Fyrbodal. See example section below.

- `kungalv2Storgoteborg`:

  As `kungalv2Fyrbodal` but classifies Kungalv as a part of
  Storgoteborg.

- `real_names`:

  Give the area names with correct Swedish spelling (including spaces).
  This is not as default due to compatibility reasons and because names
  with spaces must be back-ticked when referred to.

To use with
[region](https://eribul.github.io/decoder/reference/region.md)

- `short_region_names`:

  Exclude the prefix 'Region' from the region names, hence 'Syd' instead
  of 'Region Syd' etcetera.

## See also

[keyvalue](https://eribul.github.io/decoder/reference/keyvalue.md),
[extra_functions](https://eribul.github.io/decoder/reference/extra_functions.md)

## Author

Erik Bulow

## Examples

``` r

KON_VALUE <- sample(1:2, 20, replace = TRUE)
(kon <- decode(KON_VALUE, decoder::kon))
#> Error in derive_pubkey(key): RAW() can only be applied to a 'raw', not a 'character'
code(kon, decoder::kon)
#> No variables decoded!
#>   key  value
#> 1   1    Man
#> 2   2 Kvinna

# Get a sample of Snomed-codes
snomed2 <- sample(decoder::snomed$key, 30, replace = TRUE)
#> Error in derive_pubkey(key): RAW() can only be applied to a 'raw', not a 'character'
# ... then decode them:
(snomed3 <- decode(snomed2, "snomed"))
#> Error: object 'snomed2' not found


# Health care regions can be defined in more than one way
# By default Kungalv define a region of its own:
set.seed(123456789)
healtcare_areas_west <-
  sample(unlist(decoder::sjukvardsomrade), 100, replace = TRUE)
(areas <- decode(healtcare_areas_west, "sjukvardsomrade"))
#> Warning: transformed to match the keyvalue:  Punctuations are removed. Only the first 4 characters are used.
#> Warning: Some codes could not be translated (46 cells)
#>   [1] NA               NA               "Sodra_Alvsborg" "Sodra_Alvsborg"
#>   [5] "Fyrbodal"       NA               "Fyrbodal"       "Fyrbodal"      
#>   [9] "Skaraborg"      "Fyrbodal"       "Sodra_Alvsborg" "Fyrbodal"      
#>  [13] "Fyrbodal"       "Skaraborg"      "Sodra_Alvsborg" "Fyrbodal"      
#>  [17] NA               "Kungalv"        "Sodra_Alvsborg" NA              
#>  [21] NA               "Fyrbodal"       "Skaraborg"      "Fyrbodal"      
#>  [25] "Skaraborg"      NA               NA               "Skaraborg"     
#>  [29] NA               "Kungalv"        "Fyrbodal"       NA              
#>  [33] NA               NA               "Skaraborg"      "Skaraborg"     
#>  [37] NA               NA               "Norra_Halland"  NA              
#>  [41] NA               NA               NA               "Fyrbodal"      
#>  [45] "Kungalv"        NA               "Fyrbodal"       NA              
#>  [49] "Skaraborg"      "Sodra_Alvsborg" "Sodra_Alvsborg" "Skaraborg"     
#>  [53] "Skaraborg"      "Fyrbodal"       NA               NA              
#>  [57] "Fyrbodal"       NA               NA               "Fyrbodal"      
#>  [61] "Sodra_Alvsborg" "Sodra_Alvsborg" "Sodra_Alvsborg" "Storgoteborg"  
#>  [65] "Skaraborg"      "Skaraborg"      NA               NA              
#>  [69] "Fyrbodal"       NA               "Storgoteborg"   "Sodra_Alvsborg"
#>  [73] "Sodra_Alvsborg" NA               "Fyrbodal"       NA              
#>  [77] NA               "Fyrbodal"       NA               NA              
#>  [81] NA               NA               NA               NA              
#>  [85] "Norra_Halland"  NA               NA               NA              
#>  [89] NA               NA               NA               "Norra_Halland" 
#>  [93] NA               NA               "Sodra_Alvsborg" "Skaraborg"     
#>  [97] NA               NA               "Fyrbodal"       "Fyrbodal"      
table(areas)
#> areas
#>       Fyrbodal        Kungalv  Norra_Halland      Skaraborg Sodra_Alvsborg 
#>             20              3              3             13             13 
#>   Storgoteborg 
#>              2 

# But if we want Kungalv to be a part of Storgoteborg
# (which is common practice for example with lung cancer data):
(areas2 <-
  decode(healtcare_areas_west, "sjukvardsomrade", "kungalv2Storgoteborg"))
#> Warning: transformed to match the keyvalue:  Punctuations are removed. Only the first 4 characters are used.
#> Warning: Some codes could not be translated (46 cells)
#>   [1] NA               NA               "Sodra_Alvsborg" "Sodra_Alvsborg"
#>   [5] "Fyrbodal"       NA               "Fyrbodal"       "Fyrbodal"      
#>   [9] "Skaraborg"      "Fyrbodal"       "Sodra_Alvsborg" "Fyrbodal"      
#>  [13] "Fyrbodal"       "Skaraborg"      "Sodra_Alvsborg" "Fyrbodal"      
#>  [17] NA               "Storgoteborg"   "Sodra_Alvsborg" NA              
#>  [21] NA               "Fyrbodal"       "Skaraborg"      "Fyrbodal"      
#>  [25] "Skaraborg"      NA               NA               "Skaraborg"     
#>  [29] NA               "Storgoteborg"   "Fyrbodal"       NA              
#>  [33] NA               NA               "Skaraborg"      "Skaraborg"     
#>  [37] NA               NA               "Norra_Halland"  NA              
#>  [41] NA               NA               NA               "Fyrbodal"      
#>  [45] "Storgoteborg"   NA               "Fyrbodal"       NA              
#>  [49] "Skaraborg"      "Sodra_Alvsborg" "Sodra_Alvsborg" "Skaraborg"     
#>  [53] "Skaraborg"      "Fyrbodal"       NA               NA              
#>  [57] "Fyrbodal"       NA               NA               "Fyrbodal"      
#>  [61] "Sodra_Alvsborg" "Sodra_Alvsborg" "Sodra_Alvsborg" "Storgoteborg"  
#>  [65] "Skaraborg"      "Skaraborg"      NA               NA              
#>  [69] "Fyrbodal"       NA               "Storgoteborg"   "Sodra_Alvsborg"
#>  [73] "Sodra_Alvsborg" NA               "Fyrbodal"       NA              
#>  [77] NA               "Fyrbodal"       NA               NA              
#>  [81] NA               NA               NA               NA              
#>  [85] "Norra_Halland"  NA               NA               NA              
#>  [89] NA               NA               NA               "Norra_Halland" 
#>  [93] NA               NA               "Sodra_Alvsborg" "Skaraborg"     
#>  [97] NA               NA               "Fyrbodal"       "Fyrbodal"      
table(areas2)
#> areas2
#>       Fyrbodal  Norra_Halland      Skaraborg Sodra_Alvsborg   Storgoteborg 
#>             20              3             13             13              5 

# We can also combine several extra_functions if we for example
# also want the area names with correct Swedish spelling.
(areas3 <-
  decode(
    healtcare_areas_west,
    "sjukvardsomrade", c("kungalv2Storgoteborg", "real_names")
 )
)
#> Warning: transformed to match the keyvalue:  Punctuations are removed. Only the first 4 characters are used.
#> Warning: Some codes could not be translated (46 cells)
#>   [1] NA               NA               "Södra Älvsborg" "Södra Älvsborg"
#>   [5] "Fyrbodal"       NA               "Fyrbodal"       "Fyrbodal"      
#>   [9] "Skaraborg"      "Fyrbodal"       "Södra Älvsborg" "Fyrbodal"      
#>  [13] "Fyrbodal"       "Skaraborg"      "Södra Älvsborg" "Fyrbodal"      
#>  [17] NA               "Storgöteborg"   "Södra Älvsborg" NA              
#>  [21] NA               "Fyrbodal"       "Skaraborg"      "Fyrbodal"      
#>  [25] "Skaraborg"      NA               NA               "Skaraborg"     
#>  [29] NA               "Storgöteborg"   "Fyrbodal"       NA              
#>  [33] NA               NA               "Skaraborg"      "Skaraborg"     
#>  [37] NA               NA               "Norra Halland"  NA              
#>  [41] NA               NA               NA               "Fyrbodal"      
#>  [45] "Storgöteborg"   NA               "Fyrbodal"       NA              
#>  [49] "Skaraborg"      "Södra Älvsborg" "Södra Älvsborg" "Skaraborg"     
#>  [53] "Skaraborg"      "Fyrbodal"       NA               NA              
#>  [57] "Fyrbodal"       NA               NA               "Fyrbodal"      
#>  [61] "Södra Älvsborg" "Södra Älvsborg" "Södra Älvsborg" "Storgöteborg"  
#>  [65] "Skaraborg"      "Skaraborg"      NA               NA              
#>  [69] "Fyrbodal"       NA               "Storgöteborg"   "Södra Älvsborg"
#>  [73] "Södra Älvsborg" NA               "Fyrbodal"       NA              
#>  [77] NA               "Fyrbodal"       NA               NA              
#>  [81] NA               NA               NA               NA              
#>  [85] "Norra Halland"  NA               NA               NA              
#>  [89] NA               NA               NA               "Norra Halland" 
#>  [93] NA               NA               "Södra Älvsborg" "Skaraborg"     
#>  [97] NA               NA               "Fyrbodal"       "Fyrbodal"      


# The region names can be both with and without prefix:
regs <- sample(6, 10, replace = TRUE)
decode(regs, "region") # With prefix
#> Error in derive_pubkey(key): RAW() can only be applied to a 'raw', not a 'character'
decode(regs, "region", "short_region_names") # without prefix
#> Error in derive_pubkey(key): RAW() can only be applied to a 'raw', not a 'character'

# Note that only the first four digits of the LKF-code were used abowe?
# What if we use the full LKF-code?
lkfs <- sample(decoder::forsamling$key, 100, replace = TRUE)
#> Error in derive_pubkey(key): RAW() can only be applied to a 'raw', not a 'character'
decode(lkfs, "sjukvardsomrade")
#> Error: object 'lkfs' not found
# That work's just as fine when exact = FALSE (which it is by default).

# decode can also be used for data.frames with recognised column names
d <- data.frame(
     kon = sample(1:2, 10, replace = TRUE),
     sex = sample(1:2, 10, replace = TRUE),
     lkf = sample(decoder::hemort$key, 10, replace = TRUE)
 )
#> Error in derive_pubkey(key): RAW() can only be applied to a 'raw', not a 'character'
 decode(d)
#> Error: object 'd' not found
```
