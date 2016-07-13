#' Saturated Enthalpy (H)
#'
#' sat_enthalpy and sat_enthalpy2 solve for the saturated enthalpy (H) given an
#' elevation in feet and a range of temperature values (degrees F).
#'
#' The sat_enthalpy function provides a file dialog for the user to choose the
#' selected file.
#'
#' The sat_enthalpy2 function either allows the user to provide the elevation
#' and temperature values without a file or allows the user to provide a file
#' without using a file dialog.
#'
#'
#'
#' H is expressed as
#'
#' 	\deqn{H = \left(0.24 \times T\right) + \left[W \times \left(1061 + 0.444 \times T\right)\right]}
#'
#' \describe{
#'	\item{\emph{H}}{enthalpy (Btu/lb)}
#'	\item{\emph{T}}{dry-bulb temperature (degrees F)}
#'	\item{\emph{W}}{specific humidity (lbwater / lbdry air)}
#' }
#'
#'
#' where W or SH (Specific Humidity) is expressed as
#'
#' 	\deqn{W = \left(0.622 \times E\right)/\left(Mb - \left(0.378 \times E\right)\right)}
#'
#' \describe{
#'	\item{\emph{W}}{W or SH -- Specific Humidity (kg/kg)}
#'	\item{\emph{E}}{Vapor pressure in saturated air at this temperature (millibars)}
#'	\item{\emph{Mb}}{Pressure (millibars)}
#' }
#'
#'
#'
#' @param file Input file (.xls, .xlsx, or .csv)
#' @param sheet Sheet number or sheet name for the input file (default is
#'          sheet 1)
#' @param elevation numeric vector that contains the location elevation in feet
#' @param tbegin numeric vector that contains the beginning temperature in
#'        degrees F
#' @param tend numeric vector that contains the ending temperature in
#'        degrees F
#' @param tincrement numeric vector that contains the temperature increment in
#'        degrees F
#' @param output The output format of the resulting data.table
#'        (console, .csv, or .xlsx)
#' @param overwrite If \code{TRUE}, overwrite any existing spreadsheet.
#'
#' @return data.table with the output parameters displayed on the console or as
#'        a spreadsheet
#'
#'
#'
#' @source
#' \enumerate{
#'    \item r - Better error message for stopifnot? - Stack Overflow answered by Andrie on Dec 1 2011. See \url{http://stackoverflow.com/questions/8343509/better-error-message-for-stopifnot}.
#'    \item How to check file extensions in R - Stack Overflow answered by lebatsnok on May 17 2014. See \url{http://stackoverflow.com/questions/23713284/how-to-check-file-extensions-in-r}.
#'    \item inside-R: TclInterface {tcltk}. See \url{http://www.inside-r.org/r-doc/tcltk/.Tcl}.
#'    \item James Wettenhall & Philippe Grosjean, File Open/Save dialogs in R tcltk, December 01, 2015. See \url{http://www.sciviews.org/recipes/tcltk/TclTk-file-open-save-dialogs/}.
#'    \item multiple output filenames in R - Stack Overflow asked and edited by Gabelins on Feb 1 2013. See \url{http://stackoverflow.com/questions/14651594/multiple-output-filenames-in-r}.
#'    \item r - Regex return file name, remove path and file extension - Stack Overflow answered and edited by Ananda Mahto on Feb 25 20134. See \url{http://stackoverflow.com/questions/15073753/regex-return-file-name-remove-path-and-file-extension/15073919}.
#'}
#'
#'
#' @references
#' \enumerate{
#'    \item "Andrew Revering's List of Meteorological Formulas", \url{http://www.aprweather.com/pages/calc.htm}.
#'    \item Functional Testing and Design Guides, \emph{Functional Testing Guide: from the Fundamentals to the Field}, "Sidebar 3: How to Calculate Enthalpy", \url{http://www.ftguide.org/ftg/IntegratedOperation/IOC-Sidebars-1-3/IOC-SB3-How-To-Calculate-Enthalpy.htm}.
#'}
#'
#'
#' @encoding UTF-8
#'
#' @author Irucka Embry [R version], Timothy H. Diehl [Microsoft Excel(R) spreadsheet]
#'
#'
#'
#' @examples
#' \dontrun{
#' library(ie2misc)
#' # Example to check the input file format
#'
#' # Copy and paste the following code into the R console if you
#' # wish to see the input file format.
#' library(openxlsx)
#' openXL(system.file("extdata", "Saturated_Enthalpy_Example_Input.xlsx",
#' package = "ie2misc"))
#'   # opens the workbook using the default spreadsheet application
#'
#'
#'
#' # Examples to show different use cases
#'
#' sat_enthalpy(output = "csv")
#' # The sheet number is 1 (default) and the output is csv
#'
#'
#' sat_enthalpy2(system.file("extdata", "Saturated_Enthalpy_Example_Input.xlsx"
#' , package = "ie2misc"), output = "xlsx")
#' # The sheet number is 1 (default) and the output is xlsx
#'
#'
#' sat_enthalpy2(system.file("extdata", "Saturated_Enthalpy_Example_Input.csv",
#' package = "ie2misc"), output = "console")
#' # The sheet number is 1 (default) and the output is the console
#'
#'
#' sat_enthalpy2(elevation = 1200, tbegin = 32, tend = 180,
#' tincrement = 0.01, output = "csv")
#' # elevation = 1200 feet, tbegin = 32 degrees F, tend = 180 degrees F,
#' # tincrement = 0.01 degrees F
#' }
#'
#'
#' @import stringi
#' @import data.table
#' @import readxl
#' @import openxlsx
#' @import tcltk
#' @import gWidgets2
#' @import gWidgets2tcltk
#' @import utils
#'
#' @name sat_enthalpy
NULL

