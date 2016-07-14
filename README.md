# ie2misc

R package that contains Irucka Embry's miscellaneous USGS functions (processing .exp and .psf files, statistical error functions, "+" dyadic operator for use with NA, creating ADAPS and QW spreadsheet files, calculating saturated enthalpy, etc.). Irucka created these functions while a Cherokee Nation Technology Solutions (CNTS) United States Geological Survey (USGS) Contractor and/or USGS employee.


# Installation

```R
install.packages("ie2misc")
```


# Examples
```R
library(ie2misc)
require(stats)

# 1) Calculate the mean-absolute deviation (MAD)
set.seed(1003) # makes the example reproducible

obs1 <- rnorm(1003) # observed

# Using the default value of na.rm = FALSE
# using a matrix of the numeric vector obs1
mat1 <- matrix(data = obs1, nrow = length(obs1), ncol = 1, byrow = FALSE,
dimnames = list(c(rep("", length(obs1))), "Observed"))

madstat(mat1)



# 2) Compute the index of agreement (dr)
set.seed(300) # makes the example reproducible
obs <- rnorm(300) # observed
pre <- rnorm(300) # predicted

# Using the default value of na.rm = FALSE
# using a matrix of the numeric vectors pre and obs
mat <- matrix(data = c(obs, pre), nrow = length(pre), ncol = 2, byrow = FALSE,
dimnames = list(c(rep("", length(pre))), c("Predicted", "Observed")))

dr(mat[, 2], mat[, 1])



# 3) Produce a saturated enthalpy table and direct the output to the console

sat_enthalpy2(elevation = 1810, tbegin = 28, tend = 80, tincrement = 0.1,
output = "console")
# elevation = 120 feet, tbegin = 32 degrees F, tend = 100 degrees F,
# tincrement = 0.1 degrees F



# 4) Create an .xlsx spreadsheet for each of the following water-quality data
# sets (follow the file dialog):

file1 <- "http://waterdata.usgs.gov/nwis/dv?cb_80154=on&format=rdb"
file2 <- "&site_no=03584500&referred_module=sw&period=&begin_date=1904-07-01"
file3 <- "&end_date=2016-06-22"
file4 <- paste0(file1, file2, file3) # used to truncate the file name
qw2(file4)

# USGS 03584500 ELK RIVER NEAR PROSPECT, TN
# Suspended sediment concentration, milligrams per liter (Mean)


file5 <- "http://waterdata.usgs.gov/nwis/dv?cb_80155=on&format=rdb"
file6 <- "&site_no=03584500&referred_module=sw&period=&begin_date=1904-07-01"
file7 <- "&end_date=2016-06-22"
file8 <- paste0(file5, file6, file7) # used to truncate the file name
qw2(file8)

# USGS 03584500 ELK RIVER NEAR PROSPECT, TN
# Suspended sediment discharge, tons per day (Mean)
```



# Disclaimer

This software is in the public domain because it contains materials that originally came from the U.S. Geological Survey, an agency of the United States Department of Interior. For more information, see the official [USGS copyright policy](http://www.usgs.gov/visual-id/credit_usgs.html#copyright)

Although this software program has been used by the U.S. Geological Survey (USGS), no warranty, expressed or implied, is made by the USGS or the U.S. Government as to the accuracy and functioning of the program and related program material nor shall the fact of distribution constitute any such warranty, and no responsibility is assumed by the USGS in connection therewith.

This software is provided "AS IS."


Note: The datasets included in the extdata folder may not have received the USGS's Director's approval and thus may still be provisional and subject to revision. The data are included in this package for illustration purposes only. The data are released on the condition that neither the USGS nor the United States Government may be held liable for any damages resulting from its authorized or unauthorized use.
