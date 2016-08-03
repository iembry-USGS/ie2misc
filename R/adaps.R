#' adaps, adaps2, and adapsBATCH
#'
#' adaps, adaps2, and adapsBATCH process raw Automated Data Processing System
#'   (ADAPS) .rdb files from the U.S. Geological Survey (USGS) National Water
#'   Information System (NWIS). For these functions, it is only for continuous
#'   ADAPS data of the following parameters: discharge (00060), FNU turbidity
#'   (63680), and NTRU turbidity (63676 from 63680).
#'
#' adaps function opens single or multiple raw ADAPS .rdb file(s) to modify the
#'   format and then exports the file(s) in .xlsx format. This is done for a
#'   single file or multiple files that the user selects with a file dialog.
#'
#' adaps2 function opens a single raw ADAPS .rdb file to modify the format and
#'   then exports the file in .xlsx format. This is done for a single file
#'   that the user selects without a file dialog.
#'
#' adapsBATCH function opens raw ADAPS .rdb files, from a directory, to modify
#'   the format and then exports the files in .xlsx format. This is done in a
#'   BATCH mode (whole directory of ADAPS .rdb files) using a directory dialog.
#'
#' adaps, adaps2, and adapsBATCH functions perform the same processes on the
#'   raw ADAPS .rdb files: 1) Read in the file and remove the 1st 4 or 5 lines
#'   depending on whether NTRU data are present or not, 2) create 4 or 5
#'   columns (depending on whether NTRU data are present or not) based on the
#'   1st 4 or 5 lines, and 3) export the modified file in .xlsx format.
#'
#'
#'
#'
#' The following lines are representative of the .rdb format used in the files
#'   that these functions can operate on. Note: ntru may not be present. If so,
#'   then there will only be 3 cases of 16N in the last row. The last row will
#'   be removed in the final spreadsheet.
#'
#' \tabular{ccccc}{
#'   DATETIME \tab ght\cr
#'   cfs\cr
#'   fnu\cr
#'   ntru\cr
#'   19D \tab 16N \tab 16N \tab 16N \tab 16N
#' }
#'
#'
#'
#' @param file Input ADAPS .rdb file(s) to be selected through a file dialog.
#' @param interactive If interactive is \code{TRUE}, then the user will select
#' the filenames(s) to use for saving with the file dialog. In order to
#' select more than one file, the user must hold down the Ctrl (Control)
#' button while mouse clicking the chosen files. If interactive is \code{FALSE},
#' then the user will select the directory, via the directory dialog, to use
#'   for saving and the original filenames will be used.
#' @param overwrite If \code{TRUE}, overwrite any existing spreadsheet.
#' @param path Directory path of ADAPS .rdb files to be selected through a
#'   directory dialog. The user will be asked where to find the ADAPS .rdb
#'   files & then the user will be asked where to save the ADAPS .xlsx files.
#'
#' @return ADAPS .xlsx file(s)
#'
#'
#'
#' @source
#' \enumerate{
#'    \item r - How can I check if a file is empty? - Stack Overflow answered by Konrad Rudolph and edited by Geekuna Matata on Apr 23 2014. See \url{http://stackoverflow.com/questions/23254002/how-can-i-check-if-a-file-is-empty}.
#'    \item r - Better error message for stopifnot? - Stack Overflow answered by Andrie on Dec 1 2011. See \url{http://stackoverflow.com/questions/8343509/better-error-message-for-stopifnot}.
#'    \item RDocumentation: TclInterface {tcltk}. See \url{http://www.rdocumentation.org/packages/tcltk/versions/3.3.1/topics/TclInterface}.
#'    \item James Wettenhall & Philippe Grosjean, File Open/Save dialogs in R tcltk, December 01, 2015. See \url{http://www.sciviews.org/recipes/tcltk/TclTk-file-open-save-dialogs/}.
#'    \item r - read csv files and perform function, then bind together - Stack Overflow answered by bjoseph on Jan 8 2015. See \url{http://stackoverflow.com/questions/27846715/read-csv-files-and-perform-function-then-bind-together}.
#'    \item multiple output filenames in R - Stack Overflow asked and edited by Gabelins on Feb 1 2013. See \url{http://stackoverflow.com/questions/14651594/multiple-output-filenames-in-r}.
#'    \item r - Regex return file name, remove path and file extension - Stack Overflow answered and edited by Ananda Mahto on Feb 25 2013. See \url{http://stackoverflow.com/questions/15073753/regex-return-file-name-remove-path-and-file-extension/15073919}.
#'    \item R help - How to change the default Date format for write.csv function? answered by William Dunlap on Dec 28, 2009. See \url{http://r.789695.n4.nabble.com/How-to-change-the-default-Date-format-for-write-csv-function-td989826.html}.
#'    \item RDocumentation: strptime {base}. See \url{http://www.rdocumentation.org/packages/base/versions/3.3.1/topics/strptime}.
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
#' # Example to check the input file format
#' # Copy and paste the following code into the R console if you
#' # wish to see the ADAPS .rdb input file format.
#' # Note the number of lines and the row headings.
#' file.show(system.file("extdata", "spring_creek_partial.rdb",
#'   package = "ie2misc"), title = paste("spring_creek_partial.rdb"))
#' # opens the .rdb file using the default text editor
#'
#'
#'
#'
#' # Examples to change (an) ADAPS .rdb file(s) interactively and
#' # non-interactively
#' adaps2(system.file("extdata", "spring_creek_partial.rdb",
#' package = "ie2misc"))
#'
#'
#' adaps() # default where interactive = TRUE
#' # Follow the file dialog instructions
#'
#'
#' adaps(interactive = FALSE)
#' # Follow the file dialog instructions
#'
#'
#' # Example to change a directory of ADAPS .rdb files
#' adapsBATCH()
#' # Follow the file dialog instructions
#' }
#'
#'
#' @import stringi
#' @importFrom lubridate mdy_hms
#' @import reader
#' @import tools
#' @import tcltk
#' @import gWidgets2
#' @import gWidgets2tcltk
#' @import openxlsx
#'
#' @name adaps
NULL

