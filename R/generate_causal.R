#' @title Simulating a causal data set \eqn{S = (X,T,Y_0, Y_1, Y_{obs})} with potential outcomes.
#'
#' @description Creates a causal data set \eqn{S = (X,T,Y_0, Y_1, Y_{obs})} for causal inference.
#' The \eqn{p} columns of \eqn{X} are sampled from an independent Gaussian distribution with mean \eqn{\mu_i} with
#' standard deviation \eqn{\sigma_i}, i.e. \eqn{N(\mu_i, \sigma_i^2)}.
#' A binary treatment \eqn{T} taking values 0 or 1 is sampled with probability \eqn{p_{treatment}}.
#' The observations \eqn{Y_0, Y_1} correspond to the outcome if the treatment \eqn{T} is 0 or 1, respectively,
#' while \eqn{T} is the actual treatment observed and corresponds to \eqn{Y_{observed}}.
#' The outcome \eqn{Y} is assumed to depend on \eqn{X} in a linear fashion,
#' so the average treatment effect can be pre-specified to obtain the right data set.
#' See Causality (Pearl 2009) for further details and a general introduction to causal inference.
#' @param n desired number of data points in the data set.
#' @param mu a \eqn{p}-dimensional vector of means  for \eqn{\mu}.
#' @param sigma  a \eqn{p}-dimensional vector of non-negative standard deviations for \eqn{\sigma}.
#' @param beta_coefficients a \eqn{p}-dimensional vector of coefficients for \eqn{\beta}.
#' @param treatment_prob a probability between 0 and 1 specifying the probability of treatment assignment \eqn{p_{treatment}}.
#' @param treatment_effect the average treatment between two potential outcomes \eqn{Y_0} and \eqn{Y_1}.
#'
#' @return A causal data set \eqn{S = (X,T,Y_0, Y_1, Y_{obs})}.
#' In the base case, the columns \eqn{X_i} are sampled from \eqn{N(0,1)} and the coefficients are all 1.
#' We also have \eqn{n = 100}, \eqn{p = 4}, with beta-coefficients 1 to 10.
#' The treatment probability is 0.5 (i.e. a coin flip), with the default average treatment effect being 10.
#' @examples
#' causal_XTY_binary()
#' causal_XTY_binary(n = 40, mu = 1:10, sigma = rep(1, 10),
#'                   beta_coefficients = 1:10, treatment_prob = 0.75, treatment_effect = 25)
#' @importFrom rlang .data
#' @export
causal_XTY_binary <- function(n = 100, mu = rep(0, 4), sigma = rep(1,4), beta_coefficients = 1:4, treatment_prob = 0.5, treatment_effect = 10){
  if(length(treatment_prob) != 1) stop("treatment_prob must be a single value. Supplied treatment_prob: ", treatment_prob)
  if(is.na(treatment_prob)) stop("treatment_prob must not be NA")
  if(!is.numeric(treatment_prob)) stop("treatment_prob must be numeric. Supplied treatment_prob: ", treatment_prob)
  if(treatment_prob <= 0 | treatment_prob >= 1) stop("treatment_prob must be between 0 and 1. treatment_prob supplied: ", treatment_prob)

  if(length(treatment_effect) != 1) stop("treatment_effect must be a single value. Supplied treatment_effect: ", treatment_effect)
  if(is.na(treatment_effect)) stop("treatment_effect must not be NA")
  if(!is.numeric(treatment_effect)) stop("treatment_effect must be numeric. Supplied treatment_effect: ", treatment_effect)

  # Generate standard data set
  out <- generate_XY(n, mu, sigma, beta_coefficients)

  # Add potential outcomes and treatment assignment
  out <- out %>%
    dplyr::mutate(Y0 = .data$Y,
                  Y1 = .data$Y0 + treatment_effect) %>%
    dplyr::mutate(treatment = sample(c(0,1), n, replace = TRUE, prob = c(1-treatment_prob, treatment_prob)),
                  Y_observed = ifelse(.data$treatment, .data$Y1, .data$Y0)) %>%
    dplyr::relocate("treatment", .before = "Y0") %>%
    dplyr::select(-c("Y"))

  return(out)
}

