
library(reshape2)
library(tidyverse)

plot.CTD.data <- function(CTD.data,
                          not2plot = c("depSM", "prDM", "pr", "scan", "nbin",
                                       "flag", "timeS", "nbf",
                                       "altM", "prDM", "spar",
                                       "header.latitude", "header.longitude",
                                       "latitude", "longitude"),
                          depvar = c("depSM", "prDM", "pr")){
    df   <- CTD.data$data
    meta <- CTD.data$meta
    
    try({
        melted.df <- melt(df, id.vars = names(df)[names(df) %in% c(depvar, not2plot)])
        
        #"water depth parameter of choice is the first one that matches 'depvar':
        water.depth.parameter <- names(melted.df)[names(melted.df) %in% depvar][1]
        melted.df$depth <- melted.df[, water.depth.parameter]
        
        if(nrow(df) < 50){
            geom_case <- geom_point()
        }else{geom_case <- geom_line()} 
        
        ggplot(melted.df,
               aes(x = depth, y = value)) +
            geom_case +
            scale_x_reverse() +
            coord_flip() +
            facet_grid(.~variable, scales = "free") +
            theme_bw() +
            ggtitle(paste(names(meta), meta %>% na_if("character(0)"), collapse = ", ")) +
            xlab(paste0("Depth (", water.depth.parameter, ")")) +
            theme(axis.text.x = element_text(angle = 45, hjust = 1))
    })
    
}



