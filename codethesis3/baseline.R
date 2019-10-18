setwd("~/Desktop/Research_Project/codethesis3")
###############
#####################################################################
# Benchmark Model Naive Bayes Classifier
############################################################
# Installing all required packages.
library(naivebayes)
library(e1071)
library(dplyr)
library(ggplot2)
library(psych)
library(caret)

#Reading dataset and appling Standard Naive Bayes classifier
Data<- read.csv("cleaned_dataset_tfidf.csv", stringsAsFactors = FALSE)

####
Data$url <- NULL
Data$title <- NULL
Data$text <- NULL
Data$cleaned_title <- NULL

####
Data<- na.omit(Data)

str(Data)
# Checking data imbalance
table(Data$label)

Data$label<- as.factor(Data$label)
Data$cleaned_text<-as.character(Data$cleaned_text)
str(Data)
#Data
#Splitting dataset into training and testing data
set.seed(781)
ind_NB<- sample(2, nrow(Data), replace=T, prob = c(0.8,0.2))
train_NB<- Data[ind_NB==1,]
test_NB<- Data[ind_NB==2,]
#View(train)
#View(test)
#memory.limit()
#memory.limit(size=20000)
gc()
# Applying classifier only on news articles i.e. text columns
model_NB<- naiveBayes(label~cleaned_text, data = train_NB)
#View(model)
#model

#Comparing training dataset with testing dataset
pred_NB<- predict(model_NB, test_NB)
tab_NB<- table(Predicted= pred_NB, Actual= test_NB$label)
tab_NB
#Evaluating results with the help of confusion matrix
library(caret)
confusionMatrix(pred_NB,test_NB$label, positive = '1')

# precision value for untuned Naive Bayes 
precision <- posPredValue(pred_NB, test_NB$label, positive="1")

# recall value for untuned Naive Bayes 
recall <- sensitivity(pred_NB, test_NB$label, positive="1")

# F1 score for untuned svm
F1 <- (2 * precision * recall) / (precision + recall)

print(paste(precision, recall, F1), sep=" ")


###################################################

