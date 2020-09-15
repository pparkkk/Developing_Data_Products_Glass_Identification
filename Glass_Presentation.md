Glass Identification
========================================================
author: Park
date: 15 September 2020
autosize: true
font-family: Helvetica

Executive Summary
========================================================

This is the final course project of the *Developing Data Products* Course, the fourth course in the *Statistics and Machine Learning* Specialization, taught in Coursera.

The [application](https://pparkkk.shinyapps.io/glass_identification/) attempts to fit a **random forest** machine learning algorithm in order to predict the types of glass based on their physical (refractive index) and chemical properties (oxides composition). In addition, it allows users to manipulate each of the characteristics of the glass (both refractive index and oxides composition) and tries to predict the glass type based on data provided by the data set.

For the R code of the application, please follow this [link](https://github.com/pparkkk/Developing_Data_Products_Glass_Identification) on GitHub.


Glass Data Set
========================================================
The data set is obtained from the *mlbench* package in R. It comprises of 214 observations and 10 variables. The variables are refractive index, 8 oxide compositions and the type of glass. In general, there are 7 types of glasses, of which 6 of them are included in the data set.

```r
library(mlbench); data(Glass)
names(Glass)
```

```
 [1] "RI"   "Na"   "Mg"   "Al"   "Si"   "K"    "Ca"   "Ba"   "Fe"   "Type"
```

```r
levels(Glass$Type)
```

```
[1] "1" "2" "3" "5" "6" "7"
```


Random Forest
========================================================

With only 214 observations, it is considered too small for the algorithm. Thus, bootstrap is applied to the data set first -- sample 1000 observations with replacement. Then, the random forest algorithm of 100 trees is applied.


```r
library(caret)
# bootstrapping
set.seed(418801)
newrow <- sample(1:nrow(Glass), size = 1000, replace = TRUE)
newdata <- Glass[newrow, ]
# fit the model
fit <- train(Type ~ ., data = newdata, method = "rf", ntree = 100)
```


Result
========================================================

Finally, predict on the original Glass data set and display the accuracy. 


```
          Reference
Prediction  1  2  3  5  6  7
         1 70  0  0  0  0  0
         2  0 76  0  0  0  0
         3  0  0 17  0  0  0
         5  0  0  0 13  0  0
         6  0  0  0  0  9  0
         7  0  0  0  0  0 29
```

As a bonus, the user could create their own glass characteristics and get the predicted glass type.

