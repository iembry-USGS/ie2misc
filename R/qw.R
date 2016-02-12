#' qw and qwBATCH
#'
#' qw and qwBATCH process raw QW files.
#'
#' qw function opens a single or multiple raw, QW file(s) to modify the format
#'   and then exports the file(s) in .xlsx format. This is done for a single
#'   file or multiple files that the user selects.
#'
#'
#' qwBATCH function opens raw QW files, from a directory, to modify the format
#'   and then exports the files in .xlsx format.  This is done in a BATCH mode
#'   (whole directory of QW files).
#'
#' Both qw and qwBATCH functions perform the same processes on the raw QW
#'   files: 1) remove row 1 (which starts with 5s), 2) create a column with
#'   the Date and Time rather than 2 separate Date and Time columns, and
#'   3) exports the QW file as a spreadsheet with three sheets (sheet1
#'   corrects the timezones for Daylight Savings Times and removes the
#'   timezone datum column, sheet2 does not correct for Daylight Savings Time,
#'   and sheet3 provides the meta data from the top of the file). The
#'   supported US timezones are the following: Eastern, Central, Mountain, and
#'   Pacific. If you are processing stations in the Alaska, Hawai'i and/or
#'   Puerto Rico timezones, then the timezones will not be adjusted for
#'   Daylight Savings Time. The same is also true of any stations located in
#'   other US regions that do not following Daylight Savings Time.
#'
#'
#'
#'
#' @param file Input QW file(s) to be selected through a file dialog.
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
#' @param pattern The default pattern is \code{qwdata$} (the filename ends with a case
#'	insensitive "qwdata"). This pattern can be changed by
#'   \code{qwBATCH(pattern = "pattern")}.
#'
#' @return QW .xlsx file(s) where sheet1 is named after the original filename
#'   and the exported format is suitable only for viewing in a spreadsheet
#'   application.
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
#'    \item GMT: Greenwich Mean Time - World Time / Time in every Time Zone: Eastern Time EST (USA & Canada) &gt; What's the current time now in EST? (EDT in Summer). See \url{http://wwp.greenwichmeantime.com/time-zone/usa/eastern-time/}.
#'    \item GMT: Greenwich Mean Time - World Time / Time in every Time Zone: CST Central Time &gt; What's current time in Central Time Zone now? (USA & Canada). See \url{http://wwp.greenwichmeantime.com/time-zone/usa/central-time/}.
#'    \item GMT: Greenwich Mean Time - World Time / Time in every Time Zone: Mountain Time (MST - USA & Canada). What's the current time now? / MDT in Summer. See \url{http://wwp.greenwichmeantime.com/time-zone/usa/mountain-time/}.
#'    \item GMT: Greenwich Mean Time - World Time / Time in every Time Zone: PST: Pacific Time (USA & Canada). What's the current time now in PST? / PDT in Summer. See \url{http://wwp.greenwichmeantime.com/time-zone/usa/pacific-time/}.
#'    \item multiple output filenames in R - Stack Overflow asked and edited by Gabelins on Feb 1 2013. See \url{http://stackoverflow.com/questions/14651594/multiple-output-filenames-in-r}.
#'    \item r - Regex return file name, remove path and file extension - Stack Overflow answered and edited by Ananda Mahto on Feb 25 2013. See \url{http://stackoverflow.com/questions/15073753/regex-return-file-name-remove-path-and-file-extension/15073919}.
#'    \item warnings - How do I get rid of the NOTE's generated by R CMD check when using for example ddply in my package? - Stack Overflow answered by shadow on Mar 4 2015 and edited by shadow on Mar 5 2015. See \url{https://stackoverflow.com/questions/28851812/how-do-i-get-rid-of-the-notes-generated-by-r-cmd-check-when-using-for-example-d}.
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
#' # Examples to change (an) QW file(s) interactively and non-interactively
#' library(ie2misc)
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
#' @import stringi
#' @import tools
#' @import tcltk
#' @import gWidgets2
#' @import gWidgets2tcltk
#' @import openxlsx
#' @import data.table
#'
#' @name qw
NULL

