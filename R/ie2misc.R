#' ie2misc: Irucka Embry's miscellaneous USGS functions
#'
#' ie2misc provides many functions that will be useful to people within the
#'  USGS, while other functions will be useful for others. Functions are
#'  included for statistical errors (RMSE, NSE, dr, MAPE, MAE, MAD),
#'  processing .exp and .psf files, a "+" dyadic operator for use with NA,
#'  and making it easier to view USGS ADAPS and QW files within a spreadsheet
#'  application.
#'
#' @docType package
#' @name ie2misc
#' @import stringi data.table openxlsx readxl tcltk gWidgets2 gWidgets2tcltk qdap stats utils tools reader
#' @importFrom lubridate guess_formats ymd dmy mdy ymd_hm dmy_hm mdy_hm ymd_hms dmy_hms mdy_hms
