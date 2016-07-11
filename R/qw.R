#' qw, qw2 and qwBATCH
#'
#' qw, qw2 and qwBATCH process raw QW files. The QW files contain "selected
#'   water-quality data for stations in the U.S. Geological Survey (USGS)
#'   National Water Information System (NWIS) water-quality database. The data
#'   you have secured from the USGS NWISWeb database may include data that have
#'   not received Director's approval and as such are provisional and subject
#'   to revision."
#'
#' qw function opens a single or multiple raw, QW file(s) to modify the format
#'   and then exports the file(s) in .xlsx format. This is done for a single
#'   file or multiple files that the user selects with a file dialog.
#'
#' qw2 function opens a single QW file to modify the format and then exports
#'   the file in .xlsx format. This is done for a single file that the user
#'   selects without a file dialog.
#'
#' qwBATCH function opens raw QW files, from a directory, to modify the format
#'   and then exports the files in .xlsx format.  This is done in a BATCH mode
#'   (whole directory of QW files) using a directory dialog.
#'
#' qw, qw2 and qwBATCH functions perform the same processes on the raw QW
#'   files: 1) remove the first row, 2) create a single column with the Date
#'   and Time rather than 2 separate Date and Time columns (if needed), and 3)
#'   exports the QW file as a spreadsheet with three sheets (sheet1 corrects
#'   the timezones for Daylight Savings Times, sheet2 includes everything
#'   except for the meta data, and sheet3 provides the meta data from the top
#'   of the file). The supported US timezones are the following: Eastern,
#'   Central, Mountain, Pacific, Alaska, Hawai'i, and Atlantic (Puerto Rico
#'   and US Virgin Islands).
#'
#'
#'
#'
#' @param file Input QW file(s) to be selected through a file dialog.
#' @param file Input QW file.
#' @param interactive If interactive is \code{TRUE}, then the user will select the
#'   filenames(s) to use for saving with the file dialog. In order to select
#'   more than one file, the user must hold down the Ctrl (Control) button
#'   while mouse clicking the chosen files. If interactive is \code{FALSE}, then
#'   the user will select the directory, via the directory dialog, to use for
#'   saving and the original filenames will be used.
#' @param overwrite If \code{TRUE}, overwrite any existing spreadsheet.
#' @param path Directory path of QW files to be selected through a directory
#'   dialog. The user will be asked where to find the QW files & then the
#'   user will be asked where to save the QW .xlsx files.
#' @param pattern The default pattern is \code{.rdb} (the filename has the .rdb
#'   extension). This pattern can be changed by \code{qwBATCH(pattern = "pattern")}.
#'
#' @return QW .xlsx file(s).
#'
#'
#'
#' @source
#' \enumerate{
#'    \item r - How can I check if a file is empty? - Stack Overflow answered by Konrad Rudolph and edited by Geekuna Matata on Apr 23 2014. See \url{http://stackoverflow.com/questions/23254002/how-can-i-check-if-a-file-is-empty}.
#'    \item r - Better error message for stopifnot? - Stack Overflow answered by Andrie on Dec 1 2011. See \url{http://stackoverflow.com/questions/8343509/better-error-message-for-stopifnot}.
#'    \item inside-R: TclInterface {tcltk}. See \url{http://www.inside-r.org/r-doc/tcltk/.Tcl}.
#'    \item James Wettenhall & Philippe Grosjean, File Open/Save dialogs in R tcltk, December 01, 2015. See \url{http://www.sciviews.org/recipes/tcltk/TclTk-file-open-save-dialogs/}.
#'    \item r - read csv files and perform function, then bind together - Stack Overflow answered by bjoseph on Jan 8 2015. See \url{http://stackoverflow.com/questions/27846715/read-csv-files-and-perform-function-then-bind-together}.
#'    \item r - Convert column classes in data.table - Stack Overflow answered by Matt Dowle on Dec 27 2013. See \url{http://stackoverflow.com/questions/7813578/convert-column-classes-in-data-table}.
#'    \item Does column exist and how to rearrange columns in R data frame - Stack Overflow answered and edited by Peter McMahan on Aug 2 2009. See \url{http://stackoverflow.com/questions/1177919/does-column-exist-and-how-to-rearrange-columns-in-r-data-frame}.
#'    \item time - Dealing with timestamps in R - Stack Overflow answered by Dirk Eddelbuettel on Dec 26 2009. See \url{http://stackoverflow.com/questions/1962278/dealing-with-timestamps-in-r/1962336}.
#'    \item R help - How to change the default Date format for write.csv function? answered by William Dunlap on Dec 28, 2009. See \url{http://r.789695.n4.nabble.com/How-to-change-the-default-Date-format-for-write-csv-function-td989826.html}.
#'    \item inside-R: strptime {base}. See \url{http://www.inside-r.org/r-doc/base/strftime}.
#'    \item National Water Information System: Help System Time Zone Codes. See \url{http://help.waterdata.usgs.gov/code/tz_query?fmt=html}.
#'    \item multiple output filenames in R - Stack Overflow asked and edited by Gabelins on Feb 1 2013. See \url{http://stackoverflow.com/questions/14651594/multiple-output-filenames-in-r}.
#'    \item r - Regex return file name, remove path and file extension - Stack Overflow answered and edited by Ananda Mahto on Feb 25 2013. See \url{http://stackoverflow.com/questions/15073753/regex-return-file-name-remove-path-and-file-extension/15073919}.
#'    \item warnings - How do I get rid of the NOTE's generated by R CMD check when using for example ddply in my package? - Stack Overflow answered by shadow on Mar 4 2015 and edited by shadow on Mar 5 2015. See \url{https://stackoverflow.com/questions/28851812/how-do-i-get-rid-of-the-notes-generated-by-r-cmd-check-when-using-for-example-d}.
#'    \item trinker/qdapRegex - dictionary_maintenance.R. See \url{https://github.com/trinker/qdapRegex/blob/master/inst/dictionary_maintenance.R}.
#'    \item excel - Interconverting POSIXct and numeric in R - Stack Overflow by LauraS on May 6 2016. See \url{http://stackoverflow.com/questions/37078772/interconverting-posixct-and-numeric-in-r}.
#'    \item convert date and time string to POSIX in R - Stack Overflow commented by cryo111 on Sep 18 2013. See \url{http://stackoverflow.com/questions/18874400/convert-date-and-time-string-to-posix-in-r/18874863}.
#' }
#'
#' @encoding UTF-8
#'
#'
#'
#'
#'
#'
#' @examples
#' \dontrun{
#' library(ie2misc)
#' # Examples to change (an) QW file(s) interactively and non-interactively
#' qw2("http://waterdata.usgs.gov/nwis/dv?cb_00060=on&format=rdb&site_no=03584500&referred_module=sw&period=&begin_date=1904-07-01&end_date=2016-06-22")
#' # USGS 03584500 ELK RIVER NEAR PROSPECT, TN
#' # Discharge, cubic feet per second (Mean)
#'
#'
#'
#' qw() # default where interactive = TRUE
#' # Follow the file dialog instructions
#'
#'
#' qw(interactive = FALSE)
#' # Follow the file dialog instructions
#'
#'
#' # Example to change QW files in batch mode
#' qwBATCH()
#' # Follow the file dialog instructions
#' }
#'
#'
#'
#' @import stringi
#' @importFrom lubridate guess_formats ymd dmy mdy ymd_hm dmy_hm mdy_hm ymd_hms dmy_hms mdy_hms
#' @import tools
#' @import tcltk
#' @import gWidgets2
#' @import gWidgets2tcltk
#' @import readxl
#' @import openxlsx
#' @import data.table
#'
#' @name qw
NULL

#' @export
#' @rdname qw
qw <- function (file = tk_choose.files(default = "", caption = "Select file(s) to open & hold down Ctrl to choose more than 1 file", multi = TRUE, filters = matrix(c("QW file", "*", "QW file", ".rdb", "QW file", ".RDB"), 6, 2, byrow = TRUE)), interactive = TRUE, overwrite = TRUE) {

overwrite <- overwrite

#date_times <- date_times_tf <- DateTimes_Timezone_Corrected <- NULL
#sample_start_time_datum_cd <- NULL
# Source 14

if (interactive == TRUE) { # default

if (length(file) == 1) {

if (!nchar(file)) {

  stop("You did not choose a file. Please try again with a different file.")
# Source 2 / provide a stop warning if no file was selected

} else {

confirm <- gconfirm(toolkit = guiToolkit("tcltk"), msg = paste0("Do you want to select", " ", file, "?"), title = "Confirm", icon = "question")

if (confirm == FALSE) {

  stop("Please try again with a different file.")
# Source 2 / provide a stop warning if the user wants to change the file

} else {

if (file.info(file)$size == 0) {

  stop("Your file is empty. Please try again with a different file.")
# Source 1 & 2 / only process non-empty files and provide a stop warning if the input

} else {

 rddatatmp <- read.table(file, header = TRUE, row.names = NULL, comment.char = "#", fill = TRUE, stringsAsFactors = FALSE, sep = "\t")
  rddatatmp <- setDT(rddatatmp)

  rddatatmp1 <- copy(rddatatmp)

  site_no <- rddatatmp[2, "site_no", with = FALSE][[1]]

  rddatatmp <- rddatatmp[-1, -c("agency_cd", "site_no"), with = FALSE]

 datecol <- which(grepl(rddatatmp, pattern = "\\d{0,2}/\\d{2}/(?:\\d{4}|\\d{2})?|\\d{0,2}-\\d{2}-(?:\\d{4}|\\d{2})?|\\d{0,2}\\.\\d{2}\\.(?:\\d{4}|\\d{2})?|(\\b)([A-Za-z]{3,9})(\\s+)([0-9][0-9]*)(,)(\\s+)([0-9]{4})|[0-9]{4}-[0-9]{2}-[0-9]{2}|\\d{0,2}/\\d{2}/(?:\\d{4}|\\d{2})?|\\d{0,2}-\\d{2}-(?:\\d{4}|\\d{2})?|\\d{0,2}\\.\\d{2}\\.(?:\\d{4}|\\d{2})?|(\\b)([A-Za-z]{3,9})(\\s+)([0-9][0-9]*)(,)(\\s+)([0-9]{4})|[0-9]{4}-[0-9]{2}-[0-9]{2}") == TRUE) # Source 15

 datecolname <- names(rddatatmp[, datecol, with = FALSE])

 timecol <- which(grepl(rddatatmp, pattern = "\\d{0,2}:\\d{2}(?:[:.]\\d+)?|(\\d{0,2}:\\d{2}(?:[:.]\\d+)?)(\\s+(([AP]\\.{0,1}M\\.{0,1})|([ap]\\.{0,1}m\\.{0,1})))") == TRUE) # Source 15

 timecolname <- names(rddatatmp[, timecol, with = FALSE])

 ifelse (datecol == timecol, timecol <- NA, datecol <- datecol)
 ifelse (length(timecol) == 0, timecol <- NA, timecol <- timecol)


 if (!is.na(timecol)) {
  numericcol <- which(grepl(rddatatmp, pattern = "[0-9]"))
 numericcol <- numericcol[-c(datecol, timecol)]

 } else if (is.na(timecol)) {

 numericcol <- which(grepl(rddatatmp, pattern = "[0-9]"))
 numericcol <- numericcol[-datecol]

 }


# changing column to numeric class
# obtain the name of the column based on the column number
  change_class1 <- numericcol
  for (col in change_class1) set(rddatatmp, j = col, value = as.numeric(rddatatmp[[col]])) # Source 4

  tz_column <- which(grepl(rddatatmp, pattern = "EST|EDT|CST|CDT|MST|MDT|PST|PDT|AKST|AKDT|HST|HDT|AST|ADT"))
  tz_columnname <- names(rddatatmp[, tz_column, with = FALSE])

dateformat <- guess_formats(rddatatmp[, datecol, with = FALSE][[1]], c("ymd", "dmy", "mdy", "ymd hm", "dmy hm", "mdy hm", "ymd hms", "dmy hms", "mdy hms"))

ymd_check <- length(which(names(dateformat) == "ymd") == TRUE) == nrow(rddatatmp)
dmy_check <- length(which(names(dateformat) == "dmy") == TRUE) == nrow(rddatatmp)
mdy_check <- length(which(names(dateformat) == "mdy") == TRUE) == nrow(rddatatmp)
ymdHM_check <- length(which(names(dateformat) == "ymdHM") == TRUE) == nrow(rddatatmp)
dmyHM_check <- length(which(names(dateformat) == "dmyHM") == TRUE) == nrow(rddatatmp)
mdyHM_check <- length(which(names(dateformat) == "mdyHM") == TRUE) == nrow(rddatatmp)
ymdHMS_check <- length(which(names(dateformat) == "ymdHMS") == TRUE) == nrow(rddatatmp)
dmyHMS_check <- length(which(names(dateformat) == "dmyHMS") == TRUE) == nrow(rddatatmp)
mdyHMS_check <- length(which(names(dateformat) == "mdyHMS") == TRUE) == nrow(rddatatmp)

datechecks <- data.table(ymd_check, dmy_check, mdy_check, ymdHM_check, dmyHM_check, mdyHM_check, ymdHMS_check, dmyHMS_check, mdyHMS_check)


if (is.na(timecol)) {

if (ymd_check) {

rddatatmp[, DateTimes := rddatatmp[, datecol, with = FALSE][[1]]]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class1 <- "DateTimes"
  for (col in change_class1) set(rddatatmp, j = col, value = ymd(rddatatmp[[col]], quiet = TRUE)) # Source 6

  rddatatmp[, datecolname := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))


} else if (ymdHM_check) {

rddatatmp[, DateTimes := rddatatmp[, datecol, with = FALSE][[1]]]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class2 <- "DateTimes"
  for (col in change_class2) set(rddatatmp, j = col, value = ymd_hm(rddatatmp[[col]], quiet = TRUE, tz = "GMT")) # Source 6

  rddatatmp[, datecolname := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))

  datetime <- as.POSIXct(rddatatmp[[1]], tzone = "GMT")
  rddatatmp[, datetimes := as.numeric(datetime)]

  rddatatmp[, DateTimes_Timezone_Corrected := ifelse (grepl(rddatatmp[, tz_columnname, with = FALSE][[1]], pattern = "EDT|CDT|MDT|PDT|AKDT|HDT|ADT"), {rddatatmp[, datetimes] - 3600}, {rddatatmp[, datetimes]})]
# Source 8 / if the date-time stamp is DT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time

  rddatatmp[, DateTimes_Timezone_Corrected2 := as.POSIXct(DateTimes_Timezone_Corrected, origin = "1970-01-01 00:00:00", tzone = "GMT")]
# convert the numeric date time back to POSIXct with the origin of GMT

  attributes(rddatatmp$DateTimes_Timezone_Corrected2)$tzone <- "GMT" # Source 16

  rddatatmp[, c("datetimes", "DateTimes", "DateTimes_Timezone_Corrected") := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))
  setnames(rddatatmp, 1, "DateTime")


} else if (ymdHMS_check) {

rddatatmp[, DateTimes := rddatatmp[, datecol, with = FALSE][[1]]]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class2 <- "DateTimes"
  for (col in change_class2) set(rddatatmp, j = col, value = ymd_hms(rddatatmp[[col]], quiet = TRUE, tz = "GMT")) # Source 6

  rddatatmp[, datecolname := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))

  datetime <- as.POSIXct(rddatatmp[[1]], tzone = "GMT")
  rddatatmp[, datetimes := as.numeric(datetime)]

  rddatatmp[, DateTimes_Timezone_Corrected := ifelse (grepl(rddatatmp[, tz_columnname, with = FALSE][[1]], pattern = "EDT|CDT|MDT|PDT|AKDT|HDT|ADT"), {rddatatmp[, datetimes] - 3600}, {rddatatmp[, datetimes]})]
# Source 8 / if the date-time stamp is DT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time

  rddatatmp[, DateTimes_Timezone_Corrected2 := as.POSIXct(DateTimes_Timezone_Corrected, origin = "1970-01-01 00:00:00", tzone = "GMT")]
# convert the numeric date time back to POSIXct with the origin of GMT

  attributes(rddatatmp$DateTimes_Timezone_Corrected2)$tzone <- "GMT" # Source 16

  rddatatmp[, c("datetimes", "DateTimes", "DateTimes_Timezone_Corrected") := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))
  setnames(rddatatmp, 1, "DateTime")


} else if (dmy_check) {

rddatatmp[, DateTimes := rddatatmp[, datecol, with = FALSE][[1]]]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class1 <- "DateTimes"
  for (col in change_class1) set(rddatatmp, j = col, value = dmy(rddatatmp[[col]], quiet = TRUE)) # Source 6

  rddatatmp[, datecolname := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))


} else if (dmyHM_check) {

rddatatmp[, DateTimes := rddatatmp[, datecol, with = FALSE][[1]]]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class2 <- "DateTimes"
  for (col in change_class2) set(rddatatmp, j = col, value = dmy_hm(rddatatmp[[col]], quiet = TRUE, tz = "GMT")) # Source 6

  rddatatmp[, datecolname := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))

  datetime <- as.POSIXct(rddatatmp[[1]], tzone = "GMT")
  rddatatmp[, datetimes := as.numeric(datetime)]

  rddatatmp[, DateTimes_Timezone_Corrected := ifelse (grepl(rddatatmp[, tz_columnname, with = FALSE][[1]], pattern = "EDT|CDT|MDT|PDT|AKDT|HDT|ADT"), {rddatatmp[, datetimes] - 3600}, {rddatatmp[, datetimes]})]
# Source 8 / if the date-time stamp is DT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time

  rddatatmp[, DateTimes_Timezone_Corrected2 := as.POSIXct(DateTimes_Timezone_Corrected, origin = "1970-01-01 00:00:00", tzone = "GMT")]
# convert the numeric date time back to POSIXct with the origin of GMT

  attributes(rddatatmp$DateTimes_Timezone_Corrected2)$tzone <- "GMT" # Source 16

  rddatatmp[, c("datetimes", "DateTimes", "DateTimes_Timezone_Corrected") := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))
  setnames(rddatatmp, 1, "DateTime")


  } else if (dmyHMS_check) {

rddatatmp[, DateTimes := rddatatmp[, datecol, with = FALSE][[1]]]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class2 <- "DateTimes"
  for (col in change_class2) set(rddatatmp, j = col, value = dmy_hms(rddatatmp[[col]], quiet = TRUE, tz = "GMT")) # Source 6

  rddatatmp[, datecolname := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))

  datetime <- as.POSIXct(rddatatmp[[1]], tzone = "GMT")
  rddatatmp[, datetimes := as.numeric(datetime)]

  rddatatmp[, DateTimes_Timezone_Corrected := ifelse (grepl(rddatatmp[, tz_columnname, with = FALSE][[1]], pattern = "EDT|CDT|MDT|PDT|AKDT|HDT|ADT"), {rddatatmp[, datetimes] - 3600}, {rddatatmp[, datetimes]})]
# Source 8 / if the date-time stamp is DT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time

  rddatatmp[, DateTimes_Timezone_Corrected2 := as.POSIXct(DateTimes_Timezone_Corrected, origin = "1970-01-01 00:00:00", tzone = "GMT")]
# convert the numeric date time back to POSIXct with the origin of GMT

  attributes(rddatatmp$DateTimes_Timezone_Corrected2)$tzone <- "GMT" # Source 16

  rddatatmp[, c("datetimes", "DateTimes", "DateTimes_Timezone_Corrected") := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))
  setnames(rddatatmp, 1, "DateTime")


} else if (mdy_check) {

rddatatmp[, DateTimes := rddatatmp[, datecol, with = FALSE][[1]]]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class1 <- "DateTimes"
  for (col in change_class1) set(rddatatmp, j = col, value = mdy(rddatatmp[[col]], quiet = TRUE)) # Source 6

  rddatatmp[, datecolname := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))


} else if (mdyHM_check) {

rddatatmp[, DateTimes := rddatatmp[, datecol, with = FALSE][[1]]]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class2 <- "DateTimes"
  for (col in change_class2) set(rddatatmp, j = col, value = mdy_hm(rddatatmp[[col]], quiet = TRUE, tz = "GMT")) # Source 6

  rddatatmp[, datecolname := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))

  datetime <- as.POSIXct(rddatatmp[[1]], tzone = "GMT")
  rddatatmp[, datetimes := as.numeric(datetime)]

  rddatatmp[, DateTimes_Timezone_Corrected := ifelse (grepl(rddatatmp[, tz_columnname, with = FALSE][[1]], pattern = "EDT|CDT|MDT|PDT|AKDT|HDT|ADT"), {rddatatmp[, datetimes] - 3600}, {rddatatmp[, datetimes]})]
