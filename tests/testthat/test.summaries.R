library(robis)
context("Summaries")

test_that("get_summaries returns summaries", {
  n <- 10
  data <- get_summaries(maxFeatures=n)
  expect_true("es" %in% names(data))
  expect_true("shannon" %in% names(data))
  expect_true("simpson" %in% names(data))
  expect_equal(nrow(data), n)
})