#' @title Simulating a normal data set \eqn{S = (X)}.
#'
#' @description Creates a data set \eqn{S = (X)} where the columns of \eqn{X}
#' are sampled from an independent Gaussian distribution with mean \eqn{\mu_i} and
#' standard deviation \eqn{\sigma_i}, i.e. \eqn{N(\mu_i, \sigma_i^2)}.
#' The final dimension will be \eqn{n \times p},
#' with the number of data points \eqn{n} to be specified.
#'
#' @param n desired number of data points in the data set.
#' @param mu a \eqn{p}-dimensional vector of means  for \eqn{\mu}.
#' @param sigma  a \eqn{p}-dimensional vector of non-negative standard deviations for \eqn{\sigma}.
#'
#' @return An \eqn{n \times p} dimensional data frame given by \eqn{S = (X)}.
#' In the base case, the columns \eqn{X_i} are sampled from \eqn{N(0,1)}, \eqn{n = 100} and \eqn{p = 10}.
#' @examples
#' generate_X()
#' generate_X(n = 40, mu = 1:10, sigma = rep(1, 10))
#' @export
generate_X <- function(n = 100, mu = rep(0,10), sigma = rep(1,10)){
  if(any(is.na(n))) stop("n must not be NA")
  if(length(n) != 1) stop("The parameter n must be a single value and not a vector. Supplied n: ", n)
  if(n %% 1 != 0) stop("n must be an integer. Supplied n: ", n)
  if(n <= 0) stop("The parameter n must be a positive integer. Supplied n: ", n)

  if(any(is.na(mu))) stop("mu must not be NA")
  if(any(!is.numeric(mu))) stop("mu is not a numeric vector. Supplied mu: ", mu)

  if(any(is.na(sigma))) stop("sigma must not be NA")
  if(any(!is.numeric(sigma))) stop("sigma is not a numeric vector. Supplied sigma: ", sigma)
  if(any(sigma < 0)) stop("The parameter sigma must contain non-negative numbers. Supplied sigma: ", sigma)

  if(length(mu) != length(sigma)) stop("mu and sigma do not have the same length. Length of mu: ", length(mu), ". Length of sigma: ", length(sigma))

  p = length(mu)

  out <- suppressMessages(purrr::map2_dfc(mu, sigma, ~rnorm(n, .x, .y)))
  colnames(out)[1:p] <- paste0("X", 1:p)

  return(out)
}

#' @title Simulating a normal data set \eqn{S} that includes categorical variables.
#'
#' @description Creates a data set \eqn{S = (X_1, X_2)} where the columns of \eqn{X_1}
#' are sampled from an independent Gaussian distribution with mean \eqn{\mu_i} and
#' standard deviation \eqn{\sigma_i}, i.e. \eqn{N(\mu_i, \sigma_i^2)},
#' and the columns of \eqn{X_2} are categorical, sampled with replacement from a given number of categories (indexed by numbers).
#' The final dimension will be \eqn{n \times (p_1 + p_2)},
#' where \eqn{p_1} is the number of columns in \eqn{X_1} and \eqn{p_2} is the number of columns in \eqn{X_2},
#' with the number of data points \eqn{n} to be specified.
#'
#' @param n desired number of data points in the data set.
#' @param mu a \eqn{p_1}-dimensional vector of means for \eqn{\mu}.
#' @param sigma  a \eqn{p_1}-dimensional vector of non-negative standard deviations for \eqn{\sigma}.
#' @param no_of_cat a \eqn{p_2}-dimensional vector where the entries indicate the number of categories desired for each column of \eqn{X_2}.
#'
#' @return An \eqn{n \times p} dimensional data frame given by \eqn{S = (X_1, X_2)}.
#' In the base case, the columns of \eqn{X_1} are sampled from \eqn{N(0,1)}, \eqn{n = 100} and \eqn{p = 10},
#' and two additional categorical columns of \eqn{X_2} are added.
#' @examples
#' generate_X_cat()
#' generate_X_cat(n = 40, mu = 1:10, sigma = rep(1, 10), no_of_cat = c(2,3))
#' @export
generate_X_cat <- function(n = 100, mu = rep(0,10), sigma = rep(1,10), no_of_cat = c(4,5)){
  if(any(is.na(no_of_cat))) stop("no_of_cat must be not NA")
  if(length(no_of_cat) < 1) stop("no_of_cat must contain at least one entry")
  if(any(no_of_cat %% 1 != 0) | any(no_of_cat <= 0)) stop("no_of_cat must contain positive integers. Supplied no_of_cat: ", no_of_cat)

  # Generate standard data set
  out <- generate_X(n = n, mu = mu, sigma = sigma)
  p <- ncol(out)

  # Add categorical variables
  out_cat <- suppressMessages(purrr::map_dfc(no_of_cat, ~sample(LETTERS[1:(.x)], n, replace = TRUE))) %>%
    dplyr::mutate(dplyr::across(dplyr::everything(), factor))
  colnames(out_cat) <- paste0("X", (p+1):(p+length(no_of_cat)))

  return(dplyr::bind_cols(out, out_cat))
}


#' @title Simulating a normal data set \eqn{S = (X,Y)}, where \eqn{Y = X^T \beta}.
#'
#' @description Creates a data set \eqn{S = (X,Y)} where the columns of \eqn{X}
#' are sampled from an independent Gaussian distribution with mean \eqn{\mu_i} and
#' standard deviation \eqn{\sigma_i}, i.e. \eqn{N(\mu_i, \sigma_i^2)}. The response \eqn{Y}
#' is given by \eqn{Y = X\beta}. The final dimension will be \eqn{n \times (p + 1)},
#' with the number of data points \eqn{n} to be specified.
#'
#' @param n desired number of data points in the data set.
#' @param mu a \eqn{p}-dimensional vector of means  for \eqn{\mu}.
#' @param sigma  a \eqn{p}-dimensional vector of non-negative standard deviations for \eqn{\sigma}.
#' @param beta_coefficients a \eqn{p}-dimensional vector of coefficients for \eqn{\beta}.
#'
#' @return An \eqn{n \times (p+1)} dimensional data frame given by \eqn{S = (X,Y)}.
#' In the base case, the columns \eqn{X_i} are sampled from \eqn{N(0,1)} and the coefficients are all 1.
#' We also have \eqn{n = 100} and \eqn{p = 10}, with beta-coefficients 1 to 10.
#' @examples
#' generate_XY()
#' generate_XY(n = 40, mu = 1:10, sigma = rep(1, 10), beta_coefficients = 1:10)
#' @export
generate_XY <- function(n = 100, mu = rep(0, 10), sigma = rep(1,10), beta_coefficients = 1:10){
  if(any(is.na(beta_coefficients))) stop("beta_coefficients must not be NA")
  if(any(!is.numeric(beta_coefficients))) stop("beta_coefficients is not a numeric vector. Supplied beta_coefficients: ", beta_coefficients)

  if(length(mu) != length(beta_coefficients)) stop("mu and beta_coefficients do not have the same length. Length of mu: ", length(mu), ". Length of beta_coefficients: ", length(beta_coefficients))

  # Generate standard data set
  out <- generate_X(n = n, mu = mu, sigma = sigma)

  # Compute outcomes Y
  Y = as.vector(as.matrix(out) %*% beta_coefficients)

  # Combine the data frame with the outcomes
  out <- dplyr::mutate(out, Y = Y)

  return(out)
}
