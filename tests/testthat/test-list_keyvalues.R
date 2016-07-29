context("list_keyvalues")

test_that("misc", {
  expect_true(all(c("snomed", "kon", "sjukvardsomrade", "lan") %in% 
                    list_keyvalues()))
  expect_equal(list_keyvalues(), ALL_KEYVALUE_OBJECTS)
})
