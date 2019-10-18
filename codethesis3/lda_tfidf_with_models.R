
setwd("~/Desktop/Research_Project/codethesis3")
library(plyr)
library(dplyr)
library(tm)
library(stringr)
library(tidytext)
library(ggplot2)

data <- read.csv("data.csv", stringsAsFactors = F) #will not autoencode the text attributes to factors
summary(data)

data<- as.data.frame(data)

#adding id numbers
data$id <- seq.int(nrow(data))

#rename
colnames(data)[colnames(data)=="Headline"] <- "title"
colnames(data)[colnames(data)=="Label"] <- "label"
colnames(data)[colnames(data)=="Body"] <- "text"
colnames(data)[colnames(data)=="URLs"] <- "url"

write.csv(data,file = "sliced_data.csv", row.names = F)

###############cleaning
data <- as.data.frame(data)
########################################################################
#column Text
###################################################################################
data$text<- as.character(data$text)
#Case Folding - tranforming into lower case
data$text<-tolower(data$text)
# Removing Stop words from the data
stopword<-c("a","i","me" ,"my" ,"myself" ,"we" ,"our" ,"ours" ,"ourselves" ,"you" ,
            "your" ,"yours" ,"yourself" ,"yourselves", "he" ,"him" ,"his" ,"himself" ,
            "she" ,"her" ,"hers" ,"herself" ,"it" ,"its" ,"itself" ,"they" ,"them" ,
            "their" ,"theirs" ,"themselves" ,"what" ,"which" ,"who" ,"whom" ,"this" ,
            "that" ,"these" ,"those" ,"am" ,"is" ,"are", "was" ,"were" ,"be" ,"been" ,
            "being" ,"have" ,"has" ,"had" ,"having" ,"do" ,"does" ,"did" ,"doing" ,
            "would" ,"should" ,"could" ,"ought" ,"i'm" ,"you're" ,"he's" ,"she's" ,
            "it's" ,"we're" ,"they're" ,"i've" ,"you've" ,"we've" ,"they've" ,"i'd" ,
            "you'd" ,"he'd" ,"she'd" ,"we'd" ,"they'd" ,"i'll" ,"you'll" ,"he'll" ,
            "she'll" ,"we'll" ,"they'll" ,"isn't" ,"aren't" ,"wasn't" ,"weren't" ,
            "hasn't" ,"haven't" ,"hadn't" ,"doesn't" ,"don't" ,"didn't" ,"won't" ,
            "wouldn't" ,"shan't" ,"shouldn't" ,"can't" ,"cannot" ,"couldn't" ,
            "mustn't" ,"let's" ,"that's" ,"who's" ,"what's" ,"here's" ,"there's" ,
            "when's" ,"where's" ,"why's" ,"how's" ,"an" ,"the" ,"and" ,"but" ,
            "if" ,"or" ,"because" ,"as" ,"until" ,"while" ,"of", "at" ,"by" ,"for" ,
            "with" ,"about" ,"against" ,"between" ,"into" ,"through" ,"during",
            "before" ,"after" ,"above" ,"below" ,"to" ,"from" ,"up" ,"down" ,"in" 
            ,"out" ,"on" ,"off" ,"over" ,"under" ,"again" ,"further" ,"then" ,"once" ,
            "here" ,"there" ,"when" ,"where" ,"why" ,"how" ,"all" ,"any" ,"both" ,
            "each" ,"few" ,"more" ,"most" ,"other" ,"some" ,"such" ,"no" , "nor" ,
            "not" ,"only" ,"own" ,"same" ,"so" ,"than" ,"too" ,"very" ,"a's" ,"able" ,
            "about" ,"above" ,"according" ,"accordingly" ,"across" ,"actually" ,
            "after" ,"afterwards" ,"again" ,"against" ,"ain't" ,"all" ,"allow" ,
            "allows" ,"almost" ,"alone" ,"along" ,"already" ,"also" ,"although" ,
            "always" ,"am" ,"among" ,"amongst" ,"an" ,"and" ,"another" ,"any" ,
            "anybody" ,"anyhow" ,"anyone" ,"anything" ,"anyway" ,"anyways" ,
            "anywhere" ,"apart" ,"appear" ,"appreciate" ,"appropriate" ,"are" ,
            "aren't" ,"around" ,"as" ,"aside" ,"ask" ,"asking" ,"associated", "at" ,
            "available" ,"away" ,"awfully" ,"be" ,"became", "because" ,"become" ,
            "becomes" ,"becoming" ,"been" ,"before" ,"beforehand" ,"behind" ,"being" ,
            "believe" ,"below" ,"beside" ,"besides" ,"best" ,"better" ,"between" ,
            "beyond" ,"both", "brief" ,"but" ,"by" ,"c'mon" ,"c's" ,"came" ,"can" ,
            "can't" ,"cannot" ,"cant" ,"cause" ,"causes" ,"certain" ,"certainly" ,
            "changes" ,"clearly" ,"come" ,"comes" ,"concerning" ,
            "consequently" ,"consider" ,"considering" ,"contain" ,"containing" ,
            "contains" ,"corresponding" ,"could" ,"couldn't" ,"course" ,"currently" ,
            "definitely" ,"described" ,"despite" ,"did" ,"didn't" ,"different" ,"do" ,
            "does" ,"doesn't" ,"doing" ,"don't", "done" ,"down" ,"downwards" ,
            "during" ,"each"  ,"eight" ,"either" ,"else" ,"elsewhere" ,
            "enough" ,"entirely" ,"especially","etc" ,"even" ,"ever" ,"every" ,
            "everybody" ,"everyone" ,"everything" ,"everywhere" ,"ex" ,"exactly" ,
            "example" ,"except", "far" ,"few" ,"fifth" ,"first" ,"five" ,"followed" ,
            "following" ,"follows", "for" ,"former" ,"formerly" ,"forth" ,"four" ,
            "from" ,"further" ,"furthermore" ,"get", "gets" ,"getting" ,"given" ,
            "gives" ,"go" ,"goes" ,"going" ,"gone" ,"got" ,"gotten" ,"greetings" ,
            "had" ,"hadn't" ,"happens" ,"hardly" ,"has" ,"hasn't" ,"have" ,"haven't" ,
            "having" ,"he" ,"he's" ,"hello" ,"help" ,"hence" ,"her" ,"here" ,
            "here's" ,"hereafter" ,"hereby" ,"herein" ,"hereupon" ,"hers" ,
            "herself", "hi" ,"him" ,"himself" ,"his" ,"hither" ,"hopefully" ,"how" ,
            "howbeit" ,"however" ,"i'd" ,"i'll" ,"i'm" ,"i've" ,"ie" ,"if" ,"ignored",
            "immediate" ,"in" ,"inasmuch"  ,"indeed" ,"indicate" ,"indicated" ,
            "indicates" ,"inner" ,"insofar" ,"instead" ,"into" ,"inward" ,"is" ,
            "isn't"  ,"it'd" , "it'll" ,"it's" ,"its" ,"itself" ,"just" ,"keep" ,
            "keeps" ,"kept" ,"know" ,"knows" ,"known" ,"last" ,"lately" ,"later" ,
            "latter" ,"latterly" ,"least" ,"less" ,"lest" ,"let" ,"let's" ,"like" ,
            "liked" ,"likely" ,"little" ,"look" ,"looking" ,"looks" ,"ltd" ,"mainly" ,
            "many" ,"may" ,"maybe"  ,"mean" ,"meanwhile" ,"merely" ,"might" ,
            "more" ,"moreover" ,"most" ,"mostly" ,"much" ,"must" ,"my" ,"myself" ,
            "name" ,"namely" ,"near", "nearly" ,"necessary" ,"need" ,"needs" 
            ,"neither" ,"never" ,"nevertheless" ,"new" ,"next" ,"nine" ,"no" ,
            "nobody" ,"non" ,"none" ,"noone" ,"nor" ,"normally" ,"not" ,"nothing",
            "novel" ,"now" ,"nowhere" ,"obviously" ,"of" ,"off" ,"often"  ,"ok" ,"didnt",
            "okay" ,"old" ,"once" ,"only" ,"onto" ,"or" ,
            "other" ,"others" ,"otherwise" ,"ought" ,"our" ,"ours" ,"ourselves" ,
            "out" ,"outside" ,"over" ,"overall" ,"own" ,"particular", "particularly" ,"perhaps" ,"placed" ,"please" ,"plus" ,"possible" ,"presumably" ,
            "probably" ,"provides" ,"quite" ,"rather" ,
            "really", "reasonably" ,"regarding" ,"regardless" ,"regards" ,
            "relatively" ,"respectively" ,"right" ,"said" ,"same" ,"saw" ,"say" , "made","make","see","back",
            "saying" ,"says" ,"second" ,"secondly" ,"seeing" ,"seem" ,
            "seemed" ,"seeming" ,"seems" ,"seen" ,"self" ,"selves" ,"sensible" ,
            "sent" ,"serious" ,"seriously" ,"seven" ,"several" ,"shall" ,"she" ,
            "should", "shouldn't" ,"since" ,"six" ,"some" ,"somebody" ,
            "somehow" ,"someone" ,"something" ,"sometime" ,"sometimes" ,"somewhat" ,
            "somewhere" ,"soon" ,"sorry" ,"specified" ,"specify" ,"specifying" ,
            "still" ,"such" ,"sure"  ,"take" ,"taken" ,"tell" ,
            "tends"  ,"than", "thank" ,"thanks" ,"thanx" ,"that", "that's" ,
            "thats" ,"the" ,"their" ,"theirs" ,"them" ,"themselves" ,"then" ,
            "thence" ,"there" ,"there's" ,"thereafter" ,"thereby" ,"therefore" ,
            "therein" ,"theres" ,"thereupon" ,"these" ,"they" ,"they'd" ,"they'll" ,
            "they're" ,"they've" ,"think" ,"third" ,"this" ,"thorough", "thoroughly" ,
            "those" ,"though" ,"three" ,"through" ,"throughout" ,"thru" ,"thus" ,
            "to" ,"together" ,"too" ,"took" ,"toward" ,"towards" ,"tried" ,"tries" ,
            "truly" ,"try" ,"trying" ,"twice" ,"two"  ,"under" ,
            "unfortunately" ,"unless" ,"unlikely" ,"until" ,"unto" ,"up" ,"upon" ,"use" ,"used", "useful" ,"uses" ,"using" ,"usually" ,"uucp"
            ,"various" ,"very" ,"via" ,"viz" ,"want", "wants" ,"was" ,"wasn't" ,
            "way" , "we'd" ,"we'll" ,"we're" ,"we've" ,"welcome" ,"well" ,
            "went" ,"were" ,"weren't" ,"what" ,"what's" ,"whatever", "when" ,
            "whence" ,"whenever" ,"where" ,"where's" ,"whereafter" ,"whereas" ,
            "whereby" ,"wherein" ,"whereupon" ,"wherever" ,"whether" ,"which" ,
            "while" ,"whither" ,"who" ,"who's" ,"whoever" ,"whole" ,"whom" ,
            "whose" ,"why", "will" ,"willing" ,"wish" ,"with", "within" ,"without" ,
            "won't" ,"wonder" ,"would" ,"wouldn't" ,"yes" ,"yet" ,"you" ,"you'd" ,
            "you'll" ,"you're" ,"you've", "your", "yours", "yourself", "yourselves")

