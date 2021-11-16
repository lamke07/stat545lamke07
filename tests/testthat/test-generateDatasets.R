test_that("Non-redundant (degenerate) inputs for mu, sigma, and beta.", {
  expect_error(generate_XY(n = 40, mu = c(NA, rep(1, 7)), sigma = 1:8, beta_coefficients = sample(1:50, 8)),
               "mu must not be NA")
  expect_error(generate_XY(n = 40, mu = rep(1, 8), sigma = rep("Test-NA", 8), beta_coefficients = sample(1:50, 8)),
               "sigma is not a numeric vector")
  expect_error(generate_XY(n = 40, mu = rep(1, 8), sigma = 1:8, beta_coefficients = vector("numeric", 0)),
               "mu and beta_coefficients do not have the same length")
})

test_that("Example function output needs to match dimension", {
  expect_equal(dim(generate_XY(n = 40, mu = 1:8, sigma = 1:8, beta_coefficients = sample(1:50, 8))),
               c(40, 9))
  expect_equal(is.data.frame(generate_XY(n = 40, mu = 1:8, sigma = 1:8, beta_coefficients = sample(1:50, 8))),
               TRUE)
})

test_that("Mathematical assumptions check", {
  expect_error(generate_XY(n = 10.5, mu = 1:8, sigma = 1:8, beta_coefficients = sample(1:50, 8)),
               "n must be an integer.")
  expect_error(generate_XY(n = -2, mu = 1:8, sigma = 1:8, beta_coefficients = sample(1:50, 8)),
               "The parameter n must be a positive integer.")
  expect_error(generate_XY(n = 40, mu = 1:8, sigma = c(1:7, -1), beta_coefficients = sample(1:50, 8)),
               "The parameter sigma must contain non-negative numbers")
  expect_error(generate_XY(n = 40, mu = 1:8, sigma = c(1:7), beta_coefficients = sample(1:50, 8)),
               "mu and sigma do not have the same length.")
})
