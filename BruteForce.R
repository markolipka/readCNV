### Run through all cnv-files in the Dropbox directory and try to plot them:
source("read.cnv.files.R")
source("plot.CTD.data.R")

path.to.start <- "~/ownCloud/"

files <- list.files(path = path.to.start, pattern = "\\.cnv$", recursive = T, ignore.case = T)

for(file in files){
    cat(paste(file, " ... \n"))
    file.abs.path <- paste0(path.to.start, file)
    file.path.sub <- gsub("/", "_", file.abs.path)
    import <- read.cnv.file(file.abs.path)
    plot.CTD.data(import)
    ggsave(filename = paste0(file.path.sub, ".png"),
           path = "~/cnv_test", width = 12, height = 4)
    cat("... done\n")
}