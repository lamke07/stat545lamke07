
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
print(head(df))
#> # A tibble: 6 × 11
#>         X1      X2     X3     X4     X5       X6     X7      X8      X9     X10
#>      <dbl>   <dbl>  <dbl>  <dbl>  <dbl>    <dbl>  <dbl>   <dbl>   <dbl>   <dbl>
#> 1 -0.161    0.0708  1.01   0.864  1.28   1.06     0.565 -0.508   0.703   1.01  
#> 2 -0.557    0.342  -0.695  1.82  -0.561 -0.138   -1.33  -1.74   -0.0868  0.615 
#> 3  0.583    0.575  -2.11  -1.30   1.05  -0.00676  0.139  0.636   0.163  -0.659 
#> 4 -0.806    1.17    0.719  1.67   0.109  0.196   -0.490  0.217  -0.114   0.0797
#> 5  0.00819 -0.836  -1.21  -0.318  0.821  0.390   -1.15  -0.0418  0.684   0.240 
#> 6  0.0694  -2.61   -0.160  1.23  -0.150 -0.989    0.507 -0.140   1.51   -0.143 
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
#> -6.014e-14 -1.561e-15  1.621e-15  3.786e-15  2.552e-14 
#> 
#> Coefficients:
#>               Estimate Std. Error    t value Pr(>|t|)    
#> (Intercept) -5.389e-16  9.713e-16 -5.550e-01     0.58    
#> X1           1.000e+00  1.103e-15  9.063e+14   <2e-16 ***
#> X2           2.000e+00  1.067e-15  1.874e+15   <2e-16 ***
#> X3           3.000e+00  1.095e-15  2.741e+15   <2e-16 ***
#> X4           4.000e+00  9.824e-16  4.072e+15   <2e-16 ***
#> X5           5.000e+00  9.915e-16  5.043e+15   <2e-16 ***
#> X6           6.000e+00  1.051e-15  5.707e+15   <2e-16 ***
#> X7           7.000e+00  1.007e-15  6.951e+15   <2e-16 ***
#> X8           8.000e+00  1.018e-15  7.857e+15   <2e-16 ***
#> X9           9.000e+00  9.233e-16  9.747e+15   <2e-16 ***
#> X10          1.000e+01  1.033e-15  9.684e+15   <2e-16 ***
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
#> 
#> Residual standard error: 9.388e-15 on 89 degrees of freedom
#> Multiple R-squared:      1,  Adjusted R-squared:      1 
#> F-statistic: 4.133e+31 on 10 and 89 DF,  p-value: < 2.2e-16
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
#>       X1    X2    X3    X4     X5     X6     X7      X8    X9    X10     Y
#>    <dbl> <dbl> <dbl> <dbl>  <dbl>  <dbl>  <dbl>   <dbl> <dbl>  <dbl> <dbl>
#> 1  2.04  2.56  4.53   8.74  8.69  -4.37  10.9     8.52   6.98  8.99   370.
#> 2  2.05  0.135 2.70  -6.85  8.43  10.4   10.8     9.75  10.7  20.7    544.
#> 3  1.57  2.89  1.44  11.1   0.298 10.4   12.7   -12.6    8.16  4.08   222.
#> 4  2.46  0.932 4.44  18.2  -1.45   5.88   5.22   10.9   16.4   0.675  397.
#> 5  0.558 0.272 3.58   5.07  5.36  -4.58   6.98    0.476 16.7   3.16   266.
#> 6 -0.645 4.10  0.546  6.46  6.03   0.686 -0.789  17.5   -1.15 10.9    302.

# Test a linear model
m1 <- lm(Y~ X1 + X2 + X3 + X4, data = df)
summary(m1)
#> 
#> Call:
#> lm(formula = Y ~ X1 + X2 + X3 + X4, data = df)
#> 
#> Residuals:
#>     Min      1Q  Median      3Q     Max 
#> -447.56 -113.37   -1.72  111.00  552.25 
#> 
#> Coefficients:
#>             Estimate Std. Error t value Pr(>|t|)    
#> (Intercept) 340.2594    11.3812  29.897  < 2e-16 ***
#> X1            0.1963     5.0984   0.038  0.96930    
#> X2            3.7334     2.4280   1.538  0.12446    
#> X3            5.3406     1.7269   3.093  0.00204 ** 
#> X4            5.0864     1.2323   4.127 3.98e-05 ***
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
#> 
#> Residual standard error: 158 on 995 degrees of freedom
#> Multiple R-squared:  0.02837,    Adjusted R-squared:  0.02447 
#> F-statistic: 7.263 on 4 and 995 DF,  p-value: 9.137e-06
```