library(qdap)
removed_text <- rm_stopwords(text.var = data$text, stopwords = stopword, ignore.case = F, strip = TRUE)
data$text <- NULL
data[["text"]] <- removed_text

#text
data$text<- gsub("^[c]", "", data$text)
data$text <- gsub("^[(]","",data$text)
data$text <- iconv(data$text, "utf-8", "ASCII")
#data$text<- gsub("", "",data$text)

#title
data$title<- gsub("^[c]", "", data$title)
data$title <- gsub("^[(]","",data$title)
data$title <- iconv(data$title, "utf-8", "ASCII")
#data$title<- gsub(" ", "",data$title)

data<- na.omit(data)

data$text<- gsub("[[:punct:]]", " ",data$text)

#replacing name of text to content
colnames(data)[colnames(data)=="text"] <- "content"

# making them to lowercase
data$content <- tolower(data$content)
data$title <- tolower(data$title)

#punc
data$content <- gsub("([<>-])|[[:punct:]]", "\\1", data$content)
data$title <- gsub("([<>-])|[[:punct:]]", "\\1", data$title)

tokens_content <- data %>%
  unnest_tokens(word, content, drop = FALSE) %>%
  count(id, word, sort = TRUE) %>%
  ungroup()

tokens_title <- data %>%
  unnest_tokens(word, title, drop = FALSE) %>%
  count(id, word, sort = TRUE) %>%
  ungroup()

