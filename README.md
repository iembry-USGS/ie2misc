# ie2misc

R package that contains Irucka Embry's miscellaneous USGS functions (processing .exp and .psf files, statistical error functions, "+" dyadic operator for use with NA, linear interpolation with NA, creating ADAPS and QW spreadsheet files, etc.). Irucka created these functions while a Cherokee Nation Technology Solutions (CNTS) United States Geological Survey (USGS) Contractor and/or USGS employee.


# Disclaimer

This software is in the public domain because it contains materials that originally came from the U.S. Geological Survey, an agency of the United States Department of Interior. For more information, see the official  [USGS copyright policy](http://www.usgs.gov/visual-id/credit_usgs.html#copyright)

Although this software program has been used by the U.S. Geological Survey (USGS), no warranty, expressed or implied, is made by the USGS or the U.S. Government as to the accuracy and functioning of the program and related program material nor shall the fact of distribution constitute any such warranty, and no responsibility is assumed by the USGS in connection therewith.

This software is provided "AS IS."



```R
# Examples
library(iemisc2)
require(stats)

set.seed(100) # makes the example reproducible
obs1 <- rnorm(100) # observed

## Using the default value of na.rm = TRUE
# using a matrix of the numeric vector obs1
mat1 <- matrix(data = obs1, nrow = length(obs1), ncol = 1, byrow = FALSE, dimnames = list(c(rep("", length(obs1))), "Observed"))
madstat(mat1)
```
