##############################################################
#### R function to read SBE CTD cnv-files into data.frame ####
##### v0.2   Marko Lipka   marko.lipka@io-warnemuende.de #####
##############################################################


read.cnv.file <- function(filename){ #  filename as character string (e.g. "V0033F01.cnv")
    cnv.file <- readLines(filename, encoding = "latin1") #  reads the file as large character string
    # substitute terrible would-be-NA-values with less terrible would-be-NA-values:
    bad.flag <- sub(".*= (.*)$", "\\1", cnv.file[grep("bad_flag", cnv.file)])
    cnv.file <- gsub(bad.flag, " NA ", cnv.file) 
    #cnv.file <- gsub("-9.990e-29", " NA ", cnv.file) 
    #cnv.file <- gsub("-9.9900e-29", " NA ", cnv.file)
    
    header.definition.list <- as.list(cnv.file)[grep("# name", cnv.file)] #  find column definitions in the header, store as list
    header.definition.df   <- data.frame( #  write column names and description in data.frame
        colnames  = sub('.*= (.*):(.*)', '\\1', header.definition.list),
        longnames = sub('.*= (.*):(.*)', '\\2', header.definition.list))
    
    header.end.position <- grep("*END*", cnv.file) #  find string '*END*' in cnv-file that marks the end of the header, thus the beginning of the data table
    
    # extract longitude and latitude from header - not all SBE cnv's contain columns with lon and lat
    position <- cnv.file[grep("GPS_Posn", cnv.file)]
    pos.regexp <- ".*= ([-1234567890]*) ([1234567890.]*)[NS] ([-1234567890]*) ([1234567890.]*)[EW].*"
    latdeg <- as.numeric(sub(pos.regexp, "\\1", position))
    latmin <- as.numeric(sub(pos.regexp, "\\2", position))
    latdec <- latdeg + latmin / 60
    longdeg <- as.numeric(sub(pos.regexp, "\\3", position))
    longmin <- as.numeric(sub(pos.regexp, "\\4", position))
    longdec <- longdeg + longmin / 60
    
    # read data table ...
    if(length(cnv.file) > header.end.position){
        data.frame <- read.table(text = cnv.file, #  ... from given filname ...
                                 na.strings = c("NA"),
                                 sep="", #  ... with whitespaces as column separator ...
                                 dec=".", #  ... and '.' as decimal point
                                 skip=header.end.position, #  ... skipping the header ...
                                 col.names = header.definition.df$colnames, # ... and using the extracted column definitions as column names for the created data.frame. 
                                 row.names = NULL,
                                 stringsAsFactors = FALSE) 
        
        # add longitude and latitude from header as new columns
        data.frame$header.latitude <- latdec
        data.frame$header.longitude <- longdec
        
        return(data.frame)} #  the function finally returns the data.frame
    else{warning("cnv-file seems to contain no measurement data!")
        return(NULL)}}
    ## IDEA: return a list including the data.frame, header.definition.df$longname and some metadata (Date, position, cruise, operator, ...)
    ##      or even include the meta-data into the data.frame?
    
    ## FIXME: funky character in 'sigma'-colname may be a problem (David?)
    
    ## TODO: include more would-be-NA-value conversions (David must help)