#' @export
#' @rdname adaps
adaps <- function (file = tk_choose.files(default = "", caption = "Select file(s) to open & hold down Ctrl to choose more than 1 file", multi = TRUE, filters = matrix(c("ADAPS file", ".rdb", "ADAPS file", ".RDB"), 4, 2, byrow = TRUE)), interactive = TRUE, overwrite = TRUE) {

overwrite <- overwrite

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
# Source 1 & 2 / only process non-empty files and provide a stop warning if the input file is empty

} else {

# check the delimiter of the file
  checkdelim <- get.delim(file, skip = 5L)
# read in file to obtain the delimiter

# determine the number of lines to skip
  skip <- grep("[0-9][a-z]", readLines(file), ignore.case = TRUE)
# read to find the number of lines to skip

# reads ADAPS .rdb file as a table by skipping the first n lines (based on skip) after a check is made whether the file is tab ("\t") or comma separated (",")
if (checkdelim == "\t") {

# read in file as a table and save as rddatatmp
  rddatatmp <- read.table(file, skip = skip, col.names = c("DateTime", "ght", "Q", "fnu", "NTRU"), colClasses = c("character", "numeric", "numeric", "numeric", "numeric"), fill = TRUE, stringsAsFactors = FALSE, sep = "\t")

} else {

# read in file as a table and save as rddatatmp
  rddatatmp <- read.table(file, skip = skip, col.names = c("DateTime", "ght", "Q", "fnu", "NTRU"), colClasses = c("character", "numeric", "numeric", "numeric", "numeric"), fill = TRUE, stringsAsFactors = FALSE, sep = ",")

}

  rddatatmp[[1]] <- mdy_hms(rddatatmp[[1]], quiet = TRUE, tz = "GMT")
# Source 8 and 9 / transforms the character vector into a POSIXct object with the GMT time zone so the existing timezone should not change
    rddatatmp[[1]] <- strptime(rddatatmp[[1]], "%Y-%m-%d %H:%M:%S") # changes from POSIXct to character for the DateTime
    rddatatmp[[1]] <- format(rddatatmp[[1]], "%Y-%m-%d %H:%M:%S") # Source 10 / changes the DateTime format to numeric month/numeric date/four digit year with HMS

# creation of the raw ADAPS data spreadsheet
  wb <- createWorkbook()
# use R package openxlsx to create the .xlsx spreadsheet
  addWorksheet(wb, "ADAPS Data")
# adds the worksheet with the name of ADAPS Data
  writeDataTable(wb, "ADAPS Data", rddatatmp)
# writes the data to the workbook
  setColWidths(wb, sheet = 1, cols = 1, widths = 22)
# column width of 22 units for column 1

  filesave1 <- tclvalue(tkgetSaveFile(title = paste0("Save", " ", stri_trans_toupper(basename(file_path_sans_ext(file))), " ", "file as"), filetypes = "{{MS Excel file} .xlsx}"))
# Source 3 & 4 / GUI file dialog to save the spreadsheet
# Source 6 & 7 / original file name minus the extension and path in uppercase
  saveWorkbook(wb, filesave1, overwrite = overwrite)

}
}
}

} else {

for (i in 1:length(file)) { # Source 5

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
# check the delimiter of the file
  assign(file[i], get.delim(file[i], skip = 5L))
# read in file to obtain the delimiter
  checkdelim <- assign(file[i], get(file[i]))

# determine the number of lines to skip
  assign(file[i], grep("[0-9][a-z]", readLines(file[i]), ignore.case = TRUE))
# read to find the number of lines to skip
  skip <- assign(file[i], get(file[i]))
# Source 5 ends

# reads each ADAPS .rdb file as a table by skipping the first n lines (based on skip) after a check is made whether the file is tab ("\t") or comma separated (",")
if (checkdelim == "\t") {

# Source 5 begins
# read in file as a table and save as rddatatmp
  assign(file[i], read.table(file[i], skip = skip, col.names = c("DateTime", "ght", "Q", "fnu", "NTRU"), colClasses = c("character", "numeric", "numeric", "numeric", "numeric"), fill = TRUE, stringsAsFactors = FALSE, sep = "\t"))
  rddatatmp <- assign(file[i], get(file[i]))
# Source 5 ends

} else {

# Source 5 begins
# read in file as a table and save as rddatatmp
  assign(file[i], read.table(file[i], skip = skip, col.names = c("DateTime", "ght", "Q", "fnu", "NTRU"), colClasses = c("character", "numeric", "numeric", "numeric", "numeric"), fill = TRUE, stringsAsFactors = FALSE, sep = ","))
  rddatatmp <- assign(file[i], get(file[i]))
# Source 5 ends

}

  rddatatmp[[1]] <- mdy_hms(rddatatmp[[1]], quiet = TRUE, tz = "GMT")
# Source 8 and 9 / transforms the character vector into a POSIXct object with the GMT time zone so the existing timezone should not change
    rddatatmp[[1]] <- strptime(rddatatmp[[1]], "%Y-%m-%d %H:%M:%S") # changes from POSIXct to character for the DateTime
    rddatatmp[[1]] <- format(rddatatmp[[1]], "%Y-%m-%d %H:%M:%S") # Source 10 / changes the DateTime format to numeric month/numeric date/four digit year with HMS


# creation of the raw ADAPS data spreadsheet
  wb <- createWorkbook()
# use R package openxlsx to create the .xlsx spreadsheet
  addWorksheet(wb, "ADAPS Data")
# adds the worksheet with the name of ADAPS Data
  writeDataTable(wb, "ADAPS Data", rddatatmp)
# writes the data to the workbook
  setColWidths(wb, sheet = 1, cols = 1, widths = 22)
# column width of 22 units for column 1

  filesave2 <- tclvalue(tkgetSaveFile(title = paste0("Save", " ", stri_trans_toupper(basename(file_path_sans_ext(file[i]))), " ", "file as"), filetypes = "{{MS Excel file} .xlsx}"))
# Source 3 & 4 / GUI file dialog to save the spreadsheet
# Source 6 & 7 / original file name minus the extension and path in uppercase
  saveWorkbook(wb, filesave2, overwrite = overwrite)

}
}
}
}
}

} else if (interactive == FALSE) {

filesave3 <- tk_choose.dir(caption = "Select directory to save the .xlsx files")
# user selects directory and save all .xlsx files with given names in the chosen directory

# Source 5 begins
for (i in 1:length(file)) {

# check the delimiter of the file
  assign(file[i], get.delim(file[i], skip = 5L))
# read in file to obtain the delimiter
  checkdelim <- assign(file[i], get(file[i]))
# Source 5 ends

# determine the number of lines to skip
# Source 5 begins
  assign(file[i], grep("[0-9][a-z]", readLines(file[i]), ignore.case = TRUE))
# read to find the number of lines to skip
  skip <- assign(file[i], get(file[i]))
# Source 5 ends

# reads each ADAPS .rdb file as a table by skipping the first n lines (based on skip) after a check is made whether the file is tab ("\t") or comma separated (",")
if (checkdelim == "\t") {

# Source 5 begins
# read in file as a table and save as rddatatmp
  assign(file[i], read.table(file[i], skip = skip, col.names = c("DateTime", "ght", "Q", "fnu", "NTRU"), colClasses = c("character", "numeric", "numeric", "numeric", "numeric"), fill = TRUE, stringsAsFactors = FALSE, sep = "\t"))
  rddatatmp <- assign(file[i], get(file[i]))
# Source 5 ends

} else {

# Source 5 begins
# read in file as a table and save as rddatatmp
  assign(file[i], read.table(file[i], skip = skip, col.names = c("DateTime", "ght", "Q", "fnu", "NTRU"), colClasses = c("character", "numeric", "numeric", "numeric", "numeric"), fill = TRUE, stringsAsFactors = FALSE, sep = ","))
  rddatatmp <- assign(file[i], get(file[i]))
# Source 5 ends

}

  rddatatmp[[1]] <- mdy_hms(rddatatmp[[1]], quiet = TRUE, tz = "GMT")
# Source 8 and 9 / transforms the character vector into a POSIXct object with the GMT time zone so the existing timezone should not change
    rddatatmp[[1]] <- strptime(rddatatmp[[1]], "%Y-%m-%d %H:%M:%S") # changes from POSIXct to character for the DateTime
    rddatatmp[[1]] <- format(rddatatmp[[1]], "%Y-%m-%d %H:%M:%S") # Source 10 / changes the DateTime format to numeric month/numeric date/four digit year with HMS


# creation of the raw ADAPS data spreadsheet
  wb <- createWorkbook()
# use R package openxlsx to create the .xlsx spreadsheet
  addWorksheet(wb, "ADAPS Data")
# adds the worksheet with the name of ADAPS Data
  writeDataTable(wb, "ADAPS Data", rddatatmp)
# writes the data to the workbook
  setColWidths(wb, sheet = 1, cols = 1, widths = 22)
# column width of 22 units for column 1

# Source 6, 9, and 13 begins
  filesave3a <- paste0(filesave3, "/", basename(file_path_sans_ext(file[i])))
# combine the directory name with the basename and remove the file extension
  saveWorkbook(wb, paste0(filesave3a, ".xlsx"), overwrite = overwrite)
# saves the workbook as original file name without the extension + .xlsx
# Source 6, 9, and 13 ends

}
}
}



