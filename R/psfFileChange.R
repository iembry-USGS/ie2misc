#' psfFileChange and psfFileChangeBATCH
#'
#' The .psf file is a script file that records the specifications used to run
#' the USGS PeakFQ program (\url{http://water.usgs.gov/software/PeakFQ/}) for
#' a station. psfFileChange and psfFileChangeBATCH modify the original .psf
#' settings.
#'
#'
#' psfFileChange searches for a character vector of patterns (SkewSE,
#'   GenSkew, and SkewOpt) in single or multiple .psf file(s) to replace. If
#'   the patterns are missing, then the patterns are added to the file(s).
#'   This is done for a single file or multiple files that the user selects.
#'   Although these changes are currently pre-determined, future versions may
#'   allow the user to change particular settings (for example, how
#'   outliers are handled).
#'
#' psfFileChangeBATCH searches for a character vector of patterns
#'   (SkewSE, GenSkew, and SkewOpt) in a directory of .psf files to replace. If
#'   the patterns are missing, then the patterns are added to the files. This
#'   is done in a BATCH mode (whole directory of .psf files). Although these
#'   changes are currently pre-determined, future versions may allow the
#'   user to change particular settings (for example, how outliers are handled).
#'
#'
#'
#' @param file Input .psf file(s) to change specific SkewSE, GenSkew, and
#'   SkewOpt information to be selected through a file dialog.
#' @param interactive If interactive is TRUE, then the user will select the
#'   filenames(s) to use for saving with the file dialog. In order to select
#'   more than one file, the user must hold down the Ctrl (Control) button
#'   while mouse clicking the chosen files. If interactive is \code{FALSE}, then
#'   the user will select the directory, via the directory dialog, to use for
#'   saving and the original filenames will be used.
#' @param path Directory path of .psf files, to be selected through a
#'   directory dialog, to change specific SkewSE, GenSkew, and SkewOpt
#'   information. The user will be asked where to find the .psf files
#'   & then the user will be asked where to save the revised .psf files.
#'
#' @return Revised .psf text file(s)
#'
#'
#' @author Irucka Embry, Anne Hoos
#'
#'
#' @source
#' \enumerate{
#'    \item r - How can I check if a file is empty? - Stack Overflow answered by Konrad Rudolph and edited by Geekuna Matata on Apr 23 2014. See \url{http://stackoverflow.com/questions/23254002/how-can-i-check-if-a-file-is-empty}.
#'    \item r - Better error message for stopifnot? - Stack Overflow answered by Andrie on Dec 1 2011. See \url{http://stackoverflow.com/questions/8343509/better-error-message-for-stopifnot}.
#'    \item inside-R: TclInterface {tcltk}. See \url{http://www.inside-r.org/r-doc/tcltk/.Tcl}.
#'    \item James Wettenhall & Philippe Grosjean, File Open/Save dialogs in R tcltk, December 01, 2015. See \url{http://www.sciviews.org/recipes/tcltk/TclTk-file-open-save-dialogs/}.
#'    \item Replacing nth line in a text file in R - Stack Overflow answered by Spacedman on Aug 1 2012. See \url{http://stackoverflow.com/questions/11756353/replacing-nth-line-in-a-text-file-in-r}.
#'    \item r - read csv files and perform function, then bind together - Stack Overflow answered by bjoseph on Jan 8 2015. See \url{http://stackoverflow.com/questions/27846715/read-csv-files-and-perform-function-then-bind-together}.
#'    \item multiple output filenames in R - Stack Overflow asked and edited by Gabelins on Feb 1 2013. See \url{http://stackoverflow.com/questions/14651594/multiple-output-filenames-in-r}.
#'    \item r - Regex return file name, remove path and file extension - Stack Overflow answered and edited by Ananda Mahto on Feb 25 20134. See \url{http://stackoverflow.com/questions/15073753/regex-return-file-name-remove-path-and-file-extension/15073919}.
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
#' # Examples to change (a) .psf file(s) interactively and non-interactively
#' library(ie2misc)
#' psfFileChange() # default where interactive = TRUE
#' # Follow the file dialog instructions
#'
#'
#' # These are the rows that have been added or changed as a result of this function:
#'
#' # SkewSE 0.361804179633127
#' # GenSkew 0.0104293904
#' # SkewOpt Weighted
#'
#'
#'
#' psfFileChange(interactive = FALSE)
#' # Follow the file dialog instructions
#'
#' # These are the rows that have been added or changed as a result of this function:
#'
#' # SkewSE 0.361804179633127
#' # GenSkew 0.0104293904
#' # SkewOpt Weighted
#'
#'
#'
#' psfFileChangeBATCH() # Follow the file dialog instructions
#'
#'
#' # These are the rows that have been added or changed as a result of this function:
#'
#' # SkewSE 0.361804179633127
#' # GenSkew 0.0104293904
#' # SkewOpt Weighted
#' }
#'
#' @import stringi
#' @import qdap
#' @import tcltk
#' @import gWidgets2
#' @import gWidgets2tcltk
#'
#'
#' @name psfFileChange
NULL

