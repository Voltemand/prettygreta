#' Pretty normal distributions
#'
#' @details see greta documentation
#'
#' @export
#'
#' @import greta
N <- function(mean, sd){
  greta::normal(mean, sd)
}

#' Pretty half cauchy distributions
#'
#' @details see greta documentation
#'
#' @export
#'
#' @import greta
HalfCauchy <- function(location, scale){
  greta::cauchy(location, scale, truncation = c(0, Inf))
}
