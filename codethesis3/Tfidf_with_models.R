setwd("~/Desktop/Research_Project/codethesis3")
library(plyr) #  for pre-processing 
library(tidyverse)
library(tidytext)
library(caret)
library(SnowballC)
library(tm)

news_full <- read.csv( "final_dataset.csv", stringsAsFactors = FALSE )

news <- news_full
#news$text <- gsub('[[:punct:] ]+',' ',news$text)
#news$text <- gsub('[0-9]+', '', news$text)
#news$text <- gsub("  ", '', news$text)

data_clean <- news %>%
  mutate(text = str_replace_all(news$text, " ?(f|ht)tp(s?)://(.*)[.][a-z]+", "")) %>%
  select(id, text,label)
head(data_clean)

data_clean <- na.omit(data_clean)

data_clean %>%
ggplot(aes(label)) +
geom_bar()

data_counts <- map_df(1:1, ~ unnest_tokens(data_clean, word, text, token = "ngrams", n = .x)) %>%
  anti_join(stop_words, by = "word") %>%
  count(id, word, sort = TRUE) %>%
  mutate(word = SnowballC::wordStem(word))

head(data_counts)

words_10 <- data_counts %>%
  group_by(word) %>%
  summarise(n = n()) %>%
  filter(n >= 50) %>%
  select(word)

words_10 <- na.omit(words_10)

data_dtm <- data_counts %>%
  right_join(words_10, by = "word") %>%
  bind_tf_idf(word, id, n) %>%
  cast_dtm(id, word, tf_idf , weighting = tm::weightTfIdf)

inspect(data_dtm[1:10,1:10])

meta <- tibble(id = as.numeric(dimnames(data_dtm)[[1]])) %>%
  left_join(data_clean[!duplicated(data_clean$id), ], by = "id")

#write.csv(meta,file = "tfidf_for_models.csv", row.names = F)
#tfidf_for_models.csv <- read.csv( "tfidf_for_models.csv", stringsAsFactors = FALSE )

set.seed(3122)
trainIndex <- createDataPartition(meta$label, p = 0.8, list = FALSE, times = 1)

data_df_train <- data_dtm[trainIndex, ] %>% as.matrix() %>% as.data.frame()
data_df_test <- data_dtm[-trainIndex, ] %>% as.matrix() %>% as.data.frame()

response_train <- meta$label[trainIndex]

#missing text
data_clean %>%
  anti_join(meta, by = "id") %>%
  head(25) %>%
  pull(text)

head(data_clean)

trctrl <- trainControl(method = "none")

#################### SVM #################################


########################SVM
#SVM Linear
svm_mod_l <- train(x = data_df_train,
                 y = as.factor(response_train),
                 method = "svmLinear",
                 trControl = trctrl
                 )

svm_pred_l <- predict(svm_mod_l,
                    newdata = data_df_test)

svm_cm_l <- confusionMatrix(table(svm_pred_l, meta[-trainIndex, ]$label)) 
svm_cm_l

str(svm_cm_l)
tocsv <- data.frame(cbind(t(svm_cm_l$overall),t(svm_cm_l$byClass)))
# You can then use
write.csv(tocsv,file="output_of_svm_linear_tfidf.csv")

############################

#SVM Radial
svm_mod_r <- train(x = data_df_train,
                   y = as.factor(response_train),
                   method = "svmRadial",
                   trControl = trctrl
)

svm_pred_r <- predict(svm_mod_r,
                      newdata = data_df_test)

svm_cm_r <- confusionMatrix(table(svm_pred_r, meta[-trainIndex, ]$label)) 
svm_cm_r

str(svm_cm_r)
tocsv <- data.frame(cbind(t(svm_cm_r$overall),t(svm_cm_r$byClass)))
# You can then use
write.csv(tocsv,file="output_of_svm_radial_tfidf.csv")

############################



#########NB
nb_mod <- train(x = data_df_train,
                y = as.factor(response_train),
                method = "naive_bayes",
                trControl = trctrl,
                tuneGrid = data.frame(laplace = 0,
                                      usekernel = FALSE,
                                      adjust = FALSE))

