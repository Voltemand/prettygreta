#' Pretty normal distributions
#'
#' @details see greta documentation
#'
N <- function(mean, sd){
  normal(mean, sd)
}

#' Pretty half cauchy distributions
#'
#' @details see greta documentation
#'
HalfCauchy <- function(location, scale){
  cauchy(location, scale, truncation = c(0, Inf))
}
