##############################################################
#### R function to read SBE CTD cnv-files into data.frame ####
##### v0.2   Marko Lipka   marko.lipka@posteo.de #############
##############################################################


read.cnv.file <- function(filename){ #  filename as character string (e.g. "V0033F01.cnv")
  csv.file <- readLines(filename, encoding = "latin1") #  reads the file as large character string
  # substitute terrible would-be-NA-values with less terrible would-be-NA-values:
  csv.file <- gsub("-9.990e-29", " NA ", csv.file) 
  csv.file <- gsub("-9.9900e-29", " NA ", csv.file)
  
  header.definition.list <- as.list(csv.file)[grep("# name", csv.file)] #  find column definitions in the header, store as list
  header.definition.df   <- data.frame( #  write column names and description in data.frame
    colnames  = sub('.*= (.*):(.*)', '\\1', header.definition.list),
    longnames = sub('.*= (.*):(.*)', '\\2', header.definition.list))
  
  header.end.position <- grep("*END*", csv.file) #  find string '*END*' in cnv-file that marks the end of the header, thus the beginning of the data table
  
  # read data table ...
  data.frame <- read.table(text = csv.file, #  ... from given filname ...
                           na.strings = c(""),
                           sep="", #  ... with whitespaces as column separator ...
                           dec=".", #  ... and '.' as decimal point
                           skip=header.end.position, #  ... skipping the header ...
                           col.names = header.definition.df$colnames, # ... and using the extracted column definitions as column names for the created data.frame. 
                           row.names = NULL,
                           stringsAsFactors = FALSE) 
return(data.frame)} #  the function finally returns the data.frame

## IDEA: return a list including the data.frame, header.definition.df$longname and some metadata (Date, position, cruise, operator, ...)
##      or even include the meta-data into the data.frame?

## FIXME: funky character in 'sigma'-colname may be a problem (David?)

## TODO: include more would-be-NA-value conversions (David can help)