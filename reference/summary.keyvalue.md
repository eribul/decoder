# Object summary for keyvalue objects

Objects of type `keyvalue11` are summarized as data.frames with an
additional display of possible `standard_var_names`. Objects of type
`keyvalue` also gives a list of non 1:1 key-value pairs.

## Usage

``` r
# S3 method for class 'keyvalue'
summary(object, ...)
```

## Arguments

- object:

  a keyvalue object

- ...:

  ignored

## Value

A list with three elements: a summary of the underlying data.frame, the
standard_var_names and possibly a data.frame with all non 1:1 relations.

## See also

[keyvalue](https://eribul.github.io/decoder/reference/keyvalue.md)
