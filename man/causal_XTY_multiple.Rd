% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/generate_causal.R
\name{causal_XTY_multiple}
\alias{causal_XTY_multiple}
\title{Simulating a causal data set \eqn{S = (X,Y_i, T, Y_{obs})} with multiple potential outcomes.}
\usage{
causal_XTY_multiple(
  n = 100,
  mu = rep(0, 3),
  sigma = rep(1, 3),
  beta_coefficients = 1:3,
  treatment_prob = rep(0.25, 4),
  treatment_effect = c(10, 20, 30, 40)
)
}
\arguments{
\item{n}{desired number of data points in the data set.}

\item{mu}{a \eqn{p}-dimensional vector of means  for \eqn{\mu}.}

\item{sigma}{a \eqn{p}-dimensional vector of non-negative standard deviations for \eqn{\sigma}.}

\item{beta_coefficients}{a \eqn{p}-dimensional vector of coefficients for \eqn{\beta}.}

\item{treatment_prob}{a probability vector with weights summing to 1, corresponding to the probability of treatment.}

\item{treatment_effect}{a vector corresponding to the additive treatment effect of each treatment on the outcome \eqn{Y}.}
}
\value{
A causal data set \eqn{S = (X,Y_i, T, Y_{obs})} with multiple potential outcomes.
In the default case, the \eqn{p} columns \eqn{X_i} are sampled from \eqn{N(0,1)}, with \eqn{beta}-coefficients 1 to 3 for the base outcome \eqn{Y}.
We also have \eqn{n = 100}, \eqn{p = 3}, where \eqn{p} corresponds to the number of columns in \eqn{X}.
The treatment probabilities are equally likely.
}
\description{
Creates a causal data set \eqn{S = (X, Y_i, T, Y_{obs})} for causal inference.
The \eqn{p} columns of \eqn{X} are sampled from an independent Gaussian distribution with mean \eqn{\mu_i} with
standard deviation \eqn{\sigma_i}, i.e. \eqn{N(\mu_i, \sigma_i^2)}.
A treatment \eqn{T} is sampled, where more than 2 treatments are possible.
The observations \eqn{Y_i} correspond to the outcome if the treatment \eqn{i} is applied.
The outcome \eqn{Y = X^T \beta} is assumed to depend on \eqn{X} in a linear fashion, and the
treatment effect of treatment \eqn{T = i} is additive.
See Causality (Pearl 2009) for further details and a general introduction to causal inference.
}
\examples{
causal_XTY_multiple()

causal_XTY_multiple(n = 40, mu = rep(2, 7), sigma = 1:7,
                    beta_coefficients = 1:7,
                    treatment_prob = c(0.4, 0.1, 0.1, 0.2, 0.2),
                    treatment_effect = 1:5)
}
