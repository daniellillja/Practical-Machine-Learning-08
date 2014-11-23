print("Preprocessing data")

# get only cols with cooresponding data in testing
training <- training.csv[,-nearZeroVar(testing.csv)]

# remove some cols
training <- training %>%
  select(-X, -user_name, -raw_timestamp_part_1, -raw_timestamp_part_2, -cvtd_timestamp, -num_window)
         
#preprocess with pca (10 vars)

preObj <- preProcess(training[,-53], method=c("pca","knnImpute"), pcaComp=param.pcas)
trainPC <- predict(preObj, training[,-53])
trainPC$class <- training$classe

