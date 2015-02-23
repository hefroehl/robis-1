library(robis)
context("Occurrences")

test_that("get_occurrences returns specified number of results", {
  n <- 10
  data <- get_occurrences("Abra alba", maxFeatures=n)
  expect_equal(nrow(data), n)
})