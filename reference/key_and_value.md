# Coerce to key or value in objects in a key-value pair

Functions to check if an object is a valid key or value in a keyvalue
pair, or coerce it if possible.

## Usage

``` r
as.key(x)

is.key(x)

as.value(x)

is.value(x)
```

## Arguments

- x:

  a vector

## Value

`as.value` returns a value-object (currently the vector itself but with
class "value"). `as.key` returns a key-object (building on `value` but
with unique entries and as character).
