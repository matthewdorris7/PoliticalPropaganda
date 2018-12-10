library(tm)
library(RTextTools)
library(e1071)
library(dplyr)
library(caret)
library(doSNOW)

#data to dataframe
df <- read.csv(file.choose(), header = T, stringsAsFactors = FALSE)
glimpse(df)

#randomize data
set.seed(1)
df <- df[sample(nrow(df)), ]
df <- df[sample(nrow(df)), ]
glimpse(df)


df$class <- as.factor(df$class)
df$class
#create corpus
corpus <- Corpus(VectorSource(df$text))
# Inspect the corpus
corpus
inspect(corpus[1:3])

#Data Cleanup
corpus.clean <- corpus %>%
  tm_map(content_transformer(tolower)) %>% 
  tm_map(removePunctuation) %>%
  tm_map(removeNumbers) %>%
  tm_map(removeWords, stopwords(kind="en")) %>%
  tm_map(stripWhitespace)

#document term matrix
dtm <- DocumentTermMatrix(corpus.clean)
dtm
inspect(dtm[40:50, 10:15])

#partition the data
#75:25 partitions
df.train <- df[1:315,]
df.test <- df[316:420,]

dtm.train <- dtm[1:315,]
dtm.test <- dtm[316:420,]

corpus.clean.train <- corpus.clean[1:315]
corpus.clean.test <- corpus.clean[316:420]

#feature selection
#contains 5773 features
dim(dtm.train)

#find the 5 most frequent terms to build matrix
fivefreq <- findFreqTerms(dtm.train, 5)
length((fivefreq))

dtm.train.nb <- DocumentTermMatrix(corpus.clean.train, control=list(dictionary = fivefreq))
#
dim(dtm.train.nb)

dtm.test.nb <- DocumentTermMatrix(corpus.clean.test, control=list(dictionary = fivefreq))

dim(dtm.train.nb)


#naive bayes classification algorithm
convert_count <- function(x) {
  y <- ifelse(x > 0, 1,0)
  y <- factor(y, levels=c(0,1), labels=c("No", "Yes"))
  y
}

trainNB <- apply(dtm.train.nb, 2, convert_count)
testNB <- apply(dtm.test.nb, 2, convert_count)
trainNB
testNB

#**************
#training the model
#dim(trainNB)

#dim(df$class)
system.time( classifier <- naiveBayes(trainNB, df.train$class, laplace = 1) )
# Use the NB classifier we built to make predictions on the test set.
system.time( pred <- predict(classifier, newdata=testNB) )

#
#facebookAds <- read.csv(file.choose(), header = T, stringsAsFactors = FALSE)
#predict(classifier, newdata = FacebookAds[1,]$AdText)
table("Predictions"= pred,  "Actual" = df.test$class )


conf.mat <- confusionMatrix(pred, df.test$class)
conf.mat
conf.mat$byClass
conf.mat$overall
conf.mat$overall['Accuracy']