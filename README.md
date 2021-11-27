
<!-- README.md is generated from README.Rmd. Please edit that file -->

# stat545lamke07

<!-- badges: start -->
<!-- badges: end -->

The goal of `stat545lamke07` is to have a collection of functions that
can quickly create toy data sets to test a statistical or machine
learning model on. Many times one is interested in using simulated data,
but these often need to be written out quickly. The `stat545lamke07`
package aims to make this process easier and in an orderly way and
provides simple data sets, including **causal** data sets.

## Installation

You can install the released version of `stat545lamke07` from the
[GitHub repository](https://github.com/lamke07/stat545lamke07) with:

``` r
devtools::install_github("lamke07/stat545lamke07")
```

## Basic Examples

This is a basic example which shows you how to solve a common problem:
the `generate_XY` function creates a data set where *Y* is a linear
combination of the columns in *X*. As such, a linear model on the full
data set is expected to give a perfect fit.

``` r
library(stat545lamke07)

# Obtain a quick data set S = (X,Y)
df <- generate_XY()
print(head(df))
#> # A tibble: 6 × 11
#>        X1     X2     X3      X4       X5      X6      X7     X8     X9    X10
#>     <dbl>  <dbl>  <dbl>   <dbl>    <dbl>   <dbl>   <dbl>  <dbl>  <dbl>  <dbl>
#> 1  0.557  -0.861 -0.837  0.0513 -1.43     0.0750 -1.65   -0.648  0.818 -1.16 
#> 2  0.739  -1.18  -0.387 -0.889   0.0598   0.883  -0.400  -0.919 -1.49   0.584
#> 3 -0.937   0.581 -0.492 -0.422  -0.213    1.11   -2.00    1.29   0.107  0.115
#> 4 -0.0604 -1.95   0.381 -0.456   0.00116  0.295  -0.0171  1.33   0.497  0.144
#> 5  0.229  -0.867 -0.790  0.0674 -0.567   -0.222  -1.66   -0.265  1.86   0.329
#> 6 -0.797   0.453 -0.268 -1.06    0.213    1.04    0.880   0.203 -0.231  0.389
#> # … with 1 more variable: Y <dbl>

# Test a linear model
m1 <- lm(Y ~., data = df)
summary(m1)
#> Warning in summary.lm(m1): essentially perfect fit: summary may be unreliable
#> 
#> Call:
#> lm(formula = Y ~ ., data = df)
#> 
#> Residuals:
#>        Min         1Q     Median         3Q        Max 
#> -4.973e-14 -4.549e-15 -3.840e-16  3.644e-15  5.054e-14 
#> 
#> Coefficients:
#>               Estimate Std. Error    t value Pr(>|t|)    
#> (Intercept) -1.861e-15  1.400e-15 -1.329e+00    0.187    
#> X1           1.000e+00  1.368e-15  7.310e+14   <2e-16 ***
#> X2           2.000e+00  1.352e-15  1.479e+15   <2e-16 ***
#> X3           3.000e+00  1.491e-15  2.012e+15   <2e-16 ***
#> X4           4.000e+00  1.331e-15  3.005e+15   <2e-16 ***
#> X5           5.000e+00  1.262e-15  3.963e+15   <2e-16 ***
#> X6           6.000e+00  1.310e-15  4.580e+15   <2e-16 ***
#> X7           7.000e+00  1.171e-15  5.978e+15   <2e-16 ***
#> X8           8.000e+00  1.266e-15  6.319e+15   <2e-16 ***
#> X9           9.000e+00  1.220e-15  7.376e+15   <2e-16 ***
#> X10          1.000e+01  1.551e-15  6.449e+15   <2e-16 ***
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
#> 
#> Residual standard error: 1.246e-14 on 89 degrees of freedom
#> Multiple R-squared:      1,  Adjusted R-squared:      1 
#> F-statistic: 1.962e+31 on 10 and 89 DF,  p-value: < 2.2e-16
```

It is possible to specify the individual parameters of the normal
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

``` r
# Obtain a quick data set S = (X,Y)
df <- generate_XY(n = 1000, mu = 1:10, sigma = 1:10, beta_coefficients = 1:10)
print(head(df))
#> # A tibble: 6 × 11
#>      X1    X2    X3    X4     X5    X6    X7     X8     X9    X10     Y
#>   <dbl> <dbl> <dbl> <dbl>  <dbl> <dbl> <dbl>  <dbl>  <dbl>  <dbl> <dbl>
#> 1  1.87  1.31  7.70  6.33 -7.89   6.94 19.0    1.13  -6.19 15.0    291.
#> 2  2.73  2.14  2.74 13.8  -0.182  1.26 17.2    8.89  -1.81  3.39   286.
#> 3  1.76  3.47  1.96  2.30 11.7    4.77  8.59  12.8   18.0  16.0    596.
#> 4  1.50  2.96  3.94  5.35 11.8    2.10 13.8   -1.81   2.32  0.329  218.
#> 5  1.18  1.16  4.91  5.81 10.0    3.08 -1.34 -12.1  -16.1  -0.521 -146.
#> 6  2.07  2.20  8.92  8.47 12.2    5.92  3.91   1.40   8.12 17.1    446.

# Test a linear model
m1 <- lm(Y~ X1 + X2 + X3 + X4, data = df)
summary(m1)
#> 
#> Call:
#> lm(formula = Y ~ X1 + X2 + X3 + X4, data = df)
#> 
#> Residuals:
#>     Min      1Q  Median      3Q     Max 
#> -555.37  -93.34   -3.90  101.38  473.32 
#> 
#> Coefficients:
#>             Estimate Std. Error t value Pr(>|t|)    
#> (Intercept)  354.487     10.736  33.019  < 2e-16 ***
#> X1            -6.059      4.623  -1.311 0.190317    
#> X2             6.929      2.467   2.809 0.005066 ** 
#> X3             5.460      1.565   3.489 0.000506 ***
#> X4             4.630      1.184   3.912 9.79e-05 ***
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
#> 
#> Residual standard error: 152.1 on 995 degrees of freedom
#> Multiple R-squared:  0.0371, Adjusted R-squared:  0.03323 
#> F-statistic: 9.584 on 4 and 995 DF,  p-value: 1.32e-07
```

We have also included an option to create causal toy data sets.

``` r
# Obtain a quick causal data set.
df <- causal_XTY_binary()
print(head(df))
#> # A tibble: 6 × 8
#>        X1     X2     X3       X4 treatment     Y0    Y1 Y_observed
#>     <dbl>  <dbl>  <dbl>    <dbl>     <dbl>  <dbl> <dbl>      <dbl>
#> 1 -0.0373  2.38  -0.304 -0.743           1  0.840 10.8       10.8 
#> 2  0.180   1.29  -0.528  0.0370          0  1.31  11.3        1.31
#> 3  0.499   0.740 -0.631  0.00653         1  0.113 10.1       10.1 
#> 4 -0.610  -1.54   1.07  -1.24            0 -5.45   4.55      -5.45
#> 5 -1.89   -0.201  1.82   0.236           0  4.10  14.1        4.10
#> 6  0.670   1.01  -0.618 -0.844           1 -2.54   7.46       7.46
```
