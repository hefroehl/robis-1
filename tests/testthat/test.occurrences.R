library(robis)
context("Occurrences")

test_that("get_occurrences returns occurrences", {
  n <- 10
  data <- get_occurrences("Abra alba", maxFeatures=n)
  expect_true("basisofrecord" %in% names(data))
  expect_true("datecollected" %in% names(data))
  expect_equal(nrow(data), n)
})