### based on tf_idf calculated below : removing words with numbers present:
#tokens_content <- tokens_content[!grepl("\\d+", tokens_content$word),]
#tokens_title <- tokens_title[!grepl("\\d+", tokens_title$word),]

colnames(tokens_content)[2:3] <- paste0("content.", colnames(tokens_content)[2:3])
colnames(tokens_title)[2:3] <- paste0("title.", colnames(tokens_title)[2:3])

# parent <- join_all(list(data, tokens_content, tokens_title), by = "id")
parent.content <- left_join(data, tokens_content, by = "id")
parent.title <- left_join(data, tokens_title, by = "id")

tf.idf.content <- parent.content %>% bind_tf_idf(content.word, content, content.n) %>%
  select(id, content, content.word, tf, idf, tf_idf)
tf.idf.title   <- parent.title %>% bind_tf_idf(  title.word,   title, title.n) %>%
  select(id, title, title.word, tf, idf, tf_idf)


colnames(tf.idf.content)[4:6] <- paste0("content.", colnames(tf.idf.content)[4:6])
colnames(tf.idf.title)[4:6] <- paste0("title.", colnames(tf.idf.title)[4:6])

#title.pred <- tf.idf.title %>% group_by(id) %>% top_n(n=10) %>%  
#  summarise(title.tag = toString(title.word))
#content.pred <- tf.idf.content %>% group_by(id) %>% top_n(n=10)%>%
#  summarise(content.pred = toString(content.word))

