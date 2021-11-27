
<!-- README.md is generated from README.Rmd. Please edit that file -->

# stat545lamke07

Note: This package was created as part of the [STAT545B Assignment
4](https://stat545.stat.ubc.ca/assignments/assignment-b4/) submission.

The goal of `stat545lamke07` is to have a collection of functions that
can quickly create toy data sets to test a statistical or machine
learning model on. Many times one is interested in using simulated data,
but these often need to be written out quickly. The `stat545lamke07`
package aims to make this process easier and in an orderly way and
provides simple data sets, including data sets based on the **normal**
distribution and **causal** data sets.

## Installation

You can install the released version of `stat545lamke07` from the
[GitHub repository](https://github.com/lamke07/stat545lamke07) with:

``` r
devtools::install_github("lamke07/stat545lamke07")
```

Note: when using `devtools::check()`, you might need to have `qpdf`
installed locally, otherwise you may run into a warning with the
following message.

> WARNING
>
> ‘qpdf’ is needed for checks on size reduction of PDFs

## Quick Start

This is a basic example which shows you how to solve a common problem:
the `generate_XY()` function creates a data set where *Y* is a linear
combination of the columns in *X*. As such, a linear model on the full
data set is expected to give a perfect fit.

    library(stat545lamke07)

    # Obtain a quick data set S = (X,Y)
    df <- generate_XY()
    print(head(df))

    # Test a linear model
    m1 <- lm(Y ~., data = df)
    summary(m1)

It is possible to specify the **individual parameters** of the normal
distribution for the columns of *X*:

-   *n*: the desired number of data points in the data set. The
    corresponding parameter will be `n`.
-   *μ*: a *p*-dimensional vector of means. This can be any numeric
    vector. The corresponding parameter will be `mu`.
-   *σ*: a *p*-dimensional vector of standard deviations. The values of
    *σ* must be non-negative. The corresponding parameter will be
    `sigma`.
-   *β*: a *p*-dimensional vector of coefficients. This can be any
    numeric vector. The corresponding parameter will be
    `beta_coefficients`.

Below we have given an example of how one could possibly specify the
parameters. We need to make sure that all the dimensions are correct.

    # Obtain a quick data set S = (X,Y)
    df <- generate_XY(n = 1000, mu = 1:10, sigma = 1:10, beta_coefficients = 1:10)
    print(head(df))

    # Test a linear model
    m1 <- lm(Y~ X1 + X2 + X3 + X4, data = df)
    summary(m1)

We have also included functions to create **causal** toy data sets,
`causal_XTY_binary()` and `causal_XTY_multiple()` where the treatment
effect is additive and the relationship between the outcomes *Y* and
covariates *X* is linear.

    # Obtain a quick causal data set.
    df_causal_binary <- causal_XTY_binary()
    print(head(df_causal_binary))

    df_causal_multiple <- causal_XTY_multiple()
    print(head(df_causal_multiple))
