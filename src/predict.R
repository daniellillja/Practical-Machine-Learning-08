colNums <- match(colnames(training), names(testing.csv))
colNums <- colNums[!is.na(colNums)]

testing <- testing.csv %>%
  select(colNums)

testingPC <- predict(preObj, testing)

testingPC$results <- predict(modFit, newdata=testingPC)


# write answers to file
pml_write_files = function(x){
  n = length(x)
  for(i in 1:n){
    filename = paste0("../reports/answers/problem_id_",i,".txt")
    write.table(x[i],file=filename,quote=FALSE,row.names=FALSE,col.names=FALSE)
  }
}

pml_write_files(testingPC$results)