#' @export
#' @rdname sat_enthalpy
sat_enthalpy <- function (file = tk_choose.files(default = "", caption = "Select file to open", multi = FALSE, filters = matrix(c("Comma-separated value file", ".csv", "MS Excel spreadsheet", ".xlsx", "MS Excel 97-2003 spreadsheet", ".xls"), 6, 2, byrow = TRUE)), sheet = 1, overwrite = TRUE, output = c("console", "csv", "xlsx")) {

overwrite <- overwrite

confirm <- gconfirm(toolkit = guiToolkit("tcltk"), msg = paste0("Do you want to select", " ", file, "?"), title = "Confirm", icon = "question")

if (confirm == FALSE) {

  stop("Please try again with a different file.")
# Source 2 / provide a stop warning if the user wants to change the file

  } else {

if (file.info(file)$size == 0) {

  stop("Your file is empty. Please try again with a different file.")
# Sources 1 & 2 / only process non-empty files and provide a stop warning if the input file is empty

  } else {

# Input provides the following parameters: Elevation (feet), Temperature (deg F)

if (grepl("*.xls", file)) { # Source 2

ifelse (class(sheet) == "numeric", sheetname <- excel_sheets(file)[sheet], sheetname <- sheet) # obtain the sheet name

sat <- read_excel(file, sheet = sheet)
sat <- data.frame(sat)
sat <- setDT(sat)

elev_ft <- sat[1, 1, with = FALSE][[1]]

temp_sat_F <- sat[, 2, with = FALSE][[1]]

elev_m <- elev_ft * 0.3048 # m, Elevation above sea level at cooling towers

press_Pa <- 100 * ((44331.514 - elev_m) / 11880.516) ^ (1 / 0.1902632) # Pressure, pascals, Tower evaporation model

press_mb <- press_Pa / 100 # Design pressure, millibars (mb)

press_psia <- press_mb / 68.94757293 # Pressure, psia

temp_sat_C <- (temp_sat_F - 32) * 5 / 9 # temperature at saturation, degrees C

e_sat_mb <- 6.1078*10 ^ ((temp_sat_C * 7.5) / (temp_sat_C + 237.3)) # e sat, mb

e_sat_psia <- e_sat_mb / 68.94757293 # e sat, psia

W <- (0.622 * e_sat_mb) / (press_mb - (0.378 * e_sat_mb)) # W, kg/kg

sat_h <- (0.24 * temp_sat_F) + (W * (1061 + 0.444 * temp_sat_F)) # Sat Enthalpy H, Btu/lb

sat_h_table <- data.table(temp_sat_C, temp_sat_F, e_sat_mb, e_sat_psia, sat_h, W)

setnames(sat_h_table, c("Temperature at Saturation, degrees C", "Temperature at Saturation, degrees F", "e sat, millibars", "e sat, psia", "Saturated Enthalpy H, Btu/lb", "Specific Humidity (W), kg/kg"))


## output of results to console
if (output == "console") {

return(sat_h_table)


} else if (output == "csv") {

## create csv file
filesave1 <- tclvalue(tkgetSaveFile(title = paste0("Save", " ", stri_trans_toupper(basename(file_path_sans_ext(file))), " ", "file as"), filetypes = "{{Comma-separated value file} .csv}"))
# Sources 3 & 4 / GUI file dialog to save the spreadsheet
# Sources 5 & 6 / original file name minus the extension and path in uppercase
write.csv(sat_h_table, file = filesave1, row.names = FALSE, na = "")


## create xlsx file
} else if (output == "xlsx") {

# creation of the Saturated Enthalpy Table spreadsheet
wb <- createWorkbook()
# use R package openxlsx to create the .xlsx spreadsheet
addWorksheet(wb, "Saturated Enthalpy Table")
# adds the worksheet with the name of Saturated Enthalpy Table
writeDataTable(wb, "Saturated Enthalpy Table", sat_h_table)
# writes the data to the workbook
setColWidths(wb, sheet = 1, 1:ncol(sat_h_table), widths = "auto")


filesave2 <- tclvalue(tkgetSaveFile(title = paste0("Save", " ", stri_trans_toupper(basename(file_path_sans_ext(file))), " ", "file as"), filetypes = "{{MS Excel file} .xlsx}"))
# Sources 3 & 4 / GUI file dialog to save the spreadsheet
# Sources 5 & 6 / original file name minus the extension and path in uppercase
saveWorkbook(wb, filesave2, overwrite = overwrite)


}

} else if (grepl("*.csv", file)) {

sat <- fread(file)

elev_ft <- sat[1, 1, with = FALSE][[1]]

temp_sat_F <- sat[, 2, with = FALSE][[1]]

elev_m <- elev_ft * 0.3048 # m, Elevation above sea level at cooling towers

press_Pa <- 100 * ((44331.514 - elev_m) / 11880.516) ^ (1 / 0.1902632) # Pressure, pascals, Tower evaporation model

press_mb <- press_Pa / 100 # Design pressure, millibars (mb)

press_psia <- press_mb / 68.94757293 # Pressure, psia

temp_sat_C <- (temp_sat_F - 32) * 5 / 9 # temperature at saturation, degrees C

e_sat_mb <- 6.1078*10 ^ ((temp_sat_C * 7.5) / (temp_sat_C + 237.3)) # e sat, mb

e_sat_psia <- e_sat_mb / 68.94757293 # e sat, psia

W <- (0.622 * e_sat_mb) / (press_mb - (0.378 * e_sat_mb)) # W, kg/kg

sat_h <- (0.24 * temp_sat_F) + (W * (1061 + 0.444 * temp_sat_F)) # Sat Enthalpy H, Btu/lb

sat_h_table <- data.table(temp_sat_C, temp_sat_F, e_sat_mb, e_sat_psia, sat_h, W)

setnames(sat_h_table, c("Temperature at Saturation, degrees C", "Temperature at Saturation, degrees F", "e sat, millibars", "e sat, psia", "Saturated Enthalpy H, Btu/lb", "Specific Humidity (W), kg/kg"))


## output of results to console
if (output == "console") {

return(sat_h_table)


} else if (output == "csv") {

## create csv file
filesave3 <- tclvalue(tkgetSaveFile(title = paste0("Save", " ", stri_trans_toupper(basename(file_path_sans_ext(file))), " ", "file as"), filetypes = "{{Comma-separated value file} .csv}"))
# Sources 3 & 4 / GUI file dialog to save the spreadsheet
# Sources 5 & 6 / original file name minus the extension and path in uppercase
write.csv(sat_h_table, file = filesave3, row.names = FALSE, na = "")


## create xlsx file
} else if (output == "xlsx") {

# creation of the Saturated Enthalpy Table spreadsheet
wb <- createWorkbook()
# use R package openxlsx to create the .xlsx spreadsheet
addWorksheet(wb, "Saturated Enthalpy Table")
# adds the worksheet with the name of Saturated Enthalpy Table
writeDataTable(wb, "Saturated Enthalpy Table", sat_h_table)
# writes the data to the workbook
setColWidths(wb, sheet = 1, 1:ncol(sat_h_table), widths = "auto")


filesave4 <- tclvalue(tkgetSaveFile(title = paste0("Save", " ", stri_trans_toupper(basename(file_path_sans_ext(file))), " ", "file as"), filetypes = "{{MS Excel file} .xlsx}"))
# Sources 3 & 4 / GUI file dialog to save the spreadsheet
# Sources 5 & 6 / original file name minus the extension and path in uppercase
saveWorkbook(wb, filesave4, overwrite = overwrite)

}
}
}
}
}




