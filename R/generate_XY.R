#' @title Simulating a data set \eqn{S = (X,Y)}, where \eqn{Y = X*beta}.
#'
#' @description Creates a data set \eqn{S = (X,Y)} where the columns of \eqn{X}
#' are sampled from an independent Gaussian distribution with mean \eqn{mu_i} and
#' standard deviation \eqn{sigma_i}, i.e. \eqn{N(\mu_i, \sigma_i)}. The response \eqn{Y}
#' is given by \eqn{Y = X\beta}. The final dimension will be \eqn{n \times (p + 1)},
#' with the number of data points \eqn{n} to be specified.
#'
#' @param n desired number of data points in the data set.
#' @param mu a \eqn{p}-dimensional vector of means
#' @param sigma  a \eqn{p}-dimensional vector of non-negative standard deviations
#' @param beta_coefficients a \eqn{p}-dimensional vector of coefficients
#'
#' @return An \eqn{n \times (p+1)} dimensional data frame given by \eqn{S = (X,Y)}.
#' In the base case, the columns \eqn{X_i} are sampled from \eqn{N(0,1)} and the coefficients are all 1.
#' We also have \eqn{n = 100} and \eqn{p = 10}.
#' @examples
#' generate_XY()
#' generate_XY(n = 40, mu = 1:10, sigma = rep(1, 10), beta_coefficients = 1:10)
#' @export
generate_XY <- function(n = 100, mu = rep(0, 10), sigma = rep(1,10), beta_coefficients = 1:10){
  if(any(is.na(n))) stop("n must not be NA")
  if(length(n) != 1) stop("The parameter n must be a single value and not a vector. Supplied n: ", n)
  if(n %% 1 != 0) stop("n must be an integer. Supplied n: ", n)
  if(n <= 0) stop("The parameter n must be a positive integer. Supplied n: ", n)

  if(any(is.na(mu))) stop("mu must not be NA")
  if(any(!is.numeric(mu))) stop("mu is not a numeric vector. Supplied mu: ", mu)

  if(any(is.na(beta_coefficients))) stop("beta_coefficients must not be NA")
  if(any(!is.numeric(beta_coefficients))) stop("beta_coefficients is not a numeric vector. Supplied beta_coefficients: ", beta_coefficients)

  if(any(is.na(sigma))) stop("sigma must not be NA")
  if(any(!is.numeric(sigma))) stop("sigma is not a numeric vector. Supplied sigma: ", sigma)
  if(any(sigma < 0)) stop("The parameter sigma must contain non-negative numbers. Supplied sigma: ", sigma)

  if(length(mu) != length(sigma)) stop("mu and sigma do not have the same length. Length of mu: ", length(mu), ". Length of sigma: ", length(sigma))
  if(length(mu) != length(beta_coefficients)) stop("mu and beta_coefficients do not have the same length. Length of mu: ", length(mu), ". Length of beta_coefficients: ", length(beta_coefficients))

  p = length(mu)

  out <- purrr::map2_dfc(mu, sigma, ~rnorm(n, .x, .y))
  colnames(out)[1:p] <- paste0("X", 1:p)

  Y = as.vector(as.matrix(out) %*% beta_coefficients)

  out <- dplyr::mutate(out, Y = Y)

  return(out)
}
