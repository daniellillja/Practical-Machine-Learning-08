# clear previous workspace
rm(list=ls())

#TODO: change number of pcas?
param.pcas <- 7
param.training.method <- "parRF"

source("load_deps.R")
source("load_data.R")
source("preprocess.R")
source("training.R")
source("predict.R")
#source("explore_data.R")