#' @export
#' @rdname adaps
adapsBATCH <- function (path = tk_choose.dir(caption = "Select directory with the ADAPS .rdb files"), overwrite = TRUE) {

overwrite <- overwrite

confirm <- gconfirm(toolkit = guiToolkit("tcltk"), msg = paste0("Do you want to select", " ", path, " as the directory with the ADAPS .rdb files?"), title = "Confirm", icon = "question")

if (confirm == FALSE) {

  stop("Please try again with a different directory.")
# Source 2 / provide a stop warning if the user wants to change the directory

} else {

file <- list.files(path, pattern = "rdb|RDB$", full.names = TRUE)
file <- file[stri_detect_fixed(file, ".rdb", case_insensitive = TRUE)]

dirsave <- tk_choose.dir(caption = "Select directory to save the batch set of .xlsx files")
# user selects directory and save all .xlsx files with given names in the chosen directory

confirm <- gconfirm(toolkit = guiToolkit("tcltk"), msg = paste0("Do you want to select", " ", dirsave, " as the directory to save the batch set of files?"), title = "Confirm", icon = "question")

if (confirm == FALSE) {

  stop("Please try again with a different directory.")
# Source 2 / provide a stop warning if the user wants to change the directory

} else {

for (i in 1:length(file)) { # Source 3

if (!nchar(file[i])) {

  stop("You did not choose a file. Please try again with a different file.")
# Source 2 / provide a stop warning if no file was selected

} else {

if (file.info(file[i])$size == 0) {

  stop("Your file is empty. Please try again with a different file.")
# Source 1 & 2 / only process non-empty files and provide a stop warning if the input file is empty

} else {

# Source 3 begins
# check the delimiter of the file
  assign(file[i], get.delim(file[i], skip = 5L))
# read in file to obtain the delimiter
  checkdelim <- assign(file[i], get(file[i]))
# Source 3 ends

# determine the number of lines to skip
# Source 3 begins
  assign(file[i], grep("[0-9][a-z]", readLines(file[i]), ignore.case = TRUE))
# read to find the number of lines to skip
  skip <- assign(file[i], get(file[i]))
# Source 3 ends

# reads each ADAPS .rdb file as a table by skipping the first n lines (based on skip) after a check is made whether the file is tab ("\t") or comma separated (",")
if (checkdelim == "\t") {

# Source 3 begins
# read in file as a table and save as rddatatmp
  assign(file[i], read.table(file[i], skip = skip, col.names = c("DateTime", "ght", "Q", "fnu", "NTRU"), colClasses = c("character", "numeric", "numeric", "numeric", "numeric"), fill = TRUE, stringsAsFactors = FALSE, sep = "\t"))
  rddatatmp <- assign(file[i], get(file[i]))
# Source 3 ends

} else {

# Source 3 begins
# read in file as a table and save as rddatatmp
  assign(file[i], read.table(file[i], skip = skip, col.names = c("DateTime", "ght", "Q", "fnu", "NTRU"), colClasses = c("character", "numeric", "numeric", "numeric", "numeric"), fill = TRUE, stringsAsFactors = FALSE, sep = ","))
  rddatatmp <- assign(file[i], get(file[i]))
# Source 3 ends

}

  rddatatmp[[1]] <- mdy_hms(rddatatmp[[1]], quiet = TRUE, tz = "GMT")
# Source 8 and 9 / transforms the character vector into a POSIXct object with the GMT time zone so the existing timezone should not change
    rddatatmp[[1]] <- strptime(rddatatmp[[1]], "%Y-%m-%d %H:%M:%S") # changes from POSIXct to character for the DateTime
    rddatatmp[[1]] <- format(rddatatmp[[1]], "%Y-%m-%d %H:%M:%S") # Source 10 / changes the DateTime format to numeric month/numeric date/four digit year with HMS


# creation of the raw ADAPS data spreadsheet
  wb <- createWorkbook()
# use R package openxlsx to create the .xlsx spreadsheet
  addWorksheet(wb, "ADAPS Data")
# adds the worksheet with the name of ADAPS Data
  writeDataTable(wb, "ADAPS Data", rddatatmp)
# writes the data to the workbook
  setColWidths(wb, sheet = 1, cols = 1, widths = 22)
# column width of 22 units for column 1

# Source 6, 9, and 13 begins
  dirsave1 <- paste0(dirsave, "/", basename(file_path_sans_ext(file[i])))
# combine the directory name with the basename and remove the file extension
  saveWorkbook(wb, paste0(dirsave1, ".xlsx"), overwrite = overwrite)
# saves the workbook as original file name without the extension + .xlsx
# Source 6, 9, and 13 ends

}
}
}
}
}
}




