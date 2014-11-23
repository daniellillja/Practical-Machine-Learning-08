---
title: "Practical Machine Learning"
author: "Daniel Lillja"
date: "Sunday, November 23, 2014"
output: html_document
---
### Summary
The goal of this project was to take data from the HAR (Human Activity Recognition) project to create a model able to predict the quality and form of exercises done. Output categories were A, B, C, D, and E and each cooresponds to a different way in which bicep curls were performed. All information can be found at the HAR site, <http://groupware.les.inf.puc-rio.br/har>. Without further ado, let's see the analysis.

****

### Project Layout
The project was organized with each step of analysis in a different file. The master.R file serves as the entry point for the script and call each of the other scripts.

```
source("load_deps.R")
source("load_data.R")
source("preprocess.R")
source("training.R")
source("predict.R")
```

#### load_deps.R
The load_deps.R file was use to load package dependencies for the project.

#### load_data.R
The load_data.R file was use to load the csv files into data frames. The data frames were then saved into .Rdata files for faster loading and higher compression. The raw data was loaded into variables training.csv and testing.csv.

#### preprocess.R
The preprocess.R file was use to transform the raw data into a more useful format that the model could be run on. Looking at the testing.csv data, we see that the window slice summaries are not present. In fact, most of the variables either had little data. These columns were removed to reduce the dimensionality of the dataset.

```
# get only cols with cooresponding data in testing
training <- training.csv[,-nearZeroVar(testing.csv)]
```

After doing this, there were still too many variables:

```r
ncol(training)
```

```
## [1] 53
```
PCA was employed to reduce the number of variables from 53 to 7.

#### training.R
The training.R file was responsible for creating a model based off of the reduced training data.
The training data was sampled to reduce computation time. To take advantage of multicore processing a parallel random forest was used.

```r
str(trainPC.train)
```

```
## 'data.frame':	9812 obs. of  8 variables:
##  $ PC1  : num  4.35 4.35 4.35 4.4 4.36 ...
##  $ PC2  : num  1.69 1.74 1.7 1.73 1.67 ...
##  $ PC3  : num  -2.78 -2.74 -2.77 -2.77 -2.71 ...
##  $ PC4  : num  0.834 0.823 0.838 0.832 0.818 ...
##  $ PC5  : num  -1.3 -1.33 -1.33 -1.39 -1.24 ...
##  $ PC6  : num  2.07 2.15 2.11 2.15 2.07 ...
##  $ PC7  : num  -0.182 -0.224 -0.201 -0.216 -0.209 ...
##  $ class: Factor w/ 5 levels "A","B","C","D",..: 1 1 1 1 1 1 1 1 1 1 ...
```

```
modFit <- train(class ~ ., data=trainPC.train, method=param.training.method, prox=TRUE)
```
#### predict.R
Finally, predict.R was used to generate results based off of the model. The testing dataset was preprocessed using the parameters estimated in the training process. Answers were saved to files and put in the reports/answers folder.

```
testingPC$results <- predict(modFit, newdata=testingPC)
```

***
### Model accuracy
Overall, the model was fairly successful at classifying the testing dataset.


```r
modFit
```

```
## Parallel Random Forest 
## 
## 9812 samples
##    7 predictor
##    5 classes: 'A', 'B', 'C', 'D', 'E' 
## 
## No pre-processing
## Resampling: Bootstrapped (25 reps) 
## 
## Summary of sample sizes: 9812, 9812, 9812, 9812, 9812, 9812, ... 
## 
## Resampling results across tuning parameters:
## 
##   mtry  Accuracy   Kappa      Accuracy SD  Kappa SD   
##   2     0.8735018  0.8398616  0.004384193  0.005624733
##   4     0.8644106  0.8283395  0.005994949  0.007661183
##   7     0.8450198  0.8037998  0.006075813  0.007741690
## 
## Accuracy was used to select the optimal model using  the largest value.
## The final value used for the model was mtry = 2.
```
Using bootstrapping 25 times, the model accuracy was estimated to be around 87%.

### Future Improvements
Because of limited computation time, only 50% of the training data was used to create the model. Also, adjustments could be made to the PCA preproccesing. 7 principal components were used, but playing around with the number could yield extra model accuracy.