#' @export
#' @rdname psfFileChange
psfFileChange <- function (file = tk_choose.files(default = "", caption = "Select file(s) to open & hold down Ctrl to choose more than 1 file", multi = TRUE, filters = matrix(c("Text file", ".psf", "Text file", ".PSF"), 4, 2, byrow = TRUE)), interactive = TRUE) {

pattern <- c("SkewSE [[:punct:]]+[[:digit:]]+.[[:digit:]]+", "SkewSE [[:digit:]]+.[[:digit:]]+", "GenSkew [[:punct:]]+[[:digit:]]+.[[:digit:]]+", "GenSkew [[:digit:]]+.[[:digit:]]+", "SkewOpt Station")
# pattern to search for, punct is used to catch any dashes for negative values

replacement <- c("SkewSE 0.361804179633127", "SkewSE 0.361804179633127", "GenSkew 0.0104293904", "GenSkew 0.0104293904", "SkewOpt Weighted")
# replacement pattern

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

rddatatmp <- readLines(file)
# read in file as a string of characters line by line and save as rddatatmp
rddatatmp <- multigsub(pattern, replacement, rddatatmp, fixed = FALSE)
# multiple substitution replacement using qdap's multigsub function
rddatatmplocate1 <- stri_detect_fixed(rddatatmp, "SkewSE")
# search for the pattern using the stringi's stri_detect_fixed function

ifelse ("TRUE" %in% rddatatmplocate1 == FALSE, {rddatatmp[length(rddatatmp) + 1L] <- "SkewSE 0.361804179633127"}, rddatatmp <- rddatatmp)
# Source 5 / # if the pattern was not found, then add 1 line to the rddatatmp and write out this pattern

rddatatmplocate2 <- stri_detect_fixed(rddatatmp, "GenSkew")
# search for the pattern using the stringi's stri_detect_fixed function

ifelse ("TRUE" %in% rddatatmplocate2 == FALSE, {rddatatmp[length(rddatatmp) + 1L] <- "GenSkew 0.0104293904"}, rddatatmp <- rddatatmp)
# Source 5 / # if the pattern was not found, then add 1 line to the rddatatmp and write out this pattern

filesave1 <- tclvalue(tkgetSaveFile(title = paste0("Save revised", " ", stri_trans_toupper(basename(file_path_sans_ext(file))), " ", "file as"), filetypes = "{{Text file} .psf}"))
# Sources 3 & 4 / GUI file dialog to save the file
writeLines(rddatatmp, filesave1)
# Write the lines contained in rddatatmp as a string of characters line by line and end with the .psf file extension
}
}
}
} else {

for (i in 1:length(file)) { # Source 6

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

# Source 6 begins
  assign(file[i], readLines(file[i]))
# read in file as a string of characters line by line and save as rddatatmp
  rddatatmp <- assign(file[i], get(file[i]))
# Source 6 ends
  rddatatmp <- multigsub(pattern, replacement, rddatatmp, fixed = FALSE)
# multiple substitution replacement using qdap's multigsub function
  rddatatmplocate1 <- stri_detect_fixed(rddatatmp, "SkewSE")
# search for the pattern using the stringi's stri_detect_fixed function

  ifelse ("TRUE" %in% rddatatmplocate1 == FALSE, {rddatatmp[length(rddatatmp) + 1L] <- "SkewSE 0.361804179633127"}, rddatatmp <- rddatatmp)
# Source 5 / # if the pattern was not found, then add 1 line to the rddatatmp and write out this pattern

  rddatatmplocate2 <- stri_detect_fixed(rddatatmp, "GenSkew")
# search for the pattern using the stringi's stri_detect_fixed function

  ifelse ("TRUE" %in% rddatatmplocate2 == FALSE, {rddatatmp[length(rddatatmp) + 1L] <- "GenSkew 0.0104293904"}, rddatatmp <- rddatatmp)
# Source 5 / # if the pattern was not found, then add 1 line to the rddatatmp and write out this pattern

  filesave2 <- tclvalue(tkgetSaveFile(title = paste0("Save revised", " ", stri_trans_toupper(basename(file_path_sans_ext(file[i]))), " ", "file as"), filetypes = "{{Text file} .psf}"))
# Sources 3 & 4 / GUI file dialog to save the file
  writeLines(rddatatmp, filesave2)
# Write the lines contained in rddatatmp as a string of characters line by line and end with the .psf file extension
}
}
}
}
}

} else { # Interactive = FALSE

filesave3 <- tk_choose.dir(caption = "Select directory to save the revised .psf files")
# user selects directory and save all .psf files with given names in the chosen directory

# Source 6 begins
for (i in 1:length(file)) {

  assign(file[i], readLines(file[i]))
# read in file as a string of characters line by line and save as rddatatmp
  rddatatmp <- assign(file[i], get(file[i]))
# Source 6 ends
  rddatatmp <- multigsub(pattern, replacement, rddatatmp, fixed = FALSE)
# multiple substitution replacement using qdap's multigsub function
  rddatatmplocate1 <- stri_detect_fixed(rddatatmp, "SkewSE")
# search for the pattern using the stringi's stri_detect_fixed function

  ifelse ("TRUE" %in% rddatatmplocate1 == FALSE, {rddatatmp[length(rddatatmp) + 1L] <- "SkewSE 0.361804179633127"}, rddatatmp <- rddatatmp)
# Source 5 / # if the pattern was not found, then add 1 line to the rddatatmp and write out this pattern

  rddatatmplocate2 <- stri_detect_fixed(rddatatmp, "GenSkew")
# search for the pattern using the stringi's stri_detect_fixed function

  ifelse ("TRUE" %in% rddatatmplocate2 == FALSE, {rddatatmp[length(rddatatmp) + 1L] <- "GenSkew 0.0104293904"}, rddatatmp <- rddatatmp)
# Source 5 / # if the pattern was not found, then add 1 line to the rddatatmp and write out this pattern

  filesave3a <- paste0(filesave3, "/", "revised_", basename(file[i]))
# combine the directory name with the basename
  writeLines(rddatatmp, con = filesave3a)
# Write the lines contained in rddatatmp as a string of characters line by line and end with the .psf file extension
}
}
}


