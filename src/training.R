print("Training")

#multicore processing
cl <- makePSOCKcluster(3)
clusterEvalQ(cl, library(foreach))
registerDoParallel(cl)

#creating a sub training set because my pc ain't powerful enough :)
inTrain <- createDataPartition(y=trainPC$class, p=0.5, list=FALSE)
trainPC.train <- trainPC[inTrain,]

print("Modeling")
modFit <- train(class ~ ., data=trainPC.train, method=param.training.method, prox=TRUE)

closeAllConnections();

