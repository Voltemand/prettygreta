context("tilde")

test_that("greta models work", {
  library(greta)

  rating <- attitude$rating
  complaints <- attitude$complaints

  int ~ N(0, 10)
  coef ~ N(0, 10)
  sd ~ HalfCauchy(0, 3)
  mu = int + coef * complaints
  rating ~ N(mu, sd)

  expect_error(m <- model(int, coef, sd), NA)
})

test_that("normal formulas still work", {

  x <- 1:20
  y <- 2 * x + rnorm(20)
  fit <- lm(y ~ x)
  expect_equal(class(fit), "lm")

})