# Source 8 / if the date-time stamp is DT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time

  rddatatmp[, DateTimes_Timezone_Corrected2 := as.POSIXct(DateTimes_Timezone_Corrected, origin = "1970-01-01 00:00:00", tzone = "GMT")]
# convert the numeric date time back to POSIXct with the origin of GMT

  attributes(rddatatmp$DateTimes_Timezone_Corrected2)$tzone <- "GMT" # Source 16

  rddatatmp[, c("datetimes", "DateTimes", "DateTimes_Timezone_Corrected") := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))
  setnames(rddatatmp, 1, "DateTime")


  } else if (mdyHMS_check) {

rddatatmp[, DateTimes := rddatatmp[, datecol, with = FALSE][[1]]]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class2 <- "DateTimes"
  for (col in change_class2) set(rddatatmp, j = col, value = mdy_hms(rddatatmp[[col]], quiet = TRUE, tz = "GMT")) # Source 6

  rddatatmp[, datecolname := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))

  datetime <- as.POSIXct(rddatatmp[[1]], tzone = "GMT")
  rddatatmp[, datetimes := as.numeric(datetime)]

  rddatatmp[, DateTimes_Timezone_Corrected := ifelse (grepl(rddatatmp[, tz_columnname, with = FALSE][[1]], pattern = "EDT|CDT|MDT|PDT|AKDT|HDT|ADT"), {rddatatmp[, datetimes] - 3600}, {rddatatmp[, datetimes]})]
# Source 8 / if the date-time stamp is DT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time

  rddatatmp[, DateTimes_Timezone_Corrected2 := as.POSIXct(DateTimes_Timezone_Corrected, origin = "1970-01-01 00:00:00", tzone = "GMT")]
# convert the numeric date time back to POSIXct with the origin of GMT

  attributes(rddatatmp$DateTimes_Timezone_Corrected2)$tzone <- "GMT" # Source 16

  rddatatmp[, c("datetimes", "DateTimes", "DateTimes_Timezone_Corrected") := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))
  setnames(rddatatmp, 1, "DateTime")

  }

} else if (!is.na(timecol)) {

if (ymd_check) {

rddatatmp[, DateTimes := paste(rddatatmp[, datecol, with = FALSE][[1]], rddatatmp[, timecol, with = FALSE][[1]], sep = " ")]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class2 <- "DateTimes"
  for (col in change_class2) set(rddatatmp, j = col, value = ymd_hm(rddatatmp[[col]], quiet = TRUE, tz = "GMT")) # Source 6

  rddatatmp[, c(datecolname, timecolname) := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))

datetime <- as.POSIXct(rddatatmp[[1]], tzone = "GMT")
  rddatatmp[, datetimes := as.numeric(datetime)]

  rddatatmp[, DateTimes_Timezone_Corrected := ifelse (grepl(rddatatmp[, tz_columnname, with = FALSE][[1]], pattern = "EDT|CDT|MDT|PDT|AKDT|HDT|ADT"), {rddatatmp[, datetimes] - 3600}, {rddatatmp[, datetimes]})]
# Source 8 / if the date-time stamp is DT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time

  rddatatmp[, DateTimes_Timezone_Corrected2 := as.POSIXct(DateTimes_Timezone_Corrected, origin = "1970-01-01 00:00:00", tzone = "GMT")]
# convert the numeric date time back to POSIXct with the origin of GMT

  attributes(rddatatmp$DateTimes_Timezone_Corrected2)$tzone <- "GMT" # Source 16

  rddatatmp[, c("datetimes", "DateTimes", "DateTimes_Timezone_Corrected") := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))
  setnames(rddatatmp, 1, "DateTime")


} else if (ymdHM_check) {

rddatatmp[, DateTimes := paste(rddatatmp[, datecol, with = FALSE][[1]], rddatatmp[, timecol, with = FALSE][[1]], sep = " ")]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class2 <- "DateTimes"
  for (col in change_class2) set(rddatatmp, j = col, value = ymd_hm(rddatatmp[[col]], quiet = TRUE, tz = "GMT")) # Source 6

  rddatatmp[, c(datecolname, timecolname) := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))

datetime <- as.POSIXct(rddatatmp[[1]], tzone = "GMT")
  rddatatmp[, datetimes := as.numeric(datetime)]

  rddatatmp[, DateTimes_Timezone_Corrected := ifelse (grepl(rddatatmp[, tz_columnname, with = FALSE][[1]], pattern = "EDT|CDT|MDT|PDT|AKDT|HDT|ADT"), {rddatatmp[, datetimes] - 3600}, {rddatatmp[, datetimes]})]
# Source 8 / if the date-time stamp is DT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time

  rddatatmp[, DateTimes_Timezone_Corrected2 := as.POSIXct(DateTimes_Timezone_Corrected, origin = "1970-01-01 00:00:00", tzone = "GMT")]
# convert the numeric date time back to POSIXct with the origin of GMT

  attributes(rddatatmp$DateTimes_Timezone_Corrected2)$tzone <- "GMT" # Source 16

  rddatatmp[, c("datetimes", "DateTimes", "DateTimes_Timezone_Corrected") := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))
  setnames(rddatatmp, 1, "DateTime")


  } else if (ymdHMS_check) {

rddatatmp[, DateTimes := paste(rddatatmp[, datecol, with = FALSE][[1]], rddatatmp[, timecol, with = FALSE][[1]], sep = " ")]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class2 <- "DateTimes"
  for (col in change_class2) set(rddatatmp, j = col, value = ymd_hms(rddatatmp[[col]], quiet = TRUE, tz = "GMT")) # Source 6

  rddatatmp[, c(datecolname, timecolname) := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))

datetime <- as.POSIXct(rddatatmp[[1]], tzone = "GMT")
  rddatatmp[, datetimes := as.numeric(datetime)]

  rddatatmp[, DateTimes_Timezone_Corrected := ifelse (grepl(rddatatmp[, tz_columnname, with = FALSE][[1]], pattern = "EDT|CDT|MDT|PDT|AKDT|HDT|ADT"), {rddatatmp[, datetimes] - 3600}, {rddatatmp[, datetimes]})]
# Source 8 / if the date-time stamp is DT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time

  rddatatmp[, DateTimes_Timezone_Corrected2 := as.POSIXct(DateTimes_Timezone_Corrected, origin = "1970-01-01 00:00:00", tzone = "GMT")]
# convert the numeric date time back to POSIXct with the origin of GMT

  attributes(rddatatmp$DateTimes_Timezone_Corrected2)$tzone <- "GMT" # Source 16

  rddatatmp[, c("datetimes", "DateTimes", "DateTimes_Timezone_Corrected") := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))
  setnames(rddatatmp, 1, "DateTime")


  } else if (dmy_check) {

rddatatmp[, DateTimes := paste(rddatatmp[, datecol, with = FALSE][[1]], rddatatmp[, timecol, with = FALSE][[1]], sep = " ")]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class2 <- "DateTimes"
  for (col in change_class2) set(rddatatmp, j = col, value = mdy_hm(rddatatmp[[col]], quiet = TRUE, tz = "GMT")) # Source 6

  rddatatmp[, c(datecolname, timecolname) := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))

  datetime <- as.POSIXct(rddatatmp[[1]], tzone = "GMT")
  rddatatmp[, datetimes := as.numeric(datetime)]

  rddatatmp[, DateTimes_Timezone_Corrected := ifelse (grepl(rddatatmp[, tz_columnname, with = FALSE][[1]], pattern = "EDT|CDT|MDT|PDT|AKDT|HDT|ADT"), {rddatatmp[, datetimes] - 3600}, {rddatatmp[, datetimes]})]
# Source 8 / if the date-time stamp is DT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time

  rddatatmp[, DateTimes_Timezone_Corrected2 := as.POSIXct(DateTimes_Timezone_Corrected, origin = "1970-01-01 00:00:00", tzone = "GMT")]
# convert the numeric date time back to POSIXct with the origin of GMT

  attributes(rddatatmp$DateTimes_Timezone_Corrected2)$tzone <- "GMT" # Source 16

  rddatatmp[, c("datetimes", "DateTimes", "DateTimes_Timezone_Corrected") := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))
  setnames(rddatatmp, 1, "DateTime")


} else if (dmyHM_check) {

rddatatmp[, DateTimes := paste(rddatatmp[, datecol, with = FALSE][[1]], rddatatmp[, timecol, with = FALSE][[1]], sep = " ")]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class2 <- "DateTimes"
  for (col in change_class2) set(rddatatmp, j = col, value = dmy_hm(rddatatmp[[col]], quiet = TRUE, tz = "GMT")) # Source 6

  rddatatmp[, c(datecolname, timecolname) := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))

  datetime <- as.POSIXct(rddatatmp[[1]], tzone = "GMT")
  rddatatmp[, datetimes := as.numeric(datetime)]

  rddatatmp[, DateTimes_Timezone_Corrected := ifelse (grepl(rddatatmp[, tz_columnname, with = FALSE][[1]], pattern = "EDT|CDT|MDT|PDT|AKDT|HDT|ADT"), {rddatatmp[, datetimes] - 3600}, {rddatatmp[, datetimes]})]
# Source 8 / if the date-time stamp is DT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time

  rddatatmp[, DateTimes_Timezone_Corrected2 := as.POSIXct(DateTimes_Timezone_Corrected, origin = "1970-01-01 00:00:00", tzone = "GMT")]
# convert the numeric date time back to POSIXct with the origin of GMT

  attributes(rddatatmp$DateTimes_Timezone_Corrected2)$tzone <- "GMT" # Source 16

  rddatatmp[, c("datetimes", "DateTimes", "DateTimes_Timezone_Corrected") := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))
  setnames(rddatatmp, 1, "DateTime")


  } else if (dmyHMS_check) {

rddatatmp[, DateTimes := paste(rddatatmp[, datecol, with = FALSE][[1]], rddatatmp[, timecol, with = FALSE][[1]], sep = " ")]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class2 <- "DateTimes"
  for (col in change_class2) set(rddatatmp, j = col, value = dmy_hms(rddatatmp[[col]], quiet = TRUE, tz = "GMT")) # Source 6

  rddatatmp[, c(datecolname, timecolname) := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))

  datetime <- as.POSIXct(rddatatmp[[1]], tzone = "GMT")
  rddatatmp[, datetimes := as.numeric(datetime)]

  rddatatmp[, DateTimes_Timezone_Corrected := ifelse (grepl(rddatatmp[, tz_columnname, with = FALSE][[1]], pattern = "EDT|CDT|MDT|PDT|AKDT|HDT|ADT"), {rddatatmp[, datetimes] - 3600}, {rddatatmp[, datetimes]})]
# Source 8 / if the date-time stamp is DT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time

  rddatatmp[, DateTimes_Timezone_Corrected2 := as.POSIXct(DateTimes_Timezone_Corrected, origin = "1970-01-01 00:00:00", tzone = "GMT")]
# convert the numeric date time back to POSIXct with the origin of GMT

  attributes(rddatatmp$DateTimes_Timezone_Corrected2)$tzone <- "GMT" # Source 16

  rddatatmp[, c("datetimes", "DateTimes", "DateTimes_Timezone_Corrected") := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))
  setnames(rddatatmp, 1, "DateTime")


  } else if (mdy_check) {

rddatatmp[, DateTimes := paste(rddatatmp[, datecol, with = FALSE][[1]], rddatatmp[, timecol, with = FALSE][[1]], sep = " ")]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class2 <- "DateTimes"
  for (col in change_class2) set(rddatatmp, j = col, value = mdy_hm(rddatatmp[[col]], quiet = TRUE, tz = "GMT")) # Source 6

  rddatatmp[, c(datecolname, timecolname) := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))

  datetime <- as.POSIXct(rddatatmp[[1]], tzone = "GMT")
  rddatatmp[, datetimes := as.numeric(datetime)]

  rddatatmp[, DateTimes_Timezone_Corrected := ifelse (grepl(rddatatmp[, tz_columnname, with = FALSE][[1]], pattern = "EDT|CDT|MDT|PDT|AKDT|HDT|ADT"), {rddatatmp[, datetimes] - 3600}, {rddatatmp[, datetimes]})]
# Source 8 / if the date-time stamp is DT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time

  rddatatmp[, DateTimes_Timezone_Corrected2 := as.POSIXct(DateTimes_Timezone_Corrected, origin = "1970-01-01 00:00:00", tzone = "GMT")]
# convert the numeric date time back to POSIXct with the origin of GMT

  attributes(rddatatmp$DateTimes_Timezone_Corrected2)$tzone <- "GMT" # Source 16

  rddatatmp[, c("datetimes", "DateTimes", "DateTimes_Timezone_Corrected") := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))
  setnames(rddatatmp, 1, "DateTime")


   } else if (mdyHM_check) {

rddatatmp[, DateTimes := paste(rddatatmp[, datecol, with = FALSE][[1]], rddatatmp[, timecol, with = FALSE][[1]], sep = " ")]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class2 <- "DateTimes"
  for (col in change_class2) set(rddatatmp, j = col, value = mdy_hm(rddatatmp[[col]], quiet = TRUE, tz = "GMT")) # Source 6

  rddatatmp[, c(datecolname, timecolname) := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))

  datetime <- as.POSIXct(rddatatmp[[1]], tzone = "GMT")
  rddatatmp[, datetimes := as.numeric(datetime)]

  rddatatmp[, DateTimes_Timezone_Corrected := ifelse (grepl(rddatatmp[, tz_columnname, with = FALSE][[1]], pattern = "EDT|CDT|MDT|PDT|AKDT|HDT|ADT"), {rddatatmp[, datetimes] - 3600}, {rddatatmp[, datetimes]})]
# Source 8 / if the date-time stamp is DT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time

  rddatatmp[, DateTimes_Timezone_Corrected2 := as.POSIXct(DateTimes_Timezone_Corrected, origin = "1970-01-01 00:00:00", tzone = "GMT")]
# convert the numeric date time back to POSIXct with the origin of GMT

  attributes(rddatatmp$DateTimes_Timezone_Corrected2)$tzone <- "GMT" # Source 16

  rddatatmp[, c("datetimes", "DateTimes", "DateTimes_Timezone_Corrected") := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))
  setnames(rddatatmp, 1, "DateTime")


} else if (mdyHMS_check) {

rddatatmp[, DateTimes := paste(rddatatmp[, datecol, with = FALSE][[1]], rddatatmp[, timecol, with = FALSE][[1]], sep = " ")]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class2 <- "DateTimes"
  for (col in change_class2) set(rddatatmp, j = col, value = mdy_hms(rddatatmp[[col]], quiet = TRUE, tz = "GMT")) # Source 6

  rddatatmp[, c(datecolname, timecolname) := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))

  datetime <- as.POSIXct(rddatatmp[[1]], tzone = "GMT")
  rddatatmp[, datetimes := as.numeric(datetime)]

  rddatatmp[, DateTimes_Timezone_Corrected := ifelse (grepl(rddatatmp[, tz_columnname, with = FALSE][[1]], pattern = "EDT|CDT|MDT|PDT|AKDT|HDT|ADT"), {rddatatmp[, datetimes] - 3600}, {rddatatmp[, datetimes]})]
# Source 8 / if the date-time stamp is DT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time

  rddatatmp[, DateTimes_Timezone_Corrected2 := as.POSIXct(DateTimes_Timezone_Corrected, origin = "1970-01-01 00:00:00", tzone = "GMT")]
# convert the numeric date time back to POSIXct with the origin of GMT

  attributes(rddatatmp$DateTimes_Timezone_Corrected2)$tzone <- "GMT" # Source 16

  rddatatmp[, c("datetimes", "DateTimes", "DateTimes_Timezone_Corrected") := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))
  setnames(rddatatmp, 1, "DateTime")

  }
  }


## Source 9 and 10 begin
    RDdatatmp <- copy(rddatatmp) # copies rddatatmp

if (grepl(RDdatatmp[[1]][1], pattern = "\\d{0,2}:\\d{2}(?:[:.]\\d+)?|(\\d{0,2}:\\d{2}(?:[:.]\\d+)?)(\\s+(([AP]\\.{0,1}M\\.{0,1})|([ap]\\.{0,1}m\\.{0,1})))") == TRUE) { # Source 15

    RDdatatmp[[1]] <- strptime(RDdatatmp[[1]], "%Y-%m-%d %H:%M:%S") # changes from POSIXct to character for the DateTime
    RDdatatmp[[1]] <- format(RDdatatmp[[1]], "%Y-%m-%d %H:%M:%S") # Source 17 / changes the DateTime format to numeric month/numeric date/four digit year with HMS

} else {

    RDdatatmp[[1]] <- strptime(RDdatatmp[[1]], "%Y-%m-%d") # changes from POSIXct to character for the DateTime
    RDdatatmp[[1]] <- format(RDdatatmp[[1]], "%Y-%m-%d") # Source 17 / changes the DateTime format to numeric month/numeric date/four digit year
}
## Source 9 and 10 end


  rddatatmp2 <- readLines(file)
# reads the large table
  idx.comments <- grep("^[#]", rddatatmp2)
  rddatatmp2 <- rddatatmp2[idx.comments]
  rddatatmp2 <- stri_replace_all_fixed(rddatatmp2, "#", "")


  wb <- createWorkbook()
# use R package openxlsx to create the .xlsx spreadsheet
  addWorksheet(wb, "QW Data TZ Corrected")
# adds the worksheet with the name of QW Data TZ Corrected
  writeDataTable(wb, "QW Data TZ Corrected", RDdatatmp)
# writes the data to the workbook
  setColWidths(wb, sheet = 1, cols = 1, widths = 22)
# column width of 22 units for column 1
  addWorksheet(wb, "QW Data")
# adds the worksheet with the name of QW Data
  writeDataTable(wb, "QW Data", rddatatmp1)
# writes the data to the workbook
  setColWidths(wb, sheet = 2, cols = 1:ncol(rddatatmp1), widths = 22)
# column width of 22 units for all columns
  addWorksheet(wb, paste(site_no, "meta", sep = " "))
# adds the worksheet with the name of meta
  writeData(wb, paste(site_no, "meta", sep = " "), rddatatmp2)
# writes the data to the workbook
  filesave1 <- tclvalue(tkgetSaveFile(title = paste0("Save", " ", stri_trans_toupper(basename(file_path_sans_ext(file))), " ", "file as"), filetypes = "{{MS Excel file} .xlsx}"))