#' @export
#' @rdname sat_enthalpy
sat_enthalpy2 <- function (file = NULL, sheet = 1, elevation = NULL, tbegin = NULL, tend = NULL, tincrement = NULL, overwrite = TRUE, output = c("console", "csv", "xlsx")) {

overwrite <- overwrite

if (is.null(file) == TRUE) {

# if no file is selected, then proceed with the following calculations

elev_ft <- elevation

tbegin <- tbegin

tend <- tend

tincrement <- tincrement

elev_m <- elev_ft * 0.3048 # m, Elevation above sea level at cooling towers

press_Pa <- 100 * ((44331.514 - elev_m) / 11880.516) ^ (1 / 0.1902632) # Pressure, pascals, Tower evaporation model

press_mb <- press_Pa / 100 # Design pressure, millibars (mb)

press_psia <- press_mb / 68.94757293 # Pressure, psia

temp_sat_F <- seq(tbegin, tend, tincrement) # temperature at saturation, degrees F

temp_sat_C <- (temp_sat_F - 32) * 5 / 9 # temperature at saturation, degrees C

e_sat_mb <- 6.1078*10 ^ ((temp_sat_C * 7.5) / (temp_sat_C + 237.3)) # e sat, mb

e_sat_psia <- e_sat_mb / 68.94757293 # e sat, psia

W <- (0.622 * e_sat_mb) / (press_mb - (0.378 * e_sat_mb)) # W, kg/kg

sat_h <- (0.24 * temp_sat_F) + (W * (1061 + 0.444 * temp_sat_F)) # Sat Enthalpy H, Btu/lb

sat_h_table <- data.table(temp_sat_C, temp_sat_F, e_sat_mb, e_sat_psia, sat_h, W)

setnames(sat_h_table, c("Temperature at Saturation, degrees C", "Temperature at Saturation, degrees F", "e sat, millibars", "e sat, psia", "Saturated Enthalpy H, Btu/lb", "Specific Humidity (W), kg/kg"))

## output of results to console
if (output == "console") {

return(sat_h_table)


} else if (output == "csv") {

## create csv file
filesave5 <- tclvalue(tkgetSaveFile(title = paste0("Save file as"), filetypes = "{{Comma-separated value file} .csv}"))
# Sources 3 & 4 / GUI file dialog to save the spreadsheet
# Sources 5 & 6 / original file name minus the extension and path in uppercase
write.csv(sat_h_table, file = filesave5, row.names = FALSE, na = "")


## create xlsx file
} else if (output == "xlsx") {

# creation of the Saturated Enthalpy Table spreadsheet
wb <- createWorkbook()
# use R package openxlsx to create the .xlsx spreadsheet
addWorksheet(wb, "Saturated Enthalpy Table")
# adds the worksheet with the name of Saturated Enthalpy Table
writeDataTable(wb, "Saturated Enthalpy Table", sat_h_table)
# writes the data to the workbook
setColWidths(wb, sheet = 1, 1:ncol(sat_h_table), widths = "auto")


filesave6 <- tclvalue(tkgetSaveFile(title = paste0("Save file as"), filetypes = "{{MS Excel file} .xlsx}"))
# Sources 3 & 4 / GUI file dialog to save the spreadsheet
# Sources 5 & 6 / original file name minus the extension and path in uppercase
saveWorkbook(wb, filesave6, overwrite = overwrite)


}

  } else {

  confirm <- gconfirm(toolkit = guiToolkit("tcltk"), msg = paste0("Do you want to select", " ", file, "?"), title = "Confirm", icon = "question")

if (confirm == FALSE) {

  stop("Please try again with a different file.")
# Source 2 / provide a stop warning if the user wants to change the file

  } else {

 if (file.info(file)$size == 0) {

  stop("Your file is empty. Please try again with a different file.")
# Sources 1 & 2 / only process non-empty files and provide a stop warning if the input file is empty

  } else {


# Input provides the following parameters: Elevation (feet), Temperature (deg F)

if (grepl("*.xls", file)) { # Source 2

ifelse (class(sheet) == "numeric", sheetname <- excel_sheets(file)[sheet], sheetname <- sheet) # obtain the sheet name

sat <- read_excel(file, sheet = sheet)
sat <- data.frame(sat)
sat <- setDT(sat)

elev_ft <- sat[1, 1, with = FALSE][[1]]

temp_sat_F <- sat[, 2, with = FALSE][[1]]

elev_m <- elev_ft * 0.3048 # m, Elevation above sea level at cooling towers

press_Pa <- 100 * ((44331.514 - elev_m) / 11880.516) ^ (1 / 0.1902632) # Pressure, pascals, Tower evaporation model

press_mb <- press_Pa / 100 # Design pressure, millibars (mb)

press_psia <- press_mb / 68.94757293 # Pressure, psia

temp_sat_C <- (temp_sat_F - 32) * 5 / 9 # temperature at saturation, degrees C

e_sat_mb <- 6.1078*10 ^ ((temp_sat_C * 7.5) / (temp_sat_C + 237.3)) # e sat, mb

e_sat_psia <- e_sat_mb / 68.94757293 # e sat, psia

W <- (0.622 * e_sat_mb) / (press_mb - (0.378 * e_sat_mb)) # W, kg/kg

sat_h <- (0.24 * temp_sat_F) + (W * (1061 + 0.444 * temp_sat_F)) # Sat Enthalpy H, Btu/lb

sat_h_table <- data.table(temp_sat_C, temp_sat_F, e_sat_mb, e_sat_psia, sat_h, W)

setnames(sat_h_table, c("Temperature at Saturation, degrees C", "Temperature at Saturation, degrees F", "e sat, millibars", "e sat, psia", "Saturated Enthalpy H, Btu/lb", "Specific Humidity (W), kg/kg"))

## output of results to console
if (output == "console") {

return(sat_h_table)


} else if (output == "csv") {

## create csv file
filesave7 <- tclvalue(tkgetSaveFile(title = paste0("Save", " ", stri_trans_toupper(basename(file_path_sans_ext(file))), " ", "file as"), filetypes = "{{Comma-separated value file} .csv}"))
# Sources 3 & 4 / GUI file dialog to save the spreadsheet
# Sources 5 & 6 / original file name minus the extension and path in uppercase
write.csv(sat_h_table, file = filesave7, row.names = FALSE, na = "")


## create xlsx file
} else if (output == "xlsx") {

# creation of the Saturated Enthalpy Table spreadsheet
wb <- createWorkbook()
# use R package openxlsx to create the .xlsx spreadsheet
addWorksheet(wb, "Saturated Enthalpy Table")
# adds the worksheet with the name of Saturated Enthalpy Table
writeDataTable(wb, "Saturated Enthalpy Table", sat_h_table)
# writes the data to the workbook
setColWidths(wb, sheet = 1, 1:ncol(sat_h_table), widths = "auto")


filesave8 <- tclvalue(tkgetSaveFile(title = paste0("Save", " ", stri_trans_toupper(basename(file_path_sans_ext(file))), " ", "file as"), filetypes = "{{MS Excel file} .xlsx}"))
# Sources 3 & 4 / GUI file dialog to save the spreadsheet
# Sources 5 & 6 / original file name minus the extension and path in uppercase
saveWorkbook(wb, filesave8, overwrite = overwrite)

}

} else if (grepl("*.csv", file)) {

sat <- fread(file)

elev_ft <- sat[1, 1, with = FALSE][[1]]

temp_sat_F <- sat[, 2, with = FALSE][[1]]

elev_m <- elev_ft * 0.3048 # m, Elevation above sea level at cooling towers

press_Pa <- 100 * ((44331.514 - elev_m) / 11880.516) ^ (1 / 0.1902632) # Pressure, pascals, Tower evaporation model

press_mb <- press_Pa / 100 # Design pressure, millibars (mb)

press_psia <- press_mb / 68.94757293 # Pressure, psia

temp_sat_C <- (temp_sat_F - 32) * 5 / 9 # temperature at saturation, degrees C

e_sat_mb <- 6.1078*10 ^ ((temp_sat_C * 7.5) / (temp_sat_C + 237.3)) # e sat, mb

e_sat_psia <- e_sat_mb / 68.94757293 # e sat, psia

W <- (0.622 * e_sat_mb) / (press_mb - (0.378 * e_sat_mb)) # W, kg/kg

sat_h <- (0.24 * temp_sat_F) + (W * (1061 + 0.444 * temp_sat_F)) # Sat Enthalpy H, Btu/lb

sat_h_table <- data.table(temp_sat_C, temp_sat_F, e_sat_mb, e_sat_psia, sat_h, W)

setnames(sat_h_table, c("Temperature at Saturation, degrees C", "Temperature at Saturation, degrees F", "e sat, millibars", "e sat, psia", "Saturated Enthalpy H, Btu/lb", "Specific Humidity (W), kg/kg"))

## output of results to console
if (output == "console") {

return(sat_h_table)


} else if (output == "csv") {

## create csv file
filesave9 <- tclvalue(tkgetSaveFile(title = paste0("Save", " ", stri_trans_toupper(basename(file_path_sans_ext(file))), " ", "file as"), filetypes = "{{Comma-separated value file} .csv}"))
# Sources 3 & 4 / GUI file dialog to save the spreadsheet
# Sources 5 & 6 / original file name minus the extension and path in uppercase
write.csv(sat_h_table, file = filesave9, row.names = FALSE, na = "")


## create xlsx file
} else if (output == "xlsx") {

# creation of the Saturated Enthalpy Table spreadsheet
wb <- createWorkbook()
# use R package openxlsx to create the .xlsx spreadsheet
addWorksheet(wb, "Saturated Enthalpy Table")
# adds the worksheet with the name of Saturated Enthalpy Table
writeDataTable(wb, "Saturated Enthalpy Table", sat_h_table)
# writes the data to the workbook
setColWidths(wb, sheet = 1, 1:ncol(sat_h_table), widths = "auto")


filesave10 <- tclvalue(tkgetSaveFile(title = paste0("Save", " ", stri_trans_toupper(basename(file_path_sans_ext(file))), " ", "file as"), filetypes = "{{MS Excel file} .xlsx}"))
# Sources 3 & 4 / GUI file dialog to save the spreadsheet
# Sources 5 & 6 / original file name minus the extension and path in uppercase
saveWorkbook(wb, filesave10, overwrite = overwrite)

}
}
}
}
}
}
