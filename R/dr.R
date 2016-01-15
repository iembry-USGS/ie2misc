#' Index of agreement (dr)
#'
#' This function computes the index of agreement (dr)
#'
#' dr is expressed as
#'
#' \deqn{d_{r} = 1 - \frac{\sum \limits_{i=1}^n{\left|P_i - O_i\right|}}{c \sum \limits_{i=1}^n{O_i - \bar{O}}}, when \sum \limits_{i=1}^n{\left|P_i - O_i\right|} \leq c \sum \limits_{i=1}^n{O_i - \bar{O}}}
#'
#' \deqn{d_{r} = \frac{{c \sum \limits_{i=1}^n{O_i - \bar{O}}}{\sum \limits_{i=1}^n{\left|P_i - O_i\right|}} - 1}, when \sum \limits_{i=1}^n{\left|P_i - O_i\right|} > c \sum \limits_{i=1}^n{O_i - \bar{O}}}
#'
#'	where \emph{n} is the number of observations,
#'	where \emph{P} represents the "model estimates or predictions", and
#'	\emph{O} represents the "pairwise-matched observations that are judged to
#'	be reliable".
#'
#' 	Note: Both P and O should have the same units.
#'
#'	The index of agreement (dr) is fully discussed in the Willmott reference.
#'
#'
#' @param predicted A numeric vector that contains the predicted data
#'	points (1st parameter)
#' @param observed A numeric vector that contains the observed data
#'	points (2nd parameter)
#' @param na.rm A logical vector that determines whether the missing
#'	values should be removed or not.
#'
#' @return index of agreement (dr) as a numeric vector. The default choice
#'	is that any NA values will be removed (na.rm = TRUE). This can be
#'	changed by specifying \code{na.rm = FALSE}, such as \code{dr(pre, obs, na.rm = FALSE)}.
#'
#'
#' @source
#' r - Better error message for stopifnot? - Stack Overflow answered by Andrie on Dec 1 2011. See \url{http://stackoverflow.com/questions/8343509/better-error-message-for-stopifnot}.
#'
#'
#' @references
#' Cort J. Willmott, Scott M. Robeson, and Kenji Matsuura, "A refined index of model performance", \emph{International Journal of Climatology}, Volume 32, Issue 13, pages 2088-2094, 15 November 2012, \url{http://onlinelibrary.wiley.com/doi/10.1002/joc.2419/pdf}.
#'
#'
#' @encoding UTF-8
#'
#'
#'
#'
#' @seealso \code{\link{mape}}, \code{\link{vnse}}, \code{\link{madstat}}, \code{\link{mae}}, \code{\link{rmse}}
#'
#'
#'
#' @examples
#' library(ie2misc)
#' ## All of the following examples use the default value of na.rm = TRUE
#' obs <- 1:10 # observed
#' pre <- 2:11 # predicted
#' dr(pre, obs)
#'
#'
#' require(stats)
#' set.seed(100) # makes the example reproducible
#' obs1 <- rnorm(100) # observed
#' pre1 <- rnorm(100) # predicted
#'
#'
#' ## using the vectors pre1 and obs1
#' dr(pre1, obs1)
#'
#'
#' ## using a matrix of the numeric vectors pre1 and obs1
#' mat1 <- matrix(data = c(obs1, pre1), nrow = length(pre1), ncol = 2,
#' byrow = FALSE, dimnames = list(c(rep("", length(pre1))),
#' c("Predicted", "Observed")))
#' dr(mat1[, 2], mat1[, 1])
#'
#' ## mat1[, 1] # observed values from column 1 of mat1
#' ## mat1[, 2] # predicted values from column 2 of mat1
#'
#'
#' ## using a data.frame of the numeric vectors pre1 and obs1
#' df1 <- data.frame(obs1, pre1)
#' dr(df1[, 2], df1[, 1])
#'
#' ## df1[, 1] # observed values from column 1 of df1
#' ## df1[, 2] # predicted values from column 2 of df1
#'
#'
#' ## using a data.table of the numeric vectors pre1 and obs1
#' df2 <- data.table(obs1, pre1)
#' dr(df2[, 2, with = FALSE][[1]], df2[, 1, with = FALSE][[1]])
#'
#' ## df2[, 1, with = FALSE][[1]] # observed values from column 1 of df2
#' ## df2[, 2, with = FALSE][[1]] # predicted values from column 2 of df2
#'
#'
#'
#' @export
dr <- function (predicted, observed, na.rm = TRUE) {

## The base::mean.default code has been helpful with regards to the treatment
## of non-numeric values

if (length(predicted) < 1 | length(observed) < 1) {

  stop("Check the length of the predicted and observed vectors since one of them
 has a length of 0. Use a different set of values and then try again.")
# Source 1 / provide a stop warning if the length of one of the vectors is 0

} else {

if (length(predicted) != length(observed)) {

  stop("Check the length of the predicted and observed vectors since they don't
  match. Use a different set of values and then try again.")
# Source 1 / provide a stop warning if the length of the numeric vectors do
# not match

} else {

if (!is.numeric(predicted) | !is.numeric(observed)) {

  stop("Either the predicted or observed vector is not numeric. Use a
  different set of values and then try again.")
# Source 1 / provide a stop warning if the either one of the vectors is not
# numeric

} else {

  c <- 2

if (sum(abs(predicted - observed), na.rm = na.rm) <=
(c * sum(abs(observed - mean(observed)), na.rm = na.rm))) {

  1 - (sum(abs(predicted - observed), na.rm = na.rm) /
  (c * sum(abs(observed - mean(observed)), na.rm = na.rm)))

} else {

  ((c * sum(abs(observed - mean(observed)), na.rm = na.rm)) /
  sum(abs(predicted - observed), na.rm = na.rm)) - 1
}
}
}
}
}
