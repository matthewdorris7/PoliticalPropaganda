rm(list= ls(all=TRUE))

library(tm)
library(RTextTools)
library(e1071)
library(dplyr)
library(caret)
library(doSNOW)

#data to dataframe
df1 <- read.csv(file.choose(), header = T, stringsAsFactors = FALSE)
glimpse(df1)

#randomize data
set.seed(1)
df1 <- df1[sample(nrow(df1)), ]
df1 <- df1[sample(nrow(df1)), ]
glimpse(df1)


df1$ï..class <- as.factor(df1$ï..class)
df1$ï..class
#create corpus
corpus <- Corpus(VectorSource(df1$text))
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
df1.train <- df1[1:2607,]
df1.test <- df1[2608:3474,]

dtm.train <- dtm[1:2607,]
dtm.test <- dtm[2608:3474,]

corpus.clean.train <- corpus.clean[1:2607]
corpus.clean.test <- corpus.clean[2608:3474]

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

#dim(df1$ï..class)
system.time( classifier <- naiveBayes(trainNB, df1.train$ï..class, laplace = 1) )
# Use the NB classifier we built to make predictions on the test set.
system.time( pred <- predict(classifier, newdata=testNB) )


#facebookAds <- read.csv(file.choose(), header = T, stringsAsFactors = FALSE)
#predict(classifier, newdata = FacebookAds[1,]$AdText)
table("Predictions"= pred,  "Actual" = df1.test$ï..class )

conf.mat <- confusionMatrix(pred, df1.test$ï..class)
conf.mat
conf.mat$byClass
conf.mat$overall
conf.mat$overall['Accuracy']

glimpse(classifier)

ctable <- as.table(matrix(c(167, 71, 166, 463), nrow = 2, byrow = TRUE))
fourfoldplot(ctable, color = c("#CC6666", "#99CC99"),
             conf.level = 0, margin = 1, main = "Conservative/Liberal")

library(e1071)
library(caret)
model <- naiveBayes(trainNB, df1.train$ï..class, laplace = 1)
decisionplot(model, x, class = "class", main = "naive Bayes")