#' @export
#' @rdname adaps
adaps2 <- function (file, overwrite = TRUE) {

overwrite <- overwrite

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
# Source 1 & 2 / only process non-empty files and provide a stop warning if the input file is empty

} else {

# check the delimiter of the file
  checkdelim <- get.delim(file, skip = 5L)
# read in file to obtain the delimiter

# determine the number of lines to skip
  skip <- grep("[0-9][a-z]", readLines(file), ignore.case = TRUE)
# read to find the number of lines to skip

# reads ADAPS .rdb file as a table by skipping the first n lines (based on skip) after a check is made whether the file is tab ("\t") or comma separated (",")
if (checkdelim == "\t") {

# read in file as a table and save as rddatatmp
  rddatatmp <- read.table(file, skip = skip, col.names = c("DateTime", "ght", "Q", "fnu", "NTRU"), colClasses = c("character", "numeric", "numeric", "numeric", "numeric"), fill = TRUE, stringsAsFactors = FALSE, sep = "\t")

} else {

# read in file as a table and save as rddatatmp
  rddatatmp <- read.table(file, skip = skip, col.names = c("DateTime", "ght", "Q", "fnu", "NTRU"), colClasses = c("character", "numeric", "numeric", "numeric", "numeric"), fill = TRUE, stringsAsFactors = FALSE, sep = ",")

}

  rddatatmp[[1]] <- mdy_hms(rddatatmp[[1]], quiet = TRUE, tz = "GMT")
# Source 8 and 9 / transforms the character vector into a POSIXct object with the GMT time zone so the existing timezone should not change
    rddatatmp[[1]] <- strptime(rddatatmp[[1]], "%Y-%m-%d %H:%M:%S") # changes from POSIXct to character for the DateTime
    rddatatmp[[1]] <- format(rddatatmp[[1]], "%Y-%m-%d %H:%M:%S") # Source 10 / changes the DateTime format to numeric month/numeric date/four digit year with HMS


# creation of the raw ADAPS data spreadsheet
  wb <- createWorkbook()
# use R package openxlsx to create the .xlsx spreadsheet
  addWorksheet(wb, "ADAPS Data")
# adds the worksheet with the name of ADAPS Data
  writeDataTable(wb, "ADAPS Data", rddatatmp)
# writes the data to the workbook
  setColWidths(wb, sheet = 1, cols = 1, widths = 22)
# column width of 22 units for column 1

  filesave1 <- tclvalue(tkgetSaveFile(title = paste0("Save", " ", stri_trans_toupper(basename(file_path_sans_ext(file))), " ", "file as"), filetypes = "{{MS Excel file} .xlsx}"))
# Source 3 & 4 / GUI file dialog to save the spreadsheet
# Source 6 & 7 / original file name minus the extension and path in uppercase
  saveWorkbook(wb, filesave1, overwrite = overwrite)

}
}
}
}