#' @title Simulating a causal data set \eqn{S = (X,Y_i, T, Y_{obs})} with multiple potential outcomes.
#'
#' @description Creates a causal data set \eqn{S = (X, Y_i, T, Y_{obs})} for causal inference.
#' The \eqn{p} columns of \eqn{X} are sampled from an independent Gaussian distribution with mean \eqn{\mu_i} with
#' standard deviation \eqn{\sigma_i}, i.e. \eqn{N(\mu_i, \sigma_i^2)}.
#' A treatment \eqn{T} is sampled, where more than 2 treatments are possible.
#' The observations \eqn{Y_i} correspond to the outcome if the treatment \eqn{i} is applied.
#' The outcome \eqn{Y} is assumed to depend on \eqn{X} in a linear fashion, and the
#' treatment effect of treatment \eqn{i} is additive.
#' See Causality (Pearl 2009) for further details and a general introduction to causal inference.
#' @param n desired number of data points in the data set.
#' @param mu a \eqn{p}-dimensional vector of means  for \eqn{\mu}.
#' @param sigma  a \eqn{p}-dimensional vector of non-negative standard deviations for \eqn{\sigma}.
#' @param beta_coefficients a \eqn{p}-dimensional vector of coefficients for \eqn{\beta}.
#' @param treatment_prob a probability vector with weights summing to 1, corresponding to the probability of treatment.
#' @param treatment_effect a vector corresponding to the additive treatment effect of each treatment on the outcome \eqn{Y}.
#'
#' @return A causal data set \eqn{S = (X,Y_i, T, Y_{obs})} with multiple potential outcomes.
#' In the base case, the columns \eqn{X_i} are sampled from \eqn{N(0,1)} and the coefficients are all 1.
#' We also have \eqn{n = 100}, \eqn{p = 4}, with beta-coefficients 1 to 10, where \eqn{p} corresponds to the number of columns in \eqn{X}.
#' The treatment probabilities are equally likely.
#' @examples
#' causal_XTY_multiple()
#' causal_XTY_multiple(n = 40, mu = rep(2, 7), sigma = 1:7,
#'                     beta_coefficients = 1:7,
#'                     treatment_prob = c(0.4, 0.1, 0.1, 0.2, 0.2),
#'                     treatment_effect = 1:5)
#' @importFrom rlang .data
#' @export
causal_XTY_multiple <- function(n = 100, mu = rep(0, 4), sigma = rep(1,4), beta_coefficients = 1:4, treatment_prob = rep(0.25, 4), treatment_effect = c(10, 20, 30, 40)){
  if(any(is.na(treatment_prob))) stop("treatment_prob must not be NA")
  if(any(!is.numeric(treatment_prob))) stop("treatment_prob must be numeric. Supplied treatment_prob: ", treatment_prob)
  if(length(treatment_prob) < 1) stop("Vector of probabilities must have at least 1 entry. Supplied length: ", length(treatment_prob))
  if(sum(treatment_prob) != 1) stop("treatment_prob must sum to 1. Sum of input probabilities:", sum(treatment_prob))

  if(any(is.na(treatment_effect))) stop("treatment_effect must not be NA")
  if(any(!is.numeric(treatment_effect))) stop("treatment_effect must be numeric. Supplied treatment_effect: ", treatment_effect)

  if(length(treatment_effect) != length(treatment_prob)) {
    stop("treatment_effect and treatment_prob must have the same dimension. Supplied dimensions: ", length(treatment_effect), " and ", length(treatment_prob))
    }

  # Generate standard data set
  out <- generate_XY(n, mu, sigma, beta_coefficients)

  # Generate potential treatment outcomes
  p <- length(treatment_effect)
  out_treatments <- suppressMessages(purrr::map_dfc(treatment_effect, ~.x + dplyr::select(out, Y)))
  colnames(out_treatments)[1:p] <- paste0("Y", 1:p)

  # Combine the data set and sample the chosen treatment
  out <- out %>%
    dplyr::bind_cols(out_treatments) %>%
    dplyr::mutate(treatment = sample(1:p, n, replace = TRUE, prob = treatment_prob),
                  Y_observed = .data$Y + treatment_effect[.data$treatment])

  return(out)
}