# Source 3 & 4 / GUI file dialog to save the spreadsheet
# Source 12 & 13 / original file name minus the extension and path in uppercase
  saveWorkbook(wb, filesave1, overwrite = overwrite)

}
}
}

} else {

for (i in 1:length(file)) {

# Source 5
if (!nchar(file[i])) {

  stop("You did not choose a file. Please try again with a different file.")
# Source 2 / provide a stop warning if no file was selected

} else {

confirm <- gconfirm(toolkit = guiToolkit("tcltk"), msg = paste0("Do you want to select", " ", file[i], "?"), title = "Confirm", icon = "question")

if (confirm == FALSE) {

  stop("Please try again with a different file.")
# Source 2 / provide a stop warning if the user wants to change the file

} else {

if (file.info(file[i])$size == 0) {

  stop("Your file is empty. Please try again with a different file.")
# Source 1 & 2 / only process non-empty files and provide a stop warning if the input file is empty

} else {

# Source 5 begins
  assign(file[i], read.table(file[i], header = TRUE, row.names = NULL, comment.char = "#", fill = TRUE, stringsAsFactors = FALSE, sep = "\t"))
# reads the qw data file as a table and fills in the table with NA for any missing values
  rddatatmp <- assign(file[i], get(file[i]))
# Source 5 ends

  rddatatmp <- setDT(rddatatmp)

  rddatatmp1 <- copy(rddatatmp)

  site_no <- rddatatmp[2, "site_no", with = FALSE][[1]]

  rddatatmp <- rddatatmp[-1, -c("agency_cd", "site_no"), with = FALSE]

 datecol <- which(grepl(rddatatmp, pattern = "\\d{0,2}/\\d{2}/(?:\\d{4}|\\d{2})?|\\d{0,2}-\\d{2}-(?:\\d{4}|\\d{2})?|\\d{0,2}\\.\\d{2}\\.(?:\\d{4}|\\d{2})?|(\\b)([A-Za-z]{3,9})(\\s+)([0-9][0-9]*)(,)(\\s+)([0-9]{4})|[0-9]{4}-[0-9]{2}-[0-9]{2}|\\d{0,2}/\\d{2}/(?:\\d{4}|\\d{2})?|\\d{0,2}-\\d{2}-(?:\\d{4}|\\d{2})?|\\d{0,2}\\.\\d{2}\\.(?:\\d{4}|\\d{2})?|(\\b)([A-Za-z]{3,9})(\\s+)([0-9][0-9]*)(,)(\\s+)([0-9]{4})|[0-9]{4}-[0-9]{2}-[0-9]{2}") == TRUE) # Source 15

 datecolname <- names(rddatatmp[, datecol, with = FALSE])

 timecol <- which(grepl(rddatatmp, pattern = "\\d{0,2}:\\d{2}(?:[:.]\\d+)?|(\\d{0,2}:\\d{2}(?:[:.]\\d+)?)(\\s+(([AP]\\.{0,1}M\\.{0,1})|([ap]\\.{0,1}m\\.{0,1})))") == TRUE) # Source 15

 timecolname <- names(rddatatmp[, timecol, with = FALSE])

 ifelse (datecol == timecol, timecol <- NA, datecol <- datecol)
 ifelse (length(timecol) == 0, timecol <- NA, timecol <- timecol)


 if (!is.na(timecol)) {
  numericcol <- which(grepl(rddatatmp, pattern = "[0-9]"))
 numericcol <- numericcol[-c(datecol, timecol)]

 } else if (is.na(timecol)) {

 numericcol <- which(grepl(rddatatmp, pattern = "[0-9]"))
 numericcol <- numericcol[-datecol]

 }


# changing column to numeric class
# obtain the name of the column based on the column number
  change_class1 <- numericcol
  for (col in change_class1) set(rddatatmp, j = col, value = as.numeric(rddatatmp[[col]])) # Source 4

  tz_column <- which(grepl(rddatatmp, pattern = "EST|EDT|CST|CDT|MST|MDT|PST|PDT|AKST|AKDT|HST|HDT|AST|ADT"))
  tz_columnname <- names(rddatatmp[, tz_column, with = FALSE])

dateformat <- guess_formats(rddatatmp[, datecol, with = FALSE][[1]], c("ymd", "dmy", "mdy", "ymd hm", "dmy hm", "mdy hm", "ymd hms", "dmy hms", "mdy hms"))

ymd_check <- length(which(names(dateformat) == "ymd") == TRUE) == nrow(rddatatmp)
dmy_check <- length(which(names(dateformat) == "dmy") == TRUE) == nrow(rddatatmp)
mdy_check <- length(which(names(dateformat) == "mdy") == TRUE) == nrow(rddatatmp)
ymdHM_check <- length(which(names(dateformat) == "ymdHM") == TRUE) == nrow(rddatatmp)
dmyHM_check <- length(which(names(dateformat) == "dmyHM") == TRUE) == nrow(rddatatmp)
mdyHM_check <- length(which(names(dateformat) == "mdyHM") == TRUE) == nrow(rddatatmp)
ymdHMS_check <- length(which(names(dateformat) == "ymdHMS") == TRUE) == nrow(rddatatmp)
dmyHMS_check <- length(which(names(dateformat) == "dmyHMS") == TRUE) == nrow(rddatatmp)
mdyHMS_check <- length(which(names(dateformat) == "mdyHMS") == TRUE) == nrow(rddatatmp)

datechecks <- data.table(ymd_check, dmy_check, mdy_check, ymdHM_check, dmyHM_check, mdyHM_check, ymdHMS_check, dmyHMS_check, mdyHMS_check)


if (is.na(timecol)) {

if (ymd_check) {

rddatatmp[, DateTimes := rddatatmp[, datecol, with = FALSE][[1]]]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class1 <- "DateTimes"
  for (col in change_class1) set(rddatatmp, j = col, value = ymd(rddatatmp[[col]], quiet = TRUE)) # Source 6

  rddatatmp[, datecolname := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))


} else if (ymdHM_check) {

rddatatmp[, DateTimes := rddatatmp[, datecol, with = FALSE][[1]]]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class2 <- "DateTimes"
  for (col in change_class2) set(rddatatmp, j = col, value = ymd_hm(rddatatmp[[col]], quiet = TRUE, tz = "GMT")) # Source 6

  rddatatmp[, datecolname := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))

  datetime <- as.POSIXct(rddatatmp[[1]], tzone = "GMT")
  rddatatmp[, datetimes := as.numeric(datetime)]

  rddatatmp[, DateTimes_Timezone_Corrected := ifelse (grepl(rddatatmp[, tz_columnname, with = FALSE][[1]], pattern = "EDT|CDT|MDT|PDT|AKDT|HDT|ADT"), {rddatatmp[, datetimes] - 3600}, {rddatatmp[, datetimes]})]
# Source 8 / if the date-time stamp is DT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time

  rddatatmp[, DateTimes_Timezone_Corrected2 := as.POSIXct(DateTimes_Timezone_Corrected, origin = "1970-01-01 00:00:00", tzone = "GMT")]
# convert the numeric date time back to POSIXct with the origin of GMT

  attributes(rddatatmp$DateTimes_Timezone_Corrected2)$tzone <- "GMT" # Source 16

  rddatatmp[, c("datetimes", "DateTimes", "DateTimes_Timezone_Corrected") := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))
  setnames(rddatatmp, 1, "DateTime")


} else if (ymdHMS_check) {

rddatatmp[, DateTimes := rddatatmp[, datecol, with = FALSE][[1]]]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class2 <- "DateTimes"
  for (col in change_class2) set(rddatatmp, j = col, value = ymd_hms(rddatatmp[[col]], quiet = TRUE, tz = "GMT")) # Source 6

  rddatatmp[, datecolname := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))

  datetime <- as.POSIXct(rddatatmp[[1]], tzone = "GMT")
  rddatatmp[, datetimes := as.numeric(datetime)]

  rddatatmp[, DateTimes_Timezone_Corrected := ifelse (grepl(rddatatmp[, tz_columnname, with = FALSE][[1]], pattern = "EDT|CDT|MDT|PDT|AKDT|HDT|ADT"), {rddatatmp[, datetimes] - 3600}, {rddatatmp[, datetimes]})]
# Source 8 / if the date-time stamp is DT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time

  rddatatmp[, DateTimes_Timezone_Corrected2 := as.POSIXct(DateTimes_Timezone_Corrected, origin = "1970-01-01 00:00:00", tzone = "GMT")]
# convert the numeric date time back to POSIXct with the origin of GMT

  attributes(rddatatmp$DateTimes_Timezone_Corrected2)$tzone <- "GMT" # Source 16

  rddatatmp[, c("datetimes", "DateTimes", "DateTimes_Timezone_Corrected") := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))
  setnames(rddatatmp, 1, "DateTime")


} else if (dmy_check) {

rddatatmp[, DateTimes := rddatatmp[, datecol, with = FALSE][[1]]]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class1 <- "DateTimes"
  for (col in change_class1) set(rddatatmp, j = col, value = dmy(rddatatmp[[col]], quiet = TRUE)) # Source 6

  rddatatmp[, datecolname := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))


} else if (dmyHM_check) {

rddatatmp[, DateTimes := rddatatmp[, datecol, with = FALSE][[1]]]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class2 <- "DateTimes"
  for (col in change_class2) set(rddatatmp, j = col, value = dmy_hm(rddatatmp[[col]], quiet = TRUE, tz = "GMT")) # Source 6

  rddatatmp[, datecolname := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))

  datetime <- as.POSIXct(rddatatmp[[1]], tzone = "GMT")
  rddatatmp[, datetimes := as.numeric(datetime)]

  rddatatmp[, DateTimes_Timezone_Corrected := ifelse (grepl(rddatatmp[, tz_columnname, with = FALSE][[1]], pattern = "EDT|CDT|MDT|PDT|AKDT|HDT|ADT"), {rddatatmp[, datetimes] - 3600}, {rddatatmp[, datetimes]})]
# Source 8 / if the date-time stamp is DT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time

  rddatatmp[, DateTimes_Timezone_Corrected2 := as.POSIXct(DateTimes_Timezone_Corrected, origin = "1970-01-01 00:00:00", tzone = "GMT")]
# convert the numeric date time back to POSIXct with the origin of GMT

  attributes(rddatatmp$DateTimes_Timezone_Corrected2)$tzone <- "GMT" # Source 16

  rddatatmp[, c("datetimes", "DateTimes", "DateTimes_Timezone_Corrected") := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))
  setnames(rddatatmp, 1, "DateTime")


  } else if (dmyHMS_check) {

rddatatmp[, DateTimes := rddatatmp[, datecol, with = FALSE][[1]]]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class2 <- "DateTimes"
  for (col in change_class2) set(rddatatmp, j = col, value = dmy_hms(rddatatmp[[col]], quiet = TRUE, tz = "GMT")) # Source 6

  rddatatmp[, datecolname := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))

  datetime <- as.POSIXct(rddatatmp[[1]], tzone = "GMT")
  rddatatmp[, datetimes := as.numeric(datetime)]

  rddatatmp[, DateTimes_Timezone_Corrected := ifelse (grepl(rddatatmp[, tz_columnname, with = FALSE][[1]], pattern = "EDT|CDT|MDT|PDT|AKDT|HDT|ADT"), {rddatatmp[, datetimes] - 3600}, {rddatatmp[, datetimes]})]
# Source 8 / if the date-time stamp is DT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time

  rddatatmp[, DateTimes_Timezone_Corrected2 := as.POSIXct(DateTimes_Timezone_Corrected, origin = "1970-01-01 00:00:00", tzone = "GMT")]
# convert the numeric date time back to POSIXct with the origin of GMT

  attributes(rddatatmp$DateTimes_Timezone_Corrected2)$tzone <- "GMT" # Source 16

  rddatatmp[, c("datetimes", "DateTimes", "DateTimes_Timezone_Corrected") := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))
  setnames(rddatatmp, 1, "DateTime")


} else if (mdy_check) {

rddatatmp[, DateTimes := rddatatmp[, datecol, with = FALSE][[1]]]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class1 <- "DateTimes"
  for (col in change_class1) set(rddatatmp, j = col, value = mdy(rddatatmp[[col]], quiet = TRUE)) # Source 6

  rddatatmp[, datecolname := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))


} else if (mdyHM_check) {

rddatatmp[, DateTimes := rddatatmp[, datecol, with = FALSE][[1]]]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class2 <- "DateTimes"
  for (col in change_class2) set(rddatatmp, j = col, value = mdy_hm(rddatatmp[[col]], quiet = TRUE, tz = "GMT")) # Source 6

  rddatatmp[, datecolname := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))

  datetime <- as.POSIXct(rddatatmp[[1]], tzone = "GMT")
  rddatatmp[, datetimes := as.numeric(datetime)]

  rddatatmp[, DateTimes_Timezone_Corrected := ifelse (grepl(rddatatmp[, tz_columnname, with = FALSE][[1]], pattern = "EDT|CDT|MDT|PDT|AKDT|HDT|ADT"), {rddatatmp[, datetimes] - 3600}, {rddatatmp[, datetimes]})]
# Source 8 / if the date-time stamp is DT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time

  rddatatmp[, DateTimes_Timezone_Corrected2 := as.POSIXct(DateTimes_Timezone_Corrected, origin = "1970-01-01 00:00:00", tzone = "GMT")]
# convert the numeric date time back to POSIXct with the origin of GMT

  attributes(rddatatmp$DateTimes_Timezone_Corrected2)$tzone <- "GMT" # Source 16

  rddatatmp[, c("datetimes", "DateTimes", "DateTimes_Timezone_Corrected") := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))
  setnames(rddatatmp, 1, "DateTime")


  } else if (mdyHMS_check) {

rddatatmp[, DateTimes := rddatatmp[, datecol, with = FALSE][[1]]]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class2 <- "DateTimes"
  for (col in change_class2) set(rddatatmp, j = col, value = mdy_hms(rddatatmp[[col]], quiet = TRUE, tz = "GMT")) # Source 6

  rddatatmp[, datecolname := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))

  datetime <- as.POSIXct(rddatatmp[[1]], tzone = "GMT")
  rddatatmp[, datetimes := as.numeric(datetime)]

  rddatatmp[, DateTimes_Timezone_Corrected := ifelse (grepl(rddatatmp[, tz_columnname, with = FALSE][[1]], pattern = "EDT|CDT|MDT|PDT|AKDT|HDT|ADT"), {rddatatmp[, datetimes] - 3600}, {rddatatmp[, datetimes]})]
# Source 8 / if the date-time stamp is DT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time

  rddatatmp[, DateTimes_Timezone_Corrected2 := as.POSIXct(DateTimes_Timezone_Corrected, origin = "1970-01-01 00:00:00", tzone = "GMT")]
# convert the numeric date time back to POSIXct with the origin of GMT

  attributes(rddatatmp$DateTimes_Timezone_Corrected2)$tzone <- "GMT" # Source 16

  rddatatmp[, c("datetimes", "DateTimes", "DateTimes_Timezone_Corrected") := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))
  setnames(rddatatmp, 1, "DateTime")

  }

} else if (!is.na(timecol)) {

if (ymd_check) {

rddatatmp[, DateTimes := paste(rddatatmp[, datecol, with = FALSE][[1]], rddatatmp[, timecol, with = FALSE][[1]], sep = " ")]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class2 <- "DateTimes"
  for (col in change_class2) set(rddatatmp, j = col, value = ymd_hm(rddatatmp[[col]], quiet = TRUE, tz = "GMT")) # Source 6

  rddatatmp[, c(datecolname, timecolname) := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))

datetime <- as.POSIXct(rddatatmp[[1]], tzone = "GMT")
  rddatatmp[, datetimes := as.numeric(datetime)]

  rddatatmp[, DateTimes_Timezone_Corrected := ifelse (grepl(rddatatmp[, tz_columnname, with = FALSE][[1]], pattern = "EDT|CDT|MDT|PDT|AKDT|HDT|ADT"), {rddatatmp[, datetimes] - 3600}, {rddatatmp[, datetimes]})]
# Source 8 / if the date-time stamp is DT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time

  rddatatmp[, DateTimes_Timezone_Corrected2 := as.POSIXct(DateTimes_Timezone_Corrected, origin = "1970-01-01 00:00:00", tzone = "GMT")]
# convert the numeric date time back to POSIXct with the origin of GMT

  attributes(rddatatmp$DateTimes_Timezone_Corrected2)$tzone <- "GMT" # Source 16

  rddatatmp[, c("datetimes", "DateTimes", "DateTimes_Timezone_Corrected") := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))
  setnames(rddatatmp, 1, "DateTime")


} else if (ymdHM_check) {

rddatatmp[, DateTimes := paste(rddatatmp[, datecol, with = FALSE][[1]], rddatatmp[, timecol, with = FALSE][[1]], sep = " ")]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class2 <- "DateTimes"
  for (col in change_class2) set(rddatatmp, j = col, value = ymd_hm(rddatatmp[[col]], quiet = TRUE, tz = "GMT")) # Source 6

  rddatatmp[, c(datecolname, timecolname) := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))

datetime <- as.POSIXct(rddatatmp[[1]], tzone = "GMT")
  rddatatmp[, datetimes := as.numeric(datetime)]

  rddatatmp[, DateTimes_Timezone_Corrected := ifelse (grepl(rddatatmp[, tz_columnname, with = FALSE][[1]], pattern = "EDT|CDT|MDT|PDT|AKDT|HDT|ADT"), {rddatatmp[, datetimes] - 3600}, {rddatatmp[, datetimes]})]
# Source 8 / if the date-time stamp is DT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time

  rddatatmp[, DateTimes_Timezone_Corrected2 := as.POSIXct(DateTimes_Timezone_Corrected, origin = "1970-01-01 00:00:00", tzone = "GMT")]
# convert the numeric date time back to POSIXct with the origin of GMT

  attributes(rddatatmp$DateTimes_Timezone_Corrected2)$tzone <- "GMT" # Source 16

  rddatatmp[, c("datetimes", "DateTimes", "DateTimes_Timezone_Corrected") := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))
  setnames(rddatatmp, 1, "DateTime")


  } else if (ymdHMS_check) {

rddatatmp[, DateTimes := paste(rddatatmp[, datecol, with = FALSE][[1]], rddatatmp[, timecol, with = FALSE][[1]], sep = " ")]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class2 <- "DateTimes"
  for (col in change_class2) set(rddatatmp, j = col, value = ymd_hms(rddatatmp[[col]], quiet = TRUE, tz = "GMT")) # Source 6

  rddatatmp[, c(datecolname, timecolname) := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))

datetime <- as.POSIXct(rddatatmp[[1]], tzone = "GMT")
  rddatatmp[, datetimes := as.numeric(datetime)]

  rddatatmp[, DateTimes_Timezone_Corrected := ifelse (grepl(rddatatmp[, tz_columnname, with = FALSE][[1]], pattern = "EDT|CDT|MDT|PDT|AKDT|HDT|ADT"), {rddatatmp[, datetimes] - 3600}, {rddatatmp[, datetimes]})]
# Source 8 / if the date-time stamp is DT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time

  rddatatmp[, DateTimes_Timezone_Corrected2 := as.POSIXct(DateTimes_Timezone_Corrected, origin = "1970-01-01 00:00:00", tzone = "GMT")]
# convert the numeric date time back to POSIXct with the origin of GMT

  attributes(rddatatmp$DateTimes_Timezone_Corrected2)$tzone <- "GMT" # Source 16

  rddatatmp[, c("datetimes", "DateTimes", "DateTimes_Timezone_Corrected") := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))
  setnames(rddatatmp, 1, "DateTime")


  } else if (dmy_check) {

rddatatmp[, DateTimes := paste(rddatatmp[, datecol, with = FALSE][[1]], rddatatmp[, timecol, with = FALSE][[1]], sep = " ")]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class2 <- "DateTimes"
  for (col in change_class2) set(rddatatmp, j = col, value = mdy_hm(rddatatmp[[col]], quiet = TRUE, tz = "GMT")) # Source 6

  rddatatmp[, c(datecolname, timecolname) := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))

  datetime <- as.POSIXct(rddatatmp[[1]], tzone = "GMT")
  rddatatmp[, datetimes := as.numeric(datetime)]

  rddatatmp[, DateTimes_Timezone_Corrected := ifelse (grepl(rddatatmp[, tz_columnname, with = FALSE][[1]], pattern = "EDT|CDT|MDT|PDT|AKDT|HDT|ADT"), {rddatatmp[, datetimes] - 3600}, {rddatatmp[, datetimes]})]
# Source 8 / if the date-time stamp is DT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time

  rddatatmp[, DateTimes_Timezone_Corrected2 := as.POSIXct(DateTimes_Timezone_Corrected, origin = "1970-01-01 00:00:00", tzone = "GMT")]
# convert the numeric date time back to POSIXct with the origin of GMT

  attributes(rddatatmp$DateTimes_Timezone_Corrected2)$tzone <- "GMT" # Source 16

  rddatatmp[, c("datetimes", "DateTimes", "DateTimes_Timezone_Corrected") := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))
  setnames(rddatatmp, 1, "DateTime")


} else if (dmyHM_check) {

rddatatmp[, DateTimes := paste(rddatatmp[, datecol, with = FALSE][[1]], rddatatmp[, timecol, with = FALSE][[1]], sep = " ")]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class2 <- "DateTimes"
  for (col in change_class2) set(rddatatmp, j = col, value = dmy_hm(rddatatmp[[col]], quiet = TRUE, tz = "GMT")) # Source 6

  rddatatmp[, c(datecolname, timecolname) := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))

  datetime <- as.POSIXct(rddatatmp[[1]], tzone = "GMT")
  rddatatmp[, datetimes := as.numeric(datetime)]

  rddatatmp[, DateTimes_Timezone_Corrected := ifelse (grepl(rddatatmp[, tz_columnname, with = FALSE][[1]], pattern = "EDT|CDT|MDT|PDT|AKDT|HDT|ADT"), {rddatatmp[, datetimes] - 3600}, {rddatatmp[, datetimes]})]
# Source 8 / if the date-time stamp is DT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time

  rddatatmp[, DateTimes_Timezone_Corrected2 := as.POSIXct(DateTimes_Timezone_Corrected, origin = "1970-01-01 00:00:00", tzone = "GMT")]
# convert the numeric date time back to POSIXct with the origin of GMT

  attributes(rddatatmp$DateTimes_Timezone_Corrected2)$tzone <- "GMT" # Source 16

  rddatatmp[, c("datetimes", "DateTimes", "DateTimes_Timezone_Corrected") := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))
  setnames(rddatatmp, 1, "DateTime")


  } else if (dmyHMS_check) {

rddatatmp[, DateTimes := paste(rddatatmp[, datecol, with = FALSE][[1]], rddatatmp[, timecol, with = FALSE][[1]], sep = " ")]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class2 <- "DateTimes"
  for (col in change_class2) set(rddatatmp, j = col, value = dmy_hms(rddatatmp[[col]], quiet = TRUE, tz = "GMT")) # Source 6

  rddatatmp[, c(datecolname, timecolname) := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))

  datetime <- as.POSIXct(rddatatmp[[1]], tzone = "GMT")
  rddatatmp[, datetimes := as.numeric(datetime)]

  rddatatmp[, DateTimes_Timezone_Corrected := ifelse (grepl(rddatatmp[, tz_columnname, with = FALSE][[1]], pattern = "EDT|CDT|MDT|PDT|AKDT|HDT|ADT"), {rddatatmp[, datetimes] - 3600}, {rddatatmp[, datetimes]})]
