
# prettygreta

A *very* experimental pretty front end for **greta**. **prettygreta**
uses **rlang** to construct formulas and do other NSE magic.

## Usage

``` r
suppressMessages(library(greta))
suppressMessages(library(prettygreta))

rating <- attitude$rating 
complaints <- attitude$complaints

# The first example model from the greta website - but pretty...
int ~ N(0, 10)
coef ~ N(0, 10)
sd ~ HalfCauchy(0, 3)
mu = int + coef * complaints
rating ~ N(mu, sd)

m <- model(int, coef, sd)

# But we can still use normal formulas!

x <- 1:20
y <- 2 * x + rnorm(20)
fit <- lm(y ~ x)
fit
```

    ## 
    ## Call:
    ## lm(formula = y ~ x)
    ## 
    ## Coefficients:
    ## (Intercept)            y  
    ##       0.832        1.924

## Install

To install the package use:

``` r
devtools::install_github("Voltemand/prettygreta")
```
