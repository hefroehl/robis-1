library(robis)
context("AphiaID")

test_that("get_aphiaid returns the correct AphiaID", {
  expect_equal(get_aphiaid("Abra alba"), "141433")
})