# Source 8 / if the date-time stamp is DT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time

  rddatatmp[, DateTimes_Timezone_Corrected2 := as.POSIXct(DateTimes_Timezone_Corrected, origin = "1970-01-01 00:00:00", tzone = "GMT")]
# convert the numeric date time back to POSIXct with the origin of GMT

  attributes(rddatatmp$DateTimes_Timezone_Corrected2)$tzone <- "GMT" # Source 16

  rddatatmp[, c("datetimes", "DateTimes", "DateTimes_Timezone_Corrected") := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))
  setnames(rddatatmp, 1, "DateTime")


  } else if (mdy_check) {

rddatatmp[, DateTimes := paste(rddatatmp[, datecol, with = FALSE][[1]], rddatatmp[, timecol, with = FALSE][[1]], sep = " ")]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class2 <- "DateTimes"
  for (col in change_class2) set(rddatatmp, j = col, value = mdy_hm(rddatatmp[[col]], quiet = TRUE, tz = "GMT")) # Source 6

  rddatatmp[, c(datecolname, timecolname) := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))

  datetime <- as.POSIXct(rddatatmp[[1]], tzone = "GMT")
  rddatatmp[, datetimes := as.numeric(datetime)]

  rddatatmp[, DateTimes_Timezone_Corrected := ifelse (grepl(rddatatmp[, tz_columnname, with = FALSE][[1]], pattern = "EDT|CDT|MDT|PDT|AKDT|HDT|ADT"), {rddatatmp[, datetimes] - 3600}, {rddatatmp[, datetimes]})]
# Source 8 / if the date-time stamp is DT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time

  rddatatmp[, DateTimes_Timezone_Corrected2 := as.POSIXct(DateTimes_Timezone_Corrected, origin = "1970-01-01 00:00:00", tzone = "GMT")]
# convert the numeric date time back to POSIXct with the origin of GMT

  attributes(rddatatmp$DateTimes_Timezone_Corrected2)$tzone <- "GMT" # Source 16

  rddatatmp[, c("datetimes", "DateTimes", "DateTimes_Timezone_Corrected") := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))
  setnames(rddatatmp, 1, "DateTime")


   } else if (mdyHM_check) {

rddatatmp[, DateTimes := paste(rddatatmp[, datecol, with = FALSE][[1]], rddatatmp[, timecol, with = FALSE][[1]], sep = " ")]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class2 <- "DateTimes"
  for (col in change_class2) set(rddatatmp, j = col, value = mdy_hm(rddatatmp[[col]], quiet = TRUE, tz = "GMT")) # Source 6

  rddatatmp[, c(datecolname, timecolname) := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))

  datetime <- as.POSIXct(rddatatmp[[1]], tzone = "GMT")
  rddatatmp[, datetimes := as.numeric(datetime)]

  rddatatmp[, DateTimes_Timezone_Corrected := ifelse (grepl(rddatatmp[, tz_columnname, with = FALSE][[1]], pattern = "EDT|CDT|MDT|PDT|AKDT|HDT|ADT"), {rddatatmp[, datetimes] - 3600}, {rddatatmp[, datetimes]})]
# Source 8 / if the date-time stamp is DT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time

  rddatatmp[, DateTimes_Timezone_Corrected2 := as.POSIXct(DateTimes_Timezone_Corrected, origin = "1970-01-01 00:00:00", tzone = "GMT")]
# convert the numeric date time back to POSIXct with the origin of GMT

  attributes(rddatatmp$DateTimes_Timezone_Corrected2)$tzone <- "GMT" # Source 16

  rddatatmp[, c("datetimes", "DateTimes", "DateTimes_Timezone_Corrected") := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))
  setnames(rddatatmp, 1, "DateTime")


} else if (mdyHMS_check) {

rddatatmp[, DateTimes := paste(rddatatmp[, datecol, with = FALSE][[1]], rddatatmp[, timecol, with = FALSE][[1]], sep = " ")]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class2 <- "DateTimes"
  for (col in change_class2) set(rddatatmp, j = col, value = mdy_hms(rddatatmp[[col]], quiet = TRUE, tz = "GMT")) # Source 6

  rddatatmp[, c(datecolname, timecolname) := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))

  datetime <- as.POSIXct(rddatatmp[[1]], tzone = "GMT")
  rddatatmp[, datetimes := as.numeric(datetime)]

  rddatatmp[, DateTimes_Timezone_Corrected := ifelse (grepl(rddatatmp[, tz_columnname, with = FALSE][[1]], pattern = "EDT|CDT|MDT|PDT|AKDT|HDT|ADT"), {rddatatmp[, datetimes] - 3600}, {rddatatmp[, datetimes]})]
# Source 8 / if the date-time stamp is DT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time

  rddatatmp[, DateTimes_Timezone_Corrected2 := as.POSIXct(DateTimes_Timezone_Corrected, origin = "1970-01-01 00:00:00", tzone = "GMT")]
# convert the numeric date time back to POSIXct with the origin of GMT

  attributes(rddatatmp$DateTimes_Timezone_Corrected2)$tzone <- "GMT" # Source 16

  rddatatmp[, c("datetimes", "DateTimes", "DateTimes_Timezone_Corrected") := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))
  setnames(rddatatmp, 1, "DateTime")

  }
  }


## Source 9 and 10 begin
    RDdatatmp <- copy(rddatatmp) # copies rddatatmp

if (grepl(RDdatatmp[[1]][1], pattern = "\\d{0,2}:\\d{2}(?:[:.]\\d+)?|(\\d{0,2}:\\d{2}(?:[:.]\\d+)?)(\\s+(([AP]\\.{0,1}M\\.{0,1})|([ap]\\.{0,1}m\\.{0,1})))") == TRUE) { # Source 15

    RDdatatmp[[1]] <- strptime(RDdatatmp[[1]], "%Y-%m-%d %H:%M:%S") # changes from POSIXct to character for the DateTime
    RDdatatmp[[1]] <- format(RDdatatmp[[1]], "%Y-%m-%d %H:%M:%S") # Source 17 / changes the DateTime format to numeric month/numeric date/four digit year with HMS

} else {

    RDdatatmp[[1]] <- strptime(RDdatatmp[[1]], "%Y-%m-%d") # changes from POSIXct to character for the DateTime
    RDdatatmp[[1]] <- format(RDdatatmp[[1]], "%Y-%m-%d") # Source 17 / changes the DateTime format to numeric month/numeric date/four digit year
}
## Source 9 and 10 end


  rddatatmp2 <- readLines(file[i])
# reads the large table
  idx.comments <- grep("^[#]", rddatatmp2)
  rddatatmp2 <- rddatatmp2[idx.comments]
  rddatatmp2 <- stri_replace_all_fixed(rddatatmp2, "#", "")


  wb <- createWorkbook()
# use R package openxlsx to create the .xlsx spreadsheet
  addWorksheet(wb, "QW Data TZ Corrected")
# adds the worksheet with the name of QW Data TZ Corrected
  writeDataTable(wb, "QW Data TZ Corrected", RDdatatmp)
# writes the data to the workbook
  setColWidths(wb, sheet = 1, cols = 1, widths = 22)
# column width of 22 units for column 1
  addWorksheet(wb, "QW Data")
# adds the worksheet with the name of QW Data
  writeDataTable(wb, "QW Data", rddatatmp1)
# writes the data to the workbook
  setColWidths(wb, sheet = 2, cols = 1:ncol(rddatatmp1), widths = 22)
# column width of 22 units for all columns
  addWorksheet(wb, paste(site_no, "meta", sep = " "))
# adds the worksheet with the name of meta
  writeData(wb, paste(site_no, "meta", sep = " "), rddatatmp2)
# writes the data to the workbook
  filesave2 <- tclvalue(tkgetSaveFile(title = paste0("Save", " ", stri_trans_toupper(basename(file_path_sans_ext(file[i]))), " ", "file as"), filetypes = "{{MS Excel file} .xlsx}"))
# Source 3 & 4 / GUI file dialog to save the spreadsheet
# Source 12 & 13 / original file name minus the extension and path in uppercase
  saveWorkbook(wb, filesave2, overwrite = overwrite)

}
}
}
}
}


} else if (interactive == FALSE) { # Interactive = FALSE

filesave3 <- tk_choose.dir(caption = "Select directory to save the .xlsx files")
# user selects directory and save all .xlsx files with given names in the chosen directory

# Source 5 begins
for (i in 1:length(file)) {

  assign(file[i], read.table(file[i], header = TRUE, row.names = NULL, comment.char = "#", fill = TRUE, stringsAsFactors = FALSE, sep = "\t"))
# reads the qw data file as a table and fills in the table with NA for any missing values
  rddatatmp <- assign(file[i], get(file[i]))
# Source 5 ends

  rddatatmp <- setDT(rddatatmp)

  rddatatmp1 <- copy(rddatatmp)

  site_no <- rddatatmp[2, "site_no", with = FALSE][[1]]

  rddatatmp <- rddatatmp[-1, -c("agency_cd", "site_no"), with = FALSE]

 datecol <- which(grepl(rddatatmp, pattern = "\\d{0,2}/\\d{2}/(?:\\d{4}|\\d{2})?|\\d{0,2}-\\d{2}-(?:\\d{4}|\\d{2})?|\\d{0,2}\\.\\d{2}\\.(?:\\d{4}|\\d{2})?|(\\b)([A-Za-z]{3,9})(\\s+)([0-9][0-9]*)(,)(\\s+)([0-9]{4})|[0-9]{4}-[0-9]{2}-[0-9]{2}|\\d{0,2}/\\d{2}/(?:\\d{4}|\\d{2})?|\\d{0,2}-\\d{2}-(?:\\d{4}|\\d{2})?|\\d{0,2}\\.\\d{2}\\.(?:\\d{4}|\\d{2})?|(\\b)([A-Za-z]{3,9})(\\s+)([0-9][0-9]*)(,)(\\s+)([0-9]{4})|[0-9]{4}-[0-9]{2}-[0-9]{2}") == TRUE) # Source 15

 datecolname <- names(rddatatmp[, datecol, with = FALSE])

 timecol <- which(grepl(rddatatmp, pattern = "\\d{0,2}:\\d{2}(?:[:.]\\d+)?|(\\d{0,2}:\\d{2}(?:[:.]\\d+)?)(\\s+(([AP]\\.{0,1}M\\.{0,1})|([ap]\\.{0,1}m\\.{0,1})))") == TRUE) # Source 15

 timecolname <- names(rddatatmp[, timecol, with = FALSE])

 ifelse (datecol == timecol, timecol <- NA, datecol <- datecol)
 ifelse (length(timecol) == 0, timecol <- NA, timecol <- timecol)


 if (!is.na(timecol)) {
  numericcol <- which(grepl(rddatatmp, pattern = "[0-9]"))
 numericcol <- numericcol[-c(datecol, timecol)]

 } else if (is.na(timecol)) {

 numericcol <- which(grepl(rddatatmp, pattern = "[0-9]"))
 numericcol <- numericcol[-datecol]

 }


# changing column to numeric class
# obtain the name of the column based on the column number
  change_class1 <- numericcol
  for (col in change_class1) set(rddatatmp, j = col, value = as.numeric(rddatatmp[[col]])) # Source 4

  tz_column <- which(grepl(rddatatmp, pattern = "EST|EDT|CST|CDT|MST|MDT|PST|PDT|AKST|AKDT|HST|HDT|AST|ADT"))
  tz_columnname <- names(rddatatmp[, tz_column, with = FALSE])

dateformat <- guess_formats(rddatatmp[, datecol, with = FALSE][[1]], c("ymd", "dmy", "mdy", "ymd hm", "dmy hm", "mdy hm", "ymd hms", "dmy hms", "mdy hms"))

ymd_check <- length(which(names(dateformat) == "ymd") == TRUE) == nrow(rddatatmp)
dmy_check <- length(which(names(dateformat) == "dmy") == TRUE) == nrow(rddatatmp)
mdy_check <- length(which(names(dateformat) == "mdy") == TRUE) == nrow(rddatatmp)
ymdHM_check <- length(which(names(dateformat) == "ymdHM") == TRUE) == nrow(rddatatmp)
dmyHM_check <- length(which(names(dateformat) == "dmyHM") == TRUE) == nrow(rddatatmp)
mdyHM_check <- length(which(names(dateformat) == "mdyHM") == TRUE) == nrow(rddatatmp)
ymdHMS_check <- length(which(names(dateformat) == "ymdHMS") == TRUE) == nrow(rddatatmp)
dmyHMS_check <- length(which(names(dateformat) == "dmyHMS") == TRUE) == nrow(rddatatmp)
mdyHMS_check <- length(which(names(dateformat) == "mdyHMS") == TRUE) == nrow(rddatatmp)

datechecks <- data.table(ymd_check, dmy_check, mdy_check, ymdHM_check, dmyHM_check, mdyHM_check, ymdHMS_check, dmyHMS_check, mdyHMS_check)


if (is.na(timecol)) {

if (ymd_check) {

rddatatmp[, DateTimes := rddatatmp[, datecol, with = FALSE][[1]]]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class1 <- "DateTimes"
  for (col in change_class1) set(rddatatmp, j = col, value = ymd(rddatatmp[[col]], quiet = TRUE)) # Source 6

  rddatatmp[, datecolname := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))


} else if (ymdHM_check) {

rddatatmp[, DateTimes := rddatatmp[, datecol, with = FALSE][[1]]]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class2 <- "DateTimes"
  for (col in change_class2) set(rddatatmp, j = col, value = ymd_hm(rddatatmp[[col]], quiet = TRUE, tz = "GMT")) # Source 6

  rddatatmp[, datecolname := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))

  datetime <- as.POSIXct(rddatatmp[[1]], tzone = "GMT")
  rddatatmp[, datetimes := as.numeric(datetime)]

  rddatatmp[, DateTimes_Timezone_Corrected := ifelse (grepl(rddatatmp[, tz_columnname, with = FALSE][[1]], pattern = "EDT|CDT|MDT|PDT|AKDT|HDT|ADT"), {rddatatmp[, datetimes] - 3600}, {rddatatmp[, datetimes]})]
# Source 8 / if the date-time stamp is DT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time

  rddatatmp[, DateTimes_Timezone_Corrected2 := as.POSIXct(DateTimes_Timezone_Corrected, origin = "1970-01-01 00:00:00", tzone = "GMT")]
# convert the numeric date time back to POSIXct with the origin of GMT

  attributes(rddatatmp$DateTimes_Timezone_Corrected2)$tzone <- "GMT" # Source 16

  rddatatmp[, c("datetimes", "DateTimes", "DateTimes_Timezone_Corrected") := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))
  setnames(rddatatmp, 1, "DateTime")


} else if (ymdHMS_check) {

rddatatmp[, DateTimes := rddatatmp[, datecol, with = FALSE][[1]]]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class2 <- "DateTimes"
  for (col in change_class2) set(rddatatmp, j = col, value = ymd_hms(rddatatmp[[col]], quiet = TRUE, tz = "GMT")) # Source 6

  rddatatmp[, datecolname := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))

  datetime <- as.POSIXct(rddatatmp[[1]], tzone = "GMT")
  rddatatmp[, datetimes := as.numeric(datetime)]

  rddatatmp[, DateTimes_Timezone_Corrected := ifelse (grepl(rddatatmp[, tz_columnname, with = FALSE][[1]], pattern = "EDT|CDT|MDT|PDT|AKDT|HDT|ADT"), {rddatatmp[, datetimes] - 3600}, {rddatatmp[, datetimes]})]
# Source 8 / if the date-time stamp is DT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time

  rddatatmp[, DateTimes_Timezone_Corrected2 := as.POSIXct(DateTimes_Timezone_Corrected, origin = "1970-01-01 00:00:00", tzone = "GMT")]
# convert the numeric date time back to POSIXct with the origin of GMT

  attributes(rddatatmp$DateTimes_Timezone_Corrected2)$tzone <- "GMT" # Source 16

  rddatatmp[, c("datetimes", "DateTimes", "DateTimes_Timezone_Corrected") := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))
  setnames(rddatatmp, 1, "DateTime")


} else if (dmy_check) {

rddatatmp[, DateTimes := rddatatmp[, datecol, with = FALSE][[1]]]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class1 <- "DateTimes"
  for (col in change_class1) set(rddatatmp, j = col, value = dmy(rddatatmp[[col]], quiet = TRUE)) # Source 6

  rddatatmp[, datecolname := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))


} else if (dmyHM_check) {

rddatatmp[, DateTimes := rddatatmp[, datecol, with = FALSE][[1]]]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class2 <- "DateTimes"
  for (col in change_class2) set(rddatatmp, j = col, value = dmy_hm(rddatatmp[[col]], quiet = TRUE, tz = "GMT")) # Source 6

  rddatatmp[, datecolname := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))

  datetime <- as.POSIXct(rddatatmp[[1]], tzone = "GMT")
  rddatatmp[, datetimes := as.numeric(datetime)]

  rddatatmp[, DateTimes_Timezone_Corrected := ifelse (grepl(rddatatmp[, tz_columnname, with = FALSE][[1]], pattern = "EDT|CDT|MDT|PDT|AKDT|HDT|ADT"), {rddatatmp[, datetimes] - 3600}, {rddatatmp[, datetimes]})]
# Source 8 / if the date-time stamp is DT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time

  rddatatmp[, DateTimes_Timezone_Corrected2 := as.POSIXct(DateTimes_Timezone_Corrected, origin = "1970-01-01 00:00:00", tzone = "GMT")]
# convert the numeric date time back to POSIXct with the origin of GMT

  attributes(rddatatmp$DateTimes_Timezone_Corrected2)$tzone <- "GMT" # Source 16

  rddatatmp[, c("datetimes", "DateTimes", "DateTimes_Timezone_Corrected") := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))
  setnames(rddatatmp, 1, "DateTime")


  } else if (dmyHMS_check) {

rddatatmp[, DateTimes := rddatatmp[, datecol, with = FALSE][[1]]]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class2 <- "DateTimes"
  for (col in change_class2) set(rddatatmp, j = col, value = dmy_hms(rddatatmp[[col]], quiet = TRUE, tz = "GMT")) # Source 6

  rddatatmp[, datecolname := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))

  datetime <- as.POSIXct(rddatatmp[[1]], tzone = "GMT")
  rddatatmp[, datetimes := as.numeric(datetime)]

  rddatatmp[, DateTimes_Timezone_Corrected := ifelse (grepl(rddatatmp[, tz_columnname, with = FALSE][[1]], pattern = "EDT|CDT|MDT|PDT|AKDT|HDT|ADT"), {rddatatmp[, datetimes] - 3600}, {rddatatmp[, datetimes]})]
# Source 8 / if the date-time stamp is DT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time

  rddatatmp[, DateTimes_Timezone_Corrected2 := as.POSIXct(DateTimes_Timezone_Corrected, origin = "1970-01-01 00:00:00", tzone = "GMT")]
# convert the numeric date time back to POSIXct with the origin of GMT

  attributes(rddatatmp$DateTimes_Timezone_Corrected2)$tzone <- "GMT" # Source 16

  rddatatmp[, c("datetimes", "DateTimes", "DateTimes_Timezone_Corrected") := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))
  setnames(rddatatmp, 1, "DateTime")


} else if (mdy_check) {

rddatatmp[, DateTimes := rddatatmp[, datecol, with = FALSE][[1]]]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class1 <- "DateTimes"
  for (col in change_class1) set(rddatatmp, j = col, value = mdy(rddatatmp[[col]], quiet = TRUE)) # Source 6

  rddatatmp[, datecolname := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))


} else if (mdyHM_check) {

rddatatmp[, DateTimes := rddatatmp[, datecol, with = FALSE][[1]]]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class2 <- "DateTimes"
  for (col in change_class2) set(rddatatmp, j = col, value = mdy_hm(rddatatmp[[col]], quiet = TRUE, tz = "GMT")) # Source 6

  rddatatmp[, datecolname := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))

  datetime <- as.POSIXct(rddatatmp[[1]], tzone = "GMT")
  rddatatmp[, datetimes := as.numeric(datetime)]

  rddatatmp[, DateTimes_Timezone_Corrected := ifelse (grepl(rddatatmp[, tz_columnname, with = FALSE][[1]], pattern = "EDT|CDT|MDT|PDT|AKDT|HDT|ADT"), {rddatatmp[, datetimes] - 3600}, {rddatatmp[, datetimes]})]
