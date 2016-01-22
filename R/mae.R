#' Mean-absolute error (MAE)
#'
#' This function computes the mean-absolute error (MAE).
#'
#' (MAE) is expressed as
#'
#'	\deqn{n^{-1} \sum \limits_{i=1}^n{ \left| P_i - O_i \right|}}
#'
#' \describe{
#'	\item{\emph{n}}{the number of observations}
#'	\item{\emph{P}}{the "model estimates or predictions"}
#'	\item{\emph{O}}{the "thought-to-be reliable and pairwise matched
#'   observations"}
#' }
#'
#'	MAE is fully discussed in the Willmott reference, including a
#'   comparison to root mean square error (RMSE).
#'
#'
#' @param predicted numeric vector that contains the model predicted
#'   data points (1st parameter)
#' @param observed numeric vector that contains the observed data
#'   points (2nd parameter)
#' @param na.rm logical vector that determines whether the missing
#'   values should be removed or not.
#'
#' @return mean-absolute error (MAE) as a numeric vector using the same
#'    units as the given variables. The default choice is that any NA values
#'    will be kept (\code{na.rm = FALSE}). This can be changed by
#'	 specifying \code{na.rm = TRUE}, such as \code{mae(pre, obs, na.rm = TRUE)}.
#'
#'
#' @source
#' r - Better error message for stopifnot? - Stack Overflow answered by Andrie on Dec 1 2011. See \url{http://stackoverflow.com/questions/8343509/better-error-message-for-stopifnot}.
#'
#'
#' @references
#' Cort J. Willmott and Kenji Matsuura, "Advantages of the mean-absolute error (MAE) over the root mean square error (RMSE) in assessing average model performance", \emph{Climate Research}, Vol. 30: 79-82, 2005, \url{http://climate.geog.udel.edu/~climate/publication_html/Pdf/WM_CR_05.pdf}.
#'
#' @encoding UTF-8
#'
#'
#'
#'
#'
#' @seealso \code{\link{mape}} for mean absolute percent error (MAPE), \code{\link{madstat}} for
#'  mean-absolute deviation (MAD), \code{\link{dr}} for "index of agreement (dr)", \code{\link{vnse}}
#'  for Nash-Sutcliffe model efficiency (NSE), and \code{\link{rmse}} for
#'  root mean square error (RMSE).
#'
#'
#'
#'
#'
#'
#'
#' @examples
#' library(ie2misc)
#' obs <- 1:10 # observed
#' pre <- 2:11 # predicted
#' mae(pre, obs)
#'
#'
#' require(stats)
#' set.seed(100) # makes the example reproducible
#' obs1 <- rnorm(100) # observed
#' pre1 <- rnorm(100) # predicted
#'
#'
#' # using the vectors pre1 and obs1
#' mae(pre1, obs1)
#'
#'
#' # using a matrix of the numeric vectors pre1 and obs1
#' mat1 <- matrix(data = c(obs1, pre1), nrow = length(pre1), ncol = 2,
#'    byrow = FALSE, dimnames = list(c(rep("", length(pre1))),
#'    c("Predicted", "Observed")))
#' mae(mat1[, 2], mat1[, 1])
#'
#' # mat1[, 1] # observed values from column 1 of mat1
#' # mat1[, 2] # predicted values from column 2 of mat1
#'
#'
#' # using a data.frame of the numeric vectors pre1 and obs1
#' df1 <- data.frame(obs1, pre1)
#' mae(df1[, 2], df1[, 1])
#'
#' # df1[, 1] # observed values from column 1 of df1
#' # df1[, 2] # predicted values from column 2 of df1
#'
#'
#' # using a data.table of the numeric vectors pre1 and obs1
#' df2 <- data.table(obs1, pre1)
#' mae(df2[, 2, with = FALSE][[1]], df2[, 1, with = FALSE][[1]])
#'
#' # df2[, 1, with = FALSE][[1]] # observed values from column 1 of df2
#' # df2[, 2, with = FALSE][[1]] # predicted values from column 2 of df2
#'
#'
#' @export
mae <- function (predicted, observed, na.rm = FALSE) {

# The base::mean.default code has been helpful with regards to the treatment
# of non-numeric values

# The moments::kurtosis code has been helpful with regards to the treatment of
# na.rm

if (length(predicted) < 1 | length(observed) < 1) {

  stop("Check the length of the predicted and observed vectors since one of
  them has a length of 0. Use a different set of values and then try again.")
# Source 1 / provide a stop warning if the length of one of the vectors is 0

} else {

if (length(predicted) != length(observed)) {

  stop("Check the length of the predicted and observed vectors since they don't
  match. Use a different set of values and then try again.")
# Source 1 / provide a stop warning if the length of the numeric vectors do not match

} else {

if (!is.numeric(predicted) | !is.numeric(observed)) {

  stop("Either the predicted or observed vector is not numeric. Use a different
  set of values and then try again.")
# Source 1 / provide a stop warning if the either one of the vectors is not numeric

} else {

if (na.rm == TRUE) {

  observed <- observed[!is.na(observed)]

  predicted <- predicted[!is.na(predicted)]

  n <- length(predicted)

  (n ^ -1) * (sum(abs(predicted - observed), na.rm = na.rm))

} else {

  n <- length(predicted)

  (n ^ -1) * (sum(abs(predicted - observed), na.rm = na.rm))

}
}
}
}
}
