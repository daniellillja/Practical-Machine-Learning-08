exportTraining <- function() {
  training.csv <- read.csv(paste0(data.dir,"pml-training.csv"))
  save(training.csv, file=paste0(data.dir, "pml-training.Rdata"))
}

exportTesting <- function() {
  testing.csv <- read.csv(paste0(data.dir,"pml-testing.csv"))
  save(testing.csv, file=paste0(data.dir, "pml-testing.Rdata"))
}

# if rdata format does not exist, export to Rdata format
if(!file.exists(paste0(data.dir, "pml-training.Rdata"))) {
  exportTraining()
}

if(!file.exists(paste0(data.dir, "pml-testing.Rdata"))) {
  exportTesting()
}