# Source 8 / if the date-time stamp is DT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time

  rddatatmp[, DateTimes_Timezone_Corrected2 := as.POSIXct(DateTimes_Timezone_Corrected, origin = "1970-01-01 00:00:00", tzone = "GMT")]
# convert the numeric date time back to POSIXct with the origin of GMT

  attributes(rddatatmp$DateTimes_Timezone_Corrected2)$tzone <- "GMT" # Source 16

  rddatatmp[, c("datetimes", "DateTimes", "DateTimes_Timezone_Corrected") := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))
  setnames(rddatatmp, 1, "DateTime")


  } else if (mdyHMS_check) {

rddatatmp[, DateTimes := rddatatmp[, datecol, with = FALSE][[1]]]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class2 <- "DateTimes"
  for (col in change_class2) set(rddatatmp, j = col, value = mdy_hms(rddatatmp[[col]], quiet = TRUE, tz = "GMT")) # Source 6

  rddatatmp[, datecolname := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))

  datetime <- as.POSIXct(rddatatmp[[1]], tzone = "GMT")
  rddatatmp[, datetimes := as.numeric(datetime)]

  rddatatmp[, DateTimes_Timezone_Corrected := ifelse (grepl(rddatatmp[, tz_columnname, with = FALSE][[1]], pattern = "EDT|CDT|MDT|PDT|AKDT|HDT|ADT"), {rddatatmp[, datetimes] - 3600}, {rddatatmp[, datetimes]})]
# Source 8 / if the date-time stamp is DT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time

  rddatatmp[, DateTimes_Timezone_Corrected2 := as.POSIXct(DateTimes_Timezone_Corrected, origin = "1970-01-01 00:00:00", tzone = "GMT")]
# convert the numeric date time back to POSIXct with the origin of GMT

  attributes(rddatatmp$DateTimes_Timezone_Corrected2)$tzone <- "GMT" # Source 16

  rddatatmp[, c("datetimes", "DateTimes", "DateTimes_Timezone_Corrected") := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))
  setnames(rddatatmp, 1, "DateTime")

  }

} else if (!is.na(timecol)) {

if (ymd_check) {

rddatatmp[, DateTimes := paste(rddatatmp[, datecol, with = FALSE][[1]], rddatatmp[, timecol, with = FALSE][[1]], sep = " ")]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class2 <- "DateTimes"
  for (col in change_class2) set(rddatatmp, j = col, value = ymd_hm(rddatatmp[[col]], quiet = TRUE, tz = "GMT")) # Source 6

  rddatatmp[, c(datecolname, timecolname) := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))

datetime <- as.POSIXct(rddatatmp[[1]], tzone = "GMT")
  rddatatmp[, datetimes := as.numeric(datetime)]

  rddatatmp[, DateTimes_Timezone_Corrected := ifelse (grepl(rddatatmp[, tz_columnname, with = FALSE][[1]], pattern = "EDT|CDT|MDT|PDT|AKDT|HDT|ADT"), {rddatatmp[, datetimes] - 3600}, {rddatatmp[, datetimes]})]
# Source 8 / if the date-time stamp is DT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time

  rddatatmp[, DateTimes_Timezone_Corrected2 := as.POSIXct(DateTimes_Timezone_Corrected, origin = "1970-01-01 00:00:00", tzone = "GMT")]
# convert the numeric date time back to POSIXct with the origin of GMT

  attributes(rddatatmp$DateTimes_Timezone_Corrected2)$tzone <- "GMT" # Source 16

  rddatatmp[, c("datetimes", "DateTimes", "DateTimes_Timezone_Corrected") := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))
  setnames(rddatatmp, 1, "DateTime")


} else if (ymdHM_check) {

rddatatmp[, DateTimes := paste(rddatatmp[, datecol, with = FALSE][[1]], rddatatmp[, timecol, with = FALSE][[1]], sep = " ")]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class2 <- "DateTimes"
  for (col in change_class2) set(rddatatmp, j = col, value = ymd_hm(rddatatmp[[col]], quiet = TRUE, tz = "GMT")) # Source 6

  rddatatmp[, c(datecolname, timecolname) := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))

datetime <- as.POSIXct(rddatatmp[[1]], tzone = "GMT")
  rddatatmp[, datetimes := as.numeric(datetime)]

  rddatatmp[, DateTimes_Timezone_Corrected := ifelse (grepl(rddatatmp[, tz_columnname, with = FALSE][[1]], pattern = "EDT|CDT|MDT|PDT|AKDT|HDT|ADT"), {rddatatmp[, datetimes] - 3600}, {rddatatmp[, datetimes]})]
# Source 8 / if the date-time stamp is DT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time

  rddatatmp[, DateTimes_Timezone_Corrected2 := as.POSIXct(DateTimes_Timezone_Corrected, origin = "1970-01-01 00:00:00", tzone = "GMT")]
# convert the numeric date time back to POSIXct with the origin of GMT

  attributes(rddatatmp$DateTimes_Timezone_Corrected2)$tzone <- "GMT" # Source 16

  rddatatmp[, c("datetimes", "DateTimes", "DateTimes_Timezone_Corrected") := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))
  setnames(rddatatmp, 1, "DateTime")


  } else if (ymdHMS_check) {

rddatatmp[, DateTimes := paste(rddatatmp[, datecol, with = FALSE][[1]], rddatatmp[, timecol, with = FALSE][[1]], sep = " ")]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class2 <- "DateTimes"
  for (col in change_class2) set(rddatatmp, j = col, value = ymd_hms(rddatatmp[[col]], quiet = TRUE, tz = "GMT")) # Source 6

  rddatatmp[, c(datecolname, timecolname) := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))

datetime <- as.POSIXct(rddatatmp[[1]], tzone = "GMT")
  rddatatmp[, datetimes := as.numeric(datetime)]

  rddatatmp[, DateTimes_Timezone_Corrected := ifelse (grepl(rddatatmp[, tz_columnname, with = FALSE][[1]], pattern = "EDT|CDT|MDT|PDT|AKDT|HDT|ADT"), {rddatatmp[, datetimes] - 3600}, {rddatatmp[, datetimes]})]
# Source 8 / if the date-time stamp is DT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time

  rddatatmp[, DateTimes_Timezone_Corrected2 := as.POSIXct(DateTimes_Timezone_Corrected, origin = "1970-01-01 00:00:00", tzone = "GMT")]
# convert the numeric date time back to POSIXct with the origin of GMT

  attributes(rddatatmp$DateTimes_Timezone_Corrected2)$tzone <- "GMT" # Source 16

  rddatatmp[, c("datetimes", "DateTimes", "DateTimes_Timezone_Corrected") := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))
  setnames(rddatatmp, 1, "DateTime")


  } else if (dmy_check) {

rddatatmp[, DateTimes := paste(rddatatmp[, datecol, with = FALSE][[1]], rddatatmp[, timecol, with = FALSE][[1]], sep = " ")]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class2 <- "DateTimes"
  for (col in change_class2) set(rddatatmp, j = col, value = mdy_hm(rddatatmp[[col]], quiet = TRUE, tz = "GMT")) # Source 6

  rddatatmp[, c(datecolname, timecolname) := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))

  datetime <- as.POSIXct(rddatatmp[[1]], tzone = "GMT")
  rddatatmp[, datetimes := as.numeric(datetime)]

  rddatatmp[, DateTimes_Timezone_Corrected := ifelse (grepl(rddatatmp[, tz_columnname, with = FALSE][[1]], pattern = "EDT|CDT|MDT|PDT|AKDT|HDT|ADT"), {rddatatmp[, datetimes] - 3600}, {rddatatmp[, datetimes]})]
# Source 8 / if the date-time stamp is DT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time

  rddatatmp[, DateTimes_Timezone_Corrected2 := as.POSIXct(DateTimes_Timezone_Corrected, origin = "1970-01-01 00:00:00", tzone = "GMT")]
# convert the numeric date time back to POSIXct with the origin of GMT

  attributes(rddatatmp$DateTimes_Timezone_Corrected2)$tzone <- "GMT" # Source 16

  rddatatmp[, c("datetimes", "DateTimes", "DateTimes_Timezone_Corrected") := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))
  setnames(rddatatmp, 1, "DateTime")


} else if (dmyHM_check) {

rddatatmp[, DateTimes := paste(rddatatmp[, datecol, with = FALSE][[1]], rddatatmp[, timecol, with = FALSE][[1]], sep = " ")]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class2 <- "DateTimes"
  for (col in change_class2) set(rddatatmp, j = col, value = dmy_hm(rddatatmp[[col]], quiet = TRUE, tz = "GMT")) # Source 6

  rddatatmp[, c(datecolname, timecolname) := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))

  datetime <- as.POSIXct(rddatatmp[[1]], tzone = "GMT")
  rddatatmp[, datetimes := as.numeric(datetime)]

  rddatatmp[, DateTimes_Timezone_Corrected := ifelse (grepl(rddatatmp[, tz_columnname, with = FALSE][[1]], pattern = "EDT|CDT|MDT|PDT|AKDT|HDT|ADT"), {rddatatmp[, datetimes] - 3600}, {rddatatmp[, datetimes]})]
# Source 8 / if the date-time stamp is DT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time

  rddatatmp[, DateTimes_Timezone_Corrected2 := as.POSIXct(DateTimes_Timezone_Corrected, origin = "1970-01-01 00:00:00", tzone = "GMT")]
# convert the numeric date time back to POSIXct with the origin of GMT

  attributes(rddatatmp$DateTimes_Timezone_Corrected2)$tzone <- "GMT" # Source 16

  rddatatmp[, c("datetimes", "DateTimes", "DateTimes_Timezone_Corrected") := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))
  setnames(rddatatmp, 1, "DateTime")


  } else if (dmyHMS_check) {

rddatatmp[, DateTimes := paste(rddatatmp[, datecol, with = FALSE][[1]], rddatatmp[, timecol, with = FALSE][[1]], sep = " ")]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class2 <- "DateTimes"
  for (col in change_class2) set(rddatatmp, j = col, value = dmy_hms(rddatatmp[[col]], quiet = TRUE, tz = "GMT")) # Source 6

  rddatatmp[, c(datecolname, timecolname) := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))

  datetime <- as.POSIXct(rddatatmp[[1]], tzone = "GMT")
  rddatatmp[, datetimes := as.numeric(datetime)]

  rddatatmp[, DateTimes_Timezone_Corrected := ifelse (grepl(rddatatmp[, tz_columnname, with = FALSE][[1]], pattern = "EDT|CDT|MDT|PDT|AKDT|HDT|ADT"), {rddatatmp[, datetimes] - 3600}, {rddatatmp[, datetimes]})]
# Source 8 / if the date-time stamp is DT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time

  rddatatmp[, DateTimes_Timezone_Corrected2 := as.POSIXct(DateTimes_Timezone_Corrected, origin = "1970-01-01 00:00:00", tzone = "GMT")]
# convert the numeric date time back to POSIXct with the origin of GMT

  attributes(rddatatmp$DateTimes_Timezone_Corrected2)$tzone <- "GMT" # Source 16

  rddatatmp[, c("datetimes", "DateTimes", "DateTimes_Timezone_Corrected") := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))
  setnames(rddatatmp, 1, "DateTime")


  } else if (mdy_check) {

rddatatmp[, DateTimes := paste(rddatatmp[, datecol, with = FALSE][[1]], rddatatmp[, timecol, with = FALSE][[1]], sep = " ")]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class2 <- "DateTimes"
  for (col in change_class2) set(rddatatmp, j = col, value = mdy_hm(rddatatmp[[col]], quiet = TRUE, tz = "GMT")) # Source 6

  rddatatmp[, c(datecolname, timecolname) := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))

  datetime <- as.POSIXct(rddatatmp[[1]], tzone = "GMT")
  rddatatmp[, datetimes := as.numeric(datetime)]

  rddatatmp[, DateTimes_Timezone_Corrected := ifelse (grepl(rddatatmp[, tz_columnname, with = FALSE][[1]], pattern = "EDT|CDT|MDT|PDT|AKDT|HDT|ADT"), {rddatatmp[, datetimes] - 3600}, {rddatatmp[, datetimes]})]
# Source 8 / if the date-time stamp is DT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time

  rddatatmp[, DateTimes_Timezone_Corrected2 := as.POSIXct(DateTimes_Timezone_Corrected, origin = "1970-01-01 00:00:00", tzone = "GMT")]
# convert the numeric date time back to POSIXct with the origin of GMT

  attributes(rddatatmp$DateTimes_Timezone_Corrected2)$tzone <- "GMT" # Source 16

  rddatatmp[, c("datetimes", "DateTimes", "DateTimes_Timezone_Corrected") := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))
  setnames(rddatatmp, 1, "DateTime")


   } else if (mdyHM_check) {

rddatatmp[, DateTimes := paste(rddatatmp[, datecol, with = FALSE][[1]], rddatatmp[, timecol, with = FALSE][[1]], sep = " ")]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class2 <- "DateTimes"
  for (col in change_class2) set(rddatatmp, j = col, value = mdy_hm(rddatatmp[[col]], quiet = TRUE, tz = "GMT")) # Source 6

  rddatatmp[, c(datecolname, timecolname) := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))

  datetime <- as.POSIXct(rddatatmp[[1]], tzone = "GMT")
  rddatatmp[, datetimes := as.numeric(datetime)]

  rddatatmp[, DateTimes_Timezone_Corrected := ifelse (grepl(rddatatmp[, tz_columnname, with = FALSE][[1]], pattern = "EDT|CDT|MDT|PDT|AKDT|HDT|ADT"), {rddatatmp[, datetimes] - 3600}, {rddatatmp[, datetimes]})]
# Source 8 / if the date-time stamp is DT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time

  rddatatmp[, DateTimes_Timezone_Corrected2 := as.POSIXct(DateTimes_Timezone_Corrected, origin = "1970-01-01 00:00:00", tzone = "GMT")]
# convert the numeric date time back to POSIXct with the origin of GMT

  attributes(rddatatmp$DateTimes_Timezone_Corrected2)$tzone <- "GMT" # Source 16

  rddatatmp[, c("datetimes", "DateTimes", "DateTimes_Timezone_Corrected") := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))
  setnames(rddatatmp, 1, "DateTime")


} else if (mdyHMS_check) {

rddatatmp[, DateTimes := paste(rddatatmp[, datecol, with = FALSE][[1]], rddatatmp[, timecol, with = FALSE][[1]], sep = " ")]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class2 <- "DateTimes"
  for (col in change_class2) set(rddatatmp, j = col, value = mdy_hms(rddatatmp[[col]], quiet = TRUE, tz = "GMT")) # Source 6

  rddatatmp[, c(datecolname, timecolname) := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))

  datetime <- as.POSIXct(rddatatmp[[1]], tzone = "GMT")
  rddatatmp[, datetimes := as.numeric(datetime)]

  rddatatmp[, DateTimes_Timezone_Corrected := ifelse (grepl(rddatatmp[, tz_columnname, with = FALSE][[1]], pattern = "EDT|CDT|MDT|PDT|AKDT|HDT|ADT"), {rddatatmp[, datetimes] - 3600}, {rddatatmp[, datetimes]})]
# Source 8 / if the date-time stamp is DT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time

  rddatatmp[, DateTimes_Timezone_Corrected2 := as.POSIXct(DateTimes_Timezone_Corrected, origin = "1970-01-01 00:00:00", tzone = "GMT")]
# convert the numeric date time back to POSIXct with the origin of GMT

  attributes(rddatatmp$DateTimes_Timezone_Corrected2)$tzone <- "GMT" # Source 16

  rddatatmp[, c("datetimes", "DateTimes", "DateTimes_Timezone_Corrected") := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))
  setnames(rddatatmp, 1, "DateTime")

  }
  }


## Source 9 and 10 begin
    RDdatatmp <- copy(rddatatmp) # copies rddatatmp

if (grepl(RDdatatmp[[1]][1], pattern = "\\d{0,2}:\\d{2}(?:[:.]\\d+)?|(\\d{0,2}:\\d{2}(?:[:.]\\d+)?)(\\s+(([AP]\\.{0,1}M\\.{0,1})|([ap]\\.{0,1}m\\.{0,1})))") == TRUE) { # Source 15

    RDdatatmp[[1]] <- strptime(RDdatatmp[[1]], "%Y-%m-%d %H:%M:%S") # changes from POSIXct to character for the DateTime
    RDdatatmp[[1]] <- format(RDdatatmp[[1]], "%Y-%m-%d %H:%M:%S") # Source 17 / changes the DateTime format to numeric month/numeric date/four digit year with HMS

} else {

    RDdatatmp[[1]] <- strptime(RDdatatmp[[1]], "%Y-%m-%d") # changes from POSIXct to character for the DateTime
    RDdatatmp[[1]] <- format(RDdatatmp[[1]], "%Y-%m-%d") # Source 17 / changes the DateTime format to numeric month/numeric date/four digit year
}
## Source 9 and 10 end


  rddatatmp2 <- readLines(file[i])
# reads the large table
  idx.comments <- grep("^[#]", rddatatmp2)
  rddatatmp2 <- rddatatmp2[idx.comments]
  rddatatmp2 <- stri_replace_all_fixed(rddatatmp2, "#", "")

  wb <- createWorkbook()
# use R package openxlsx to create the .xlsx spreadsheet
  addWorksheet(wb, "QW Data TZ Corrected")
# adds the worksheet with the name of QW Data TZ Corrected
  writeDataTable(wb, "QW Data TZ Corrected", RDdatatmp)
# writes the data to the workbook
  setColWidths(wb, sheet = 1, cols = 1, widths = 22)
# column width of 22 units for column 1
  addWorksheet(wb, "QW Data")
# adds the worksheet with the name of QW Data
  writeDataTable(wb, "QW Data", rddatatmp1)
# writes the data to the workbook
  setColWidths(wb, sheet = 2, cols = 1:ncol(rddatatmp1), widths = 22)
# column width of 22 units for all columns
  addWorksheet(wb, paste(site_no, "meta", sep = " "))
# adds the worksheet with the name of meta
  writeData(wb, paste(site_no, "meta", sep = " "), rddatatmp2)
# writes the data to the workbook

# Source 6 and 9 begins
  filesave3a <- paste0(filesave3, "/", basename(file_path_sans_ext(file[i])))
# combine the directory name with the basename and remove the file extension
  saveWorkbook(wb, paste0(filesave3a, ".xlsx"), overwrite = overwrite)
# saves the workbook as original file name without the extension + .xlsx
# Source 6 and 9 ends

}
}
}