title.pred <- tf.idf.title %>% group_by(id) %>% arrange(desc(title.tf_idf)) %>% top_n(n=50) %>%  
  summarise(title.tag = toString(title.word))
content.pred <- tf.idf.content %>% group_by(id) %>% arrange(desc(content.tf_idf)) %>% top_n(n=50)%>%
  summarise(content.pred = toString(content.word))


tags.data <- join_all(list(data, title.pred, content.pred), by = "id")
head(tags.data, 15)

tags.data$content.pred <- gsub(", "," ",tags.data$content.pred)
tags.data$title.tag <- gsub(", "," ",tags.data$title.tag)

#tags.data$content.pred <- gsub(" ","",tags.data$content.pred)

tags.data <- na.omit(tags.data)
write.csv(tags.data, "cleaned_for_feeding_lda")
############### ############### ############### ############################## ###############
#table(tags.data$label)



############### ###############  ############### ############################## ###############
############### ############### performing LDA on tfidf features ############### ##############
############### ###############  ############### ############################## ###############


#rename
tags.data$url <- NULL
tags.data$title <- NULL
tags.data$content <- NULL
colnames(tags.data)[colnames(tags.data)=="title.tag"] <- "title"
colnames(tags.data)[colnames(tags.data)=="content.pred"] <- "text"


################################################################
# Peforming LDA on cleaned dataset
#####################################################################
#Refered from : https://www.tidytextmining.com/topicmodeling.html

# Required packages were installed
library(tidyverse)
library(tidytext)
library(topicmodels)
library(tm)
library(SnowballC)

# Reading csv file 
texts <- tags.data
#Removing empty rows to avoid error while creating document term matrix
texts<- na.omit(texts)
#Deleting unwanted columns and focusing only on news articles to improve accuracy of the model
texts$X1<-NULL
texts$id<-NULL
texts$title<- NULL

################################################################ setting seed
set.seed(3212) #for k=2
#set.seed(3214) #for k=4
#set.seed(3126) #for k=6
#set.seed(3218) #for k=8
################################################################


str(texts)
#Changing target variable into factor for execution
texts$label <- as.factor(texts$label)
gc()
texts_subsample <- texts[1:2000,] # taking first 2000 indexes
texts_subsample["document"] <- seq.int(nrow(texts_subsample))

#Creating Document term matrix and corpus
corpus <- Corpus(VectorSource(texts_subsample$text)) # make a corpus object
DTM <- DocumentTermMatrix(corpus) # get the count of words/document


unique_indexes <- unique(DTM$i)
DTM <- DTM[unique_indexes,]

#Implement LDA with specified number of topics

#Step 6<- Mention number of topics(k). In our case we took k=2, k=4, k=6,
# k=8, k=10 and k=12

lda <- LDA(DTM, k = 2, control = list(seed = 3212))
#Coverting output of LDA to a tidy
topics <- tidy(lda, matrix = "beta")
gammaDF <- as.data.frame(lda@gamma)

k=2
names(gammaDF) <- c(1:k)
gammaDF
toptopics <- as.data.frame(cbind(document = row.names(gammaDF), 
                                 topic = apply(gammaDF,1,function(x) names(gammaDF)[which(x==max(x))])))

# We considered only top 10 words from the document
top_terms <- topics  %>% 
  group_by(topic) %>%  
  top_n(10, beta) %>% 
  ungroup() %>% #
  arrange(topic, -beta)

