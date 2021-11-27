test_that("Non-redundant (degenerate) inputs for treatment_prob and treatment_effect", {
  expect_error(causal_XTY_binary(n = 40, mu = 1:10, sigma = rep(1, 10), beta_coefficients = 1:10, treatment_prob = NA, treatment_effect = 25),
               "treatment_prob must not be NA")
  expect_error(causal_XTY_binary(n = 40, mu = 1:10, sigma = rep(1, 10), beta_coefficients = 1:10, treatment_prob = c(0.75, 0.25), treatment_effect = 25),
               "treatment_prob must be a single value")
  expect_error(causal_XTY_binary(n = 40, mu = 1:10, sigma = rep(1, 10), beta_coefficients = 1:10, treatment_prob = 1.5, treatment_effect = 25),
               "treatment_prob must be between 0 and 1")
  expect_error(causal_XTY_binary(n = 40, mu = 1:10, sigma = rep(1, 10), beta_coefficients = 1:10, treatment_prob = 0.4, treatment_effect = NA),
               "treatment_effect must not be NA")
  expect_error(causal_XTY_binary(n = 40, mu = 1:10, sigma = rep(1, 10), beta_coefficients = 1:10, treatment_prob = 0.4, treatment_effect = c(25,30)),
               "treatment_effect must be a single value")
  expect_error(causal_XTY_binary(n = 40, mu = 1:10, sigma = rep(1, 10), beta_coefficients = 1:10, treatment_prob = 0.4, treatment_effect = "TEST"),
               "treatment_effect must be numeric")
})

test_that("Example function output needs to match dimension", {
  expect_true(is.data.frame(causal_XTY_binary(n = 40, mu = 1:10, sigma = rep(1, 10), beta_coefficients = 1:10, treatment_prob = 0.75, treatment_effect = 25)))
  expect_equal(dim(causal_XTY_binary(n = 40, mu = 1:10, sigma = rep(1, 10), beta_coefficients = 1:10, treatment_prob = 0.75, treatment_effect = 25)),
               c(40, 14))
})
