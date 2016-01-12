#' Nash-Sutcliffe model efficiency (NSE)
#'
#' This function computes the Nash-Sutcliffe model efficiency (NSE) or
#' 	"Nash and Sutcliffe’s coefficient of efficiency (E)",
#'
#' NSE or E is expressed as
#'
#' 	\deqn{E = 1 - \frac{\sum \limits_{i=1}^n{(P_i - O_i)^2}}{\sum \limits_{i=1}^n{(O_i - \bar{O})^2}}}
#'
#'	where \emph{n} is the number of observations,
#'	where \emph{P} represents the "model estimates or predictions", and
#'	emph{O} represents the "pairwise-matched observations that are judged to
#'     be reliable".
#'
#' 	Note: Both P and O should have the same units.
#'
#'	"Nash and Sutcliffe’s coefficient of efficiency (E)" and other
#'   "dimensionless measures of average error" are fully discussed in the
#'   Willmott reference.
#'
#'
#' @param predicted A numeric vector that contains the model predicted
#'   data points (1st parameter)
#' @param observed A numeric vector that contains the observed data
#'   points (2nd parameter)
#' @param na.rm A logical vector that determines whether the missing
#'   values should be removed or not.
#'
#' @return Nash-Sutcliffe model efficiency (NSE) as a numeric vector. The
#'   default choice is that any NA values will be removed (\code{na.rm = TRUE}). This can
#'   be changed by specifying \code{na.rm = FALSE}, such as \code{vnse(pre, obs, na.rm = FALSE)}.
#'
#'
#' @source
#' r - Better error message for stopifnot? - Stack Overflow answered by Andrie on Dec 1 2011. See \url{http://stackoverflow.com/questions/8343509/better-error-message-for-stopifnot}.
#'
#'
#' @references
#' Cort J. Willmott, Scott M. Robeson, and Kenji Matsuura, "A refined index of model performance", \emph{International Journal of Climatology}, Volume 32, Issue 13, pages 2088-2094, 15 November 2012, \url{http://onlinelibrary.wiley.com/doi/10.1002/joc.2419/pdf}.
#'
#' @encoding UTF-8
#'
#'
#'
#'
#' @family statistical error functions
#' @seealso \code{\link{mape}} for mean absolute percent error (MAPE), \code{\link{mae}} for
#' mean absolute error (MAE), \code{\link{madstat}} for mean absolute deviation (MAD), \code{\link{dr}}
#' for index of agreement (dr), and \code{\link{rmse}} for root mean square error (RMSE).
#'
#'
#'
#' @examples
#' library(ie2misc)
#' ## All of the following examples use the default value of na.rm = TRUE
#' obs <- 1:10 # observed
#' pre <- 2:11 # predicted
#' vnse(pre, obs)
#'
#'
#' require(stats)
#' set.seed(100) # makes the example reproducible
#' obs1 <- rnorm(100) # observed
#' pre1 <- rnorm(100) # predicted
#'
#'
#' ## using the vectors pre1 and obs1
#' vnse(pre1, obs1)
#'
#'
#' ## using a matrix of the numeric vectors pre1 and obs1
#' mat1 <- matrix(data = c(obs1, pre1), nrow = length(pre1), ncol = 2,
#'    byrow = FALSE, dimnames = list(c(rep("", length(pre1))),
#'    c("Predicted", "Observed")))
#' vnse(mat1[, 2], mat1[, 1])
#'
#' ## mat1[, 1] # observed values from column 1 of mat1
#' ## mat1[, 2] # predicted values from column 2 of mat1
#'
#'
#' ## using a data.frame of the numeric vectors pre1 and obs1
#' df1 <- data.frame(obs1, pre1)
#' vnse(df1[, 2], df1[, 1])
#'
#' ## df1[, 1] # observed values from column 1 of df1
#' ## df1[, 2] # predicted values from column 2 of df1
#'
#'
#' ## using a data.table of the numeric vectors pre1 and obs1
#' library(data.table)
#' df2 <- data.table(obs1, pre1)
#' vnse(df2[, 2, with = FALSE][[1]], df2[, 1, with = FALSE][[1]])
#'
#' ## df2[, 1, with = FALSE][[1]] # observed values from column 1 of df2
#' ## df2[, 2, with = FALSE][[1]] # predicted values from column 2 of df2
#'
#'
#'
#' @export
vnse <- function(predicted, observed, na.rm = TRUE) {

## The base::mean.default code has been helpful with regards to the treatment of non-numeric values

if (length(predicted) < 1 | length(observed) < 1) {

  stop("Check the length of the predicted and observed vectors since one of
  them has a length of 0. Use a different set of values and then try again.")
# Source 1 / provide a stop warning if the length of one of the vectors is 0

} else {

if (length(predicted) != length(observed)) {

  stop("Check the length of the predicted and observed vectors since they
  don't match. Use a different set of values and then try again.")
# Source 1 / provide a stop warning if the length of the numeric vectors do not match

} else {

if (!is.numeric(predicted) | !is.numeric(observed)) {

  stop("Either the predicted or observed vector is not numeric. Use a
  different set of values and then try again.")
# Source 1 / provide a stop warning if the either one of the vectors is not numeric

} else {

num <- sum((predicted - observed) ^ 2, na.rm = na.rm)

denom <- sum((observed - mean(observed) ^ 2), na.rm = na.rm)

1 - (num / denom)
}
}
}
}
