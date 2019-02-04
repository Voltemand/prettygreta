#' Reworked ~ for pretty greta use
#'
#' @param x object
#' @param y object
#'
#' @importFrom stats formula
#'
#' @export
#'
#' @details if y is a formula will try to do greta assignment otherwise will
#' convert to a normal formula
#'
`~` <- function(x, y) {

  env <- parent.frame()
  expr_x <- substitute(x)

  if (is.greta_array(y)) {

    greta_assign(expr_x, y, env)

  } else {
    x_text <- deparse(substitute(x))
    y_text <- deparse(substitute(y))
    formula_text <- paste0(x_text, "~", y_text)
    formula <- stats::formula(formula_text)
    formula
  }
}

#' Do some assignment with greta objects
#'
#' @param expr_x an expression for x
#' @param y greta_array
#' @param env the enviroment ~ was called in
#'
#' @import greta
#'
greta_assign <- function(expr_x, y, env) {

  # get the exprs
  char_x <- deparse(expr_x)

  if (in_env(char_x, env) && !has_distrib(eval(expr_x, env))){

    # We are assigning data
    x <- eval(expr_x, env)
    invisible(greta::distribution(x) <- y)

  } else {
    # We are assigning a parameter
    assign(char_x, y, envir = env)
  }

}

# Old rlang version

# `~` <- function(x, y){
#
#   quo_x <- rlang::enquo(x)
#
#   if (is.greta_array(y)) {
#
#     # do some greta assignment
#
#
#   } else {
#     # construct the formula
#
#     # TODO: undestand why we can't use enquoed stuff
#     expr_x <- rlang::expr(x)
#     expr_y <- rlang::expr(y)
#
#     f <- rlang::new_formula(expr_x, expr_y)
#
#     f
#   }
#
# }
#
# greta_assign <- function(quo_x, y) {
#
#   # get the environment
#   env <- rlang::quo_get_env(quo_x)
#
#   # get the exprs
#   expr_x <- rlang::quo_get_expr(quo_x)
#   char_x <- rlang::expr_text(expr_x)
#
#   if (in_env(char_x, env) && !has_distrib(rlang::eval_tidy(expr_x))){
#     # We are assigning data
#     invisible(rlang::exec(`distribution<-`, eval(expr_x), y, .env = env))
#   } else {
#     # We are assigning a parameter
#     assign(char_x, y, envir = env)
#   }
#
# }