t1 <- merge(toptopics, top_terms, by = "topic", all.x = TRUE, all.y = TRUE)
t1$topic <- NULL

library(plyr)
top_terms$beta <- NULL
top_terms$term <- as.factor(top_terms$term)

top_terms_merged <- ddply(t1, .(document), summarize, toString(term))
colnames(top_terms_merged)[2] <- "term"
top_terms_merged$term <- as.factor(top_terms_merged$term)

library(data.table)
top_terms_merged <- as.data.table(top_terms_merged)
data_sep<-separate_rows(top_terms_merged, term, sep = ",")
table1<- data.table::dcast.data.table(data_sep, document ~ term)
table2<-sapply(table1[,-1],function(x){x<-ifelse(is.na(x),0,1)})
colnames(table2)<-paste0("term_",colnames(table2))
table<-cbind(table1[,1],table2)
MergedData<-merge(texts_subsample,table, by="document", all.x = TRUE, all.y = TRUE)
MergedData$text <- NULL

#save the file
write.csv(MergedData, "one_hot_encoded_tfidf_lda_2.csv", row.names = F)

#Step 7<- Similarly,we repeated the procedure for k=4, k=6, k=8, k=10 and k=12
# for k=4, csv named as "one_hot_encoded4.csv"
# for k=6, csv named as "one_hot_encoded6.csv"
# for k=8, csv named as "one_hot_encoded8.csv"
# for k=10, csv named as "one_hot_encoded10.csv"
# for k=12, csv named as "one_hot_encoded12.csv"
#############################################################################


#######################################################################
# Perform Naive Bayes Classifier on Featured Extracted from LDA
#######################################################################
#Installed Required packages
library(mlbench)
library(caret)
library(PRROC)
library(e1071)
library(klaR)

# Read the dataset
mydata <- read.csv("one_hot_encoded_tfidf_lda_2.csv")
mydata<- na.omit(mydata)
str(mydata)
mydata$term_.one <- NULL
mydata$term_one <- NULL
#Deleting unwanted column from dataset
mydata$document<-NULL
mydata$url <- NULL
#Coverting target variable in factor
mydata$label<-as.factor(mydata$label)
# Splitting data into training and testing dataset
splitdata <- createDataPartition(y = mydata$label, p= 0.80, list = FALSE)
train <- mydata[splitdata,]
test <- mydata[-splitdata,]

################################################### Naive Bayes ###################################################

# Performing 5-fold cross validation to avoid over fitting of the model and definin control
train_control <- trainControl(method="cv", 
                              number=5)

# Training the model
Naive_Bayes_model <- train(label ~., 
                           data=train, 
                           trControl=train_control,
                           method="nb")
Naive_Bayes_model

# Creating predictive model
predicted <- predict(Naive_Bayes_model, newdata = test)
predictedVsActualTable<- table(predicted, test$label)
predictedVsActualTable

#Evaluating results with the help of confusion matrix
confusionMatrix(predicted, test$label, positive = "1")

#precision value for Naive Bayes LDA 
precision <- posPredValue(predicted, test$label, positive="1")

#recall value for Naive Bayes LDA 
recall <- sensitivity(predicted, test$label, positive="1")

#F1 score  for Naive Bayes LDA
F1 <- (2 * precision * recall) / (precision + recall)

print(paste(precision, recall, F1), sep=" ")


#######################################################################
# Perform Support Vector Machines- Linear Classifier on Featured Extracted from LDA
#######################################################################
#Installed Required packages

library(mlbench)
library(caret)
library(PRROC)
library(e1071)

# Read the dataset
mydata <- read.csv("one_hot_encoded_tfidf_lda_2.csv")
mydata<- na.omit(mydata)
#Deleting unwanted column from dataset
mydata$document<-NULL
mydata$term_.one <- NULL
mydata$term_one <- NULL
#Coverting target variable in factor
mydata$label<-as.factor(mydata$label)
str(mydata)
# Splitting data into training and testing dataset
splitdata <- createDataPartition(y = mydata$label, p= 0.80, list = FALSE)
train <- mydata[splitdata,]
test <- mydata[-splitdata,]

################################################### LSVM ###################################################

# Performing 5-fold cross validation to avoid over fitting of the model and definin control
train_control <- trainControl(method="cv", 
                              number=5)

# Training the model
Linear_SVM_model <- train(label ~., 
                          data=train, 
                          trControl=train_control,
                          method="svmLinear")
