# Ad Cost vs Clicks -----------------------------------------

#Library
library("XML")
library(tm)
library(wordcloud)
library(SentimentAnalysis)
####


dataset <- read.csv("C:\College\Senior\FacebookAds", header = T)

dataset <- dataset[order(-dataset$Impressions), ]

HighestImpressions <- dataset[1:100, ]


shortDate <- dataset
shortDate$CreationDate <- paste(substr(shortDate$CreationDate, 1, 2), substr(shortDate$CreationDate, 7, 8), sep="/")

ads2015 <- shortDate[substr(shortDate$CreationDate, 4, 5) == "15",]
ads2016 <- shortDate[substr(shortDate$CreationDate, 4, 5) == "16",]
ads2017 <- shortDate[substr(shortDate$CreationDate, 4, 5) == "17",]


plot(ads2015$Clicks, ads2015$AdSpend, col = "red", xlim=c(0,15000),  ylim=c(0,60000), main="2015 Advertisement Cost vs. Number of Clicks", 
     xlab="Clicks on Ad", ylab="Cost (RUB)", pch=19)

plot(ads2016$Clicks, ads2016$AdSpend, col = "green", xlim=c(0,15000), ylim=c(0,60000), main="2016 Advertisement Cost vs. Number of Clicks", 
     xlab="Clicks on Ad", ylab="Cost per Ad (RUB)", pch=19)

plot(ads2017$Clicks, ads2017$AdSpend, col = "blue", xlim=c(0,15000), ylim=c(0,60000), main="2017 Advertisement Cost vs. Number of Clicks", 
     xlab="Clicks on Ad", ylab="Cost per Ad (RUB)", pch=19)