#' @export
#' @rdname qw
qwBATCH <- function (path = tk_choose.dir(caption = "Select directory with the QW files"), pattern = "*.rdb", overwrite = TRUE) {

overwrite <- overwrite

#date_times <- date_times_tf <- DateTimes_Timezone_Corrected <- NULL
#sample_start_time_datum_cd <- NULL
# Source 17

confirm <- gconfirm(toolkit = guiToolkit("tcltk"), msg = paste0("Do you want to select", " ", path, " as the directory with the QW files?"), title = "Confirm", icon = "question")

if (confirm == FALSE) {

  stop("Please try again with a different directory.")
# Source 2 / provide a stop warning if the user wants to change the directory

} else {

file <- list.files(path, pattern = pattern, full.names = TRUE, ignore.case = TRUE)

filesave4 <- tk_choose.dir(caption = "Select directory to save the .xlsx files")
# user selects directory and save all .xlsx files with given names in the chosen directory

confirm <- gconfirm(toolkit = guiToolkit("tcltk"), msg = paste0("Do you want to select", " ", filesave4, " as the directory to save the batch set of files?"), title = "Confirm", icon = "question")

if (confirm == FALSE) {

  stop("Please try again with a different directory.")
# Source 2 / provide a stop warning if the user wants to change the directory

} else {

for (i in 1:length(file)) { # Source 5

if (!nchar(file[i])) {

  stop("You did not choose a file. Please try again with a different file.")
# Source 2 / provide a stop warning if no file was selected

} else {

if (file.info(file[i])$size == 0) {
  stop("Your file is empty. Please try again with a different file.")
# Source 1 & 2 / only process non-empty files and provide a stop warning if the input file is empty

} else {

# Source 5 begins
  assign(file[i], read.table(file[i], header = TRUE, row.names = NULL, comment.char = "#", fill = TRUE, stringsAsFactors = FALSE, sep = "\t"))
# reads the qw data file as a table and fills in the table with NA for any missing values
  rddatatmp <- assign(file[i], get(file[i]))
# Source 5 ends

 rddatatmp <- read.table(file, header = TRUE, row.names = NULL, comment.char = "#", fill = TRUE, stringsAsFactors = FALSE, sep = "\t")
  rddatatmp <- setDT(rddatatmp)

  rddatatmp1 <- copy(rddatatmp)

  site_no <- rddatatmp[2, "site_no", with = FALSE][[1]]

  rddatatmp <- rddatatmp[-1, -c("agency_cd", "site_no"), with = FALSE]

 datecol <- which(grepl(rddatatmp, pattern = "\\d{0,2}/\\d{2}/(?:\\d{4}|\\d{2})?|\\d{0,2}-\\d{2}-(?:\\d{4}|\\d{2})?|\\d{0,2}\\.\\d{2}\\.(?:\\d{4}|\\d{2})?|(\\b)([A-Za-z]{3,9})(\\s+)([0-9][0-9]*)(,)(\\s+)([0-9]{4})|[0-9]{4}-[0-9]{2}-[0-9]{2}|\\d{0,2}/\\d{2}/(?:\\d{4}|\\d{2})?|\\d{0,2}-\\d{2}-(?:\\d{4}|\\d{2})?|\\d{0,2}\\.\\d{2}\\.(?:\\d{4}|\\d{2})?|(\\b)([A-Za-z]{3,9})(\\s+)([0-9][0-9]*)(,)(\\s+)([0-9]{4})|[0-9]{4}-[0-9]{2}-[0-9]{2}") == TRUE) # Source 15

 datecolname <- names(rddatatmp[, datecol, with = FALSE])

 timecol <- which(grepl(rddatatmp, pattern = "\\d{0,2}:\\d{2}(?:[:.]\\d+)?|(\\d{0,2}:\\d{2}(?:[:.]\\d+)?)(\\s+(([AP]\\.{0,1}M\\.{0,1})|([ap]\\.{0,1}m\\.{0,1})))") == TRUE) # Source 15

 timecolname <- names(rddatatmp[, timecol, with = FALSE])

 ifelse (datecol == timecol, timecol <- NA, datecol <- datecol)
 ifelse (length(timecol) == 0, timecol <- NA, timecol <- timecol)


 if (!is.na(timecol)) {
  numericcol <- which(grepl(rddatatmp, pattern = "[0-9]"))
 numericcol <- numericcol[-c(datecol, timecol)]

 } else if (is.na(timecol)) {

 numericcol <- which(grepl(rddatatmp, pattern = "[0-9]"))
 numericcol <- numericcol[-datecol]

 }


# changing column to numeric class
# obtain the name of the column based on the column number
  change_class1 <- numericcol
  for (col in change_class1) set(rddatatmp, j = col, value = as.numeric(rddatatmp[[col]])) # Source 4

  tz_column <- which(grepl(rddatatmp, pattern = "EST|EDT|CST|CDT|MST|MDT|PST|PDT|AKST|AKDT|HST|HDT|AST|ADT"))
  tz_columnname <- names(rddatatmp[, tz_column, with = FALSE])

dateformat <- guess_formats(rddatatmp[, datecol, with = FALSE][[1]], c("ymd", "dmy", "mdy", "ymd hm", "dmy hm", "mdy hm", "ymd hms", "dmy hms", "mdy hms"))

ymd_check <- length(which(names(dateformat) == "ymd") == TRUE) == nrow(rddatatmp)
dmy_check <- length(which(names(dateformat) == "dmy") == TRUE) == nrow(rddatatmp)
mdy_check <- length(which(names(dateformat) == "mdy") == TRUE) == nrow(rddatatmp)
ymdHM_check <- length(which(names(dateformat) == "ymdHM") == TRUE) == nrow(rddatatmp)
dmyHM_check <- length(which(names(dateformat) == "dmyHM") == TRUE) == nrow(rddatatmp)
mdyHM_check <- length(which(names(dateformat) == "mdyHM") == TRUE) == nrow(rddatatmp)
ymdHMS_check <- length(which(names(dateformat) == "ymdHMS") == TRUE) == nrow(rddatatmp)
dmyHMS_check <- length(which(names(dateformat) == "dmyHMS") == TRUE) == nrow(rddatatmp)
mdyHMS_check <- length(which(names(dateformat) == "mdyHMS") == TRUE) == nrow(rddatatmp)

datechecks <- data.table(ymd_check, dmy_check, mdy_check, ymdHM_check, dmyHM_check, mdyHM_check, ymdHMS_check, dmyHMS_check, mdyHMS_check)


if (is.na(timecol)) {

if (ymd_check) {

rddatatmp[, DateTimes := rddatatmp[, datecol, with = FALSE][[1]]]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class1 <- "DateTimes"
  for (col in change_class1) set(rddatatmp, j = col, value = ymd(rddatatmp[[col]], quiet = TRUE)) # Source 6

  rddatatmp[, datecolname := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))


} else if (ymdHM_check) {

rddatatmp[, DateTimes := rddatatmp[, datecol, with = FALSE][[1]]]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class2 <- "DateTimes"
  for (col in change_class2) set(rddatatmp, j = col, value = ymd_hm(rddatatmp[[col]], quiet = TRUE, tz = "GMT")) # Source 6

  rddatatmp[, datecolname := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))

  datetime <- as.POSIXct(rddatatmp[[1]], tzone = "GMT")
  rddatatmp[, datetimes := as.numeric(datetime)]

  rddatatmp[, DateTimes_Timezone_Corrected := ifelse (grepl(rddatatmp[, tz_columnname, with = FALSE][[1]], pattern = "EDT|CDT|MDT|PDT|AKDT|HDT|ADT"), {rddatatmp[, datetimes] - 3600}, {rddatatmp[, datetimes]})]
# Source 8 / if the date-time stamp is DT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time

  rddatatmp[, DateTimes_Timezone_Corrected2 := as.POSIXct(DateTimes_Timezone_Corrected, origin = "1970-01-01 00:00:00", tzone = "GMT")]
# convert the numeric date time back to POSIXct with the origin of GMT

  attributes(rddatatmp$DateTimes_Timezone_Corrected2)$tzone <- "GMT" # Source 16

  rddatatmp[, c("datetimes", "DateTimes", "DateTimes_Timezone_Corrected") := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))
  setnames(rddatatmp, 1, "DateTime")


} else if (ymdHMS_check) {

rddatatmp[, DateTimes := rddatatmp[, datecol, with = FALSE][[1]]]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class2 <- "DateTimes"
  for (col in change_class2) set(rddatatmp, j = col, value = ymd_hms(rddatatmp[[col]], quiet = TRUE, tz = "GMT")) # Source 6

  rddatatmp[, datecolname := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))

  datetime <- as.POSIXct(rddatatmp[[1]], tzone = "GMT")
  rddatatmp[, datetimes := as.numeric(datetime)]

  rddatatmp[, DateTimes_Timezone_Corrected := ifelse (grepl(rddatatmp[, tz_columnname, with = FALSE][[1]], pattern = "EDT|CDT|MDT|PDT|AKDT|HDT|ADT"), {rddatatmp[, datetimes] - 3600}, {rddatatmp[, datetimes]})]
# Source 8 / if the date-time stamp is DT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time

  rddatatmp[, DateTimes_Timezone_Corrected2 := as.POSIXct(DateTimes_Timezone_Corrected, origin = "1970-01-01 00:00:00", tzone = "GMT")]
# convert the numeric date time back to POSIXct with the origin of GMT

  attributes(rddatatmp$DateTimes_Timezone_Corrected2)$tzone <- "GMT" # Source 16

  rddatatmp[, c("datetimes", "DateTimes", "DateTimes_Timezone_Corrected") := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))
  setnames(rddatatmp, 1, "DateTime")


} else if (dmy_check) {

rddatatmp[, DateTimes := rddatatmp[, datecol, with = FALSE][[1]]]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class1 <- "DateTimes"
  for (col in change_class1) set(rddatatmp, j = col, value = dmy(rddatatmp[[col]], quiet = TRUE)) # Source 6

  rddatatmp[, datecolname := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))


} else if (dmyHM_check) {

rddatatmp[, DateTimes := rddatatmp[, datecol, with = FALSE][[1]]]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class2 <- "DateTimes"
  for (col in change_class2) set(rddatatmp, j = col, value = dmy_hm(rddatatmp[[col]], quiet = TRUE, tz = "GMT")) # Source 6

  rddatatmp[, datecolname := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))

  datetime <- as.POSIXct(rddatatmp[[1]], tzone = "GMT")
  rddatatmp[, datetimes := as.numeric(datetime)]

  rddatatmp[, DateTimes_Timezone_Corrected := ifelse (grepl(rddatatmp[, tz_columnname, with = FALSE][[1]], pattern = "EDT|CDT|MDT|PDT|AKDT|HDT|ADT"), {rddatatmp[, datetimes] - 3600}, {rddatatmp[, datetimes]})]
# Source 8 / if the date-time stamp is DT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time

  rddatatmp[, DateTimes_Timezone_Corrected2 := as.POSIXct(DateTimes_Timezone_Corrected, origin = "1970-01-01 00:00:00", tzone = "GMT")]
# convert the numeric date time back to POSIXct with the origin of GMT

  attributes(rddatatmp$DateTimes_Timezone_Corrected2)$tzone <- "GMT" # Source 16

  rddatatmp[, c("datetimes", "DateTimes", "DateTimes_Timezone_Corrected") := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))
  setnames(rddatatmp, 1, "DateTime")


  } else if (dmyHMS_check) {

rddatatmp[, DateTimes := rddatatmp[, datecol, with = FALSE][[1]]]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class2 <- "DateTimes"
  for (col in change_class2) set(rddatatmp, j = col, value = dmy_hms(rddatatmp[[col]], quiet = TRUE, tz = "GMT")) # Source 6

  rddatatmp[, datecolname := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))

  datetime <- as.POSIXct(rddatatmp[[1]], tzone = "GMT")
  rddatatmp[, datetimes := as.numeric(datetime)]

  rddatatmp[, DateTimes_Timezone_Corrected := ifelse (grepl(rddatatmp[, tz_columnname, with = FALSE][[1]], pattern = "EDT|CDT|MDT|PDT|AKDT|HDT|ADT"), {rddatatmp[, datetimes] - 3600}, {rddatatmp[, datetimes]})]
# Source 8 / if the date-time stamp is DT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time

  rddatatmp[, DateTimes_Timezone_Corrected2 := as.POSIXct(DateTimes_Timezone_Corrected, origin = "1970-01-01 00:00:00", tzone = "GMT")]
# convert the numeric date time back to POSIXct with the origin of GMT

  attributes(rddatatmp$DateTimes_Timezone_Corrected2)$tzone <- "GMT" # Source 16

  rddatatmp[, c("datetimes", "DateTimes", "DateTimes_Timezone_Corrected") := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))
  setnames(rddatatmp, 1, "DateTime")


} else if (mdy_check) {

rddatatmp[, DateTimes := rddatatmp[, datecol, with = FALSE][[1]]]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class1 <- "DateTimes"
  for (col in change_class1) set(rddatatmp, j = col, value = mdy(rddatatmp[[col]], quiet = TRUE)) # Source 6

  rddatatmp[, datecolname := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))


} else if (mdyHM_check) {

rddatatmp[, DateTimes := rddatatmp[, datecol, with = FALSE][[1]]]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class2 <- "DateTimes"
  for (col in change_class2) set(rddatatmp, j = col, value = mdy_hm(rddatatmp[[col]], quiet = TRUE, tz = "GMT")) # Source 6

  rddatatmp[, datecolname := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))

  datetime <- as.POSIXct(rddatatmp[[1]], tzone = "GMT")
  rddatatmp[, datetimes := as.numeric(datetime)]

  rddatatmp[, DateTimes_Timezone_Corrected := ifelse (grepl(rddatatmp[, tz_columnname, with = FALSE][[1]], pattern = "EDT|CDT|MDT|PDT|AKDT|HDT|ADT"), {rddatatmp[, datetimes] - 3600}, {rddatatmp[, datetimes]})]
# Source 8 / if the date-time stamp is DT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time

  rddatatmp[, DateTimes_Timezone_Corrected2 := as.POSIXct(DateTimes_Timezone_Corrected, origin = "1970-01-01 00:00:00", tzone = "GMT")]
# convert the numeric date time back to POSIXct with the origin of GMT

  attributes(rddatatmp$DateTimes_Timezone_Corrected2)$tzone <- "GMT" # Source 16

  rddatatmp[, c("datetimes", "DateTimes", "DateTimes_Timezone_Corrected") := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))
  setnames(rddatatmp, 1, "DateTime")


  } else if (mdyHMS_check) {

rddatatmp[, DateTimes := rddatatmp[, datecol, with = FALSE][[1]]]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class2 <- "DateTimes"
  for (col in change_class2) set(rddatatmp, j = col, value = mdy_hms(rddatatmp[[col]], quiet = TRUE, tz = "GMT")) # Source 6

  rddatatmp[, datecolname := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))

  datetime <- as.POSIXct(rddatatmp[[1]], tzone = "GMT")
  rddatatmp[, datetimes := as.numeric(datetime)]

  rddatatmp[, DateTimes_Timezone_Corrected := ifelse (grepl(rddatatmp[, tz_columnname, with = FALSE][[1]], pattern = "EDT|CDT|MDT|PDT|AKDT|HDT|ADT"), {rddatatmp[, datetimes] - 3600}, {rddatatmp[, datetimes]})]
# Source 8 / if the date-time stamp is DT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time

  rddatatmp[, DateTimes_Timezone_Corrected2 := as.POSIXct(DateTimes_Timezone_Corrected, origin = "1970-01-01 00:00:00", tzone = "GMT")]
# convert the numeric date time back to POSIXct with the origin of GMT

  attributes(rddatatmp$DateTimes_Timezone_Corrected2)$tzone <- "GMT" # Source 16

  rddatatmp[, c("datetimes", "DateTimes", "DateTimes_Timezone_Corrected") := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))
  setnames(rddatatmp, 1, "DateTime")

  }

} else if (!is.na(timecol)) {

if (ymd_check) {

rddatatmp[, DateTimes := paste(rddatatmp[, datecol, with = FALSE][[1]], rddatatmp[, timecol, with = FALSE][[1]], sep = " ")]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class2 <- "DateTimes"
  for (col in change_class2) set(rddatatmp, j = col, value = ymd_hm(rddatatmp[[col]], quiet = TRUE, tz = "GMT")) # Source 6

  rddatatmp[, c(datecolname, timecolname) := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))

datetime <- as.POSIXct(rddatatmp[[1]], tzone = "GMT")
  rddatatmp[, datetimes := as.numeric(datetime)]

  rddatatmp[, DateTimes_Timezone_Corrected := ifelse (grepl(rddatatmp[, tz_columnname, with = FALSE][[1]], pattern = "EDT|CDT|MDT|PDT|AKDT|HDT|ADT"), {rddatatmp[, datetimes] - 3600}, {rddatatmp[, datetimes]})]
# Source 8 / if the date-time stamp is DT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time

  rddatatmp[, DateTimes_Timezone_Corrected2 := as.POSIXct(DateTimes_Timezone_Corrected, origin = "1970-01-01 00:00:00", tzone = "GMT")]
# convert the numeric date time back to POSIXct with the origin of GMT

  attributes(rddatatmp$DateTimes_Timezone_Corrected2)$tzone <- "GMT" # Source 16

  rddatatmp[, c("datetimes", "DateTimes", "DateTimes_Timezone_Corrected") := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))
  setnames(rddatatmp, 1, "DateTime")


} else if (ymdHM_check) {

rddatatmp[, DateTimes := paste(rddatatmp[, datecol, with = FALSE][[1]], rddatatmp[, timecol, with = FALSE][[1]], sep = " ")]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class2 <- "DateTimes"
  for (col in change_class2) set(rddatatmp, j = col, value = ymd_hm(rddatatmp[[col]], quiet = TRUE, tz = "GMT")) # Source 6

  rddatatmp[, c(datecolname, timecolname) := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))

datetime <- as.POSIXct(rddatatmp[[1]], tzone = "GMT")
  rddatatmp[, datetimes := as.numeric(datetime)]

  rddatatmp[, DateTimes_Timezone_Corrected := ifelse (grepl(rddatatmp[, tz_columnname, with = FALSE][[1]], pattern = "EDT|CDT|MDT|PDT|AKDT|HDT|ADT"), {rddatatmp[, datetimes] - 3600}, {rddatatmp[, datetimes]})]
# Source 8 / if the date-time stamp is DT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time

  rddatatmp[, DateTimes_Timezone_Corrected2 := as.POSIXct(DateTimes_Timezone_Corrected, origin = "1970-01-01 00:00:00", tzone = "GMT")]
# convert the numeric date time back to POSIXct with the origin of GMT

  attributes(rddatatmp$DateTimes_Timezone_Corrected2)$tzone <- "GMT" # Source 16

  rddatatmp[, c("datetimes", "DateTimes", "DateTimes_Timezone_Corrected") := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))
  setnames(rddatatmp, 1, "DateTime")


  } else if (ymdHMS_check) {

rddatatmp[, DateTimes := paste(rddatatmp[, datecol, with = FALSE][[1]], rddatatmp[, timecol, with = FALSE][[1]], sep = " ")]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class2 <- "DateTimes"
  for (col in change_class2) set(rddatatmp, j = col, value = ymd_hms(rddatatmp[[col]], quiet = TRUE, tz = "GMT")) # Source 6

  rddatatmp[, c(datecolname, timecolname) := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))

datetime <- as.POSIXct(rddatatmp[[1]], tzone = "GMT")
  rddatatmp[, datetimes := as.numeric(datetime)]

  rddatatmp[, DateTimes_Timezone_Corrected := ifelse (grepl(rddatatmp[, tz_columnname, with = FALSE][[1]], pattern = "EDT|CDT|MDT|PDT|AKDT|HDT|ADT"), {rddatatmp[, datetimes] - 3600}, {rddatatmp[, datetimes]})]
# Source 8 / if the date-time stamp is DT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time

  rddatatmp[, DateTimes_Timezone_Corrected2 := as.POSIXct(DateTimes_Timezone_Corrected, origin = "1970-01-01 00:00:00", tzone = "GMT")]
# convert the numeric date time back to POSIXct with the origin of GMT

  attributes(rddatatmp$DateTimes_Timezone_Corrected2)$tzone <- "GMT" # Source 16

  rddatatmp[, c("datetimes", "DateTimes", "DateTimes_Timezone_Corrected") := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))
  setnames(rddatatmp, 1, "DateTime")


  } else if (dmy_check) {

rddatatmp[, DateTimes := paste(rddatatmp[, datecol, with = FALSE][[1]], rddatatmp[, timecol, with = FALSE][[1]], sep = " ")]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class2 <- "DateTimes"
  for (col in change_class2) set(rddatatmp, j = col, value = mdy_hm(rddatatmp[[col]], quiet = TRUE, tz = "GMT")) # Source 6

  rddatatmp[, c(datecolname, timecolname) := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))

  datetime <- as.POSIXct(rddatatmp[[1]], tzone = "GMT")
  rddatatmp[, datetimes := as.numeric(datetime)]

  rddatatmp[, DateTimes_Timezone_Corrected := ifelse (grepl(rddatatmp[, tz_columnname, with = FALSE][[1]], pattern = "EDT|CDT|MDT|PDT|AKDT|HDT|ADT"), {rddatatmp[, datetimes] - 3600}, {rddatatmp[, datetimes]})]
# Source 8 / if the date-time stamp is DT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time

  rddatatmp[, DateTimes_Timezone_Corrected2 := as.POSIXct(DateTimes_Timezone_Corrected, origin = "1970-01-01 00:00:00", tzone = "GMT")]
# convert the numeric date time back to POSIXct with the origin of GMT

  attributes(rddatatmp$DateTimes_Timezone_Corrected2)$tzone <- "GMT" # Source 16

  rddatatmp[, c("datetimes", "DateTimes", "DateTimes_Timezone_Corrected") := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))
  setnames(rddatatmp, 1, "DateTime")


} else if (dmyHM_check) {

rddatatmp[, DateTimes := paste(rddatatmp[, datecol, with = FALSE][[1]], rddatatmp[, timecol, with = FALSE][[1]], sep = " ")]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class2 <- "DateTimes"
  for (col in change_class2) set(rddatatmp, j = col, value = dmy_hm(rddatatmp[[col]], quiet = TRUE, tz = "GMT")) # Source 6

  rddatatmp[, c(datecolname, timecolname) := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))

  datetime <- as.POSIXct(rddatatmp[[1]], tzone = "GMT")
  rddatatmp[, datetimes := as.numeric(datetime)]

  rddatatmp[, DateTimes_Timezone_Corrected := ifelse (grepl(rddatatmp[, tz_columnname, with = FALSE][[1]], pattern = "EDT|CDT|MDT|PDT|AKDT|HDT|ADT"), {rddatatmp[, datetimes] - 3600}, {rddatatmp[, datetimes]})]
