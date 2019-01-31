#' Reworked ~ for use in greta
#'
#' @param x an object
#' @param y an object
#'
#' @details If y is not a greta array ~ uses rlang to construct a normal
#' formula call. Otherwise ~ will assign greta array, and will use
#' \code{`distribution<-`} if appropriate
#'
#' @import rlang
#'
#' @export
`~` <- function(x, y){

  quo_x <- rlang::enquo(x)

  if (is.greta_array(y)) {

    # do some greta assignment
    greta_assign(quo_x, y)

  } else {
    # construct the formula

    # TODO: undestand why we can't use enquoed stuff
    expr_x <- rlang::expr(x)
    expr_y <- rlang::expr(y)

    f <- rlang::new_formula(expr_x, expr_y)

    f
  }

}

#' Do some assignment with greta objects
#'
#' @param quo_x a rlang::quosure wrapping the first argument to \code{x}
#' @param y greta_array
#'
#' @import rlang
#'
greta_assign <- function(quo_x, y) {

  # get the environment
  env <- rlang::quo_get_env(quo_x)

  # get the exprs
  expr_x <- rlang::quo_get_expr(quo_x)
  char_x <- rlang::expr_text(expr_x)

  if (in_env(char_x, env) && !has_distrib(rlang::eval_tidy(expr_x))){
    # We are assigning data
    invisible(rlang::exec(`distribution<-`, eval(expr_x), y, .env = env))
  } else {
    # We are assigning a parameter
    assign(char_x, y, envir = env)
  }

}