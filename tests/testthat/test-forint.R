context("format numeric values as forints")
library(mr)

test_that("integer forint values work", {
  expect_equal(forint(42), "42 Ft")
})
