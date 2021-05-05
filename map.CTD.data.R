source("read.cnv.files.R")
source("plot.CTD.data.R")

library(sf)
library(tidyverse)
library(mapview)
library(leafpop)

map.CTD.data <- function(path.to.start = "example data") {
    
    files <- list.files(path = path.to.start, 
                        pattern = "\\.cnv$",
                        full.names = TRUE,
                        recursive = T, ignore.case = T)
    
    data <- lapply(files, function(cnv){
        d <- read.cnv.file(cnv)
        if(all(!is.na(d$coords))){
            coords <- d$coords %>%
                as_tibble() %>%
                mutate(LatDecDeg = parzer::parse_lat(Lat),
                       LonDecDeg = parzer::parse_lon(Lon)) %>%
                st_as_sf(coords = c("LonDecDeg", 
                                    "LatDecDeg"), 
                         crs = 4326)
        }else(coords <- NULL)
        return(coords)
    }) %>%
        bind_rows()
    
    plots <- lapply(files, function(cnv){
        d <- read.cnv.file(cnv)
        p <- plot.CTD.data(d)
        if(all(!is.na(d$coords))){
            return(p)
        }
    })
    plots <- plots[!sapply(plots, is.null)]
    
    
    
    
    mapview(data, popup = popupGraph(plots, height = 200, width = 700))
}

# map.CTD.data()
