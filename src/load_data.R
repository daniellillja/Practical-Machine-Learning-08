print("Loading data")

data.dir <- "../data/"

# csv to rdata format
source("export_rdata.R")

# load from rdata
load(file=paste0(data.dir, "pml-training.Rdata"))
load(file=paste0(data.dir, "pml-testing.Rdata"))

