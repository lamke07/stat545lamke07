
<!-- README.md is generated from README.Rmd. Please edit that file -->

# stat545lamke07

<!-- badges: start -->
<!-- badges: end -->

The goal of `stat545lamke07` is to have a collection of functions that
can quickly create toy data sets to test their statistical or machine
learning model on. Many times one is interested in using simulated data,
but these often need to be written out quickly. The `stat545lamke07`
package therefore aims to make this process easier and in an orderly
way.

## Installation

You can install the released version of `stat545lamke07` from the
[GitHub repository](https://github.com/lamke07/stat545lamke07) with:

``` r
devtools::install_github("lamke07/stat545lamke07")
```

## Example

This is a basic example which shows you how to solve a common problem:
the `generate_XY` function creates a data set where *Y* is a linear
combination of the columns in *X*. As such, a linear model on the full
data set is expected to give a perfect fit.

``` r
library(stat545lamke07)

# Obtain a quick data set S = (X,Y)
df <- generate_XY()
#> New names:
#> * NA -> ...1
#> * NA -> ...2
#> * NA -> ...3
#> * NA -> ...4
#> * NA -> ...5
#> * ...
print(head(df))
#> # A tibble: 6 × 11
#>        X1     X2     X3      X4     X5     X6      X7      X8     X9     X10
#>     <dbl>  <dbl>  <dbl>   <dbl>  <dbl>  <dbl>   <dbl>   <dbl>  <dbl>   <dbl>
#> 1 -0.959   0.324  1.02   1.73    0.350 -0.682 -0.488  -0.416  -0.121 -0.0838
#> 2  0.285   0.461 -1.31  -0.0733 -1.51   0.507 -1.93   -0.0885 -0.480  0.0721
#> 3 -1.58   -0.899 -0.228  0.136   0.853  0.553  1.71   -1.28   -1.22  -0.106 
#> 4  0.995  -1.35   1.23  -0.177  -0.800 -0.758  0.0763 -2.47    1.17   1.71  
#> 5  0.0477 -1.26  -0.793 -1.32    2.14  -1.13   1.47    1.07    0.363 -0.855 
#> 6  0.632   1.01  -1.51  -1.27   -0.196  0.263 -0.431  -2.24    0.503 -0.384 
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
#> -5.152e-14 -2.938e-15  4.720e-16  2.568e-15  3.816e-14 
#> 
#> Coefficients:
#>              Estimate Std. Error   t value Pr(>|t|)    
#> (Intercept) 2.309e-16  1.078e-15 2.140e-01    0.831    
#> X1          1.000e+00  1.041e-15 9.608e+14   <2e-16 ***
#> X2          2.000e+00  1.096e-15 1.825e+15   <2e-16 ***
#> X3          3.000e+00  9.664e-16 3.104e+15   <2e-16 ***
#> X4          4.000e+00  1.167e-15 3.427e+15   <2e-16 ***
#> X5          5.000e+00  1.003e-15 4.985e+15   <2e-16 ***
#> X6          6.000e+00  1.094e-15 5.486e+15   <2e-16 ***
#> X7          7.000e+00  9.948e-16 7.036e+15   <2e-16 ***
#> X8          8.000e+00  1.033e-15 7.746e+15   <2e-16 ***
#> X9          9.000e+00  1.117e-15 8.057e+15   <2e-16 ***
#> X10         1.000e+01  9.435e-16 1.060e+16   <2e-16 ***
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
#> 
#> Residual standard error: 9.834e-15 on 89 degrees of freedom
#> Multiple R-squared:      1,  Adjusted R-squared:      1 
#> F-statistic: 3.556e+31 on 10 and 89 DF,  p-value: < 2.2e-16
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
#> New names:
#> * NA -> ...1
#> * NA -> ...2
#> * NA -> ...3
#> * NA -> ...4
#> * NA -> ...5
#> * ...
print(head(df))
#> # A tibble: 6 × 11
#>        X1      X2    X3    X4     X5     X6    X7    X8    X9   X10     Y
#>     <dbl>   <dbl> <dbl> <dbl>  <dbl>  <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
#> 1  1.72    3.50    4.10 13.0   4.04   6.52  13.7   7.85  8.80  4.65  416.
#> 2 -0.111  -0.0107  6.81 10.7   2.38   4.36  10.7  14.6  33.8  16.9   766.
#> 3  1.79    2.82    1.32  2.03  8.59  -0.817 27.0   9.56  6.26 23.7   616.
#> 4  1.73    2.92    3.46  6.70 11.8   10.6   11.7   6.57 12.2  19.0   602.
#> 5  1.38    1.31   -1.72 10.3   7.21  12.4    1.55 11.6   7.67 30.3   626.
#> 6 -0.0196 -2.00    3.48 -4.33  0.204  8.35  -6.13  5.92 14.8  20.7   385.
# Test a linear model
m1 <- lm(Y~ X1 + X2 + X3 + X4, data = df)
summary(m1)
#> 
#> Call:
#> lm(formula = Y ~ X1 + X2 + X3 + X4, data = df)
#> 
#> Residuals:
#>     Min      1Q  Median      3Q     Max 
#> -440.32 -105.70    6.91  109.23  518.74 
#> 
#> Coefficients:
#>              Estimate Std. Error t value Pr(>|t|)    
#> (Intercept) 337.83966   11.36361  29.730  < 2e-16 ***
#> X1            0.43097    5.15133   0.084 0.933342    
#> X2           -0.03494    2.62661  -0.013 0.989390    
#> X3            6.48880    1.71490   3.784 0.000164 ***
#> X4            5.01797    1.27892   3.924 9.32e-05 ***
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
#> 
#> Residual standard error: 160.6 on 995 degrees of freedom
#> Multiple R-squared:  0.02881,    Adjusted R-squared:  0.02491 
#> F-statistic: 7.379 on 4 and 995 DF,  p-value: 7.405e-06
```
