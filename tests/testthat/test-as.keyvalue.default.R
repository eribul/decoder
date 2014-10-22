
context("as.keyvalue.default")

test_that("misc", {
    expect_that(as.keyvalue.default(1), throws_error())
})
