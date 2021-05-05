
library(tidyverse)

plot.CTD.data <- function(CTD.data,
                          not2plot = c("depSM", "prDM", "pr", "scan", "nbin",
                                       "flag", "timeS", "nbf",
                                       "altM", "prDM", "spar",
                                       "header.latitude", "header.longitude",
                                       "latitude", "longitude"),
                          depvar = c("depSM", "prDM", "pr", "prdM", "prM")){
    
    #"water depth parameter of choice is the first one that matches 'depvar' ...
    water.depth.parameter <- names(CTD.data$data)[names(CTD.data$data) %in% depvar][1]
    # ... alternatively the first column
    if(is.na(water.depth.parameter)){
    water.depth.parameter <- names(CTD.data$data)[1]
    warning("No matching water depth parameter found, guessing ", water.depth.parameter)
    }
        
    
    df   <- CTD.data$data
    meta <- CTD.data$meta
    
    try({
        melted.df <- df %>% 
            pivot_longer(cols = names(df)[!names(df) %in% c(depvar, not2plot, water.depth.parameter)], 
                         names_to = "variable") %>%
            rename(depth = all_of(water.depth.parameter))
            #melt(df, id.vars = names(df)[names(df) %in% c(depvar, not2plot, water.depth.parameter)])
        
       # melted.df$depth <- melted.df %>% pull(water.depth.parameter)
        
        if(nrow(df) < 50){
            geom_case <- geom_point()
        }else{geom_case <- geom_path()} 
        
        ggplot(melted.df,
               aes(x = depth, y = value)) +
            geom_case +
            scale_x_reverse() +
            coord_flip() +
            facet_grid(.~variable, scales = "free") +
            theme_bw() +
            ggtitle(paste(names(meta), meta %>% na_if("character(0)"), collapse = "; ") %>%
                        sub("(.{100}[^;]*);", "\\1\\\n", .)) + # linebreak at first ";" after n characters
            xlab(paste0("Depth (", water.depth.parameter, ")")) +
            ylab(NULL) +
            theme(axis.text.x = element_text(angle = 45, hjust = 1))
    })
    
}