#' @export
#' @rdname qw
qw <- function (file = tk_choose.files(default = "", caption = "Select file(s) to open & hold down Ctrl to choose more than 1 file", multi = TRUE, filters = matrix(c("QW file", "*"), 1, 2, byrow = TRUE)), interactive = TRUE, overwrite = TRUE) {

overwrite <- overwrite

date_times <- date_times_tf <- DateTimes_Timezone_Corrected <- NULL
sample_start_time_datum_cd <- NULL
# Source 17

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
# Sources 1 & 2 / only process non-empty files and provide a stop warning if the input

} else {

  rddatatmp <- read.table(file, header = TRUE, row.names = NULL, comment.char = "#", fill = TRUE, stringsAsFactors = FALSE, sep = "\t")
# reads the qw data file as a table and fills in the table with NA for any missing values
  rddatatmp <- rddatatmp[-1,]
# removes the first row
  datetime <- paste(rddatatmp$sample_dt, rddatatmp$sample_tm, sep = " ")
# creates a combined Date and Time character vector


if (all(grepl("EST|EDT", rddatatmp$sample_start_time_datum_cd))) {

  datetime <- as.POSIXct(datetime, tzone = "EST5EDT")
# Source 11 / transforms the character vector into a POSIXct object with the EST/EDT time zone
  rddatatmp <- cbind(rddatatmp[, 1:2], datetime, rddatatmp[, 5:length(rddatatmp)])
# Source 7 / Combines the columns of rddatatmp with the columns of datetime
  rddatatmp <- setDT(rddatatmp)
# makes rddatatmp into a data.table for better performance
  setkey(rddatatmp, datetime)
# sets the key of rddatatmp as datetime

# Source 6 begins
  change_class <- grep("^p", colnames(rddatatmp))
  for (col in change_class) set(rddatatmp, j = col, value = as.numeric(rddatatmp[[col]]))
# change the class from character to numeric for all columns beginning with p
# Source 6 ends

  rddatatmp1 <- copy(rddatatmp)

  rddatatmp[, date_times := as.numeric(datetime)]
# Source 8 / converts POSIXct to numeric
  rddatatmp[, date_times_tf := ifelse (sample_start_time_datum_cd == "EDT", {date_times - 3600}, {date_times})]
# Source 8 / if the date-time stamp is EDT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time
  rddatatmp[, DateTimes_Timezone_Corrected := as.POSIXct(date_times_tf, origin = "1970-01-01 00:00:00 EST5EDT")]
# convert the numeric date time back to POSIXct with the origin of EST/EDT


} else if (all(grepl("CST|CDT", rddatatmp$sample_start_time_datum_cd))) {

  datetime <- as.POSIXct(datetime, tzone = "CST6CDT")
# Source 12 / transforms the character vector into a POSIXct object with the CST/CDT time zone
  rddatatmp <- cbind(rddatatmp[, 1:2], datetime, rddatatmp[, 5:length(rddatatmp)])
# Source 7 / Combines the columns of rddatatmp with the columns of datetime
  rddatatmp <- setDT(rddatatmp)
# makes rddatatmp into a data.table for better performance
  setkey(rddatatmp, datetime)
# sets the key of rddatatmp as datetime

# Source 6 begins
  change_class <- grep("^p", colnames(rddatatmp))
  for (col in change_class) set(rddatatmp, j = col, value = as.numeric(rddatatmp[[col]]))
# change the class from character to numeric for all columns beginning with p
# Source 6 ends

  rddatatmp1 <- copy(rddatatmp)

  rddatatmp[, date_times := as.numeric(datetime)]
# Source 8 / converts POSIXct to numeric
  rddatatmp[, date_times_tf := ifelse (sample_start_time_datum_cd == "CDT", {date_times - 3600}, {date_times})]
# Source 8 / if the date-time stamp is CDT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time
  rddatatmp[, DateTimes_Timezone_Corrected := as.POSIXct(date_times_tf, origin = "1970-01-01 00:00:00 CST6CDT")]
# convert the numeric date time back to POSIXct with the origin of CST/CDT


} else if (all(grepl("MST|MDT", rddatatmp$sample_start_time_datum_cd))) {

  datetime <- as.POSIXct(datetime, tzone = "MST7MDT")
# Source 13 / transforms the character vector into a POSIXct object with the MST/MDT time zone
  rddatatmp <- cbind(rddatatmp[, 1:2], datetime, rddatatmp[, 5:length(rddatatmp)])
# Source 7 / Combines the columns of rddatatmp with the columns of datetime
  rddatatmp <- setDT(rddatatmp)
# makes rddatatmp into a data.table for better performance
  setkey(rddatatmp, datetime)
# sets the key of rddatatmp as datetime

# Source 6 begins
  change_class <- grep("^p", colnames(rddatatmp))
  for (col in change_class) set(rddatatmp, j = col, value = as.numeric(rddatatmp[[col]]))
# change the class from character to numeric for all columns beginning with p
# Source 6 ends

  rddatatmp1 <- copy(rddatatmp)

  rddatatmp[, date_times := as.numeric(datetime)]
# Source 8 / converts POSIXct to numeric
  rddatatmp[, date_times_tf := ifelse (sample_start_time_datum_cd == "MDT", {date_times - 3600}, {date_times})]
# Source 8 / if the date-time stamp is MDT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time
  rddatatmp[, DateTimes_Timezone_Corrected := as.POSIXct(date_times_tf, origin = "1970-01-01 00:00:00 MST7MDT")]
# convert the numeric date time back to POSIXct with the origin of MST/MDT


} else if (all(grepl("PST|PDT", rddatatmp$sample_start_time_datum_cd))) {

  datetime <- as.POSIXct(datetime, tzone = "PST8PDT")
# Source 14 / transforms the character vector into a POSIXct object with the PST/PDT time zone
  rddatatmp <- cbind(rddatatmp[, 1:2], datetime, rddatatmp[, 5:length(rddatatmp)])
# Source 7 / Combines the columns of rddatatmp with the columns of datetime
  rddatatmp <- setDT(rddatatmp)
# makes rddatatmp into a data.table for better performance
  setkey(rddatatmp, datetime)
# sets the key of rddatatmp as datetime

# Source 6 begins
  change_class <- grep("^p", colnames(rddatatmp))
  for (col in change_class) set(rddatatmp, j = col, value = as.numeric(rddatatmp[[col]]))
# change the class from character to numeric for all columns beginning with p
# Source 6 ends

  rddatatmp1 <- copy(rddatatmp)

  rddatatmp[, date_times := as.numeric(datetime)]
# Source 8 / converts POSIXct to numeric
  rddatatmp[, date_times_tf := ifelse (sample_start_time_datum_cd == "PDT", {date_times - 3600}, {date_times})]
# Source 8 / if the date-time stamp is PDT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time
  rddatatmp[, DateTimes_Timezone_Corrected := as.POSIXct(date_times_tf, origin = "1970-01-01 00:00:00 PST8PDT")]
# convert the numeric date time back to POSIXct with the origin of PST/PDT
}


  setkey(rddatatmp, DateTimes_Timezone_Corrected)
# sets the key of rddatatmp to DateTimes_Timezone_Corrected
  rddatatmp <- rddatatmp[, c("datetime", "sample_start_time_datum_cd", "date_times", "date_times_tf") := NULL, with = FALSE]
# removes datetime, sample_start_time_datum_cd, date_times, date_times_tf
  setnames(rddatatmp, length(rddatatmp), "DateTime - Time Zone Corrected")
# renames the last column
  setcolorder(rddatatmp, c(1, 2, length(rddatatmp), 3:(length(rddatatmp)-1L)))
# alters the column order

# Source 9 and 10 begin
  rddatatmp[[3]] <- strptime(rddatatmp[[3]], "%Y-%m-%d %T")
# changes from POSIXct to character for the datetime
  rddatatmp[[3]] <- format(rddatatmp[[3]], "%d-%b-%Y %T")
# corrects the format

  rddatatmp1[[3]] <- strptime(rddatatmp1[[3]], "%Y-%m-%d %T")
# changes from POSIXct to character for the datetime
  rddatatmp1[[3]] <- format(rddatatmp1[[3]], "%d-%b-%Y %T")
# corrects the format
# Source 9 and 10 end

  rddatatmp2 <- readLines(file)
# reads the large table
  idx.comments <- grep("^[#]", rddatatmp2)
  rddatatmp2 <- rddatatmp2[idx.comments]
  rddatatmp2 <- stri_replace_all_fixed(rddatatmp2, "#", "")

  wb <- createWorkbook()
# use R package openxlsx to create the .xlsx spreadsheet
  addWorksheet(wb, "QW Data TZ Corrected")
# adds the worksheet with the name of QW Data TZ Corrected
  writeData(wb, "QW Data TZ Corrected", rddatatmp)
# writes the data to the workbook
  setColWidths(wb, sheet = 1, cols = 1:ncol(rddatatmp), widths = "auto")
# sets the column widths to auto for sheet 1
  addWorksheet(wb, "QW Data")
# adds the worksheet with the name of QW Data
  writeData(wb, "QW Data", rddatatmp1)
# writes the data to the workbook
  setColWidths(wb, sheet = 2, cols = 1:ncol(rddatatmp1), widths = "auto")
# sets the column widths to auto for sheet 1
  addWorksheet(wb, "meta")
# adds the worksheet with the name of meta
  writeData(wb, "meta", rddatatmp2)
# writes the data to the workbook
  filesave1 <- tclvalue(tkgetSaveFile(title = "Save file as", filetypes = "{{MS Excel file} .xlsx}"))
# Sources 3 & 4 / GUI file dialog to save the spreadsheet
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
# Sources 1 & 2 / only process non-empty files and provide a stop warning if the input file is empty

} else {

# Source 5 begins
  assign(file[i], read.table(file[i], header = TRUE, row.names = NULL, comment.char = "#", fill = TRUE, stringsAsFactors = FALSE, sep = "\t"))
# reads the qw data file as a table and fills in the table with NA for any missing values
  rddatatmp <- assign(file[i], get(file[i]))
# Source 5 ends

  rddatatmp <- rddatatmp[-1,]
# removes the first row
  datetime <- paste(rddatatmp$sample_dt, rddatatmp$sample_tm, sep = " ")
# creates a combined Date and Time character vector


if (all(grepl("EST|EDT", rddatatmp$sample_start_time_datum_cd))) {

  datetime <- as.POSIXct(datetime, tzone = "EST5EDT")
# Source 11 / transforms the character vector into a POSIXct object with the EST/EDT time zone
  rddatatmp <- cbind(rddatatmp[, 1:2], datetime, rddatatmp[, 5:length(rddatatmp)])
# Source 7 / Combines the columns of rddatatmp with the columns of datetime
  rddatatmp <- setDT(rddatatmp)
# makes rddatatmp into a data.table for better performance
  setkey(rddatatmp, datetime)
# sets the key of rddatatmp as datetime

# Source 6 begins
  change_class <- grep("^p", colnames(rddatatmp))
  for (col in change_class) set(rddatatmp, j = col, value = as.numeric(rddatatmp[[col]]))
# change the class from character to numeric for all columns beginning with p
# Source 6 ends

  rddatatmp1 <- copy(rddatatmp)

  rddatatmp[, date_times := as.numeric(datetime)]
# Source 8 / converts POSIXct to numeric
  rddatatmp[, date_times_tf := ifelse (sample_start_time_datum_cd == "EDT", {date_times - 3600}, {date_times})]
# Source 8 / if the date-time stamp is EDT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time
  rddatatmp[, DateTimes_Timezone_Corrected := as.POSIXct(date_times_tf, origin = "1970-01-01 00:00:00 EST5EDT")]
# convert the numeric date time back to POSIXct with the origin of EST/EDT


} else if (all(grepl("CST|CDT", rddatatmp$sample_start_time_datum_cd))) {

  datetime <- as.POSIXct(datetime, tzone = "CST6CDT")
# Source 12 / transforms the character vector into a POSIXct object with the CST/CDT time zone
  rddatatmp <- cbind(rddatatmp[, 1:2], datetime, rddatatmp[, 5:length(rddatatmp)])
# Source 7 / Combines the columns of rddatatmp with the columns of datetime
  rddatatmp <- setDT(rddatatmp)
# makes rddatatmp into a data.table for better performance
  setkey(rddatatmp, datetime)
# sets the key of rddatatmp as datetime

# Source 6 begins
  change_class <- grep("^p", colnames(rddatatmp))
  for (col in change_class) set(rddatatmp, j = col, value = as.numeric(rddatatmp[[col]]))
# change the class from character to numeric for all columns beginning with p
# Source 6 ends

  rddatatmp1 <- copy(rddatatmp)

  rddatatmp[, date_times := as.numeric(datetime)]
# Source 8 / converts POSIXct to numeric
  rddatatmp[, date_times_tf := ifelse (sample_start_time_datum_cd == "CDT", {date_times - 3600}, {date_times})]
# Source 8 / if the date-time stamp is CDT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time
  rddatatmp[, DateTimes_Timezone_Corrected := as.POSIXct(date_times_tf, origin = "1970-01-01 00:00:00 CST6CDT")]
# convert the numeric date time back to POSIXct with the origin of CST/CDT


} else if (all(grepl("MST|MDT", rddatatmp$sample_start_time_datum_cd))) {

  datetime <- as.POSIXct(datetime, tzone = "MST7MDT")
# Source 13 / transforms the character vector into a POSIXct object with the MST/MDT time zone
  rddatatmp <- cbind(rddatatmp[, 1:2], datetime, rddatatmp[, 5:length(rddatatmp)])
# Source 7 / Combines the columns of rddatatmp with the columns of datetime
  rddatatmp <- setDT(rddatatmp)
# makes rddatatmp into a data.table for better performance
  setkey(rddatatmp, datetime)
# sets the key of rddatatmp as datetime

# Source 6 begins
  change_class <- grep("^p", colnames(rddatatmp))
  for (col in change_class) set(rddatatmp, j = col, value = as.numeric(rddatatmp[[col]]))
# change the class from character to numeric for all columns beginning with p
# Source 6 ends

  rddatatmp1 <- copy(rddatatmp)

  rddatatmp[, date_times := as.numeric(datetime)]
# Source 8 / converts POSIXct to numeric
  rddatatmp[, date_times_tf := ifelse (sample_start_time_datum_cd == "MDT", {date_times - 3600}, {date_times})]
# Source 8 / if the date-time stamp is MDT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time
  rddatatmp[, DateTimes_Timezone_Corrected := as.POSIXct(date_times_tf, origin = "1970-01-01 00:00:00 MST7MDT")]
# convert the numeric date time back to POSIXct with the origin of MST/MDT


} else if (all(grepl("PST|PDT", rddatatmp$sample_start_time_datum_cd))) {

  datetime <- as.POSIXct(datetime, tzone = "PST8PDT")
# Source 14 / transforms the character vector into a POSIXct object with the PST/PDT time zone
  rddatatmp <- cbind(rddatatmp[, 1:2], datetime, rddatatmp[, 5:length(rddatatmp)])
# Source 7 / Combines the columns of rddatatmp with the columns of datetime
  rddatatmp <- setDT(rddatatmp)
# makes rddatatmp into a data.table for better performance
  setkey(rddatatmp, datetime)
# sets the key of rddatatmp as datetime

# Source 6 begins
  change_class <- grep("^p", colnames(rddatatmp))
  for (col in change_class) set(rddatatmp, j = col, value = as.numeric(rddatatmp[[col]]))
# change the class from character to numeric for all columns beginning with p
# Source 6 ends

  rddatatmp1 <- copy(rddatatmp)

  rddatatmp[, date_times := as.numeric(datetime)]
# Source 8 / converts POSIXct to numeric
  rddatatmp[, date_times_tf := ifelse (sample_start_time_datum_cd == "PDT", {date_times - 3600}, {date_times})]
# Source 8 / if the date-time stamp is PDT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time
  rddatatmp[, DateTimes_Timezone_Corrected := as.POSIXct(date_times_tf, origin = "1970-01-01 00:00:00 PST8PDT")]
# convert the numeric date time back to POSIXct with the origin of PST/PDT
}

  setkey(rddatatmp, DateTimes_Timezone_Corrected)
# sets the key of rddatatmp to DateTimes_Timezone_Corrected
  rddatatmp <- rddatatmp[, c("datetime", "sample_start_time_datum_cd", "date_times", "date_times_tf") := NULL, with = FALSE]
# removes datetime, sample_start_time_datum_cd, date_times, date_times_tf
  setnames(rddatatmp, length(rddatatmp), "DateTime - Time Zone Corrected")
# renames DateTimes_Timezone_Corrected to datetime
  setcolorder(rddatatmp, c(1, 2, length(rddatatmp), 3:(length(rddatatmp)-1L)))
# alters the column order

# Source 9 and 10 begin
  rddatatmp[[3]] <- strptime(rddatatmp[[3]], "%Y-%m-%d %T")
# changes from POSIXct to character for the datetime
  rddatatmp[[3]] <- format(rddatatmp[[3]], "%d-%b-%Y %T")
# corrects the format

  rddatatmp1[[3]] <- strptime(rddatatmp1[[3]], "%Y-%m-%d %T")
# changes from POSIXct to character for the datetime
  rddatatmp1[[3]] <- format(rddatatmp1[[3]], "%d-%b-%Y %T")
# corrects the format
# Source 9 and 10 end

# Source 5 begins
  assign(file[i], readLines(file[i]))
# reads the large table
  rddatatmp2 <- assign(file[i], get(file[i]))
# Source 5 ends

  idx.comments <- grep("^[#]", rddatatmp2)
  rddatatmp2 <- rddatatmp2[idx.comments]
  rddatatmp2 <- stri_replace_all_fixed(rddatatmp2, "#", "")

  wb <- createWorkbook()
# use R package openxlsx to create the .xlsx spreadsheet
  addWorksheet(wb, "QW Data TZ Corrected")
# adds the worksheet with the name of QW Data TZ Corrected
  writeData(wb, "QW Data TZ Corrected", rddatatmp)
# writes the data to the workbook
  setColWidths(wb, sheet = 1, cols = 1:ncol(rddatatmp), widths = "auto")
# sets the column widths to auto for sheet 1
  addWorksheet(wb, "QW Data")
# adds the worksheet with the name of QW Data
  writeData(wb, "QW Data", rddatatmp1)
# writes the data to the workbook
  setColWidths(wb, sheet = 2, cols = 1:ncol(rddatatmp1), widths = "auto")
# sets the column widths to auto for sheet 1
  addWorksheet(wb, "meta")
# adds the worksheet with the name of meta
  writeData(wb, "meta", rddatatmp2)
# writes the data to the workbook
  filesave2 <- tclvalue(tkgetSaveFile(title = "Save file as", filetypes = "{{MS Excel file} .xlsx}"))
# Sources 3 & 4 / GUI file dialog to save the spreadsheet
  saveWorkbook(wb, filesave2, overwrite = overwrite)
}
}
}
}
}

} else { # Interactive = FALSE

filesave3 <- tk_choose.dir(caption = "Select directory to save the .xlsx files")
# user selects directory and save all .xlsx files with given names in the chosen directory

# Source 5 begins
for (i in 1:length(file)) {

  assign(file[i], read.table(file[i], header = TRUE, row.names = NULL, comment.char = "#", fill = TRUE, stringsAsFactors = FALSE, sep = "\t"))
# reads the qw data file as a table and fills in the table with NA for any missing values
  rddatatmp <- assign(file[i], get(file[i]))
# Source 5 ends

  rddatatmp <- rddatatmp[-1,]
# removes the first row
  datetime <- paste(rddatatmp$sample_dt, rddatatmp$sample_tm, sep = " ")
# creates a combined Date and Time character vector

if (all(grepl("EST|EDT", rddatatmp$sample_start_time_datum_cd))) {

  datetime <- as.POSIXct(datetime, tzone = "EST5EDT")
# Source 11 / transforms the character vector into a POSIXct object with the EST/EDT time zone
  rddatatmp <- cbind(rddatatmp[, 1:2], datetime, rddatatmp[, 5:length(rddatatmp)])
# Source 7 / Combines the columns of rddatatmp with the columns of datetime
  rddatatmp <- setDT(rddatatmp)
# makes rddatatmp into a data.table for better performance
  setkey(rddatatmp, datetime)
# sets the key of rddatatmp as datetime

# Source 6 begins
  change_class <- grep("^p", colnames(rddatatmp))
  for (col in change_class) set(rddatatmp, j = col, value = as.numeric(rddatatmp[[col]]))
# change the class from character to numeric for all columns beginning with p
# Source 6 ends

  rddatatmp1 <- copy(rddatatmp)

  rddatatmp[, date_times := as.numeric(datetime)]
# Source 8 / converts POSIXct to numeric
  rddatatmp[, date_times_tf := ifelse (sample_start_time_datum_cd == "EDT", {date_times - 3600}, {date_times})]
# Source 8 / if the date-time stamp is EDT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time
  rddatatmp[, DateTimes_Timezone_Corrected := as.POSIXct(date_times_tf, origin = "1970-01-01 00:00:00 EST5EDT")]
# convert the numeric date time back to POSIXct with the origin of EST/EDT


} else if (all(grepl("CST|CDT", rddatatmp$sample_start_time_datum_cd))) {

  datetime <- as.POSIXct(datetime, tzone = "CST6CDT")
# Source 12 / transforms the character vector into a POSIXct object with the CST/CDT time zone
  rddatatmp <- cbind(rddatatmp[, 1:2], datetime, rddatatmp[, 5:length(rddatatmp)])
# Source 7 / Combines the columns of rddatatmp with the columns of datetime
  rddatatmp <- setDT(rddatatmp)
# makes rddatatmp into a data.table for better performance
  setkey(rddatatmp, datetime)
# sets the key of rddatatmp as datetime

# Source 6 begins
  change_class <- grep("^p", colnames(rddatatmp))
  for (col in change_class) set(rddatatmp, j = col, value = as.numeric(rddatatmp[[col]]))
# change the class from character to numeric for all columns beginning with p
# Source 6 ends

  rddatatmp1 <- copy(rddatatmp)

  rddatatmp[, date_times := as.numeric(datetime)]
# Source 8 / converts POSIXct to numeric
  rddatatmp[, date_times_tf := ifelse (sample_start_time_datum_cd == "CDT", {date_times - 3600}, {date_times})]
# Source 8 / if the date-time stamp is CDT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time
  rddatatmp[, DateTimes_Timezone_Corrected := as.POSIXct(date_times_tf, origin = "1970-01-01 00:00:00 CST6CDT")]
# convert the numeric date time back to POSIXct with the origin of CST/CDT


} else if (all(grepl("MST|MDT", rddatatmp$sample_start_time_datum_cd))) {

  datetime <- as.POSIXct(datetime, tzone = "MST7MDT")
# Source 13 / transforms the character vector into a POSIXct object with the MST/MDT time zone
  rddatatmp <- cbind(rddatatmp[, 1:2], datetime, rddatatmp[, 5:length(rddatatmp)])
# Source 7 / Combines the columns of rddatatmp with the columns of datetime
  rddatatmp <- setDT(rddatatmp)
# makes rddatatmp into a data.table for better performance
  setkey(rddatatmp, datetime)
# sets the key of rddatatmp as datetime

# Source 6 begins
  change_class <- grep("^p", colnames(rddatatmp))
  for (col in change_class) set(rddatatmp, j = col, value = as.numeric(rddatatmp[[col]]))
# change the class from character to numeric for all columns beginning with p
# Source 6 ends

  rddatatmp1 <- copy(rddatatmp)

  rddatatmp[, date_times := as.numeric(datetime)]
# Source 8 / converts POSIXct to numeric
  rddatatmp[, date_times_tf := ifelse (sample_start_time_datum_cd == "MDT", {date_times - 3600}, {date_times})]
# Source 8 / if the date-time stamp is MDT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time
  rddatatmp[, DateTimes_Timezone_Corrected := as.POSIXct(date_times_tf, origin = "1970-01-01 00:00:00 MST7MDT")]
# convert the numeric date time back to POSIXct with the origin of MST/MDT


} else if (all(grepl("PST|PDT", rddatatmp$sample_start_time_datum_cd))) {

  datetime <- as.POSIXct(datetime, tzone = "PST8PDT")
# Source 14 / transforms the character vector into a POSIXct object with the PST/PDT time zone
  rddatatmp <- cbind(rddatatmp[, 1:2], datetime, rddatatmp[, 5:length(rddatatmp)])
# Source 7 / Combines the columns of rddatatmp with the columns of datetime
  rddatatmp <- setDT(rddatatmp)
# makes rddatatmp into a data.table for better performance
  setkey(rddatatmp, datetime)
# sets the key of rddatatmp as datetime

# Source 6 begins
  change_class <- grep("^p", colnames(rddatatmp))
  for (col in change_class) set(rddatatmp, j = col, value = as.numeric(rddatatmp[[col]]))
# change the class from character to numeric for all columns beginning with p
# Source 6 ends

  rddatatmp1 <- copy(rddatatmp)

  rddatatmp[, date_times := as.numeric(datetime)]
# Source 8 / converts POSIXct to numeric
  rddatatmp[, date_times_tf := ifelse (sample_start_time_datum_cd == "PDT", {date_times - 3600}, {date_times})]
# Source 8 / if the date-time stamp is PDT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time
  rddatatmp[, DateTimes_Timezone_Corrected := as.POSIXct(date_times_tf, origin = "1970-01-01 00:00:00 PST8PDT")]
# convert the numeric date time back to POSIXct with the origin of PST/PDT
}

  setkey(rddatatmp, DateTimes_Timezone_Corrected)
# sets the key of rddatatmp to DateTimes_Timezone_Corrected
  rddatatmp <- rddatatmp[, c("datetime", "sample_start_time_datum_cd", "date_times", "date_times_tf") := NULL, with = FALSE]
# removes datetime, sample_start_time_datum_cd, date_times, date_times_tf
  setnames(rddatatmp, length(rddatatmp), "DateTime - Time Zone Corrected")
# renames DateTimes_Timezone_Corrected to datetime
  setcolorder(rddatatmp, c(1, 2, length(rddatatmp), 3:(length(rddatatmp)-1L)))
# alters the column order

# Source 9 and 10 begin
  rddatatmp[[3]] <- strptime(rddatatmp[[3]], "%Y-%m-%d %T")
# changes from POSIXct to character for the datetime
  rddatatmp[[3]] <- format(rddatatmp[[3]], "%d-%b-%Y %T")
# corrects the format

  rddatatmp1[[3]] <- strptime(rddatatmp1[[3]], "%Y-%m-%d %T")
# changes from POSIXct to character for the datetime
  rddatatmp1[[3]] <- format(rddatatmp1[[3]], "%d-%b-%Y %T")
# corrects the format
# Source 9 and 10 end

# Source 5 begins
  assign(file[i], readLines(file[i]))
# reads the large table
  rddatatmp2 <- assign(file[i], get(file[i]))
# Source 5 ends

  idx.comments <- grep("^[#]", rddatatmp2)
  rddatatmp2 <- rddatatmp2[idx.comments]
  rddatatmp2 <- stri_replace_all_fixed(rddatatmp2, "#", "")

  wb <- createWorkbook()
# use R package openxlsx to create the .xlsx spreadsheet
  addWorksheet(wb, "QW Data TZ Corrected")
# adds the worksheet with the name of QW Data TZ Corrected
  writeData(wb, "QW Data TZ Corrected", rddatatmp)
# writes the data to the workbook
  setColWidths(wb, sheet = 1, cols = 1:ncol(rddatatmp), widths = "auto")
# sets the column widths to auto for sheet 1
  addWorksheet(wb, "QW Data")
# adds the worksheet with the name of QW Data
  writeData(wb, "QW Data", rddatatmp1)
# writes the data to the workbook
  setColWidths(wb, sheet = 2, cols = 1:ncol(rddatatmp1), widths = "auto")
# sets the column widths to auto for sheet 1
  addWorksheet(wb, "meta")
# adds the worksheet with the name of meta
  writeData(wb, "meta", rddatatmp2)
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
qwBATCH <- function (path = tk_choose.dir(caption = "Select directory with the QW files"), pattern = "qwdata$", overwrite = TRUE) {

overwrite <- overwrite

date_times <- date_times_tf <- DateTimes_Timezone_Corrected <- NULL
sample_start_time_datum_cd <- NULL
# Source 17

confirm <- gconfirm(toolkit = guiToolkit("tcltk"), msg = paste0("Do you want to select", " ", path, " as the directory with the QW files?"), title = "Confirm", icon = "question")

if (confirm == FALSE) {

  stop("Please try again with a different directory.")
# Source 2 / provide a stop warning if the user wants to change the directory

} else {

file <- list.files(path, pattern = pattern, full.names = TRUE, ignore.case = TRUE)

filesave1 <- tk_choose.dir(caption = "Select directory to save the .xlsx files")
# user selects directory and save all .xlsx files with given names in the chosen directory

confirm <- gconfirm(toolkit = guiToolkit("tcltk"), msg = paste0("Do you want to select", " ", filesave1, " as the directory to save the batch set of files?"), title = "Confirm", icon = "question")

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
# Sources 1 & 2 / only process non-empty files and provide a stop warning if the input file is empty

} else {

# Source 5 begins
  assign(file[i], read.table(file[i], header = TRUE, row.names = NULL, comment.char = "#", fill = TRUE, stringsAsFactors = FALSE, sep = "\t"))
# reads the qw data file as a table and fills in the table with NA for any missing values
  rddatatmp <- assign(file[i], get(file[i]))
# Source 5 ends

  rddatatmp <- rddatatmp[-1,]
# removes the first row
  datetime <- paste(rddatatmp$sample_dt, rddatatmp$sample_tm, sep = " ")
# creates a combined Date and Time character vector


if (all(grepl("EST|EDT", rddatatmp$sample_start_time_datum_cd))) {

  datetime <- as.POSIXct(datetime, tzone = "EST5EDT")
# Source 11 / transforms the character vector into a POSIXct object with the EST/EDT time zone
  rddatatmp <- cbind(rddatatmp[, 1:2], datetime, rddatatmp[, 5:length(rddatatmp)])
# Source 7 / Combines the columns of rddatatmp with the columns of datetime
  rddatatmp <- setDT(rddatatmp)
# makes rddatatmp into a data.table for better performance
  setkey(rddatatmp, datetime)
# sets the key of rddatatmp as datetime

# Source 6 begins
  change_class <- grep("^p", colnames(rddatatmp))
  for (col in change_class) set(rddatatmp, j = col, value = as.numeric(rddatatmp[[col]]))
# change the class from character to numeric for all columns beginning with p
# Source 6 ends

  rddatatmp1 <- copy(rddatatmp)

  rddatatmp[, date_times := as.numeric(datetime)]
# Source 8 / converts POSIXct to numeric
  rddatatmp[, date_times_tf := ifelse (sample_start_time_datum_cd == "EDT", {date_times - 3600}, {date_times})]
# Source 8 / if the date-time stamp is EDT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time
  rddatatmp[, DateTimes_Timezone_Corrected := as.POSIXct(date_times_tf, origin = "1970-01-01 00:00:00 EST5EDT")]
# convert the numeric date time back to POSIXct with the origin of EST/EDT


} else if (all(grepl("CST|CDT", rddatatmp$sample_start_time_datum_cd))) {

  datetime <- as.POSIXct(datetime, tzone = "CST6CDT")
# Source 12 / transforms the character vector into a POSIXct object with the CST/CDT time zone
  rddatatmp <- cbind(rddatatmp[, 1:2], datetime, rddatatmp[, 5:length(rddatatmp)])
# Source 7 / Combines the columns of rddatatmp with the columns of datetime
  rddatatmp <- setDT(rddatatmp)
# makes rddatatmp into a data.table for better performance
  setkey(rddatatmp, datetime)
# sets the key of rddatatmp as datetime

# Source 6 begins
  change_class <- grep("^p", colnames(rddatatmp))
  for (col in change_class) set(rddatatmp, j = col, value = as.numeric(rddatatmp[[col]]))
# change the class from character to numeric for all columns beginning with p
# Source 6 ends

  rddatatmp1 <- copy(rddatatmp)

  rddatatmp[, date_times := as.numeric(datetime)]
# Source 8 / converts POSIXct to numeric
  rddatatmp[, date_times_tf := ifelse (sample_start_time_datum_cd == "CDT", {date_times - 3600}, {date_times})]
# Source 8 / if the date-time stamp is CDT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time
  rddatatmp[, DateTimes_Timezone_Corrected := as.POSIXct(date_times_tf, origin = "1970-01-01 00:00:00 CST6CDT")]
# convert the numeric date time back to POSIXct with the origin of CST/CDT


} else if (all(grepl("MST|MDT", rddatatmp$sample_start_time_datum_cd))) {

  datetime <- as.POSIXct(datetime, tzone = "MST7MDT")
# Source 13 / transforms the character vector into a POSIXct object with the MST/MDT time zone
  rddatatmp <- cbind(rddatatmp[, 1:2], datetime, rddatatmp[, 5:length(rddatatmp)])
# Source 7 / Combines the columns of rddatatmp with the columns of datetime
  rddatatmp <- setDT(rddatatmp)
# makes rddatatmp into a data.table for better performance
  setkey(rddatatmp, datetime)
# sets the key of rddatatmp as datetime

# Source 6 begins
  change_class <- grep("^p", colnames(rddatatmp))
  for (col in change_class) set(rddatatmp, j = col, value = as.numeric(rddatatmp[[col]]))
# change the class from character to numeric for all columns beginning with p
# Source 6 ends

  rddatatmp1 <- copy(rddatatmp)

  rddatatmp[, date_times := as.numeric(datetime)]
# Source 8 / converts POSIXct to numeric
  rddatatmp[, date_times_tf := ifelse (sample_start_time_datum_cd == "MDT", {date_times - 3600}, {date_times})]
# Source 8 / if the date-time stamp is MDT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time
  rddatatmp[, DateTimes_Timezone_Corrected := as.POSIXct(date_times_tf, origin = "1970-01-01 00:00:00 MST7MDT")]
# convert the numeric date time back to POSIXct with the origin of MST/MDT


} else if (all(grepl("PST|PDT", rddatatmp$sample_start_time_datum_cd))) {

  datetime <- as.POSIXct(datetime, tzone = "PST8PDT")
# Source 14 / transforms the character vector into a POSIXct object with the PST/PDT time zone
  rddatatmp <- cbind(rddatatmp[, 1:2], datetime, rddatatmp[, 5:length(rddatatmp)])
# Source 7 / Combines the columns of rddatatmp with the columns of datetime
  rddatatmp <- setDT(rddatatmp)
# makes rddatatmp into a data.table for better performance
  setkey(rddatatmp, datetime)
# sets the key of rddatatmp as datetime

# Source 6 begins
  change_class <- grep("^p", colnames(rddatatmp))
  for (col in change_class) set(rddatatmp, j = col, value = as.numeric(rddatatmp[[col]]))
# change the class from character to numeric for all columns beginning with p
# Source 6 ends

  rddatatmp1 <- copy(rddatatmp)

  rddatatmp[, date_times := as.numeric(datetime)]
# Source 8 / converts POSIXct to numeric
  rddatatmp[, date_times_tf := ifelse (sample_start_time_datum_cd == "PDT", {date_times - 3600}, {date_times})]
# Source 8 / if the date-time stamp is PDT, then subtract 1 hour (3600 seconds) from the original date time and if not, then return the original date time
  rddatatmp[, DateTimes_Timezone_Corrected := as.POSIXct(date_times_tf, origin = "1970-01-01 00:00:00 PST8PDT")]
# convert the numeric date time back to POSIXct with the origin of PST/PDT
}

  setkey(rddatatmp, DateTimes_Timezone_Corrected)
# sets the key of rddatatmp to DateTimes_Timezone_Corrected
  rddatatmp <- rddatatmp[, c("datetime", "sample_start_time_datum_cd", "date_times", "date_times_tf") := NULL, with = FALSE]
# removes datetime, sample_start_time_datum_cd, date_times, date_times_tf
  setnames(rddatatmp, length(rddatatmp), "DateTime - Time Zone Corrected")
# renames DateTimes_Timezone_Corrected to datetime
  setcolorder(rddatatmp, c(1, 2, length(rddatatmp), 3:(length(rddatatmp)-1L)))
# alters the column order

# Source 9 and 10 begin
  rddatatmp[[3]] <- strptime(rddatatmp[[3]], "%Y-%m-%d %T")
# changes from POSIXct to character for the datetime
  rddatatmp[[3]] <- format(rddatatmp[[3]], "%d-%b-%Y %T")
# corrects the format

  rddatatmp1[[3]] <- strptime(rddatatmp1[[3]], "%Y-%m-%d %T")
# changes from POSIXct to character for the datetime
  rddatatmp1[[3]] <- format(rddatatmp1[[3]], "%d-%b-%Y %T")
# corrects the format
# Source 9 and 10 end

# Source 5 begins
  assign(file[i], readLines(file[i]))
# reads the large table
  rddatatmp2 <- assign(file[i], get(file[i]))
# Source 5 ends

  idx.comments <- grep("^[#]", rddatatmp2)
  rddatatmp2 <- rddatatmp2[idx.comments]
  rddatatmp2 <- stri_replace_all_fixed(rddatatmp2, "#", "")

  wb <- createWorkbook()
# use R package openxlsx to create the .xlsx spreadsheet
  addWorksheet(wb, "QW Data TZ Corrected")
# adds the worksheet with the name of QW Data TZ Corrected
  writeData(wb, "QW Data TZ Corrected", rddatatmp)
# writes the data to the workbook
  setColWidths(wb, sheet = 1, cols = 1:ncol(rddatatmp), widths = "auto")
# sets the column widths to auto for sheet 1
  addWorksheet(wb, "QW Data")
# adds the worksheet with the name of QW Data
  writeData(wb, "QW Data", rddatatmp1)
# writes the data to the workbook
  setColWidths(wb, sheet = 2, cols = 1:ncol(rddatatmp1), widths = "auto")
# sets the column widths to auto for sheet 1
  addWorksheet(wb, "meta")
# adds the worksheet with the name of meta
  writeData(wb, "meta", rddatatmp2)
# writes the data to the workbook

# Source 15 and 16 begins
  filesave1a <- paste0(filesave1, "/", basename(file_path_sans_ext(file[i])))
# combine the directory name with the basename and remove the file extension
  saveWorkbook(wb, paste0(filesave1a, ".xlsx"), overwrite = overwrite)
# saves the workbook as original file name without the extension + .xlsx
# Source 15 and 16 ends
}
}
}
}
}
}
