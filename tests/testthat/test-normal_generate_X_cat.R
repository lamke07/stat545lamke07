test_that("Non-redundant (degenerate) inputs for no_cat.",{
  expect_error(generate_X_cat(n = 25, mu = rep(1,10), sigma = rep(1,10), no_of_cat = NULL),
               "no_of_cat must contain at least one entry")
  expect_error(generate_X_cat(n = 25, mu = rep(1,10), sigma = rep(1,10), no_of_cat = c(4, NA)),
               "no_of_cat must be not NA")
  expect_error(generate_X_cat(n = 25, mu = rep(1,10), sigma = rep(1,10), no_of_cat = c(4, 10,5.5)),
               "no_of_cat must contain positive integers.")
  expect_error(generate_X_cat(n = 25, mu = rep(1,10), sigma = rep(1,10), no_of_cat = c(4, 10, -6)),
               "no_of_cat must contain positive integers.")
})

test_that("Check all aspects of the output data frame are correct",{
  expect_true(is.data.frame(generate_X_cat(n = 25, mu = rep(1,10), sigma = rep(1,10), no_of_cat = c(4, 10, 6))))
  expect_equal(dim(generate_X_cat(n = 25, mu = rep(1,10), sigma = rep(1,10), no_of_cat = c(4, 10, 6))),
               c(25, (10+3)))
  expect_true(all(purrr::map_lgl(generate_X_cat()[,c(11,12)], is.factor)))
  expect_true(all(purrr::map_lgl(generate_X_cat()[,1:10], is.numeric)))
})
