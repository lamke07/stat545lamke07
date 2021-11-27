test_that("Non-redundant (degenerate) inputs for mu, sigma.", {
  expect_error(generate_X(n = 40, mu = c(NA, rep(1, 7)), sigma = 1:8),
               "mu must not be NA")
  expect_error(generate_X(n = 40, mu = rep(1, 8), sigma = rep("Test-NA", 8)),
               "sigma is not a numeric vector")
})

test_that("Example function output needs to match dimension", {
  expect_equal(dim(generate_X(n = 40, mu = 1:8, sigma = 1:8)),
               c(40, 8))
  expect_true(is.data.frame(generate_X(n = 40, mu = 1:8, sigma = 1:8)))
})

test_that("Mathematical assumptions check", {
  expect_error(generate_X(n = 10.5, mu = 1:8, sigma = 1:8),
               "n must be an integer.")
  expect_error(generate_X(n = -2, mu = 1:8, sigma = 1:8),
               "The parameter n must be a positive integer.")
  expect_error(generate_X(n = 40, mu = 1:8, sigma = c(1:7, -1)),
               "The parameter sigma must contain non-negative numbers")
  expect_error(generate_X(n = 40, mu = 1:8, sigma = c(1:7)),
               "mu and sigma do not have the same length.")
})

