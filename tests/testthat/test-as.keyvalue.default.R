context("as.keyvalue.default")

test_that("misc", {
  expect_error(as.keyvalue.default(1), "invalid first argument")
  expect_is(as.keyvalue.default(1, "hej"), "keyvalue")
  expect_error(as.keyvalue.default(1:10, letters))
})
