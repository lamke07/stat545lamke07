test_that("Non-redundant (degenerate) inputs for treatment_prob and treatment_effect", {
  expect_error(causal_XTY_multiple(n = 40, mu = 1:10, sigma = rep(1, 10), beta_coefficients = 1:10, treatment_prob = c(NA, 0.25, 0.75), treatment_effect = c(1,2,3)),
               "treatment_prob must not be NA")
  expect_error(causal_XTY_multiple(n = 40, mu = 1:10, sigma = rep(1, 10), beta_coefficients = 1:10, treatment_prob = numeric(0), treatment_effect = c(1,2,3)),
               "Vector of probabilities must have at least 1 entry.")
  expect_error(causal_XTY_multiple(n = 40, mu = 1:10, sigma = rep(1, 10), beta_coefficients = 1:10, treatment_prob = c("TEST", 0.25, 0.75), treatment_effect = c(1,2,3)),
               "treatment_prob must be numeric.")
  expect_error(causal_XTY_multiple(n = 40, mu = 1:10, sigma = rep(1, 10), beta_coefficients = 1:10, treatment_prob = c(3, 0.25, 0.75), treatment_effect = c(1,2,3)),
               "treatment_prob must sum to 1")
  expect_error(causal_XTY_multiple(n = 40, mu = 1:10, sigma = rep(1, 10), beta_coefficients = 1:10, treatment_prob = c(0.25, 0.25, 0.5), treatment_effect = c(NA, 20, 30)),
               "treatment_effect must not be NA")
  expect_error(causal_XTY_multiple(n = 40, mu = 1:10, sigma = rep(1, 10), beta_coefficients = 1:10, treatment_prob = c(0.25, 0.25, 0.5), treatment_effect = c("TEST", 30, 50)),
               "treatment_effect must be numeric")
  expect_error(causal_XTY_multiple(n = 40, mu = 1:10, sigma = rep(1, 10), beta_coefficients = 1:10, treatment_prob = c(0.25, 0.25, 0.5), treatment_effect = c(30, 50)),
               "treatment_effect and treatment_prob must have the same dimension.")
})

test_that("Example function output needs to match dimension", {
  expect_true(is.data.frame(causal_XTY_multiple(n = 40, mu = rep(2, 7), sigma = 1:7, beta_coefficients = 1:7, treatment_prob = c(0.4, 0.1, 0.1, 0.2, 0.2), treatment_effect = 1:5)))
  expect_equal(dim(causal_XTY_multiple(n = 40, mu = rep(2, 7), sigma = 1:7, beta_coefficients = 1:7, treatment_prob = c(0.4, 0.1, 0.1, 0.2, 0.2), treatment_effect = 1:5)),
               c(40, 15))
})
