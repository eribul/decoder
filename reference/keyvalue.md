# Coerce to a keyvalue object

Functions to check if an object is a keyvalue object, or coerce it if
possible.

## Usage

``` r
as.keyvalue(x, ...)

# S3 method for class 'data.frame'
as.keyvalue(x, standard_var_names = NULL, ...)

# Default S3 method
as.keyvalue(x, y, ...)

is.keyvalue(x)
```

## Arguments

- x:

  object to test for, or coerce to, keyvalue (see the details).

- ...:

  arguments passed between methods

- standard_var_names:

  a character vector with standard names for variables decoded with this
  key-values.

- y:

  a value vector if `x` is an unnamed vector (argument must be named 'y
  = .')

## Value

`as.keyvalue` returns a data.frame with additional class `keyvalue` that
fulfills the requirements for a `keyvalue` object and with the `key`
column as character. It also has two extra attributes
`standard_var_names` as described above and `keyvalue11` which is `TRUE`
for keyvalue objects with a 1:1 relation between its keys and values
(otherwise FALSE).

## Details

`x` can be of:

- a name of a package internal (or external) keyvalue object (character
  of length one)

- a `data.frame` with two columns "key" (with unique cells) and "value".

- a list as described in
  [`as.keyvalue.list`](https://eribul.github.io/decoder/reference/as.keyvalue.list.md)

- a named vector with all names unique

- an unnamed vector with unique cells if supplemented by additional
  vector (y)

## See also

[as.keyvalue.list](https://eribul.github.io/decoder/reference/as.keyvalue.list.md),
[decode](https://eribul.github.io/decoder/reference/decode.md),
[summary.keyvalue](https://eribul.github.io/decoder/reference/summary.keyvalue.md),
[key_and_value](https://eribul.github.io/decoder/reference/key_and_value.md)

## Examples

``` r
snomed2 <- as.keyvalue(snomed)
is.keyvalue(snomed2)
#> [1] TRUE
summary(snomed2)
#> Error in derive_pubkey(key): RAW() can only be applied to a 'raw', not a 'character'
```
