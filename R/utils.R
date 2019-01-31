#' Check whether an object is a greta_array
#'
#' @param x an object
#' @return length 1 logical vector
#'
is.greta_array <- function(x) {
  inherits(x, "greta_array")
}

#' Check whether an object is in a specified environment
#'
#' @param name an objects name
#' @param env an environment
#' @return length 1 logical vector
#'
in_env <- function(name, env) {
  name %in% ls(env)
}

#' Check whether an object has a distribution
#'
#' @param an object
#' @return length 1 logical vector
#'
#' @details Any non greta_array object has no distribution by definition
#'
has_distrib <- function(x) {
  if (inherits(x, "greta_array")) {
    !is.null(attr(x, "node")$distribution)
  } else {
    FALSE
  }
}
