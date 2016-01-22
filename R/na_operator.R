#' \%+na\%
#'
#' This function "defines a dyadic operator that will behave differently than
#' 	the "+" operator with regards to missing values". (Quote by 42- in Source
#'   1 below). In this case, add \code{x} and \code{y} so that \code{NA} is ignored
#'   when \code{x} is a number and \code{x = NA} when \code{x = 0}.
#'
#'
#' @param x numeric vector that does not contain any \code{NA} values
#' @param y numeric vector which contains at least one \code{NA} value
#'
#' @return numeric vector resulting from the \code{sum} of \code{x} and \code{y}
#'
#'
#'
#'
#' @source
#' \enumerate{
#'    \item Using `:=` in data.table to sum the values of two columns in R, ignoring NAs - Stack Overflow answered by 42- on Oct 28 2012. See   \url{http://stackoverflow.com/questions/13106645/using-in-data-table-to-sum-the-values-of-two-columns-in-r-ignoring-nas}.
#'    \item R - merge unequal regular (15 min intervals) and irregular time series within 10 minutes - Stack Overflow asked by iembry on Jan 12 2015 and edited by iembry on Feb 2 2015. See \url{http://stackoverflow.com/questions/27930548/r-data-table-dyadic-operator-and-summing-duplicate-rows-based-on-time-se}.
#' }
#'
#'
#' @encoding UTF-8
#'
#'
#'
#' @examples
#' library(ie2misc)
#' a <- 1:10
#' b <- c(98:106, NA)
#'
#' a %+na% b
#'
#' # Note that if the vector with the NA value(s) is first, then the additive
#' # result will still be an NA value(s)
#' b %+na% a
#'
#'
#' a1 <- 1:12
#' b1 <- c(98:106, rep(NA, 3))
#'
#' a1 %+na% b1
#'
#'
#' # using a matrix of the numeric vectors a and b
#' mat1 <- matrix(data = c(a, b), nrow = length(b), ncol = 2, byrow = FALSE,
#'         dimnames = list(c(rep("", length(b))), c("a", "b")))
#' mat1[, 1] %+na% mat1[, 2]
#'
#'
#' # using a data.frame of the numeric vectors a and b
#' df1 <- data.frame(a, b)
#' df1[, 1] %+na% df1[, 2]
#'
#'
#' # using a data.table of the numeric vectors a and b
#' df2 <- data.table(a, b)
#' df2[, 1, with = FALSE][[1]] %+na% df2[, 2, with = FALSE][[1]]
#'
#'
#'
#' @export
"%+na%" <- function(x, y) {

ifelse (x == 0 & is.na(y) == TRUE, NA,
ifelse (x != 0 & is.na(y) == TRUE, x, x + y))
# Source 1 and 2

}
