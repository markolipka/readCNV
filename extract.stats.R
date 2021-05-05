source("read.cnv.files.R")
library(tidyverse)

extract.stats <- function(CTD.data){
    if(is.character(CTD.data)) CTD.data <- read.cnv.file(CTD.data)
    
    lapply(CTD.data$data, summary) %>% bind_rows(.id = "parameter")
    
}

extract.stats.dir <- function(path.to.start = "example data/IOW"){
    
    files <- list.files(path = path.to.start, 
                        pattern = "\\.cnv$",
                        full.names = TRUE,
                        recursive = T, ignore.case = T)
    
    CTD.data.list <- lapply(files, read.cnv.file)
    names(CTD.data.list) <- files
    
    lapply(CTD.data.list, extract.stats) %>%
        bind_rows(.id = "source")
}