nb_pred <- predict(nb_mod,
                   newdata = data_df_test)

nb_cm <- confusionMatrix(table(nb_pred, meta[-trainIndex, ]$label))
nb_cm

tocsv_nb <- data.frame(cbind(t(nb_cm$overall),t(nb_cm$byClass)))
# You can then use
write.csv(tocsv_nb,file="output_of_nb_tfidf.csv")



###########random forest
rf_mod <- train(x = data_df_train, 
                y = as.factor(response_train), 
                method = "ranger",
                trControl = trctrl,
                tuneGrid = data.frame(mtry = floor(sqrt(dim(data_df_train)[2])),
                                      splitrule = "gini",
                                      min.node.size = 1))
#We predict on the test data set based on the fitted model.

rf_pred <- predict(rf_mod,
                   newdata = data_df_test)
#calculate the confusion matrix

rf_cm <- confusionMatrix(table(rf_pred, meta[-trainIndex, ]$label))
rf_cm

tocsv_rf <- data.frame(cbind(t(rf_cm$overall),t(rf_cm$byClass)))
# You can then use
write.csv(tocsv_rf,file="output_of_rf_tfidf.csv")


# #SVM with tuning 
# svm_mod <- train(x = data_df_train,
#                  y = as.factor(response_train),
#                  method = "svmLinearWeights2",
#                  trControl = trctrl,
#                  tuneGrid = data.frame(cost = 1, 
#                                        Loss = 0, 
#                                        weight = 1))
# 
# svm_pred <- predict(svm_mod,
#                     newdata = data_df_test)
# 
# svm_cm <- confusionMatrix(table(svm_pred, meta[-trainIndex, ]$label)) 
# svm_cm
# 
# str(svm_cm)
# tocsv <- data.frame(cbind(t(svm_cm$overall),t(svm_cm$byClass)))
# # You can then use
# write.csv(tocsv,file="output_of_svm_tfidf.csv")

###################LogitBoost

# logitboost_mod <- train(x = data_df_train,
#                         y = as.factor(response_train),
#                         method = "LogitBoost",
#                         trControl = trctrl)
# 
# logitboost_pred <- predict(logitboost_mod,
#                            newdata = data_df_test)
# 
# logitboost_cm <- confusionMatrix(table(logitboost_pred, meta[-trainIndex, ]$label))
# logitboost_cm
# 
# tocsv_logitboost <- data.frame(cbind(t(logitboost_cm$overall),t(logitboost_cm$byClass)))
# # You can then use
# write.csv(tocsv_logitboost,file="output_of_logitboost_tfidf.csv")

########### Neural Network

# nnet_mod <- train(x = data_df_train,
#                   y = as.factor(response_train),
#                   method = "nnet",
#                   trControl = trctrl,
#                   tuneGrid = data.frame(size = 1,
#                                         decay = 5e-4),
#                   MaxNWts = 5000)
# 
# nnet_pred <- predict(nnet_mod,
#                      newdata = data_df_test)
# 
# nnet_cm <- confusionMatrix(table(nnet_pred, meta[-trainIndex, ]$label))
# nnet_cm
# 
# tocsv_nnet <- data.frame(cbind(t(nnet_cm$overall),t(nnet_cm$byClass)))
# # You can then use
# write.csv(tocsv_nnet,file="output_of_nnet_tfidf.csv")

########################### xgboost
# library(caret)
#xgboost
#bootControl <- trainControl(number=5, verboseIter=TRUE)

# tune_grid_x <- expand.grid(eta = c(0.5), 
#                            nrounds = c(20),
#                            max_depth = 6:20,
#                            min_child_weight = c(2.0, 2.25, 22.5),
#                            colsample_bytree = c(0.3, 0.4, 0.5),
#                            gamma = 0,
#                            subsample = 1)
# 
# XG_Boost_model <- train(x = data_df_train,
#                         y = as.numeric(as.factor(response_train)),
#                         trControl=trctrl,
#                         method = "xgbTree",
#                         tuneGrid = tune_grid_x,
#                         verbose = 1,
#                         num_class = 1)
###