# Source 8 / if the date-time stamp is DT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time

  rddatatmp[, DateTimes_Timezone_Corrected2 := as.POSIXct(DateTimes_Timezone_Corrected, origin = "1970-01-01 00:00:00", tzone = "GMT")]
# convert the numeric date time back to POSIXct with the origin of GMT

  attributes(rddatatmp$DateTimes_Timezone_Corrected2)$tzone <- "GMT" # Source 16

  rddatatmp[, c("datetimes", "DateTimes", "DateTimes_Timezone_Corrected") := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))
  setnames(rddatatmp, 1, "DateTime")


  } else if (dmyHMS_check) {

rddatatmp[, DateTimes := paste(rddatatmp[, datecol, with = FALSE][[1]], rddatatmp[, timecol, with = FALSE][[1]], sep = " ")]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class2 <- "DateTimes"
  for (col in change_class2) set(rddatatmp, j = col, value = dmy_hms(rddatatmp[[col]], quiet = TRUE, tz = "GMT")) # Source 6

  rddatatmp[, c(datecolname, timecolname) := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))

  datetime <- as.POSIXct(rddatatmp[[1]], tzone = "GMT")
  rddatatmp[, datetimes := as.numeric(datetime)]

  rddatatmp[, DateTimes_Timezone_Corrected := ifelse (grepl(rddatatmp[, tz_columnname, with = FALSE][[1]], pattern = "EDT|CDT|MDT|PDT|AKDT|HDT|ADT"), {rddatatmp[, datetimes] - 3600}, {rddatatmp[, datetimes]})]
# Source 8 / if the date-time stamp is DT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time

  rddatatmp[, DateTimes_Timezone_Corrected2 := as.POSIXct(DateTimes_Timezone_Corrected, origin = "1970-01-01 00:00:00", tzone = "GMT")]
# convert the numeric date time back to POSIXct with the origin of GMT

  attributes(rddatatmp$DateTimes_Timezone_Corrected2)$tzone <- "GMT" # Source 16

  rddatatmp[, c("datetimes", "DateTimes", "DateTimes_Timezone_Corrected") := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))
  setnames(rddatatmp, 1, "DateTime")


  } else if (mdy_check) {

rddatatmp[, DateTimes := paste(rddatatmp[, datecol, with = FALSE][[1]], rddatatmp[, timecol, with = FALSE][[1]], sep = " ")]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class2 <- "DateTimes"
  for (col in change_class2) set(rddatatmp, j = col, value = mdy_hm(rddatatmp[[col]], quiet = TRUE, tz = "GMT")) # Source 6

  rddatatmp[, c(datecolname, timecolname) := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))

  datetime <- as.POSIXct(rddatatmp[[1]], tzone = "GMT")
  rddatatmp[, datetimes := as.numeric(datetime)]

  rddatatmp[, DateTimes_Timezone_Corrected := ifelse (grepl(rddatatmp[, tz_columnname, with = FALSE][[1]], pattern = "EDT|CDT|MDT|PDT|AKDT|HDT|ADT"), {rddatatmp[, datetimes] - 3600}, {rddatatmp[, datetimes]})]
# Source 8 / if the date-time stamp is DT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time

  rddatatmp[, DateTimes_Timezone_Corrected2 := as.POSIXct(DateTimes_Timezone_Corrected, origin = "1970-01-01 00:00:00", tzone = "GMT")]
# convert the numeric date time back to POSIXct with the origin of GMT

  attributes(rddatatmp$DateTimes_Timezone_Corrected2)$tzone <- "GMT" # Source 16

  rddatatmp[, c("datetimes", "DateTimes", "DateTimes_Timezone_Corrected") := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))
  setnames(rddatatmp, 1, "DateTime")


   } else if (mdyHM_check) {

rddatatmp[, DateTimes := paste(rddatatmp[, datecol, with = FALSE][[1]], rddatatmp[, timecol, with = FALSE][[1]], sep = " ")]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class2 <- "DateTimes"
  for (col in change_class2) set(rddatatmp, j = col, value = mdy_hm(rddatatmp[[col]], quiet = TRUE, tz = "GMT")) # Source 6

  rddatatmp[, c(datecolname, timecolname) := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))

  datetime <- as.POSIXct(rddatatmp[[1]], tzone = "GMT")
  rddatatmp[, datetimes := as.numeric(datetime)]

  rddatatmp[, DateTimes_Timezone_Corrected := ifelse (grepl(rddatatmp[, tz_columnname, with = FALSE][[1]], pattern = "EDT|CDT|MDT|PDT|AKDT|HDT|ADT"), {rddatatmp[, datetimes] - 3600}, {rddatatmp[, datetimes]})]
# Source 8 / if the date-time stamp is DT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time

  rddatatmp[, DateTimes_Timezone_Corrected2 := as.POSIXct(DateTimes_Timezone_Corrected, origin = "1970-01-01 00:00:00", tzone = "GMT")]
# convert the numeric date time back to POSIXct with the origin of GMT

  attributes(rddatatmp$DateTimes_Timezone_Corrected2)$tzone <- "GMT" # Source 16

  rddatatmp[, c("datetimes", "DateTimes", "DateTimes_Timezone_Corrected") := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))
  setnames(rddatatmp, 1, "DateTime")


} else if (mdyHMS_check) {

rddatatmp[, DateTimes := paste(rddatatmp[, datecol, with = FALSE][[1]], rddatatmp[, timecol, with = FALSE][[1]], sep = " ")]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class2 <- "DateTimes"
  for (col in change_class2) set(rddatatmp, j = col, value = mdy_hms(rddatatmp[[col]], quiet = TRUE, tz = "GMT")) # Source 6

  rddatatmp[, c(datecolname, timecolname) := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))

  datetime <- as.POSIXct(rddatatmp[[1]], tzone = "GMT")
  rddatatmp[, datetimes := as.numeric(datetime)]

  rddatatmp[, DateTimes_Timezone_Corrected := ifelse (grepl(rddatatmp[, tz_columnname, with = FALSE][[1]], pattern = "EDT|CDT|MDT|PDT|AKDT|HDT|ADT"), {rddatatmp[, datetimes] - 3600}, {rddatatmp[, datetimes]})]
# Source 8 / if the date-time stamp is DT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time

  rddatatmp[, DateTimes_Timezone_Corrected2 := as.POSIXct(DateTimes_Timezone_Corrected, origin = "1970-01-01 00:00:00", tzone = "GMT")]
# convert the numeric date time back to POSIXct with the origin of GMT

  attributes(rddatatmp$DateTimes_Timezone_Corrected2)$tzone <- "GMT" # Source 16

  rddatatmp[, c("datetimes", "DateTimes", "DateTimes_Timezone_Corrected") := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))
  setnames(rddatatmp, 1, "DateTime")

  }
  }


## Source 9 and 10 begin
    RDdatatmp <- copy(rddatatmp) # copies rddatatmp

if (grepl(RDdatatmp[[1]][1], pattern = "\\d{0,2}:\\d{2}(?:[:.]\\d+)?|(\\d{0,2}:\\d{2}(?:[:.]\\d+)?)(\\s+(([AP]\\.{0,1}M\\.{0,1})|([ap]\\.{0,1}m\\.{0,1})))") == TRUE) { # Source 15

    RDdatatmp[[1]] <- strptime(RDdatatmp[[1]], "%Y-%m-%d %H:%M:%S") # changes from POSIXct to character for the DateTime
    RDdatatmp[[1]] <- format(RDdatatmp[[1]], "%Y-%m-%d %H:%M:%S") # Source 17 / changes the DateTime format to numeric month/numeric date/four digit year with HMS

} else {

    RDdatatmp[[1]] <- strptime(RDdatatmp[[1]], "%Y-%m-%d") # changes from POSIXct to character for the DateTime
    RDdatatmp[[1]] <- format(RDdatatmp[[1]], "%Y-%m-%d") # Source 17 / changes the DateTime format to numeric month/numeric date/four digit year
}
## Source 9 and 10 end


  rddatatmp2 <- readLines(file[i])
# reads the large table
  idx.comments <- grep("^[#]", rddatatmp2)
  rddatatmp2 <- rddatatmp2[idx.comments]
  rddatatmp2 <- stri_replace_all_fixed(rddatatmp2, "#", "")

  wb <- createWorkbook()
# use R package openxlsx to create the .xlsx spreadsheet
  addWorksheet(wb, "QW Data TZ Corrected")
# adds the worksheet with the name of QW Data TZ Corrected
  writeDataTable(wb, "QW Data TZ Corrected", RDdatatmp)
# writes the data to the workbook
  setColWidths(wb, sheet = 1, cols = 1, widths = 22)
# column width of 22 units for column 1
  addWorksheet(wb, "QW Data")
# adds the worksheet with the name of QW Data
  writeDataTable(wb, "QW Data", rddatatmp1)
# writes the data to the workbook
  setColWidths(wb, sheet = 2, cols = 1:ncol(rddatatmp1), widths = 22)
# column width of 22 units for all columns
  addWorksheet(wb, paste(site_no, "meta", sep = " "))
# adds the worksheet with the name of meta
  writeData(wb, paste(site_no, "meta", sep = " "), rddatatmp2)
# writes the data to the workbook

# Source 15 and 16 begins
  filesave4a <- paste0(filesave4, "/", basename(file_path_sans_ext(file[i])))
# combine the directory name with the basename and remove the file extension
  saveWorkbook(wb, paste0(filesave4a, ".xlsx"), overwrite = overwrite)
# saves the workbook as original file name without the extension + .xlsx
# Source 15 and 16 ends


}
}
}
}
}
}



#' @export
#' @rdname qw
qw2 <- function (file, overwrite = TRUE) {

overwrite <- overwrite

#date_times <- date_times_tf <- DateTimes_Timezone_Corrected <- NULL
#sample_start_time_datum_cd <- NULL
# Source 17

if (!nchar(file)) {

  stop("You did not choose a file. Please try again with a different file.")
# Source 2 / provide a stop warning if no file was selected

} else {

confirm <- gconfirm(toolkit = guiToolkit("tcltk"), msg = paste0("Do you want to select", " ", file, "?"), title = "Confirm", icon = "question")

if (confirm == FALSE) {

  stop("Please try again with a different file.")
# Source 2 / provide a stop warning if the user wants to change the file

} else {

if (file.info(file)$size == 0) {

  stop("Your file is empty. Please try again with a different file.")
# Source 1 & 2 / only process non-empty files and provide a stop warning if the input

} else {

  rddatatmp <- read.table(file, header = TRUE, row.names = NULL, comment.char = "#", fill = TRUE, stringsAsFactors = FALSE, sep = "\t")
  rddatatmp <- setDT(rddatatmp)

  rddatatmp1 <- copy(rddatatmp)

  site_no <- rddatatmp[2, "site_no", with = FALSE][[1]]

  rddatatmp <- rddatatmp[-1, -c("agency_cd", "site_no"), with = FALSE]

 datecol <- which(grepl(rddatatmp, pattern = "\\d{0,2}/\\d{2}/(?:\\d{4}|\\d{2})?|\\d{0,2}-\\d{2}-(?:\\d{4}|\\d{2})?|\\d{0,2}\\.\\d{2}\\.(?:\\d{4}|\\d{2})?|(\\b)([A-Za-z]{3,9})(\\s+)([0-9][0-9]*)(,)(\\s+)([0-9]{4})|[0-9]{4}-[0-9]{2}-[0-9]{2}|\\d{0,2}/\\d{2}/(?:\\d{4}|\\d{2})?|\\d{0,2}-\\d{2}-(?:\\d{4}|\\d{2})?|\\d{0,2}\\.\\d{2}\\.(?:\\d{4}|\\d{2})?|(\\b)([A-Za-z]{3,9})(\\s+)([0-9][0-9]*)(,)(\\s+)([0-9]{4})|[0-9]{4}-[0-9]{2}-[0-9]{2}") == TRUE) # Source 15

 datecolname <- names(rddatatmp[, datecol, with = FALSE])

 timecol <- which(grepl(rddatatmp, pattern = "\\d{0,2}:\\d{2}(?:[:.]\\d+)?|(\\d{0,2}:\\d{2}(?:[:.]\\d+)?)(\\s+(([AP]\\.{0,1}M\\.{0,1})|([ap]\\.{0,1}m\\.{0,1})))") == TRUE) # Source 15

 timecolname <- names(rddatatmp[, timecol, with = FALSE])

 ifelse (datecol == timecol, timecol <- NA, datecol <- datecol)
 ifelse (length(timecol) == 0, timecol <- NA, timecol <- timecol)


 if (!is.na(timecol)) {
  numericcol <- which(grepl(rddatatmp, pattern = "[0-9]"))
 numericcol <- numericcol[-c(datecol, timecol)]

 } else if (is.na(timecol)) {

 numericcol <- which(grepl(rddatatmp, pattern = "[0-9]"))
 numericcol <- numericcol[-datecol]

 }


# changing column to numeric class
# obtain the name of the column based on the column number
  change_class1 <- numericcol
  for (col in change_class1) set(rddatatmp, j = col, value = as.numeric(rddatatmp[[col]])) # Source 4

  tz_column <- which(grepl(rddatatmp, pattern = "EST|EDT|CST|CDT|MST|MDT|PST|PDT|AKST|AKDT|HST|HDT|AST|ADT"))
  tz_columnname <- names(rddatatmp[, tz_column, with = FALSE])

dateformat <- guess_formats(rddatatmp[, datecol, with = FALSE][[1]], c("ymd", "dmy", "mdy", "ymd hm", "dmy hm", "mdy hm", "ymd hms", "dmy hms", "mdy hms"))

ymd_check <- length(which(names(dateformat) == "ymd") == TRUE) == nrow(rddatatmp)
dmy_check <- length(which(names(dateformat) == "dmy") == TRUE) == nrow(rddatatmp)
mdy_check <- length(which(names(dateformat) == "mdy") == TRUE) == nrow(rddatatmp)
ymdHM_check <- length(which(names(dateformat) == "ymdHM") == TRUE) == nrow(rddatatmp)
dmyHM_check <- length(which(names(dateformat) == "dmyHM") == TRUE) == nrow(rddatatmp)
mdyHM_check <- length(which(names(dateformat) == "mdyHM") == TRUE) == nrow(rddatatmp)
ymdHMS_check <- length(which(names(dateformat) == "ymdHMS") == TRUE) == nrow(rddatatmp)
dmyHMS_check <- length(which(names(dateformat) == "dmyHMS") == TRUE) == nrow(rddatatmp)
mdyHMS_check <- length(which(names(dateformat) == "mdyHMS") == TRUE) == nrow(rddatatmp)

datechecks <- data.table(ymd_check, dmy_check, mdy_check, ymdHM_check, dmyHM_check, mdyHM_check, ymdHMS_check, dmyHMS_check, mdyHMS_check)


if (is.na(timecol)) {

if (ymd_check) {

rddatatmp[, DateTimes := rddatatmp[, datecol, with = FALSE][[1]]]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class1 <- "DateTimes"
  for (col in change_class1) set(rddatatmp, j = col, value = ymd(rddatatmp[[col]], quiet = TRUE)) # Source 6

  rddatatmp[, datecolname := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))


} else if (ymdHM_check) {

rddatatmp[, DateTimes := rddatatmp[, datecol, with = FALSE][[1]]]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class2 <- "DateTimes"
  for (col in change_class2) set(rddatatmp, j = col, value = ymd_hm(rddatatmp[[col]], quiet = TRUE, tz = "GMT")) # Source 6

  rddatatmp[, datecolname := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))

  datetime <- as.POSIXct(rddatatmp[[1]], tzone = "GMT")
  rddatatmp[, datetimes := as.numeric(datetime)]

  rddatatmp[, DateTimes_Timezone_Corrected := ifelse (grepl(rddatatmp[, tz_columnname, with = FALSE][[1]], pattern = "EDT|CDT|MDT|PDT|AKDT|HDT|ADT"), {rddatatmp[, datetimes] - 3600}, {rddatatmp[, datetimes]})]
# Source 8 / if the date-time stamp is DT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time

  rddatatmp[, DateTimes_Timezone_Corrected2 := as.POSIXct(DateTimes_Timezone_Corrected, origin = "1970-01-01 00:00:00", tzone = "GMT")]
# convert the numeric date time back to POSIXct with the origin of GMT

  attributes(rddatatmp$DateTimes_Timezone_Corrected2)$tzone <- "GMT" # Source 16

  rddatatmp[, c("datetimes", "DateTimes", "DateTimes_Timezone_Corrected") := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))
  setnames(rddatatmp, 1, "DateTime")


} else if (ymdHMS_check) {

rddatatmp[, DateTimes := rddatatmp[, datecol, with = FALSE][[1]]]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class2 <- "DateTimes"
  for (col in change_class2) set(rddatatmp, j = col, value = ymd_hms(rddatatmp[[col]], quiet = TRUE, tz = "GMT")) # Source 6

  rddatatmp[, datecolname := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))

  datetime <- as.POSIXct(rddatatmp[[1]], tzone = "GMT")
  rddatatmp[, datetimes := as.numeric(datetime)]

  rddatatmp[, DateTimes_Timezone_Corrected := ifelse (grepl(rddatatmp[, tz_columnname, with = FALSE][[1]], pattern = "EDT|CDT|MDT|PDT|AKDT|HDT|ADT"), {rddatatmp[, datetimes] - 3600}, {rddatatmp[, datetimes]})]
# Source 8 / if the date-time stamp is DT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time

  rddatatmp[, DateTimes_Timezone_Corrected2 := as.POSIXct(DateTimes_Timezone_Corrected, origin = "1970-01-01 00:00:00", tzone = "GMT")]
# convert the numeric date time back to POSIXct with the origin of GMT

  attributes(rddatatmp$DateTimes_Timezone_Corrected2)$tzone <- "GMT" # Source 16

  rddatatmp[, c("datetimes", "DateTimes", "DateTimes_Timezone_Corrected") := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))
  setnames(rddatatmp, 1, "DateTime")


} else if (dmy_check) {

rddatatmp[, DateTimes := rddatatmp[, datecol, with = FALSE][[1]]]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class1 <- "DateTimes"
  for (col in change_class1) set(rddatatmp, j = col, value = dmy(rddatatmp[[col]], quiet = TRUE)) # Source 6

  rddatatmp[, datecolname := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))


} else if (dmyHM_check) {

rddatatmp[, DateTimes := rddatatmp[, datecol, with = FALSE][[1]]]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class2 <- "DateTimes"
  for (col in change_class2) set(rddatatmp, j = col, value = dmy_hm(rddatatmp[[col]], quiet = TRUE, tz = "GMT")) # Source 6

  rddatatmp[, datecolname := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))

  datetime <- as.POSIXct(rddatatmp[[1]], tzone = "GMT")
  rddatatmp[, datetimes := as.numeric(datetime)]

  rddatatmp[, DateTimes_Timezone_Corrected := ifelse (grepl(rddatatmp[, tz_columnname, with = FALSE][[1]], pattern = "EDT|CDT|MDT|PDT|AKDT|HDT|ADT"), {rddatatmp[, datetimes] - 3600}, {rddatatmp[, datetimes]})]
# Source 8 / if the date-time stamp is DT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time

  rddatatmp[, DateTimes_Timezone_Corrected2 := as.POSIXct(DateTimes_Timezone_Corrected, origin = "1970-01-01 00:00:00", tzone = "GMT")]
# convert the numeric date time back to POSIXct with the origin of GMT

  attributes(rddatatmp$DateTimes_Timezone_Corrected2)$tzone <- "GMT" # Source 16

  rddatatmp[, c("datetimes", "DateTimes", "DateTimes_Timezone_Corrected") := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))
  setnames(rddatatmp, 1, "DateTime")


  } else if (dmyHMS_check) {

rddatatmp[, DateTimes := rddatatmp[, datecol, with = FALSE][[1]]]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class2 <- "DateTimes"
  for (col in change_class2) set(rddatatmp, j = col, value = dmy_hms(rddatatmp[[col]], quiet = TRUE, tz = "GMT")) # Source 6

  rddatatmp[, datecolname := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))

  datetime <- as.POSIXct(rddatatmp[[1]], tzone = "GMT")
  rddatatmp[, datetimes := as.numeric(datetime)]

  rddatatmp[, DateTimes_Timezone_Corrected := ifelse (grepl(rddatatmp[, tz_columnname, with = FALSE][[1]], pattern = "EDT|CDT|MDT|PDT|AKDT|HDT|ADT"), {rddatatmp[, datetimes] - 3600}, {rddatatmp[, datetimes]})]