#' @export
#' @rdname psfFileChange
psfFileChangeBATCH <- function (path = tk_choose.dir(caption = "Select the directory with the .psf files")) {

pattern <- c("SkewSE [[:punct:]]+[[:digit:]]+.[[:digit:]]+", "SkewSE [[:digit:]]+.[[:digit:]]+", "GenSkew [[:punct:]]+[[:digit:]]+.[[:digit:]]+", "GenSkew [[:digit:]]+.[[:digit:]]+", "SkewOpt Station")
# pattern to search for, punct is used to catch any dashes for negative values

replacement <- c("SkewSE 0.361804179633127", "SkewSE 0.361804179633127", "GenSkew 0.0104293904", "GenSkew 0.0104293904", "SkewOpt Weighted")
# replacement pattern

confirm <- gconfirm(toolkit = guiToolkit("tcltk"), msg = paste0("Do you want to select", " ", path, " as the directory with the .psf files?"), title = "Confirm", icon = "question")

if (confirm == FALSE) {

  stop("Please try again with a different directory.")
# Source 2 / provide a stop warning if the user wants to change the directory

} else {

file <- list.files(path, pattern = "psf|PSF$", full.names = TRUE)
file <- file[stri_detect_fixed(file, ".psf", case_insensitive = TRUE)]


filesave4 <- tk_choose.dir(caption = "Select directory to save the batch set of .psf files")
# user selects directory and save all .psf files with given names in the chosen directory

confirm <- gconfirm(toolkit = guiToolkit("tcltk"), msg = paste0("Do you want to select", " ", filesave4, " as the directory to save the batch set of files?"), title = "Confirm", icon = "question")

if (confirm == FALSE) {

  stop("Please try again with a different directory.")
# Source 2 / provide a stop warning if the user wants to change the directory

} else {

for (i in 1:length(file)) { # Source 6

if (!nchar(file[i])) {

  stop("You did not choose a file. Please try again with a different file.")
# Source 2 / provide a stop warning if no file was selected

} else {

if (file.info(file[i])$size == 0) {

  stop("Your file is empty. Please try again with a different file.")
# Sources 1 & 2 / only process non-empty files and provide a stop warning if the input file is empty

} else {

# Source 6 begins
  assign(file[i], readLines(file[i]))
# read in file as a string of characters line by line and save as rddatatmp
  rddatatmp <- assign(file[i], get(file[i]))
# Source 6 ends

  rddatatmp <- multigsub(pattern, replacement, rddatatmp, fixed = FALSE)
# multiple substitution replacement using qdap's multigsub function
  rddatatmplocate1 <- stri_detect_fixed(rddatatmp, "SkewSE")
# search for the pattern using the stringi's stri_detect_fixed function

  ifelse ("TRUE" %in% rddatatmplocate1 == FALSE, {rddatatmp[length(rddatatmp) + 1L] <- "SkewSE 0.361804179633127"}, rddatatmp <- rddatatmp)
# Source 5 / if the pattern was not found, then add 1 line to the rddatatmp and write out this pattern

  rddatatmplocate2 <- stri_detect_fixed(rddatatmp, "GenSkew")
# search for the pattern using the stringi's stri_detect_fixed function

  ifelse ("TRUE" %in% rddatatmplocate2 == FALSE, {rddatatmp[length(rddatatmp) + 1L] <- "GenSkew 0.0104293904"}, rddatatmp <- rddatatmp)
# Source 5 / if the pattern was not found, then add 1 line to the rddatatmp and write out this pattern

  filesave4a <- paste0(filesave4, "/", "revised_", basename(file[i]))
# combine the directory name with the basename
  writeLines(rddatatmp, con = filesave4a)
# Write the lines contained in rddatatmp as a string of characters line by line and end with the .psf file extension
}
}
}
}
}
}
