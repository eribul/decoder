# Coerce a list to keyvalue object

`x` should be a list with properties described in section "Details".

## Usage

``` r
# S3 method for class 'list'
as.keyvalue(x, ...)
```

## Arguments

- x:

  a `list` with properties described in the details section.

- ...:

  further arguments passed to
  [`as.keyvalue`](https://eribul.github.io/decoder/reference/keyvalue.md).

## Value

The function returns an object of class `keyvalue` (and `list`.

## Details

- All names of the list elements should be unique.

- All elements of the list should be named.

- All keys should be unique (a key should only be mappad to one value).

- All elements of the list should be atomic vectors.

## See also

[as.keyvalue](https://eribul.github.io/decoder/reference/keyvalue.md)

## Examples

``` r

ex <- list(
 fruit  = c("banana", "orange", "kiwi"),
 car    = c("SAAB", "Volvo", "taxi", "truck"),
 animal = c("elephant")
)
as.keyvalue(ex)
#> Error in derive_pubkey(key): RAW() can only be applied to a 'raw', not a 'character'
is.keyvalue(ex)
#> [1] FALSE
```