# Source 8 / if the date-time stamp is DT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time

  rddatatmp[, DateTimes_Timezone_Corrected2 := as.POSIXct(DateTimes_Timezone_Corrected, origin = "1970-01-01 00:00:00", tzone = "GMT")]
# convert the numeric date time back to POSIXct with the origin of GMT

  attributes(rddatatmp$DateTimes_Timezone_Corrected2)$tzone <- "GMT" # Source 16

  rddatatmp[, c("datetimes", "DateTimes", "DateTimes_Timezone_Corrected") := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))
  setnames(rddatatmp, 1, "DateTime")


} else if (mdy_check) {

rddatatmp[, DateTimes := rddatatmp[, datecol, with = FALSE][[1]]]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class1 <- "DateTimes"
  for (col in change_class1) set(rddatatmp, j = col, value = mdy(rddatatmp[[col]], quiet = TRUE)) # Source 6

  rddatatmp[, datecolname := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))


} else if (mdyHM_check) {

rddatatmp[, DateTimes := rddatatmp[, datecol, with = FALSE][[1]]]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class2 <- "DateTimes"
  for (col in change_class2) set(rddatatmp, j = col, value = mdy_hm(rddatatmp[[col]], quiet = TRUE, tz = "GMT")) # Source 6

  rddatatmp[, datecolname := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))

  datetime <- as.POSIXct(rddatatmp[[1]], tzone = "GMT")
  rddatatmp[, datetimes := as.numeric(datetime)]

  rddatatmp[, DateTimes_Timezone_Corrected := ifelse (grepl(rddatatmp[, tz_columnname, with = FALSE][[1]], pattern = "EDT|CDT|MDT|PDT|AKDT|HDT|ADT"), {rddatatmp[, datetimes] - 3600}, {rddatatmp[, datetimes]})]
# Source 8 / if the date-time stamp is DT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time

  rddatatmp[, DateTimes_Timezone_Corrected2 := as.POSIXct(DateTimes_Timezone_Corrected, origin = "1970-01-01 00:00:00", tzone = "GMT")]
# convert the numeric date time back to POSIXct with the origin of GMT

  attributes(rddatatmp$DateTimes_Timezone_Corrected2)$tzone <- "GMT" # Source 16

  rddatatmp[, c("datetimes", "DateTimes", "DateTimes_Timezone_Corrected") := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))
  setnames(rddatatmp, 1, "DateTime")


  } else if (mdyHMS_check) {

rddatatmp[, DateTimes := rddatatmp[, datecol, with = FALSE][[1]]]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class2 <- "DateTimes"
  for (col in change_class2) set(rddatatmp, j = col, value = mdy_hms(rddatatmp[[col]], quiet = TRUE, tz = "GMT")) # Source 6

  rddatatmp[, datecolname := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))

  datetime <- as.POSIXct(rddatatmp[[1]], tzone = "GMT")
  rddatatmp[, datetimes := as.numeric(datetime)]

  rddatatmp[, DateTimes_Timezone_Corrected := ifelse (grepl(rddatatmp[, tz_columnname, with = FALSE][[1]], pattern = "EDT|CDT|MDT|PDT|AKDT|HDT|ADT"), {rddatatmp[, datetimes] - 3600}, {rddatatmp[, datetimes]})]
# Source 8 / if the date-time stamp is DT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time

  rddatatmp[, DateTimes_Timezone_Corrected2 := as.POSIXct(DateTimes_Timezone_Corrected, origin = "1970-01-01 00:00:00", tzone = "GMT")]
# convert the numeric date time back to POSIXct with the origin of GMT

  attributes(rddatatmp$DateTimes_Timezone_Corrected2)$tzone <- "GMT" # Source 16

  rddatatmp[, c("datetimes", "DateTimes", "DateTimes_Timezone_Corrected") := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))
  setnames(rddatatmp, 1, "DateTime")

  }

} else if (!is.na(timecol)) {

if (ymd_check) {

rddatatmp[, DateTimes := paste(rddatatmp[, datecol, with = FALSE][[1]], rddatatmp[, timecol, with = FALSE][[1]], sep = " ")]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class2 <- "DateTimes"
  for (col in change_class2) set(rddatatmp, j = col, value = ymd_hm(rddatatmp[[col]], quiet = TRUE, tz = "GMT")) # Source 6

  rddatatmp[, c(datecolname, timecolname) := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))

datetime <- as.POSIXct(rddatatmp[[1]], tzone = "GMT")
  rddatatmp[, datetimes := as.numeric(datetime)]

  rddatatmp[, DateTimes_Timezone_Corrected := ifelse (grepl(rddatatmp[, tz_columnname, with = FALSE][[1]], pattern = "EDT|CDT|MDT|PDT|AKDT|HDT|ADT"), {rddatatmp[, datetimes] - 3600}, {rddatatmp[, datetimes]})]
# Source 8 / if the date-time stamp is DT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time

  rddatatmp[, DateTimes_Timezone_Corrected2 := as.POSIXct(DateTimes_Timezone_Corrected, origin = "1970-01-01 00:00:00", tzone = "GMT")]
# convert the numeric date time back to POSIXct with the origin of GMT

  attributes(rddatatmp$DateTimes_Timezone_Corrected2)$tzone <- "GMT" # Source 16

  rddatatmp[, c("datetimes", "DateTimes", "DateTimes_Timezone_Corrected") := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))
  setnames(rddatatmp, 1, "DateTime")


} else if (ymdHM_check) {

rddatatmp[, DateTimes := paste(rddatatmp[, datecol, with = FALSE][[1]], rddatatmp[, timecol, with = FALSE][[1]], sep = " ")]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class2 <- "DateTimes"
  for (col in change_class2) set(rddatatmp, j = col, value = ymd_hm(rddatatmp[[col]], quiet = TRUE, tz = "GMT")) # Source 6

  rddatatmp[, c(datecolname, timecolname) := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))

datetime <- as.POSIXct(rddatatmp[[1]], tzone = "GMT")
  rddatatmp[, datetimes := as.numeric(datetime)]

  rddatatmp[, DateTimes_Timezone_Corrected := ifelse (grepl(rddatatmp[, tz_columnname, with = FALSE][[1]], pattern = "EDT|CDT|MDT|PDT|AKDT|HDT|ADT"), {rddatatmp[, datetimes] - 3600}, {rddatatmp[, datetimes]})]
# Source 8 / if the date-time stamp is DT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time

  rddatatmp[, DateTimes_Timezone_Corrected2 := as.POSIXct(DateTimes_Timezone_Corrected, origin = "1970-01-01 00:00:00", tzone = "GMT")]
# convert the numeric date time back to POSIXct with the origin of GMT

  attributes(rddatatmp$DateTimes_Timezone_Corrected2)$tzone <- "GMT" # Source 16

  rddatatmp[, c("datetimes", "DateTimes", "DateTimes_Timezone_Corrected") := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))
  setnames(rddatatmp, 1, "DateTime")


  } else if (ymdHMS_check) {

rddatatmp[, DateTimes := paste(rddatatmp[, datecol, with = FALSE][[1]], rddatatmp[, timecol, with = FALSE][[1]], sep = " ")]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class2 <- "DateTimes"
  for (col in change_class2) set(rddatatmp, j = col, value = ymd_hms(rddatatmp[[col]], quiet = TRUE, tz = "GMT")) # Source 6

  rddatatmp[, c(datecolname, timecolname) := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))

datetime <- as.POSIXct(rddatatmp[[1]], tzone = "GMT")
  rddatatmp[, datetimes := as.numeric(datetime)]

  rddatatmp[, DateTimes_Timezone_Corrected := ifelse (grepl(rddatatmp[, tz_columnname, with = FALSE][[1]], pattern = "EDT|CDT|MDT|PDT|AKDT|HDT|ADT"), {rddatatmp[, datetimes] - 3600}, {rddatatmp[, datetimes]})]
# Source 8 / if the date-time stamp is DT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time

  rddatatmp[, DateTimes_Timezone_Corrected2 := as.POSIXct(DateTimes_Timezone_Corrected, origin = "1970-01-01 00:00:00", tzone = "GMT")]
# convert the numeric date time back to POSIXct with the origin of GMT

  attributes(rddatatmp$DateTimes_Timezone_Corrected2)$tzone <- "GMT" # Source 16

  rddatatmp[, c("datetimes", "DateTimes", "DateTimes_Timezone_Corrected") := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))
  setnames(rddatatmp, 1, "DateTime")


  } else if (dmy_check) {

rddatatmp[, DateTimes := paste(rddatatmp[, datecol, with = FALSE][[1]], rddatatmp[, timecol, with = FALSE][[1]], sep = " ")]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class2 <- "DateTimes"
  for (col in change_class2) set(rddatatmp, j = col, value = mdy_hm(rddatatmp[[col]], quiet = TRUE, tz = "GMT")) # Source 6

  rddatatmp[, c(datecolname, timecolname) := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))

  datetime <- as.POSIXct(rddatatmp[[1]], tzone = "GMT")
  rddatatmp[, datetimes := as.numeric(datetime)]

  rddatatmp[, DateTimes_Timezone_Corrected := ifelse (grepl(rddatatmp[, tz_columnname, with = FALSE][[1]], pattern = "EDT|CDT|MDT|PDT|AKDT|HDT|ADT"), {rddatatmp[, datetimes] - 3600}, {rddatatmp[, datetimes]})]
# Source 8 / if the date-time stamp is DT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time

  rddatatmp[, DateTimes_Timezone_Corrected2 := as.POSIXct(DateTimes_Timezone_Corrected, origin = "1970-01-01 00:00:00", tzone = "GMT")]
# convert the numeric date time back to POSIXct with the origin of GMT

  attributes(rddatatmp$DateTimes_Timezone_Corrected2)$tzone <- "GMT" # Source 16

  rddatatmp[, c("datetimes", "DateTimes", "DateTimes_Timezone_Corrected") := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))
  setnames(rddatatmp, 1, "DateTime")


} else if (dmyHM_check) {

rddatatmp[, DateTimes := paste(rddatatmp[, datecol, with = FALSE][[1]], rddatatmp[, timecol, with = FALSE][[1]], sep = " ")]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class2 <- "DateTimes"
  for (col in change_class2) set(rddatatmp, j = col, value = dmy_hm(rddatatmp[[col]], quiet = TRUE, tz = "GMT")) # Source 6

  rddatatmp[, c(datecolname, timecolname) := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))

  datetime <- as.POSIXct(rddatatmp[[1]], tzone = "GMT")
  rddatatmp[, datetimes := as.numeric(datetime)]

  rddatatmp[, DateTimes_Timezone_Corrected := ifelse (grepl(rddatatmp[, tz_columnname, with = FALSE][[1]], pattern = "EDT|CDT|MDT|PDT|AKDT|HDT|ADT"), {rddatatmp[, datetimes] - 3600}, {rddatatmp[, datetimes]})]
# Source 8 / if the date-time stamp is DT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time

  rddatatmp[, DateTimes_Timezone_Corrected2 := as.POSIXct(DateTimes_Timezone_Corrected, origin = "1970-01-01 00:00:00", tzone = "GMT")]
# convert the numeric date time back to POSIXct with the origin of GMT

  attributes(rddatatmp$DateTimes_Timezone_Corrected2)$tzone <- "GMT" # Source 16

  rddatatmp[, c("datetimes", "DateTimes", "DateTimes_Timezone_Corrected") := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))
  setnames(rddatatmp, 1, "DateTime")


  } else if (dmyHMS_check) {

rddatatmp[, DateTimes := paste(rddatatmp[, datecol, with = FALSE][[1]], rddatatmp[, timecol, with = FALSE][[1]], sep = " ")]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class2 <- "DateTimes"
  for (col in change_class2) set(rddatatmp, j = col, value = dmy_hms(rddatatmp[[col]], quiet = TRUE, tz = "GMT")) # Source 6

  rddatatmp[, c(datecolname, timecolname) := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))

  datetime <- as.POSIXct(rddatatmp[[1]], tzone = "GMT")
  rddatatmp[, datetimes := as.numeric(datetime)]

  rddatatmp[, DateTimes_Timezone_Corrected := ifelse (grepl(rddatatmp[, tz_columnname, with = FALSE][[1]], pattern = "EDT|CDT|MDT|PDT|AKDT|HDT|ADT"), {rddatatmp[, datetimes] - 3600}, {rddatatmp[, datetimes]})]
# Source 8 / if the date-time stamp is DT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time

  rddatatmp[, DateTimes_Timezone_Corrected2 := as.POSIXct(DateTimes_Timezone_Corrected, origin = "1970-01-01 00:00:00", tzone = "GMT")]
# convert the numeric date time back to POSIXct with the origin of GMT

  attributes(rddatatmp$DateTimes_Timezone_Corrected2)$tzone <- "GMT" # Source 16

  rddatatmp[, c("datetimes", "DateTimes", "DateTimes_Timezone_Corrected") := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))
  setnames(rddatatmp, 1, "DateTime")


  } else if (mdy_check) {

rddatatmp[, DateTimes := paste(rddatatmp[, datecol, with = FALSE][[1]], rddatatmp[, timecol, with = FALSE][[1]], sep = " ")]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class2 <- "DateTimes"
  for (col in change_class2) set(rddatatmp, j = col, value = mdy_hm(rddatatmp[[col]], quiet = TRUE, tz = "GMT")) # Source 6

  rddatatmp[, c(datecolname, timecolname) := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))

  datetime <- as.POSIXct(rddatatmp[[1]], tzone = "GMT")
  rddatatmp[, datetimes := as.numeric(datetime)]

  rddatatmp[, DateTimes_Timezone_Corrected := ifelse (grepl(rddatatmp[, tz_columnname, with = FALSE][[1]], pattern = "EDT|CDT|MDT|PDT|AKDT|HDT|ADT"), {rddatatmp[, datetimes] - 3600}, {rddatatmp[, datetimes]})]
# Source 8 / if the date-time stamp is DT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time

  rddatatmp[, DateTimes_Timezone_Corrected2 := as.POSIXct(DateTimes_Timezone_Corrected, origin = "1970-01-01 00:00:00", tzone = "GMT")]
# convert the numeric date time back to POSIXct with the origin of GMT

  attributes(rddatatmp$DateTimes_Timezone_Corrected2)$tzone <- "GMT" # Source 16

  rddatatmp[, c("datetimes", "DateTimes", "DateTimes_Timezone_Corrected") := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))
  setnames(rddatatmp, 1, "DateTime")


   } else if (mdyHM_check) {

rddatatmp[, DateTimes := paste(rddatatmp[, datecol, with = FALSE][[1]], rddatatmp[, timecol, with = FALSE][[1]], sep = " ")]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class2 <- "DateTimes"
  for (col in change_class2) set(rddatatmp, j = col, value = mdy_hm(rddatatmp[[col]], quiet = TRUE, tz = "GMT")) # Source 6

  rddatatmp[, c(datecolname, timecolname) := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))

  datetime <- as.POSIXct(rddatatmp[[1]], tzone = "GMT")
  rddatatmp[, datetimes := as.numeric(datetime)]

  rddatatmp[, DateTimes_Timezone_Corrected := ifelse (grepl(rddatatmp[, tz_columnname, with = FALSE][[1]], pattern = "EDT|CDT|MDT|PDT|AKDT|HDT|ADT"), {rddatatmp[, datetimes] - 3600}, {rddatatmp[, datetimes]})]
# Source 8 / if the date-time stamp is DT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time

  rddatatmp[, DateTimes_Timezone_Corrected2 := as.POSIXct(DateTimes_Timezone_Corrected, origin = "1970-01-01 00:00:00", tzone = "GMT")]
# convert the numeric date time back to POSIXct with the origin of GMT

  attributes(rddatatmp$DateTimes_Timezone_Corrected2)$tzone <- "GMT" # Source 16

  rddatatmp[, c("datetimes", "DateTimes", "DateTimes_Timezone_Corrected") := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))
  setnames(rddatatmp, 1, "DateTime")


} else if (mdyHMS_check) {

rddatatmp[, DateTimes := paste(rddatatmp[, datecol, with = FALSE][[1]], rddatatmp[, timecol, with = FALSE][[1]], sep = " ")]

# changing column to POSIXct class
# obtain the name of the column based on the column number
  change_class2 <- "DateTimes"
  for (col in change_class2) set(rddatatmp, j = col, value = mdy_hms(rddatatmp[[col]], quiet = TRUE, tz = "GMT")) # Source 6

  rddatatmp[, c(datecolname, timecolname) := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))

  datetime <- as.POSIXct(rddatatmp[[1]], tzone = "GMT")
  rddatatmp[, datetimes := as.numeric(datetime)]

  rddatatmp[, DateTimes_Timezone_Corrected := ifelse (grepl(rddatatmp[, tz_columnname, with = FALSE][[1]], pattern = "EDT|CDT|MDT|PDT|AKDT|HDT|ADT"), {rddatatmp[, datetimes] - 3600}, {rddatatmp[, datetimes]})]
# Source 8 / if the date-time stamp is DT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time

  rddatatmp[, DateTimes_Timezone_Corrected2 := as.POSIXct(DateTimes_Timezone_Corrected, origin = "1970-01-01 00:00:00", tzone = "GMT")]
# convert the numeric date time back to POSIXct with the origin of GMT

  attributes(rddatatmp$DateTimes_Timezone_Corrected2)$tzone <- "GMT" # Source 16

  rddatatmp[, c("datetimes", "DateTimes", "DateTimes_Timezone_Corrected") := NULL, with = FALSE]
  setcolorder(rddatatmp, c(length(rddatatmp), 1:(length(rddatatmp)-1L)))
  setnames(rddatatmp, 1, "DateTime")

  }
  }


## Source 9 and 10 begin
    RDdatatmp <- copy(rddatatmp) # copies rddatatmp

if (grepl(RDdatatmp[[1]][1], pattern = "\\d{0,2}:\\d{2}(?:[:.]\\d+)?|(\\d{0,2}:\\d{2}(?:[:.]\\d+)?)(\\s+(([AP]\\.{0,1}M\\.{0,1})|([ap]\\.{0,1}m\\.{0,1})))") == TRUE) { # Source 15

    RDdatatmp[[1]] <- strptime(RDdatatmp[[1]], "%Y-%m-%d %H:%M:%S") # changes from POSIXct to character for the DateTime
    RDdatatmp[[1]] <- format(RDdatatmp[[1]], "%Y-%m-%d %H:%M:%S") # Source 17 / changes the DateTime format to numeric month/numeric date/four digit year with HMS

} else {

    RDdatatmp[[1]] <- strptime(RDdatatmp[[1]], "%Y-%m-%d") # changes from POSIXct to character for the DateTime
    RDdatatmp[[1]] <- format(RDdatatmp[[1]], "%Y-%m-%d") # Source 17 / changes the DateTime format to numeric month/numeric date/four digit year
}
## Source 9 and 10 end


  rddatatmp2 <- readLines(file)
# reads the large table
  idx.comments <- grep("^[#]", rddatatmp2)
  rddatatmp2 <- rddatatmp2[idx.comments]
  rddatatmp2 <- stri_replace_all_fixed(rddatatmp2, "#", "")


  wb <- createWorkbook()
# use R package openxlsx to create the .xlsx spreadsheet
  addWorksheet(wb, "QW Data TZ Corrected")
# adds the worksheet with the name of QW Data TZ Corrected
  writeDataTable(wb, "QW Data TZ Corrected", RDdatatmp)
# writes the data to the workbook
  setColWidths(wb, sheet = 1, cols = 1, widths = 22)
# column width of 22 units for column 1
  addWorksheet(wb, "QW Data")
# adds the worksheet with the name of QW Data
  writeDataTable(wb, "QW Data", rddatatmp1)
# writes the data to the workbook
  setColWidths(wb, sheet = 2, cols = 1:ncol(rddatatmp1), widths = 22)
# column width of 22 units for all columns
  addWorksheet(wb, paste(site_no, "meta", sep = " "))
# adds the worksheet with the name of meta
  writeData(wb, paste(site_no, "meta", sep = " "), rddatatmp2)
# writes the data to the workbook
  filesave5 <- tclvalue(tkgetSaveFile(title = paste0("Save", " ", stri_trans_toupper(basename(file_path_sans_ext(file))), " ", "file as"), filetypes = "{{MS Excel file} .xlsx}"))
# Source 3 & 4 / GUI file dialog to save the spreadsheet
# Source 12 & 13 / original file name minus the extension and path in uppercase
  saveWorkbook(wb, filesave5, overwrite = overwrite)


}
}
}
}