Linear_SVM_model

# Creating predictive model
predicted <- predict(Linear_SVM_model, newdata = test)
predictedVsActualTable<- table(predicted, test$label)
predictedVsActualTable

#Evaluating results with the help of confusion matrix
confusionMatrix(predicted, test$label, positive = "1")

#precision value for LSVM LDA 
precision <- posPredValue(predicted, test$label, positive="1")

#recall value for LSVM LDA 
recall <- sensitivity(predicted, test$label, positive="1")

#F1 score  for LSVM LDA
F1 <- (2 * precision * recall) / (precision + recall)

print(paste(precision, recall, F1), sep=" ")

#Step 11<- Repeat the procedure for different topics and evaluate the results.


#######################################################################
# Perform Support Vector Machines- Radial Classifier on Featured Extracted from LDA
#######################################################################
#Installed Required packages

library(mlbench)
library(caret)
library(PRROC)
library(e1071)

# Read the dataset
mydata <- read.csv("one_hot_encoded_tfidf_lda_2.csv")
mydata<- na.omit(mydata)
mydata$term_.one <- NULL
mydata$term_one <- NULL
#Deleting unwanted column from dataset
mydata$document<-NULL
#Coverting target variable in factor
mydata$label<-as.factor(mydata$label)
str(mydata)
# Splitting data into training and testing dataset
splitdata <- createDataPartition(y = mydata$label, p= 0.80, list = FALSE)
train <- mydata[splitdata,]
test <- mydata[-splitdata,]


################################################### SVM Radial ###################################################

# Performing 5-fold cross validation to avoid over fitting of the model and definin control
train_control <- trainControl(method="cv", 
                              number=5)

# Training the model
SVM_Radial_model <- train(label ~., 
                          data=train, 
                          trControl=train_control,
                          method="svmRadial")
SVM_Radial_model

# Creating predictive model
predicted <- predict(SVM_Radial_model, newdata = test)
predictedVsActualTable<- table(predicted, test$label)
predictedVsActualTable

#Evaluating results with the help of confusion matrix
confusionMatrix(predicted, test$label, positive = "1")

#precision value for SVM-R LDA 
precision <- posPredValue(predicted, test$label, positive="1")

#recall value for SVM-R LDA 
recall <- sensitivity(predicted, test$label, positive="1")

#F1 score for SVM-R LDA
F1 <- (2 * precision * recall) / (precision + recall)

print(paste(precision, recall, F1), sep=" ")


#######################################################################
#Perform Random forest Classifier on Featured Extracted from LDA
#######################################################################
#Installed Required packages

library(randomForest)
library(mlbench)
library(caret)
library(PRROC)

# Read the dataset
mydata <- read.csv("one_hot_encoded_tfidf_lda_2.csv")
mydata<- na.omit(mydata)

#Deleting unwanted column from dataset
mydata$document<-NULL
mydata$term_.one <- NULL

#Coverting variables in factor
mydata[sapply(mydata, is.integer)] <- lapply(mydata[sapply(mydata, is.integer)], 
                                             as.factor)

str(mydata)
# Splitting data into training and testing dataset
splitdata <- createDataPartition(y = mydata$label, p= 0.80, list = FALSE)
train <- mydata[splitdata,]
test <- mydata[-splitdata,]

# converting target variable as factor
train$label <- ifelse(train$label == 1, "Y", "N")
test$label <- ifelse(test$label == 1, "Y", "N")
train$label <- factor(train$label)
test$label <- factor(test$label)
################################################### Random Forest ###################################################
gc()
# Performing 5-fold cross validation to avoid over fitting of the model and definin control
train_control <- trainControl(method="cv", 
                              number=5)

# Training the model
Random_Forest_model <- train(label ~., 
                             data=train, 
                             trControl=train_control,
                             method="rf",
                             TuneLength=5)
Random_Forest_model

# Creating predictive model
predicted <- predict(Random_Forest_model, newdata = test)
predictedVsActualTable<- table(predicted, test$label)
predictedVsActualTable

#Evaluating results with the help of confusion matrix
confusionMatrix(predicted, test$label)

#precision value for Random Forest LDA 
precision <- posPredValue(predicted, test$label)

#recall value for Random Forest LDA 
recall <- sensitivity(predicted, test$label)

#F1 score for Randon Forest LDA
F1 <- (2 * precision * recall) / (precision + recall)

print(paste(precision, recall, F1), sep=" ")


