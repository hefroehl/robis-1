library(robis)
context("Distribution")

test_that("get_distribution returns gridded distribution", {
  n <- 10
  data <- get_distribution("Abra alba", maxFeatures=n)
  expect_true("scientific" %in% names(data))
  expect_true("num_records" %in% names(data))
  expect_equal(nrow(data), n)
})