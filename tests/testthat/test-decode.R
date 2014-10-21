
context("decode")


test_that(desc = "Basic tests",{
    
    expect_that(decode(), throws_error())
    expect_that(decode(1:2, "kon"), equals(c("Man", "Kvinna")))
})
