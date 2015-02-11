
context("decode")

suppressWarnings({
    
    test_that("decode.default", {
        expect_that(decode(1:2, "kon"), is_equivalent_to(c("Man", "Kvinna")))
        expect_that(length(decode(snomed$key, "snomed")), is_equivalent_to(length(snomed$key)))
        expect_that(decode("      0000001", "kon"), gives_warning())
        expect_that(decode("      0000001", "kon"), is_equivalent_to("Man"))
        expect_that(decode(c("0002425", 2425, "df"), "kommun"), is_equivalent_to(c("Dorotea", "Dorotea", NA)))
    })
    
    
    test_that("decode.data.frame", {
        expect_that(decode(iris), gives_warning())    
        expect_that(decode(iris), is_equivalent_to(iris))
    })
})
