
context("extra_functions")

x <- sjukvardsomrade$key

test_that("kungalv2Storgoteborg", {
    expect_that("Kungalv" %in% levels(decode(x, "sjukvardsomrade", "kungalv2Storgoteborg")), is_false())
})


test_that("kungalv2Fyrbodal", {
    expect_that("Kungalv" %in% levels(decode(x, "sjukvardsomrade", "kungalv2Fyrbodal")), is_false())
})


test_that("real_names", {
    expect_that(levels(decode(x, "sjukvardsomrade", "real_names")), is_equivalent_to(c("Fyrbodal", "Kungälv", "Norra Halland", "Skaraborg", "Storgöteborg" , "Södra Älvsborg")))
})


