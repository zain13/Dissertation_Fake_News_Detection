setwd("~/Desktop/Research_Project/codethesis3")
library(tm) # for NLP
library(plyr) #  for pre-processing 
library(tidyverse) # for pre-processing and visualisation

newsdata<- read.csv("data.csv", stringsAsFactors = FALSE)
summary(newsdata)

newsdata<- as.data.frame(newsdata)

#adding id numbers
newsdata$id <- seq.int(nrow(newsdata))

#rename
colnames(newsdata)[colnames(newsdata)=="Headline"] <- "title"
colnames(newsdata)[colnames(newsdata)=="Label"] <- "label"
colnames(newsdata)[colnames(newsdata)=="Body"] <- "text"
colnames(newsdata)[colnames(newsdata)=="URLs"] <- "url"


#####################################################################################
#**********************working with URL *********************************************
#####################################################################################

#remove everything after .com, .tv, .uk from the URL
newsdata$url <- gsub("(.com).*","\\1", newsdata$url)
newsdata$url <- gsub("(.tv).*","\\1", newsdata$url)
newsdata$url <- gsub("(.uk).*","\\1", newsdata$url)
newsdata$url <- gsub("(.net).*","\\1", newsdata$url)
newsdata$url <- gsub("(cnn.it).*","\\1", newsdata$url)

write.csv(newsdata,file = "final_dataset.csv", row.names = F)

#########
#check Common source of url links
######

fake <- newsdata[newsdata$label == "0",]
real <- newsdata[newsdata$label == "1",]
#max real news

real$url <- with(real, reorder(url, url, function(x) length(x)))
ggplot(data = real) +
  ggtitle("source count of real news") +
  geom_bar(aes(x= url),fill = "green") + coord_flip()

fake$url <- with(fake, reorder(url, url, function(x) length(x)))
ggplot(data = fake) +
  ggtitle("source count of fake news") +
  geom_bar(aes(x= url),fill = "red") + coord_flip()

##########################################################################################
#     Analysis
##########################################################################################

#########   preprocess  ###############################################################

clean_text <- function(x){ 
  gsub("…|⋆|–|‹|”|“|‘|’", " ", x) 
}

preprocess_corpus <- function(corpus){
  # Convert the text to lower case
  corpus <- tm_map(corpus, content_transformer(tolower))
  # Remove numbers
  corpus <- tm_map(corpus, removeNumbers)
  # Remove punctuations
  corpus <- tm_map(corpus, removePunctuation)
  # Remove special characters from text
  corpus <- tm_map(corpus, clean_text)
  # Remove english common stopwords
  corpus <- tm_map(corpus, removeWords, stopwords("english"))
  # Remove name of newspapers from the corpus
  corpus <- tm_map(corpus, removeWords, c("eagle rising","freedom daily"))
  # 'stem' words to root words
  corpus <- tm_map(corpus,stemDocument)
  # Eliminate extra white spaces
  corpus <- tm_map(corpus, stripWhitespace)
  return (corpus)
}
####

str(newsdata)
newsdata$label <- as.factor(newsdata$label)
levels(newsdata$label) <- c("Fake","Real")
str(newsdata)


#Analysis on  news title
#  title corpus
title_corpus <- Corpus(VectorSource(newsdata$title))
# convert title corpus to document term matrix
title_dtm <- DocumentTermMatrix(preprocess_corpus(title_corpus))
title_dtm_matrix <- as.matrix(title_dtm)

###################
#length t test 
# length of title for histogram
title_length <- rowSums(title_dtm_matrix)
# data frame of title length with categories
tl_df <- data.frame(title_length, newsdata$label)

# perform t-test
t.test(tl_df[tl_df$newsdata.label == "Fake",]$title_length, tl_df[tl_df$newsdata.label == "Real",]$title_length)

# plotting histogram of title length
ggplot(tl_df ,aes(x = title_length, fill = newsdata.label)) +
  geom_density(alpha=0.5) +
  guides(fill=guide_legend(title="News type")) + 
  xlab("Title length") + ylab("Density") + theme() + 
  ggtitle("Density distribuiton of title length for real and fake news") 



####for text############
#Analysis on Buzzfeed news title (unigrams)
#  title corpus
text_corpus <- Corpus(VectorSource(newsdata$text))
# convert text corpus to document term matrix
text_dtm <- DocumentTermMatrix(preprocess_corpus(text_corpus))
text_dtm_matrix <- as.matrix(text_dtm)

#length t test 
# length of text for histogram
text_length <- rowSums(text_dtm_matrix)
# data frame of text length with categories
text_df <- data.frame(text_length, newsdata$label)


# perform t-test
t.test(text_df[text_df$newsdata.label == "Fake",]$text_length, text_df[text_df$newsdata.label == "Real",]$text_length)

# plotting histogram of text length
ggplot(text_df,aes(x = text_length, fill = newsdata.label)) +
  geom_density(alpha=0.5) +
  guides(fill=guide_legend(text="News type")) + 
  xlab("text length") + ylab("Density") + theme() + 
  ggtitle("Density distribuiton of text length for real and fake news")
############

str(newsdata)
table(newsdata$label)
levels(newsdata$label) <- c(0,1)


########smote#########################
#sum(is.na(newsdata))
#newsdata <- na.omit(newsdata)
#smote
#str(newsdata)
#table(newsdata$label)

#newsdata$label <- as.factor(newsdata$label)
#levels(newsdata$label) <- c("1","2")

#library(DMwR)
## Smote : Synthetic Minority Oversampling Technique To Handle Class Imbalancy In Binary Classification
#smoted_data <- SMOTE(label~., newsdata, perc.over=100, perc.under=200)
#x <- as.data.frame(table(smoted_data$label))

###########################
#smote1 <- trainControl(method = "repeatedcv", 
#                      number = 5, 
#                     verboseIter = TRUE,
#                    sampling = "smote")
