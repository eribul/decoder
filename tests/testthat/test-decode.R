
context("decode")

suppressWarnings({
    
    test_that("decode.default", {
        expect_that(decode(1:2, "kon"), is_equivalent_to(c("Man", "Kvinna")))
        expect_that(length(decode(snomed$key, "snomed")), is_equivalent_to(length(snomed$key)))
    })
    
    
    test_that("decode.data.frame", {
        expect_that(decode(iris), gives_warning())    
        expect_that(decode(iris), is_equivalent_to(iris))
    })
})
