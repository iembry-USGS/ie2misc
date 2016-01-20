#' Mean absolute deviation (MAD)
#'
#' This function computes the mean absolute deviation (MAD).
#'
#' MAD is expressed as
#'
#'	\deqn{n^{-1} \sum \limits_{i=1}^n{ \left| O_i - \bar{O} \right|}}
#'
#' Reference 1 fully discusses MAD, while Reference 2 provides the formula
#' used to calculate the MAD.
#'
#'
#' @param observed A numeric vector, matrix, data.frame, or data.table
#'   that contains the observed data points.
#' @param na.rm A logical vector that determines whether the missing
#'   values should be removed or not.
#'
#' @return mean absolute deviation (MAD) as a numeric \code{\link{vector}} or a named
#'   numeric vector if using a named object (\code{\link{matrix}}, \code{\link{data.frame}}, or \code{\link{data.table}}). MAD has the
#'   same units as the observed values. The default choice is that any NA values
#'   will be removed (\code{na.rm = TRUE}). This can be changed by specifying \code{na.rm = FALSE}, such as \code{madstat(obs, na.rm = FALSE)}.
#'
#'
#' @source
#' \code{\link[moments]{kurtosis}} for use of na.rm for numeric vector, matrix, and data.frame objects
#'
#'
#' @references
#' \enumerate{
#'    \item Cort J. Willmott, Kenji Matsuura, and Scott M. Robeson, "Ambiguities inherent in sums-of-squares-based error statistics", \emph{Atmospheric Environment}, vol. 43, no. 3, pp. 749-752, 2009, \url{http://www.sciencedirect.com/science/article/pii/S1352231008009564}.
#'    \item Cort J. Willmott, Scott M. Robeson, and Kenji Matsuura, "A refined index of model performance", \emph{International Journal of Climatology}, Volume 32, Issue 13, pages 2088-2094, 15 November 2012, \url{http://onlinelibrary.wiley.com/doi/10.1002/joc.2419/pdf}.
#'    \item Nathabandu T. Kottegoda and Renzo Rosso, \emph{Statistics, Probability, and Reliability for Civil and Environmental Engineers}, New York City, New York: The McGraw-Hill Companies, Inc., 1997, page 15.
#'}
#'
#' @encoding UTF-8
#'
#'
#'
#'
#' @seealso \code{\link[stats]{mad}} for median absolute deviation (MAD)
#'
#' @family statistical error functions
#' @seealso \code{\link{mape}} for mean absolute percent error (MAPE), \code{\link{mae}} for
#'  mean absolute error (MAE), \code{\link{dr}} for index of agreement (dr), \code{\link{vnse}}
#'  for Nash-Sutcliffe model efficiency (NSE), and \code{\link{rmse}} for
#'  root mean square error (RMSE).
#'
#'
#' @examples
#' library(ie2misc)
#' # All of the following examples use the default value of na.rm = TRUE
#'
#' # Example 1.18 from Kottegoda (page 15)
#' obs <- c(50, 56, 42, 53, 49) # annual rainfall in cm
#' madstat(obs)
#'
#'
#' require(stats)
#' set.seed(100) # makes the example reproducible
#' obs1 <- rnorm(100) # observed
#'
#'
#' # using the numeric vector obs1
#' madstat(obs1)
#'
#'
#' # using a matrix of the numeric vector obs1
#' mat1 <- matrix(data = obs1, nrow = length(obs1), ncol = 1, byrow = FALSE,
#'         dimnames = list(c(rep("", length(obs1))), "Observed"))
#' madstat(mat1)
#'
#'
#' # using a data.frame of the numeric vector obs1
#' df1 <- data.frame(obs1)
#' madstat(df1)
#'
#'
#' # using a data.table of the numeric vector obs1
#' df2 <- data.table(obs1)
#' madstat(df2)
#'
#'
#' @export
madstat <- function (observed, na.rm = TRUE) {

# The moments::kurtosis code has been helpful with regards to the treatment of na.rm

  n <- length(observed)

if (is.matrix(observed))

  apply(observed, 2, madstat, na.rm = na.rm)

else if (is.vector(observed)) {

if (na.rm)

  observed <- observed[!is.na(observed)]

  n ^ -1 * (sum(abs(observed - mean(observed)), na.rm = na.rm))

} else if (is.data.frame(observed))

  sapply(observed, madstat, na.rm = na.rm)

else if (is.data.table(observed))

  sapply(observed, madstat, na.rm = na.rm)

else madstat(as.vector(observed), na.rm = na.rm)

}
