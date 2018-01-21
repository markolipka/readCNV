### Run through all cnv-files in the Dropbox directory and try to plot them:
source("read.cnv.files.R")
source("plot.CTD.data.R")

files <- list.files(path = "~/ownCloud/", pattern = "\\.cnv$", recursive = T, ignore.case = T)

for(file in files){
    cat(paste(file, " ... \n"))
    file.abs.path <- paste0("~/ownCloud/", file)
    file.path.sub <- gsub("/", "_", file.abs.path)
    import <- read.cnv.file(file.abs.path)
    plot.CTD.data(import)
    ggsave(filename = paste0(file.path.sub, ".png"),
           path = "~/cnv_test", width = 12, height = 4)
    cat("... done\n")
}