source("read.cnv.files.R")
library(reshape2)
library(ggplot2)

files <- list.files(path = "~/Dropbox/", pattern = "\\.cnv$", recursive = T, ignore.case = T)

potential.id.vars <- c("depSM", "prDM", "pr", "scan", "nbin",
                       "flag", "timeS", "nbf",
                       "altM", "prDM", "spar",
                       "header.latitude", "header.longitude",
                       "latitude", "longitude")
potential.depvars <- c("depSM", "prDM", "pr")

for(file in files){
    cat(paste(file, " ... \n"))
    file.abs.path <- paste0("~/Dropbox/", file)
    file.path.sub <- gsub("/", "_", file.abs.path)
    import <- read.cnv.file(file.abs.path)
    df   <- import$data
    meta <- import$meta
    
    try({
        melted.df <- melt(df, id.vars = names(df)[names(df) %in% potential.id.vars])
        
        #"water depth parameter of choice is the first one that matches 'potential.depvars':
        melted.df$depth <- melted.df[, names(melted.df)[names(melted.df) %in% potential.depvars][1]]
        
        ggplot(melted.df,
               aes(x = depth, y = value)) +
            geom_line() +
            scale_x_reverse() +
            coord_flip() +
            facet_grid(.~variable, scales = "free") +
            theme_bw() +
            theme(axis.text.x = element_text(angle = 45, hjust = 1))
        ggsave(filename = paste0(file.path.sub, ".png"),
               path = "~/cnv_test", width = 12, height = 4)})
    cat("... done\n")
}