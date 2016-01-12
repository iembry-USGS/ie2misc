# ie2misc

Disclaimer

This software is in the public domain because it contains materials that originally came from the U.S. Geological Survey, an agency of the United States Department of Interior. For more information, see the official USGS copyright policy at http://www.usgs.gov/visual-id/credit_usgs.html#copyright

Although this software program has been used by the U.S. Geological Survey (USGS), no warranty, expressed or implied, is made by the USGS or the U.S. Government as to the accuracy and functioning of the program and related program material nor shall the fact of distribution constitute any such warranty, and no responsibility is assumed by the USGS in connection therewith.

This software is provided "AS IS."



R package that contains functions mostly useful in the USGS and created while Irucka Embry was a USGS CNTS Contractor and/or USGS employee.


```R
	# examples
	library(iemisc2)
     expFileOutput(output = "exp") # returns .exp files
     expFileOutput(output = "csv") # returns .csv files
     expFileOutput(output = "xlsx") # returns .xlsx files
     expFileOutput(output = "all") # returns .exp, .csv, and .xlsx files
     
     
     
     psfFileChangeBATCH()
     # This is the file result of this function:
     # SkewSE 0.361804179633127
     # GenSkew 0.0104293904
     # SkewOpt Weighted

     
     psfFileChange() # default where interactive = TRUE
     # This is the file result of this function:
     # SkewSE 0.361804179633127
     # GenSkew 0.0104293904
     # SkewOpt Weighted

     
     psfFileChange(interactive = FALSE)
     # This is the file result of this function:
     # SkewSE 0.361804179633127
     # GenSkew 0.0104293904
     # SkewOpt Weighted
```
