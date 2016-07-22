context("formt_as_key")

test_that("lkf", {
  expect_true(all(nchar(format_as_key(forsamling$key, "lan")$x) <= 2))
  expect_warning(format_as_key(forsamling$key, "lan"))
  expect_true(all(nchar(format_as_key(forsamling$key, "kommun")$x) <= 4))
  expect_true(all(nchar(format_as_key(forsamling$key, "forsamling")$x) <= 6))
})
